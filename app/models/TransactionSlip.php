<?php

require_once 'App.php';

class TransactionSlip extends App {
    protected $table = 'transaction_slips';

    public $id;
    public $orderId;
    public $issuedAt;
    public $code;

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
            $transactionSlip = new self();
            $transactionSlip->id = $row['id'];
            $transactionSlip->orderId = $row['order_id'];
            $transactionSlip->issuedAt = $row['issued_at'];
            $transactionSlip->code = $row['code'];
            return $transactionSlip;
        }
        return false;
    }

    public static function findById($id) {
        $stmt = $GLOBALS['conn']->prepare("SELECT * FROM transaction_slips WHERE id = ?");
        $stmt->bind_param("i", $id);
        return self::executeFind($stmt);
    }

    public function toArray() {
        return [
            'id' => $this->id,
            'order_id' => $this->orderId,
            'issued_at' => $this->issuedAt,
            'code' => $this->code
        ];
    }

    public static function all() {
        $stmt = $GLOBALS['conn']->prepare("SELECT * FROM transaction_slips");
        $stmt->execute();
        $result = $stmt->get_result();
        $transactionSlips = [];
        while ($row = $result->fetch_assoc()) {
            $transactionSlips[] = self::executeFind($stmt);
        }
        return $transactionSlips;
    }

    public static function rows() {
        return array_map(function ($transactionSlip) {
            return $transactionSlip->toArray();
        }, self::all());
    }

    public static function exists($id) {
        return (self::findById($id) != false);
    }

    private function load() {
        $stmt = $this->conn->prepare("SELECT * FROM transaction_slips WHERE id = ?");
        $stmt->bind_param("i", $this->id);
        $stmt->execute();
        $result = $stmt->get_result();
        if ($row = $result->fetch_assoc()) {
            $this->orderId = $row['order_id'];
            $this->issuedAt = $row['issued_at'];
            $this->code = $row['code'];
        } else {
            self::returnError('HTTP/1.1 404', 'Load Transaction Slip Error: Transaction Slip [id = ' . $this->id . '] does not exist.');
        }
        $stmt->close();
    }

    public function save() {
        if ($this->id) {
            $stmt = $this->conn->prepare("UPDATE transaction_slips SET order_id = ?, issued_at = ?, code = ? WHERE id = ?");
            $stmt->bind_param("issi", $this->orderId, $this->issuedAt, $this->code, $this->id);
            $stmt->execute();
            if ($stmt->affected_rows === 0) {
                self::returnError('HTTP/1.1 404', 'Update Transaction Slip Error: No Transaction Slip updated or Transaction Slip [id = ' . $this->id . '] does not exist.');
            }
        } else {
            $stmt = $this->conn->prepare("INSERT INTO transaction_slips (order_id, issued_at, code) VALUES (?, ?, ?)");
            $stmt->bind_param("iss", $this->orderId, $this->issuedAt, $this->code);
            $stmt->execute();
            if ($stmt->affected_rows === 0) {
                self::returnError('HTTP/1.1 400', 'Create Transaction Slip Error: Unable to create Transaction Slip.');
            }
            $this->id = $this->conn->insert_id;
        }
        $stmt->close();
    }

    public function delete() {
        if (!$this->id) {
            self::returnError('HTTP/1.1 404', 'Delete Transaction Slip Error: Transaction Slip ID is missing.');
        }
        $stmt = $this->conn->prepare("DELETE FROM transaction_slips WHERE id = ?");
        $stmt->bind_param("i", $this->id);
        $stmt->execute();
        if ($stmt->affected_rows === 0) {
            self::returnError('HTTP/1.1 404', 'Delete Transaction Slip Error: Transaction Slip [id = ' . $this->id . '] does not exist.');
        }
        $stmt->close();
    }

    public function order() {
        require_once 'Order.php';
        return new Order($this->orderId);
    }
}
