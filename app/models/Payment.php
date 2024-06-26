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

    private static function executeFind($stmt) {
        $stmt->execute();
        $result = $stmt->get_result();
        if ($row = $result->fetch_assoc()) {
            $payment = new self();
            $payment->id = $row['id'];
            $payment->orderId = $row['order_id'];
            $payment->amount = $row['amount'];
            $payment->transactionStatus = $row['transaction_status'];
            $payment->paymentMethod = $row['payment_method'];
            $payment->transactionId = $row['transaction_id'];
            $payment->processedAt = $row['processed_at'];
            return $payment;
        }
        return false;
    }

    public static function findById($id) {
        $stmt = $GLOBALS['conn']->prepare("SELECT * FROM payments WHERE id = ?");
        $stmt->bind_param("i", $id);
        return self::executeFind($stmt);
    }

    public function toArray() {
        return [
            'id' => $this->id,
            'order_id' => $this->orderId,
            'amount' => $this->amount,
            'transaction_status' => $this->transactionStatus,
            'payment_method' => $this->paymentMethod,
            'transaction_id' => $this->transactionId,
            'processed_at' => $this->processedAt
        ];
    }

    public static function all() {
        $stmt = $GLOBALS['conn']->prepare("SELECT * FROM payments");
        $stmt->execute();
        $result = $stmt->get_result();
        $payments = [];
        while ($row = $result->fetch_assoc()) {
            $payments[] = self::executeFind($stmt);
        }
        return $payments;
    }

    public static function rows() {
        return array_map(function ($payment) {
            return $payment->toArray();
        }, self::all());
    }

    public static function exists($id) {
        return (self::findById($id) != false);
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
        } else {
            self::returnError('HTTP/1.1 404', 'Load Payment Error: Payment [id = ' . $this->id . '] does not exist.');
        }
        $stmt->close();
    }

    public function save() {
        if ($this->id) {
            $stmt = $this->conn->prepare("UPDATE payments SET order_id = ?, amount = ?, transaction_status = ?, payment_method = ?, transaction_id = ?, processed_at = ? WHERE id = ?");
            $stmt->bind_param("idssssi", $this->orderId, $this->amount, $this->transactionStatus, $this->paymentMethod, $this->transactionId, $this->processedAt, $this->id);
            $stmt->execute();
            if ($stmt->affected_rows === 0) {
                self::returnError('HTTP/1.1 404', 'Update Payment Error: No Payment updated or Payment [id = ' . $this->id . '] does not exist.');
            }
        } else {
            $stmt = $this->conn->prepare("INSERT INTO payments (order_id, amount, transaction_status, payment_method, transaction_id, processed_at) VALUES (?, ?, ?, ?, ?, ?)");
            $stmt->bind_param("idssss", $this->orderId, $this->amount, $this->transactionStatus, $this->paymentMethod, $this->transactionId, $this->processedAt);
            $stmt->execute();
            if ($stmt->affected_rows === 0) {
                self::returnError('HTTP/1.1 400', 'Create Payment Error: Unable to create Payment.');
            }
            $this->id = $this->conn->insert_id;
        }
        $stmt->close();
    }

    public function delete() {
        if (!$this->id) {
            self::returnError('HTTP/1.1 404', 'Delete Payment Error: Payment ID is missing.');
        }
        $stmt = $this->conn->prepare("DELETE FROM payments WHERE id = ?");
        $stmt->bind_param("i", $this->id);
        $stmt->execute();
        if ($stmt->affected_rows === 0) {
            self::returnError('HTTP/1.1 404', 'Delete Payment Error: Payment [id = ' . $this->id . '] does not exist.');
        }
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

    public function createPayment($orderId, $amount, $paymentMethod, $transactionId) {
        $this->orderId = $orderId;
        $this->amount = $amount;
        $this->paymentMethod = $paymentMethod;
        $this->transactionId = $transactionId;
        $this->transactionStatus = 'Completed';
        $this->processedAt = date('Y-m-d H:i:s');

        $stmt = $this->conn->prepare("INSERT INTO payments (order_id, amount, transaction_status, payment_method, transaction_id, processed_at) VALUES (?, ?, ?, ?, ?, ?)");
        $stmt->bind_param("idssss", $this->orderId, $this->amount, $this->transactionStatus, $this->paymentMethod, $this->transactionId, $this->processedAt);
        $stmt->execute();
        if ($stmt->affected_rows === 0) {
            throw new Exception("Failed to create payment.");
        }
        $this->id = $this->conn->insert_id;
        $stmt->close();
        return $this->id;
    }
}
