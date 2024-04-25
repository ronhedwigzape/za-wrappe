<?php

require_once 'App.php';

class Category extends App {
    protected $table = 'categories';

    public $id;
    public $name;
    public $description;
    public $imageUrl;

    public function __construct($id = null) {
        parent::__construct();
        if ($id) {
            $this->id = $id;
            $this->load();
        }
    }

    private function load() {
        $stmt = $this->conn->prepare("SELECT * FROM categories WHERE id = ?");
        $stmt->bind_param("i", $this->id);
        $stmt->execute();
        $result = $stmt->get_result();
        if ($row = $result->fetch_assoc()) {
            $this->name = $row['name'];
            $this->description = $row['description'];
            $this->imageUrl = $row['image_url'];
        } else {
            self::returnError('HTTP/1.1 404', 'Load Category Error: Category [id = ' . $this->id . '] does not exist.');
        }
        $stmt->close();
    }

    public function save() {
        if ($this->id) {
            $stmt = $this->conn->prepare("UPDATE categories SET name = ?, description = ?, image_url = ? WHERE id = ?");
            $stmt->bind_param("sssi", $this->name, $this->description, $this->imageUrl, $this->id);
            $stmt->execute();
            if ($stmt->affected_rows === 0) {
                self::returnError('HTTP/1.1 404', 'Update Category Error: No Category updated or Category [id = ' . $this->id . '] does not exist.');
            }
        } else {
            $stmt = $this->conn->prepare("INSERT INTO categories (name, description, image_url) VALUES (?, ?, ?)");
            $stmt->bind_param("sss", $this->name, $this->description, $this->imageUrl);
            $stmt->execute();
            if ($stmt->affected_rows === 0) {
                self::returnError('HTTP/1.1 400', 'Create Category Error: Unable to create Category.');
            }
            $this->id = $this->conn->insert_id;
        }
        $stmt->close();
    }

    public function delete() {
        if (!$this->id) {
            self::returnError('HTTP/1.1 404', 'Delete Category Error: Category ID is missing.');
        }
        $stmt = $this->conn->prepare("DELETE FROM categories WHERE id = ?");
        $stmt->bind_param("i", $this->id);
        $stmt->execute();
        if ($stmt->affected_rows === 0) {
            self::returnError('HTTP/1.1 404', 'Delete Category Error: Category [id = ' . $this->id . '] does not exist.');
        }
        $stmt->close();
    }

    public function products() {
        require_once 'Product.php';
        $stmt = $this->conn->prepare("SELECT id FROM products WHERE category_id = ?");
        $stmt->bind_param("i", $this->id);
        $stmt->execute();
        $result = $stmt->get_result();
        $products = [];
        while ($row = $result->fetch_assoc()) {
            $products[] = new Product($row['id']);
        }
        $stmt->close();
        return $products;
    }

    public function flavors() {
        require_once 'Flavor.php';
        $stmt = $this->conn->prepare("SELECT flavor_id FROM category_flavor WHERE category_id = ?");
        $stmt->bind_param("i", $this->id);
        $stmt->execute();
        $result = $stmt->get_result();
        $flavors = [];
        while ($row = $result->fetch_assoc()) {
            $flavors[] = new Flavor($row['flavor_id']);
        }
        $stmt->close();
        return $flavors;
    }

    public function addOns() {
        require_once 'AddOn.php';
        $stmt = $this->conn->prepare("SELECT add_on_id FROM category_add_on WHERE category_id = ?");
        $stmt->bind_param("i", $this->id);
        $stmt->execute();
        $result = $stmt->get_result();
        $addOns = [];
        while ($row = $result->fetch_assoc()) {
            $addOns[] = new AddOn($row['add_on_id']);
        }
        $stmt->close();
        return $addOns;
    }
}
