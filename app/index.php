<?php
global $conn;
require_once '_init.php';

// get requests
if(isset($_GET['getUser'])) {
    echo json_encode([
        'user' => getUser()
    ]);

    exit;
}

// Create Customer's account
else if (isset($_POST['createAccount'])) {
    require_once 'models/App.php';

    $customers_table = 'customers';
    $avatar = 'avatar.png'; // default avatar
    $phCode = '63'; // philippine code

    $username = $_POST['userName'];
    $password = $_POST['passWord'];
    $name = $_POST['name'];
    $email = $_POST['email'];
    $phone_number = $_POST['phone'];
    $address = $_POST['address'];
    $phone = $phCode . $phone_number;

    // check if all variables are stored
    if (!$username || !$password || !$name || !$email || !$phone || !$address)
        App::returnError('HTTP/1.1 404', 'Error: Account form is invalid.');

    $stmt = $conn->prepare("INSERT INTO $customers_table (username, password, avatar, name, email, phone, address) VALUES (?, ?, ?, ?, ?, ?, ?)");
    $stmt->bind_param("sssssss",  $username, $password, $avatar, $name, $email, $phone, $address);
    $stmt->execute();
}

// user sign-in
else if(isset($_POST['username']) && isset($_POST['password'])) {
    require_once 'models/Admin.php';
    require_once 'models/Customer.php';
    require_once 'models/Merchant.php';

    // todo: validate input
    $username = trim(strtolower($_POST['username']));
    $password = $_POST['password'];

    $user = (new Admin($username, $password))->signIn();
    if(!$user) {
        $user = (new Customer($username, $password))->signIn();
        if(!$user)
            $user = (new Merchant($username, $password))->signIn();
    }

    if($user) {
        // successfully logged in
        echo json_encode([
            'user' => [...$user->toArray(),]
        ]);
    }
    else
        App::returnError('HTTP/1.1 401', 'Invalid Username or Password');

    exit;
}

// user sign out
else if(isset($_POST['signOut'])) {
    if($user_info = getUser()) {
        require_once 'models/User.php';
        $user = new User($user_info['username'], $_SESSION['pass'], $user_info['userType']);
        $user->signOut();
    }
    echo json_encode([
        'signedOut' => true
    ]);

    exit;
}