<?php

require_once 'User.php';

class Merchant extends User
{

    protected $table_notifications = 'notifications';

    /***************************************************************************
     * Merchant constructor
     *
     * @param string $username
     * @param string $password
     */
    public function __construct($username = '', $password = '')
    {
        parent::__construct($username, $password, 'merchant');
    }


    /***************************************************************************
     * Execute find
     *
     * @param $stmt
     * @return Merchant|false
     */
    private static function executeFind($stmt)
    {
        $stmt->execute();
        $result = $stmt->get_result();
        if($row = $result->fetch_assoc())
            return new Merchant($row['username'], $row['password']);
        else
            return false;
    }


    /***************************************************************************
     * Find Merchant by id
     *
     * @param int $id
     * @return Merchant|boolean
     */
    public static function findById($id)
    {
        $merchant = new Merchant();
        $stmt = $merchant->conn->prepare("SELECT username, password FROM $merchant->table WHERE id = ?");
        $stmt->bind_param("i", $id);
        return self::executeFind($stmt);
    }


    /***************************************************************************
     * Convert Merchant object to array
     *
     * @param array $append
     * @return array
     */
    public function toArray($append = [])
    {
        return parent::toArray($append);
    }


    /***************************************************************************
     * Get all merchants as array of objects
     *
     * @return Merchant[]
     */
    public static function all()
    {
        $merchant = new Merchant();
        $sql = "SELECT username, password FROM $merchant->table ORDER BY id";
        $stmt = $merchant->conn->prepare($sql);
        $stmt->execute();

        $result = $stmt->get_result();
        $merchants = [];
        while($row = $result->fetch_assoc()) {
            $merchants[] = new Merchant($row['username'], $row['password']);
        }
        return $merchants;
    }


    /***************************************************************************
     * Get all merchants as array of arrays
     *
     * @return array
     */
    public static function rows()
    {
        $merchants = [];
        foreach(self::all() as $merchant) {
            $merchants[] = $merchant->toArray();
        }
        return $merchants;
    }


    /***************************************************************************
     * Check if Merchant id exists
     *
     * @param int $id
     * @return bool
     */
    public static function exists($id)
    {
        if(!$id)
            return false;

        return (self::findById($id) != false);
    }


    /***************************************************************************
     * Check if Merchant username exists
     *
     * @param string $username
     * @param int $id
     * @return bool
     */
    public static function usernameExists($username, $id = 0)
    {
        $merchant = new Merchant();
        $stmt = $merchant->conn->prepare("SELECT id FROM $merchant->table WHERE username = ? AND id != ?");
        $stmt->bind_param("si", $username, $id);
        $stmt->execute();
        $result = $stmt->get_result();
        return ($result->num_rows > 0);
    }


    /***************************************************************************
     * Insert Merchant
     *
     * @return void
     */
    public function insert()
    {
        // check id
        if(self::exists($this->id))
            App::returnError('HTTP/1.1 409', 'Insert Error: Merchant [id = ' . $this->id . '] already exists.');

        // check username
        if(trim($this->username) == '')
            App::returnError('HTTP/1.1 422', 'Insert Error: Merchant username is required.');
        else if(self::usernameExists($this->username))
            App::returnError('HTTP/1.1 409', 'Insert Error: Merchant [username = ' . $this->username . '] already exists.');

        // check password
        if($this->password == '')
            App::returnError('HTTP/1.1 422', 'Insert Error: Merchant password is required.');

        // proceed with insert
        $stmt = $this->conn->prepare("INSERT INTO $this->table(name, username, password, avatar, email, phone, address) VALUES(?, ?, ?, ?, ?, ?, ?)");
        $stmt->bind_param("sssssss", $this->name, $this->username, $this->password, $this->avatar, $this->email, $this->phone, $this->address);
        $stmt->execute();
        $this->id = $this->conn->insert_id;
    }


    /***************************************************************************
     * Update Merchant
     *
     * @return void
     */
    public function update()
    {
        // check id
        if(!self::exists($this->id))
            App::returnError('HTTP/1.1 404', 'Update Error: Merchant [id = ' . $this->id . '] does not exist.');

        // check username
        if(trim($this->username) == '')
            App::returnError('HTTP/1.1 422', 'Insert Error: Merchant username is required.');
        else if(self::usernameExists($this->username, $this->id))
            App::returnError('HTTP/1.1 409', 'Insert Error: Merchant [username = ' . $this->username . '] already exists.');

        // check password
        if($this->password == '')
            App::returnError('HTTP/1.1 422', 'Insert Error: Merchant password is required.');

        // proceed with update
        $stmt = $this->conn->prepare("UPDATE $this->table SET name = ?, username = ?, password = ? WHERE id = ?");
        $stmt->bind_param("sssi", $this->name, $this->username, $this->password, $this->id);
        $stmt->execute();
    }


    /***************************************************************************
     * Delete Merchant
     *
     * @return void
     */
    public function delete()
    {
        // check id
        if(!self::exists($this->id))
            App::returnError('HTTP/1.1 404', 'Delete Error: Merchant [id = ' . $this->id . '] does not exist.');

        // proceed with delete
        $stmt = $this->conn->prepare("DELETE FROM $this->table WHERE id = ?");
        $stmt->bind_param("i", $this->id);
        $stmt->execute();
    }


    /***************************************************************************
     * Notify the Customer that the booking has been confirmed
     *
     * @param Customer $recipient
     * @param string $message
     * @return void
     */
    public function notifyCustomer($recipient, $message)
    {

        // check sender id
        if(!self::exists($this->id))
            App::returnError('HTTP/1.1 404', 'Error: Merchant [id = ' . $this->id . '] does not exist.');

        // check recipient id
        $recipient_id = $recipient->getId();
        if (!$recipient_id)
            App::returnError('HTTP/1.1 404', 'Error: recipient [id = ' . $recipient_id . '] does not exist.');

        // check message
        if (!$message)
            App::returnError('HTTP/1.1 404', 'Error: message does not exist.');

        $stmt = $this->conn->prepare("INSERT INTO $this->table_notifications(sender_id, recipient_id, message) VALUES(?, ?, ?)");
        $stmt->bind_param("iis", $this->id,  $recipient_id, $message);
        $stmt->execute();
    }

}
