<?php

require_once 'App.php';

class AddOn extends App {
    protected $table = 'add_ons';

    public $id;
    public $name;
    public $description;
    public $imageUrl;
    public $price;
    public $active;

    public function __construct($id = null) {
        parent::__construct();
        if ($id) {
            $this->id = $id;
            $this->load();
        }
    }

    private function load() {
        $stmt = $this->conn->prepare("SELECT * FROM add_ons WHERE id = ?");
        $stmt->bind_param("i", $this->id);
        $stmt->execute();
        $result = $stmt->get_result();
        if ($row = $result->fetch_assoc()) {
            $this->name = $row['name'];
            $this->description = $row['description'];
            $this->imageUrl = $row['image_url'];
            $this->price = $row['price'];
            $this->active = $row['active'];
        } else {
            self::returnError('HTTP/1.1 404', 'Load AddOn Error: AddOn [id = ' . $this->id . '] does not exist.');
        }
        $stmt->close();
    }

    public function save() {
        if ($this->id) {
            $stmt = $this->conn->prepare("UPDATE add_ons SET name = ?, description = ?, image_url = ?, price = ?, active = ? WHERE id = ?");
            $stmt->bind_param("sssdi", $this->name, $this->description, $this->imageUrl, $this->price, $this->active, $this->id);
            $stmt->execute();
            if ($stmt->affected_rows === 0) {
                self::returnError('HTTP/1.1 404', 'Update AddOn Error: No AddOn updated or AddOn [id = ' . $this->id . '] does not exist.');
            }
        } else {
            $stmt = $this->conn->prepare("INSERT INTO add_ons (name, description, image_url, price, active) VALUES (?, ?, ?, ?, ?)");
            $stmt->bind_param("sssdi", $this->name, $this->description, $this->imageUrl, $this->price, $this->active);
            $stmt->execute();
            if ($stmt->affected_rows === 0) {
                self::returnError('HTTP/1.1 400', 'Create AddOn Error: Unable to create AddOn.');
            }
            $this->id = $this->conn->insert_id;
        }
        $stmt->close();
    }

    public function delete() {
        if (!$this->id) {
            self::returnError('HTTP/1.1 404', 'Delete AddOn Error: AddOn ID is missing.');
        }
        $stmt = $this->conn->prepare("DELETE FROM add_ons WHERE id = ?");
        $stmt->bind_param("i", $this->id);
        $stmt->execute();
        if ($stmt->affected_rows === 0) {
            self::returnError('HTTP/1.1 404', 'Delete AddOn Error: AddOn [id = ' . $this->id . '] does not exist.');
        }
        $stmt->close();
    }

    public function categories() {
        require_once 'Category.php';
        $stmt = $this->conn->prepare("SELECT category_id FROM category_add_on WHERE add_on_id = ?");
        $stmt->bind_param("i", $this->id);
        $stmt->execute();
        $result = $stmt->get_result();
        $categories = [];
        while ($row = $result->fetch_assoc()) {
            $categories[] = new Category($row['category_id']);
        }
        $stmt->close();
        return $categories;
    }
}
