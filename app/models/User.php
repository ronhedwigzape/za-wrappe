<?php

require_once 'App.php';

class User extends App
{
    // table
    protected $table;

    // properties
    protected $id = null;
    protected $username;
    protected $password;
    protected $name;
    protected $email;
    protected $phone;
    protected $address;
    protected $avatar;
    protected $userType;

    /***************************************************************************
     * User constructor
     *
     * @param $username
     * @param $password
     * @param $userType
     */
    public function __construct($username, $password, $userType)
    {
        parent::__construct();
        $this->username = $username;
        $this->password = $password;
        $this->table = $userType . 's';
        $this->userType = $userType;

        // get other info
        if($username != '' && $password != '') {
            $stmt = $this->conn->prepare("SELECT * FROM $this->table WHERE username = ? AND password = ?");
            $stmt->bind_param("ss", $this->username, $this->password);
            $stmt->execute();
            $result = $stmt->get_result();
            if($result->num_rows > 0) {
                $row = $result->fetch_assoc();
                $this->id = $row['id'];
                $this->name = $row['name'];
                $this->email = $row['email'];
                $this->phone = $row['phone'];
                $this->avatar = $row['avatar'];
                $this->address = $row['address'];
            }
        }
    }


    /***************************************************************************
     * Convert user object to array
     *
     * @param array $append
     * @return array
     */
    public function toArray($append = [])
    {
        $arr = [
            'id'       => $this->id,
            'name'     => $this->name,
            'username' => $this->username,
            'email'    => $this->email,
            'phone'    => $this->phone,
            'address'  => $this->address,
            'avatar'   => $this->avatar,
            'userType' => $this->userType
        ];

        // append
        foreach($append as $key => $value) {
            $arr[$key] = $value;
        }

        return $arr;
    }


    /***************************************************************************
     * Get currently signed-in user
     *
     * @return array|null
     */
    public static function getUser()
    {
        $user_info = null;
        if(isset($_SESSION['user']) && isset($_SESSION['pass'])) {
            $authenticated = (new User(
                $_SESSION['user']['username'],
                $_SESSION['pass'],
                $_SESSION['user']['userType']
            ))->signIn();

            if($authenticated)
                $user_info = [...$authenticated->toArray()];
            else
                session_destroy();
        }
        return $user_info;
    }


    /***************************************************************************
     * Authenticated or not
     *
     * @return bool
     */
    public function authenticated()
    {
        return (bool)$this->id;
    }


    /***************************************************************************
     * Sign in
     *
     * @return $this|false
     */
    public function signIn()
    {
        if($this->authenticated()) {
            $_SESSION['user'] = $this->toArray();
            $_SESSION['pass'] = $this->password;
            return $this;
        }
        return false;
    }


    /***************************************************************************
     * Sign out
     *
     * @return void
     */
    public function signOut()
    {
        if(isset($_SESSION['user']))
            session_destroy();
    }


    /***************************************************************************
     * Set name
     *
     * @param string $name
     * @return void
     */
    public function setName(string $name)
    {
        $this->name = $name;
    }


    /***************************************************************************
     * Set username
     *
     * @param string $username
     * @return void
     */
    public function setUsername(string $username)
    {
        $this->username = $username;
    }


    /***************************************************************************
     * Set password
     *
     * @param string $password
     * @return void
     */
    public function setPassword(string $password)
    {
        $this->password = $password;
    }


    /***************************************************************************
     * Get id
     *
     * @return int|null
     */
    public function getId()
    {
        return $this->id;
    }


    /***************************************************************************
     * Get name
     *
     * @return string
     */
    public function getName()
    {
        return $this->name;
    }


    /***************************************************************************
     * Get username
     *
     * @return string
     */
    public function getUsername(): string
    {
        return $this->username;
    }


    /***************************************************************************
     * Get password
     *
     * @return string
     */
    public function getPassword(): string
    {
        return $this->password;
    }


    /***************************************************************************
     * Get avatar
     *
     * @return mixed
     */
    public function getAvatar(): mixed
    {
        return $this->avatar;
    }


    /***************************************************************************
     * Get email
     *
     * @return mixed
     */
    public function getEmail(): mixed
    {
        return $this->email;
    }


    /***************************************************************************
     * Get phone number
     *
     * @return mixed
     */
    public function getPhone(): mixed
    {
        return $this->phone;
    }


    /***************************************************************************
     * Get address
     *
     * @return mixed
     */
    public function getAddress(): mixed
    {
        return $this->address;
    }


    /***************************************************************************
     * Get userType
     *
     * @return string
     */
    public function getUserType(): string
    {
        return $this->userType;
    }


    /***************************************************************************
     * Get table
     *
     * @return string
     */
    public function getTable(): string
    {
        return $this->table;
    }


    /***************************************************************************
     * Set id
     *
     * @param int|null $id
     */
    public function setId(?int $id): void
    {
        $this->id = $id;
    }

    /***************************************************************************
     * Set avatar
     *
     * @param mixed $avatar
     */
    public function setAvatar(mixed $avatar): void
    {
        $this->avatar = $avatar;
    }


    /***************************************************************************
     * Set phone number
     *
     * @param mixed $phone
     */
    public function setPhone(mixed $phone): void
    {
        $this->phone = $phone;
    }


    /***************************************************************************
     * Set address
     *
     * @param mixed $address
     */
    public function setAddress(mixed $address): void
    {
        $this->address = $address;
    }


    /***************************************************************************
     * Set email
     *
     * @param mixed $email
     */
    public function setEmail(mixed $email): void
    {
        $this->email = $email;
    }

}
