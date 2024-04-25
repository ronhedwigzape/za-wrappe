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

    private function load() {
        $stmt = $this->conn->prepare("SELECT * FROM transaction_slips WHERE id = ?");
        $stmt->bind_param("i", $this->id);
        $stmt->execute();
        $result = $stmt->get_result();
        if ($row = $result->fetch_assoc()) {
            $this->orderId = $row['order_id'];
            $this->issuedAt = $row['issued_at'];
            $this->code = $row['code'];
        }
        $stmt->close();
    }

    public function save() {
        if ($this->id) {
            $stmt = $this->conn->prepare("UPDATE transaction_slips SET order_id = ?, issued_at = ?, code = ? WHERE id = ?");
            $stmt->bind_param("issi", $this->orderId, $this->issuedAt, $this->code, $this->id);
        } else {
            $stmt = $this->conn->prepare("INSERT INTO transaction_slips (order_id, issued_at, code) VALUES (?, ?, ?)");
            $stmt->bind_param("iss", $this->orderId, $this->issuedAt, $this->code);
        }
        $stmt->execute();
        if (!$this->id) $this->id = $this->conn->insert_id;
        $stmt->close();
    }

    public function delete() {
        $stmt = $this->conn->prepare("DELETE FROM transaction_slips WHERE id = ?");
        $stmt->bind_param("i", $this->id);
        $stmt->execute();
        $stmt->close();
    }

    public function order() {
        require_once 'Order.php';
        return new Order($this->orderId);
    }
}
