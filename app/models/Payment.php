<?php

require_once 'App.php';

class Payment extends App {
    protected $table = 'payments';

    public $id;
    public $orderId;
    public $amount;
    public $transactionStatus;
    public $paymentMethod;
    public $transactionId;
    public $processedAt;

    public function __construct($id = null) {
        parent::__construct();
        if ($id) {
            $this->id = $id;
            $this->load();
        }
    }

    private function load() {
        $stmt = $this->conn->prepare("SELECT * FROM payments WHERE id = ?");
        $stmt->bind_param("i", $this->id);
        $stmt->execute();
        $result = $stmt->get_result();
        if ($row = $result->fetch_assoc()) {
            $this->orderId = $row['order_id'];
            $this->amount = $row['amount'];
            $this->transactionStatus = $row['transaction_status'];
            $this->paymentMethod = $row['payment_method'];
            $this->transactionId = $row['transaction_id'];
            $this->processedAt = $row['processed_at'];
        }
        $stmt->close();
    }

    public function save() {
        if ($this->id) {
            $stmt = $this->conn->prepare("UPDATE payments SET order_id = ?, amount = ?, transaction_status = ?, payment_method = ?, transaction_id = ?, processed_at = ? WHERE id = ?");
            $stmt->bind_param("idssssi", $this->orderId, $this->amount, $this->transactionStatus, $this->paymentMethod, $this->transactionId, $this->processedAt, $this->id);
        } else {
            $stmt = $this->conn->prepare("INSERT INTO payments (order_id, amount, transaction_status, payment_method, transaction_id, processed_at) VALUES (?, ?, ?, ?, ?, ?)");
            $stmt->bind_param("idssss", $this->orderId, $this->amount, $this->transactionStatus, $this->paymentMethod, $this->transactionId, $this->processedAt);
        }
        $stmt->execute();
        if (!$this->id) $this->id = $this->conn->insert_id;
        $stmt->close();
    }

    public function delete() {
        $stmt = $this->conn->prepare("DELETE FROM payments WHERE id = ?");
        $stmt->bind_param("i", $this->id);
        $stmt->execute();
        $stmt->close();
    }

    public function order() {
        require_once 'Order.php';
        return new Order($this->orderId);
    }

    public function receipt() {
        require_once 'Receipt.php';
        $stmt = $this->conn->prepare("SELECT id FROM receipts WHERE payment_id = ?");
        $stmt->bind_param("i", $this->id);
        $stmt->execute();
        $result = $stmt->get_result();
        if ($row = $result->fetch_assoc()) {
            return new Receipt($row['id']);
        }
        $stmt->close();
        return null; // Return null if no receipt is found
    }
}
