<?php
require_once '_init.php';

// get authenticated user
$authUser = getUser();

if(!$authUser)
    denyAccess();

else if($authUser['userType'] !== 'customer')
    denyAccess();

else {
    require_once 'models/Customer.php';
    $customer = new Customer($authUser['username'], $_SESSION['pass']);

    if(!$customer->authenticated())
        denyAccess();

    else {

        // get all Customer bookings
        if (isset($_GET['getOrders'])) {
            echo json_encode([
                'orders' => ''

            ]);
        }

        else
            denyAccess();
    }
}
