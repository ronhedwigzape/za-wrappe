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
