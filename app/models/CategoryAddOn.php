<?php

require_once 'App.php';

class CategoryAddOn extends App {
    public function add($categoryId, $addOnId) {
        $stmt = $this->conn->prepare("INSERT INTO category_add_on (category_id, add_on_id) VALUES (?, ?)");
        $stmt->bind_param("ii", $categoryId, $addOnId);
        if (!$stmt->execute()) {
            self::returnError('HTTP/1.1 400', 'Error adding AddOn to Category');
        }
        $stmt->close();
    }

    public function remove($categoryId, $addOnId) {
        $stmt = $this->conn->prepare("DELETE FROM category_add_on WHERE category_id = ? AND add_on_id = ?");
        $stmt->bind_param("ii", $categoryId, $addOnId);
        $stmt->execute();
        if ($stmt->affected_rows === 0) {
            self::returnError('HTTP/1.1 404', 'Error removing AddOn from Category');
        }
        $stmt->close();
    }
}
