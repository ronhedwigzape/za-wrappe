<?php

require_once 'App.php';

class Flavor extends App {
    protected $table = 'flavors';

    public $id;
    public $name;
    public $description;
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
        $stmt = $this->conn->prepare("SELECT * FROM flavors WHERE id = ?");
        $stmt->bind_param("i", $this->id);
        $stmt->execute();
        $result = $stmt->get_result();
        if ($row = $result->fetch_assoc()) {
            $this->name = $row['name'];
            $this->description = $row['description'];
            $this->imageUrl = $row['image_url'];
            $this->active = $row['active'];
        }
        $stmt->close();
    }

    public function save() {
        if ($this->id) {
            $stmt = $this->conn->prepare("UPDATE flavors SET name = ?, description = ?, image_url = ?, active = ? WHERE id = ?");
            $stmt->bind_param("sssi", $this->name, $this->description, $this->imageUrl, $this->active, $this->id);
        } else {
            $stmt = $this->conn->prepare("INSERT INTO flavors (name, description, image_url, active) VALUES (?, ?, ?, ?)");
            $stmt->bind_param("sssi", $this->name, $this->description, $this->imageUrl, $this->active);
        }
        $stmt->execute();
        if (!$this->id) $this->id = $this->conn->insert_id;
        $stmt->close();
    }

    public function delete() {
        $stmt = $this->conn->prepare("DELETE FROM flavors WHERE id = ?");
        $stmt->bind_param("i", $this->id);
        $stmt->execute();
        $stmt->close();
    }

    public function categories() {
        require_once 'Category.php';
        $stmt = $this->conn->prepare("SELECT category_id FROM category_flavor WHERE flavor_id = ?");
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
