<?php

require_once 'App.php';

class Inventory extends App {
    protected $table = 'inventories';

    public $id;
    public $productId;
    public $count;
    public $lowStockThreshold;

    public function __construct($id = null) {
        parent::__construct();
        if ($id) {
            $this->id = $id;
            $this->load();
        }
    }

    private function load() {
        $stmt = $this->conn->prepare("SELECT * FROM inventories WHERE id = ?");
        $stmt->bind_param("i", $this->id);
        $stmt->execute();
        $result = $stmt->get_result();
        if ($row = $result->fetch_assoc()) {
            $this->productId = $row['product_id'];
            $this->count = $row['count'];
            $this->lowStockThreshold = $row['low_stock_threshold'];
        } else {
            self::returnError('HTTP/1.1 404', 'Load Inventory Error: Inventory [id = ' . $this->id . '] does not exist.');
        }
        $stmt->close();
    }

    public function save() {
        if ($this->id) {
            $stmt = $this->conn->prepare("UPDATE inventories SET product_id = ?, count = ?, low_stock_threshold = ? WHERE id = ?");
            $stmt->bind_param("iiii", $this->productId, $this->count, $this->lowStockThreshold, $this->id);
            $stmt->execute();
            if ($stmt->affected_rows === 0) {
                self::returnError('HTTP/1.1 404', 'Update Inventory Error: No Inventory updated or Inventory [id = ' . $this->id . '] does not exist.');
            }
        } else {
            $stmt = $this->conn->prepare("INSERT INTO inventories (product_id, count, low_stock_threshold) VALUES (?, ?, ?)");
            $stmt->bind_param("iii", $this->productId, $this->count, $this->lowStockThreshold);
            $stmt->execute();
            if ($stmt->affected_rows === 0) {
                self::returnError('HTTP/1.1 400', 'Create Inventory Error: Unable to create Inventory.');
            }
            $this->id = $this->conn->insert_id;
        }
        $stmt->close();
    }

    public function delete() {
        if (!$this->id) {
            self::returnError('HTTP/1.1 404', 'Delete Inventory Error: Inventory ID is missing.');
        }
        $stmt = $this->conn->prepare("DELETE FROM inventories WHERE id = ?");
        $stmt->bind_param("i", $this->id);
        $stmt->execute();
        if ($stmt->affected_rows === 0) {
            self::returnError('HTTP/1.1 404', 'Delete Inventory Error: Inventory [id = ' . $this->id . '] does not exist.');
        }
        $stmt->close();
    }

    public function product() {
        require_once 'Product.php';
        return new Product($this->productId);
    }
}
