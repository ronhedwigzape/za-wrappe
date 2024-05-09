<?php

require_once 'App.php';

class Notification extends App {
    protected $table = 'notifications';

    public $id;
    public $type;
    public $receiverId;
    public $senderId;
    public $status;
    public $message;

    public function __construct($id = null) {
        parent::__construct();
        if ($id) {
            $this->id = $id;
            $this->load();
        }
    }

    private static function executeFind($stmt) {
        $stmt->execute();
        $result = $stmt->get_result();
        if ($row = $result->fetch_assoc()) {
            $notification = new self();
            $notification->id = $row['id'];
            $notification->type = $row['type'];
            $notification->receiverId = $row['receiver_id'];
            $notification->senderId = $row['sender_id'];
            $notification->status = $row['status'];
            $notification->message = $row['message'];
            return $notification;
        }
        return false;
    }

    public static function findById($id) {
        $stmt = $GLOBALS['conn']->prepare("SELECT * FROM notifications WHERE id = ?");
        $stmt->bind_param("i", $id);
        return self::executeFind($stmt);
    }

    public function toArray() {
        return [
            'id' => $this->id,
            'type' => $this->type,
            'receiverId' => $this->receiverId,
            'senderId' => $this->senderId,
            'status' => $this->status,
            'message' => $this->message
        ];
    }

    public static function all() {
        $stmt = $GLOBALS['conn']->prepare("SELECT * FROM notifications");
        $stmt->execute();
        $result = $stmt->get_result();
        $notifications = [];
        while ($row = $result->fetch_assoc()) {
            $notifications[] = self::executeFind($stmt);
        }
        return $notifications;
    }

    public static function rows() {
        return array_map(function ($notification) {
            return $notification->toArray();
        }, self::all());
    }

    public static function exists($id) {
        return (self::findById($id) != false);
    }

    private function load() {
        $stmt = $this->conn->prepare("SELECT * FROM notifications WHERE id = ?");
        $stmt->bind_param("i", $this->id);
        $stmt->execute();
        $result = $stmt->get_result();
        if ($row = $result->fetch_assoc()) {
            $this->type = $row['type'];
            $this->receiverId = $row['receiver_id'];
            $this->senderId = $row['sender_id'];
            $this->status = $row['status'];
            $this->message = $row['message'];
        } else {
            self::returnError('HTTP/1.1 404', 'Load Notification Error: Notification [id = ' . $this->id . '] does not exist.');
        }
        $stmt->close();
    }

    public function save() {
        if ($this->id) {
            $stmt = $this->conn->prepare("UPDATE notifications SET type = ?, receiver_id = ?, sender_id = ?, status = ?, message = ? WHERE id = ?");
            $stmt->bind_param("siissi", $this->type, $this->receiverId, $this->senderId, $this->status, $this->message, $this->id);
            $stmt->execute();
            if ($stmt->affected_rows === 0) {
                self::returnError('HTTP/1.1 404', 'Update Notification Error: No Notification updated or Notification [id = ' . $this->id . '] does not exist.');
            }
        } else {
            $stmt = $this->conn->prepare("INSERT INTO notifications (type, receiver_id, sender_id, status, message) VALUES (?, ?, ?, ?, ?)");
            $stmt->bind_param("siiss", $this->type, $this->receiverId, $this->senderId, $this->status, $this->message);
            $stmt->execute();
            if ($stmt->affected_rows === 0) {
                self::returnError('HTTP/1.1 400', 'Create Notification Error: Unable to create Notification.');
            }
            $this->id = $this->conn->insert_id;
        }
        $stmt->close();
    }

    public function delete() {
        if (!$this->id) {
            self::returnError('HTTP/1.1 404', 'Delete Notification Error: Notification ID is missing.');
        }
        $stmt = $this->conn->prepare("DELETE FROM notifications WHERE id = ?");
        $stmt->bind_param("i", $this->id);
        $stmt->execute();
        if ($stmt->affected_rows === 0) {
            self::returnError('HTTP/1.1 404', 'Delete Notification Error: Notification [id = ' . $this->id . '] does not exist.');
        }
        $stmt->close();
    }
}
