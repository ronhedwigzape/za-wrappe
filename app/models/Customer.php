<?php

require_once 'User.php';

class Customer extends User
{

    /***************************************************************************
     * Customer constructor
     *
     * @param string $username
     * @param string $password
     */
    public function __construct($username = '', $password = '')
    {
        parent::__construct($username, $password, 'Customer');
    }


    /***************************************************************************
     * Execute find
     *
     * @param $stmt
     * @return Customer|false
     */
    private static function executeFind($stmt)
    {
        $stmt->execute();
        $result = $stmt->get_result();
        if($row = $result->fetch_assoc())
            return new Customer($row['username'], $row['password']);
        else
            return false;
    }


    /***************************************************************************
     * Find Customer by id
     *
     * @param int $id
     * @return Customer|boolean
     */
    public static function findById($id)
    {
        $customer = new Customer();
        $stmt = $customer->conn->prepare("SELECT username, password FROM $customer->table WHERE id = ?");
        $stmt->bind_param("i", $id);
        return self::executeFind($stmt);
    }


    /***************************************************************************
     * Get all customers as array of objects
     *
     * @return Customer[]
     */
    public static function all()
    {
        $customer = new Customer();
        $sql = "SELECT username, password FROM $customer->table ORDER BY id";
        $stmt = $customer->conn->prepare($sql);
        $stmt->execute();

        $result = $stmt->get_result();
        $customers = [];
        while($row = $result->fetch_assoc()) {
            $customers[] = new Customer($row['username'], $row['password']);
        }
        return $customers;
    }


    /***************************************************************************
     * Get all customers as array of arrays
     *
     * @return array
     */
    public static function rows()
    {
        $customers = [];
        foreach(self::all() as $customer) {
            $customers[] = $customer->toArray();
        }
        return $customers;
    }


    /***************************************************************************
     * Check if Customer id exists
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
     * Check if Customer username exists
     *
     * @param string $username
     * @param int $id
     * @return bool
     */
    public static function usernameExists($username, $id = 0)
    {
        $customer = new Customer();
        $stmt = $customer->conn->prepare("SELECT id FROM $customer->table WHERE username = ? AND id != ?");
        $stmt->bind_param("si", $username, $id);
        $stmt->execute();
        $result = $stmt->get_result();
        return ($result->num_rows > 0);
    }


    /***************************************************************************
     * Insert Customer
     *
     * @return void
     */
    public function insert()
    {
        // check id
        if(self::exists($this->id))
            App::returnError('HTTP/1.1 409', 'Insert Error: Customer [id = ' . $this->id . '] already exists.');

        // check username
        if(trim($this->username) == '')
            App::returnError('HTTP/1.1 422', 'Insert Error: Customer username is required.');
        else if(self::usernameExists($this->username))
            App::returnError('HTTP/1.1 409', 'Insert Error: Customer [username = ' . $this->username . '] already exists.');

        // check password
        if($this->password == '')
            App::returnError('HTTP/1.1 422', 'Insert Error: Customer password is required.');

        // proceed with insert
        $stmt = $this->conn->prepare("INSERT INTO $this->table(name, username, password, avatar, email, phone, address) VALUES(?, ?, ?, ?, ?, ?, ?)");
        $stmt->bind_param("sssssss", $this->name, $this->username, $this->password, $this->avatar, $this->email, $this->phone, $this->address);
        $stmt->execute();
    }


    /***************************************************************************
     * Update Customer
     *
     * @return void
     */
    public function update()
    {
        // check id
        if(!self::exists($this->id))
            App::returnError('HTTP/1.1 404', 'Update Error: Customer [id = ' . $this->id . '] does not exist.');

        // check username
        if(trim($this->username) == '')
            App::returnError('HTTP/1.1 422', 'Insert Error: Customer username is required.');
        else if(self::usernameExists($this->username, $this->id))
            App::returnError('HTTP/1.1 409', 'Insert Error: Customer [username = ' . $this->username . '] already exists.');

        // check password
        if($this->password == '')
            App::returnError('HTTP/1.1 422', 'Insert Error: Customer password is required.');

        // proceed with update
        $stmt = $this->conn->prepare("UPDATE $this->table SET name = ?, username = ?, password = ? WHERE id = ?");
        $stmt->bind_param("sssi", $this->username, $this->password, $this->id);
        $stmt->execute();
    }


    /***************************************************************************
     * Delete Customer
     *
     * @return void
     */
    public function delete()
    {
        // check id
        if(!self::exists($this->id))
            App::returnError('HTTP/1.1 404', 'Delete Error: Customer [id = ' . $this->id . '] does not exist.');

        // proceed with delete
        $stmt = $this->conn->prepare("DELETE FROM $this->table WHERE id = ?");
        $stmt->bind_param("i", $this->id);
        $stmt->execute();
    }


}
