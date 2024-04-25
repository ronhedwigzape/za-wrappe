<?php

require_once 'App.php';

class Receipt extends App {
    protected $table = 'receipts';

    public $id;
    public $paymentId;
    public $issuedAt;
    public $details;

    public function __construct($id = null) {
        parent::__construct();
        if ($id) {
            $this->id = $id;
            $this->load();
        }
    }

    private static function executeFind($stmt) {
        $stmt->execute();
        $result = $stmt->get_result();
        if ($row = $result->fetch_assoc()) {
            $receipt = new self();
            $receipt->id = $row['id'];
            $receipt->paymentId = $row['payment_id'];
            $receipt->issuedAt = $row['issued_at'];
            $receipt->details = $row['details'];
            return $receipt;
        }
        return false;
    }

    public static function findById($id) {
        $stmt = $GLOBALS['conn']->prepare("SELECT * FROM receipts WHERE id = ?");
        $stmt->bind_param("i", $id);
        return self::executeFind($stmt);
    }

    public function toArray() {
        return [
            'id' => $this->id,
            'payment_id' => $this->paymentId,
            'issued_at' => $this->issuedAt,
            'details' => $this->details
        ];
    }

    public static function all() {
        $stmt = $GLOBALS['conn']->prepare("SELECT * FROM receipts");
        $stmt->execute();
        $result = $stmt->get_result();
        $receipts = [];
        while ($row = $result->fetch_assoc()) {
            $receipts[] = self::executeFind($stmt);
        }
        return receipts;
    }

    public static function rows() {
        return array_map(function ($receipt) {
            return $receipt->toArray();
        }, self::all());
    }

    public static function exists($id) {
        return (self::findById($id) != false);
    }

    private function load() {
        $stmt = $this->conn->prepare("SELECT * FROM receipts WHERE id = ?");
        $stmt->bind_param("i", $this->id);
        $stmt->execute();
        $result = $stmt->get_result();
        if ($row = $result->fetch_assoc()) {
            $this->paymentId = $row['payment_id'];
            $this->issuedAt = $row['issued_at'];
            $this->details = $row['details'];
        } else {
            self::returnError('HTTP/1.1 404', 'Load Receipt Error: Receipt [id = ' . $this->id . '] does not exist.');
        }
        $stmt->close();
    }

    public function save() {
        if ($this->id) {
            $stmt = $this->conn->prepare("UPDATE receipts SET payment_id = ?, issued_at = ?, details = ? WHERE id = ?");
            $stmt->bind_param("issi", $this->paymentId, $this->issuedAt, $this->details, $this->id);
            $stmt->execute();
            if ($stmt->affected_rows === 0) {
                self::returnError('HTTP/1.1 404', 'Update Receipt Error: No Receipt updated or Receipt [id = ' . $this->id . '] does not exist.');
            }
        } else {
            $stmt = $this->conn->prepare("INSERT INTO receipts (payment_id, issued_at, details) VALUES (?, ?, ?)");
            $stmt->bind_param("iss", $this->paymentId, $this->issuedAt, $this->details);
            $stmt->execute();
            if ($stmt->affected_rows === 0) {
                self::returnError('HTTP/1.1 400', 'Create Receipt Error: Unable to create Receipt.');
            }
            $this->id = $this->conn->insert_id;
        }
        $stmt->close();
    }

    public function delete() {
        if (!$this->id) {
            self::returnError('HTTP/1.1 404', 'Delete Receipt Error: Receipt ID is missing.');
        }
        $stmt = $this->conn->prepare("DELETE FROM receipts WHERE id = ?");
        $stmt->bind_param("i", $this->id);
        $stmt->execute();
        if ($stmt->affected_rows === 0) {
            self::returnError('HTTP/1.1 404', 'Delete Receipt Error: Receipt [id = ' . $this->id . '] does not exist.');
        }
        $stmt->close();
    }

    public function payment() {
        require_once 'Payment.php';
        return new Payment($this->paymentId);
    }
}
