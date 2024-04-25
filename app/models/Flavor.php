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
        } else {
            self::returnError('HTTP/1.1 404', 'Load Flavor Error: Flavor [id = ' . $this->id . '] does not exist.');
        }
        $stmt->close();
    }

    public function save() {
        if ($this->id) {
            $stmt = $this->conn->prepare("UPDATE flavors SET name = ?, description = ?, image_url = ?, active = ? WHERE id = ?");
            $stmt->bind_param("sssii", $this->name, $this->description, $this->imageUrl, $this->active, $this->id);
            $stmt->execute();
            if ($stmt->affected_rows === 0) {
                self::returnError('HTTP/1.1 404', 'Update Flavor Error: No Flavor updated or Flavor [id = ' . $this->id . '] does not exist.');
            }
        } else {
            $stmt = $this->conn->prepare("INSERT INTO flavors (name, description, image_url, active) VALUES (?, ?, ?, ?)");
            $stmt->bind_param("sssi", $this->name, $this->description, $this->imageUrl, $this->active);
            $stmt->execute();
            if ($stmt->affected_rows === 0) {
                self::returnError('HTTP/1.1 400', 'Create Flavor Error: Unable to create Flavor.');
            }
            $this->id = $this->conn->insert_id;
        }
        $stmt->close();
    }

    public function delete() {
        if (!$this->id) {
            self::returnError('HTTP/1.1 404', 'Delete Flavor Error: Flavor ID is missing.');
        }
        $stmt = $this->conn->prepare("DELETE FROM flavors WHERE id = ?");
        $stmt->bind_param("i", $this->id);
        $stmt->execute();
        if ($stmt->affected_rows === 0) {
            self::returnError('HTTP/1.1 404', 'Delete Flavor Error: Flavor [id = ' . $this->id . '] does not exist.');
        }
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
