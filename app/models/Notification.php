<?php

require_once 'App.php';

class Notification extends App {
    protected $table = 'notifications';

    public $id;
    public $type;
    public $relatedId;
    public $status;
    public $message;

    public function __construct($id = null) {
        parent::__construct();
        if ($id) {
            $this->id = $id;
            $this->load();
        }
    }

    private function load() {
        $stmt = $this->conn->prepare("SELECT * FROM notifications WHERE id = ?");
        $stmt->bind_param("i", $this->id);
        $stmt->execute();
        $result = $stmt->get_result();
        if ($row = $result->fetch_assoc()) {
            $this->type = $row['type'];
            $this->relatedId = $row['related_id'];
            $this->status = $row['status'];
            $this->message = $row['message'];
        }
        $stmt->close();
    }

    public function save() {
        if ($this->id) {
            $stmt = $this->conn->prepare("UPDATE notifications SET type = ?, related_id = ?, status = ?, message = ? WHERE id = ?");
            $stmt->bind_param("siiss", $this->type, $this->relatedId, $this->status, $this->message, $this->id);
        } else {
            $stmt = $this->conn->prepare("INSERT INTO notifications (type, related_id, status, message) VALUES (?, ?, ?, ?)");
            $stmt->bind_param("siis", $this->type, $this->relatedId, $this->status, $this->message);
        }
        $stmt->execute();
        if (!$this->id) $this->id = $this->conn->insert_id;
        $stmt->close();
    }

    public function delete() {
        $stmt = $this->conn->prepare("DELETE FROM notifications WHERE id = ?");
        $stmt->bind_param("i", $this->id);
        $stmt->execute();
        $stmt->close();
    }
}
