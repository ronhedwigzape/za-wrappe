<?php

require_once 'App.php';

class Order extends App {
    protected $table = 'orders';

    public $id;
    public $status;
    public $customerContact;
    public $totalPrice;
    public $verificationCode;
    public $paymentStatus;

    public function __construct($id = null) {
        parent::__construct();
        if ($id) {
            $this->id = $id;
            $this->load();
        }
    }

    private function load() {
        $stmt = $this->conn->prepare("SELECT * FROM orders WHERE id = ?");
        $stmt->bind_param("i", $this->id);
        $stmt->execute();
        $result = $stmt->get_result();
        if ($row = $result->fetch_assoc()) {
            $this->status = $row['status'];
            $this->customerContact = $row['customer_contact'];
            $this->totalPrice = $row['total_price'];
            $this->verificationCode = $row['verification_code'];
            $this->paymentStatus = $row['payment_status'];
        }
        $stmt->close();
    }

    public function save() {
        if ($this->id) {
            $stmt = $this->conn->prepare("UPDATE orders SET status = ?, customer_contact = ?, total_price = ?, verification_code = ?, payment_status = ? WHERE id = ?");
            $stmt->bind_param("ssdsii", $this->status, $this->customerContact, $this->totalPrice, $this->verificationCode, $this->paymentStatus, $this->id);
        } else {
            $stmt = $this->conn->prepare("INSERT INTO orders (status, customer_contact, total_price, verification_code, payment_status) VALUES (?, ?, ?, ?, ?)");
            $stmt->bind_param("ssdsi", $this->status, $this->customerContact, $this->totalPrice, $this->verificationCode, $this->paymentStatus);
        }
        $stmt->execute();
        if (!$this->id) $this->id = $this->conn->insert_id;
        $stmt->close();
    }

    public function delete() {
        $stmt = $this->conn->prepare("DELETE FROM orders WHERE id = ?");
        $stmt->bind_param("i", $this->id);
        $stmt->execute();
        $stmt->close();
    }

    public function orderItems() {
        require_once 'OrderItem.php';
        $stmt = $this->conn->prepare("SELECT id FROM order_items WHERE order_id = ?");
        $stmt->bind_param("i", $this->id);
        $stmt->execute();
        $result = $stmt->get_result();
        $items = [];
        while ($row = $result->fetch_assoc()) {
            $items[] = new OrderItem($row['id']);
        }
        $stmt->close();
        return $items;
    }

    public function payments() {
        require_once 'Payment.php';
        $stmt = $this->conn->prepare("SELECT id FROM payments WHERE order_id = ?");
        $stmt->bind_param("i", $this->id);
        $stmt->execute();
        $result = $stmt->get_result();
        $payments = [];
        while ($row = $result->fetch_assoc()) {
            $payments[] = new Payment($row['id']);
        }
        $stmt->close();
        return $payments;
    }
}
