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

    private static function executeFind($stmt) {
        $stmt->execute();
        $result = $stmt->get_result();
        if ($row = $result->fetch_assoc()) {
            $order = new self();
            $order->id = $row['id'];
            $order->status = $row['status'];
            $order->customerContact = $row['customer_contact'];
            $order->totalPrice = $row['total_price'];
            $order->verificationCode = $row['verification_code'];
            $order->paymentStatus = $row['payment_status'];
            return $order;
        }
        return false;
    }

    public static function findById($id) {
        $stmt = $GLOBALS['conn']->prepare("SELECT * FROM orders WHERE id = ?");
        $stmt->bind_param("i", $id);
        return self::executeFind($stmt);
    }

    public function toArray() {
        return [
            'id' => $this->id,
            'status' => $this->status,
            'customerContact' => $this->customerContact,
            'totalPrice' => $this->totalPrice,
            'verificationCode' => $this->verificationCode,
            'paymentStatus' => $this->paymentStatus
        ];
    }

    public static function all() {
        $stmt = $GLOBALS['conn']->prepare("SELECT * FROM orders");
        $stmt->execute();
        $result = $stmt->get_result();
        $orders = [];
        while ($row = $result->fetch_assoc()) {
            $orders[] = self::executeFind($stmt);
        }
        return $orders;
    }

    public static function rows() {
        return array_map(function ($order) {
            return $order->toArray();
        }, self::all());
    }

    public static function exists($id) {
        return (self::findById($id) != false);
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
        } else {
            self::returnError('HTTP/1.1 404', 'Load Order Error: Order [id = ' . $this->id . '] does not exist.');
        }
        $stmt->close();
    }

    public function save() {
        if ($this->id) {
            $stmt = $this->conn->prepare("UPDATE orders SET status = ?, customer_contact = ?, total_price = ?, verification_code = ?, payment_status = ? WHERE id = ?");
            $stmt->bind_param("ssdssi", $this->status, $this->customerContact, $this->totalPrice, $this->verificationCode, $this->paymentStatus, $this->id);
            $stmt->execute();
            if ($stmt->affected_rows === 0) {
                self::returnError('HTTP/1.1 404', 'Update Order Error: No Order updated or Order [id = ' . $this->id . '] does not exist.');
            }
        } else {
            $stmt = $this->conn->prepare("INSERT INTO orders (status, customer_contact, total_price, verification_code, payment_status) VALUES (?, ?, ?, ?, ?)");
            $stmt->bind_param("ssdss", $this->status, $this->customerContact, $this->totalPrice, $this->verificationCode, $this->paymentStatus);
            $stmt->execute();
            if ($stmt->affected_rows === 0) {
                self::returnError('HTTP/1.1 400', 'Create Order Error: Unable to create Order.');
            }
            $this->id = $this->conn->insert_id;
        }
        $stmt->close();
    }

    public function delete() {
        if (!$this->id) {
            self::returnError('HTTP/1.1 404', 'Delete Order Error: Order ID is missing.');
        }
        $stmt = $this->conn->prepare("DELETE FROM orders WHERE id = ?");
        $stmt->bind_param("i", $this->id);
        $stmt->execute();
        if ($stmt->affected_rows === 0) {
            self::returnError('HTTP/1.1 404', 'Delete Order Error: Order [id = ' . $this->id . '] does not exist.');
        }
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

    public function processPaymentAndGenerateReceipt($amount, $paymentMethod, $transactionId) {
        // Check if the payment amount matches the order's total price
        if ($this->totalPrice != $amount) {
            throw new Exception("Payment amount does not match the order total.");
        }

        // Start transaction
        $this->conn->begin_transaction();

        try {
            // Update order status to 'Payment Received'
            $this->status = 'Payment Received';
            $this->paymentStatus = 'Paid';
            $this->updateStatus();

            // Create payment record
            $payment = new Payment();
            $paymentId = $payment->createPayment($this->id, $amount, $paymentMethod, $transactionId);

            // Generate receipt
            $receipt = new Receipt();
            $receiptDetails = "Receipt for Order #" . $this->id;
            $receiptId = $receipt->generateReceipt($paymentId, $receiptDetails);

            // Commit transaction
            $this->conn->commit();

            return [
                "paymentId" => $paymentId,
                "receiptId" => $receiptId
            ];
        } catch (Exception $e) {
            // Rollback transaction in case of error
            $this->conn->rollback();
            throw $e;
        }
    }

    public function markAsCancelled() {
        if ($this->status !== 'Payment Received') {
            $this->status = 'Cancelled';
            $this->updateStatus();
        } else {
            throw new Exception("Cannot cancel order after payment has been received.");
        }
    }

    public function markAsPreparing() {
        if ($this->status === 'Payment Received') {
            $this->status = 'Preparing Order';
            $this->updateStatus();
        } else {
            throw new Exception("Order must be marked as 'Payment Received' before it can be set to 'Preparing Order'.");
        }
    }

    public function markAsReadyForPickup() {
        if ($this->status === 'Preparing Order') {
            $this->status = 'Ready for Pickup';
            $this->updateStatus();
        } else {
            throw new Exception("Order must be in 'Preparing Order' status before it can be set to 'Ready for Pickup'.");
        }
    }

    private function updateStatus() {
        $stmt = $this->conn->prepare("UPDATE orders SET status = ? WHERE id = ?");
        $stmt->bind_param("si", $this->status, $this->id);
        $stmt->execute();
        if ($stmt->affected_rows === 0) {
            throw new Exception("Update failed or no changes made.");
        }
        $stmt->close();
    }
}
