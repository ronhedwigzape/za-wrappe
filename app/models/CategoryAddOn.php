<?php

require_once 'App.php';

class CategoryAddOn extends App {
    public function addAddOnToCategory($categoryId, $addOnId) {
        $stmt = $this->conn->prepare("INSERT INTO category_add_on (category_id, add_on_id) VALUES (?, ?)");
        $stmt->bind_param("ii", $categoryId, $addOnId);
        $stmt->execute();
        $stmt->close();
    }

    public function removeAddOnFromCategory($categoryId, $addOnId) {
        $stmt = $this->conn->prepare("DELETE FROM category_add_on WHERE category_id = ? AND add_on_id = ?");
        $stmt->bind_param("ii", $categoryId, $addOnId);
        $stmt->execute();
        $stmt->close();
    }
}
