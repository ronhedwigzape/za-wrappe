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
}
