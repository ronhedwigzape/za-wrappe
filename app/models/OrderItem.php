<?php

require_once 'App.php';

class OrderItem extends App {
    protected $table = 'order_items';

    public $id;
    public $orderId;
    public $productId;
    public $addOnIds; // JSON
    public $flavorId;
    public $quantity;
    public $customizations;
    public $subtotal;

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
            $orderItem = new self();
            $orderItem->id = $row['id'];
            $orderItem->orderId = $row['order_id'];
            $orderItem->productId = $row['product_id'];
            $orderItem->addOnIds = json_decode($row['add_on_ids'], true); // Assuming it's stored as JSON
            $orderItem->flavorId = $row['flavor_id'];
            $orderItem->quantity = $row['quantity'];
            $orderItem->customizations = $row['customizations'];
            $orderItem->subtotal = $row['subtotal'];
            return $orderItem;
        }
        return false;
    }

    public static function findById($id) {
        $stmt = $GLOBALS['conn']->prepare("SELECT * FROM order_items WHERE id = ?");
        $stmt->bind_param("i", $id);
        return self::executeFind($stmt);
    }

    public function toArray() {
        return [
            'id' => $this->id,
            'order_id' => $this->orderId,
            'product_id' => $this->productId,
            'add_on_ids' => $this->addOnIds,
            'flavor_id' => $this->flavorId,
            'quantity' => $this->quantity,
            'customizations' => $this->customizations,
            'subtotal' => $this->subtotal
        ];
    }

    public static function all() {
        $stmt = $GLOBALS['conn']->prepare("SELECT * FROM order_items");
        $stmt->execute();
        $result = $stmt->get_result();
        $orderItems = [];
        while ($row = $result->fetch_assoc()) {
            $orderItems[] = self::executeFind($stmt);
        }
        return $orderItems;
    }

    public static function rows() {
        return array_map(function ($orderItem) {
            return $orderItem->toArray();
        }, self::all());
    }

    public static function exists($id) {
        return (self::findById($id) != false);
    }

    private function load() {
        $stmt = $this->conn->prepare("SELECT * FROM order_items WHERE id = ?");
        $stmt->bind_param("i", $this->id);
        $stmt->execute();
        $result = $stmt->get_result();
        if ($row = $result->fetch_assoc()) {
            $this->orderId = $row['order_id'];
            $this->productId = $row['product_id'];
            $this->addOnIds = json_decode($row['add_on_ids'], true);
            $this->flavorId = $row['flavor_id'];
            $this->quantity = $row['quantity'];
            $this->customizations = $row['customizations'];
            $this->subtotal = $row['subtotal'];
        } else {
            self::returnError('HTTP/1.1 404', 'Load OrderItem Error: OrderItem [id = ' . $this->id . '] does not exist.');
        }
        $stmt->close();
    }

    public function save() {
        $jsonAddOnIds = json_encode($this->addOnIds);
        if ($this->id) {
            $stmt = $this->conn->prepare("UPDATE order_items SET order_id = ?, product_id = ?, add_on_ids = ?, flavor_id = ?, quantity = ?, customizations = ?, subtotal = ? WHERE id = ?");
            $stmt->bind_param("iisissdi", $this->orderId, $this->productId, $jsonAddOnIds, $this->flavorId, $this->quantity, $this->customizations, $this->subtotal, $this->id);
            $stmt->execute();
            if ($stmt->affected_rows === 0) {
                self::returnError('HTTP/1.1 404', 'Update OrderItem Error: No OrderItem updated or OrderItem [id = ' . $this->id . '] does not exist.');
            }
        } else {
            $stmt = $this->conn->prepare("INSERT INTO order_items (order_id, product_id, add_on_ids, flavor_id, quantity, customizations, subtotal) VALUES (?, ?, ?, ?, ?, ?, ?)");
            $stmt->bind_param("iisissd", $this->orderId, $this->productId, $jsonAddOnIds, $this->flavorId, $this->quantity, $this->customizations, $this->subtotal);
            $stmt->execute();
            if ($stmt->affected_rows === 0) {
                self::returnError('HTTP/1.1 400', 'Create OrderItem Error: Unable to create OrderItem.');
            }
            $this->id = $this->conn->insert_id;
        }
        $stmt->close();
    }

    public function delete() {
        if (!$this->id) {
            self::returnError('HTTP/1.1 404', 'Delete OrderItem Error: OrderItem ID is missing.');
        }
        $stmt = $this->conn->prepare("DELETE FROM order_items WHERE id = ?");
        $stmt->bind_param("i", $this->id);
        $stmt->execute();
        if ($stmt->affected_rows === 0) {
            self::returnError('HTTP/1.1 404', 'Delete OrderItem Error: OrderItem [id = ' . $this->id . '] does not exist.');
        }
        $stmt->close();
    }

    public function product() {
        require_once 'Product.php';
        return new Product($this->productId);
    }

    public function flavor() {
        require_once 'Flavor.php';
        return new Flavor($this->flavorId);
    }
}
