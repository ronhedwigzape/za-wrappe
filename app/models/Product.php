<?php

require_once 'App.php';

class Product extends App {
    protected $table = 'products';

    public $id;
    public $name;
    public $description;
    public $price;
    public $categoryId;
    public $imageUrl;
    public $active;

    public function __construct($id = null) {
        parent::__construct();
        if ($id) {
            $this->id = $id;
            $this->load();
        }
    }

    private function load() {
        $stmt = $this->conn->prepare("SELECT * FROM products WHERE id = ?");
        $stmt->bind_param("i", $this->id);
        $stmt->execute();
        $result = $stmt->get_result();
        if ($row = $result->fetch_assoc()) {
            $this->name = $row['name'];
            $this->description = $row['description'];
            $this->price = $row['price'];
            $this->categoryId = $row['category_id'];
            $this->imageUrl = $row['image_url'];
            $this->active = $row['active'];
        } else {
            self::returnError('HTTP/1.1 404', 'Load Product Error: Product [id = ' . $this->id . '] does not exist.');
        }
        $stmt->close();
    }

    public function save() {
        if ($this->id) {
            $stmt = $this->conn->prepare("UPDATE products SET name = ?, description = ?, price = ?, category_id = ?, image_url = ?, active = ? WHERE id = ?");
            $stmt->bind_param("ssdisii", $this->name, $this->description, $this->price, $this->categoryId, $this->imageUrl, $this->active, $this->id);
            $stmt->execute();
            if ($stmt->affected_rows === 0) {
                self::returnError('HTTP/1.1 404', 'Update Product Error: No product updated or Product [id = ' . $this->id . '] does not exist.');
            }
        } else {
            $stmt = $this->conn->prepare("INSERT INTO products (name, description, price, category_id, image_url, active) VALUES (?, ?, ?, ?, ?, ?)");
            $stmt->bind_param("ssdisi", $this->name, $this->description, $this->price, $this->categoryId, $this->imageUrl, $this->active);
            $stmt->execute();
            if ($stmt->affected_rows === 0) {
                self::returnError('HTTP/1.1 400', 'Create Product Error: Unable to create product.');
            }
            $this->id = $this->conn->insert_id;
        }
        $stmt->close();
    }

    public function delete() {
        if (!$this->id) {
            self::returnError('HTTP/1.1 404', 'Delete Product Error: Product ID is missing.');
        }
        $stmt = $this->conn->prepare("DELETE FROM products WHERE id = ?");
        $stmt->bind_param("i", $this->id);
        $stmt->execute();
        if ($stmt->affected_rows === 0) {
            self::returnError('HTTP/1.1 404', 'Delete Product Error: Product [id = ' . $this->id . '] does not exist.');
        }
        $stmt->close();
    }

    public function category() {
        require_once 'Category.php';
        return new Category($this->categoryId);
    }

    public function inventory() {
        require_once 'Inventory.php';
        return new Inventory(null, $this->id);
    }

    public function orderItems() {
        require_once 'OrderItem.php';
        $stmt = $this->conn->prepare("SELECT id FROM order_items WHERE product_id = ?");
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
}
