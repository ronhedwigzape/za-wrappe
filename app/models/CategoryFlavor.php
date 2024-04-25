<?php

require_once 'App.php';

class CategoryFlavor extends App {
    public function add($categoryId, $flavorId) {
        $stmt = $this->conn->prepare("INSERT INTO category_flavor (category_id, flavor_id) VALUES (?, ?)");
        $stmt->bind_param("ii", $categoryId, $flavorId);
        if (!$stmt->execute()) {
            self::returnError('HTTP/1.1 400', 'Error adding Flavor to Category');
        }
        $stmt->close();
    }

    public function remove($categoryId, $flavorId) {
        $stmt = $this->conn->prepare("DELETE FROM category_flavor WHERE category_id = ? AND flavor_id = ?");
        $stmt->bind_param("ii", $categoryId, $flavorId);
        $stmt->execute();
        if ($stmt->affected_rows === 0) {
            self::returnError('HTTP/1.1 404', 'Error removing Flavor from Category');
        }
        $stmt->close();
    }

    public static function exists($categoryId, $flavorId) {
        $stmt = $GLOBALS['conn']->prepare("SELECT 1 FROM category_flavor WHERE category_id = ? AND flavor_id = ?");
        $stmt->bind_param("ii", $categoryId, $flavorId);
        $stmt->execute();
        $result = $stmt->get_result();
        return $result->num_rows > 0;
    }

    public static function all() {
        $stmt = $GLOBALS['conn']->prepare("SELECT * FROM category_flavor");
        $stmt->execute();
        $result = $stmt->get_result();
        $categoryFlavors = [];
        while ($row = $result->fetch_assoc()) {
            $categoryFlavors[] = $row;
        }
        return $categoryFlavors;
    }

    public static function rows() {
        return self::all();
    }
}
