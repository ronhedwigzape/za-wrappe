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
        }
        $stmt->close();
    }

    public function save() {
        if ($this->id) {
            $stmt = $this->conn->prepare("UPDATE receipts SET payment_id = ?, issued_at = ?, details = ? WHERE id = ?");
            $stmt->bind_param("isss", $this->paymentId, $this->issuedAt, $this->details, $this->id);
        } else {
            $stmt = $this->conn->prepare("INSERT INTO receipts (payment_id, issued_at, details) VALUES (?, ?, ?)");
            $stmt->bind_param("iss", $this->paymentId, $this->issuedAt, $this->details);
        }
        $stmt->execute();
        if (!$this->id) $this->id = $this->conn->insert_id;
        $stmt->close();
    }

    public function delete() {
        $stmt = $this->conn->prepare("DELETE FROM receipts WHERE id = ?");
        $stmt->bind_param("i", $this->id);
        $stmt->execute();
        $stmt->close();
    }

    public function payment() {
        require_once 'Payment.php';
        return new Payment($this->paymentId);
    }
}
