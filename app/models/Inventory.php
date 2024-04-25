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
        }
        $stmt->close();
    }

    public function save() {
        if ($this->id) {
            $stmt = $this->conn->prepare("UPDATE inventories SET product_id = ?, count = ?, low_stock_threshold = ? WHERE id = ?");
            $stmt->bind_param("iiii", $this->productId, $this->count, $this->lowStockThreshold, $this->id);
        } else {
            $stmt = $this->conn->prepare("INSERT INTO inventories (product_id, count, low_stock_threshold) VALUES (?, ?, ?)");
            $stmt->bind_param("iii", $this->productId, $this->count, $this->lowStockThreshold);
        }
        $stmt->execute();
        if (!$this->id) $this->id = $this->conn->insert_id;
        $stmt->close();
    }

    public function delete() {
        $stmt = $this->conn->prepare("DELETE FROM inventories WHERE id = ?");
        $stmt->bind_param("i", $this->id);
        $stmt->execute();
        $stmt->close();
    }

    public function product() {
        require_once 'Product.php';
        return new Product($this->productId);
    }
}
