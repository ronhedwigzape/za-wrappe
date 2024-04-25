<?php

require_once 'App.php';

class CategoryFlavor extends App {
    public function addFlavorToCategory($categoryId, $flavorId) {
        $stmt = $this->conn->prepare("INSERT INTO category_flavor (category_id, flavor_id) VALUES (?, ?)");
        $stmt->bind_param("ii", $categoryId, $flavorId);
        $stmt->execute();
        $stmt->close();
    }

    public function removeFlavorFromCategory($categoryId, $flavorId) {
        $stmt = $this->conn->prepare("DELETE FROM category_flavor WHERE category_id = ? AND flavor_id = ?");
        $stmt->bind_param("ii", $categoryId, $flavorId);
        $stmt->execute();
        $stmt->close();
    }
}
