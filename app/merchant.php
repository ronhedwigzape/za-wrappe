<?php
require_once '_init.php';

// get authenticated user
$authUser = getUser();

if(!$authUser)
    denyAccess();

else if($authUser['userType'] !== 'merchant')
    denyAccess();

else {
    require_once 'models/Merchant.php';
    $merchant = new Merchant($authUser['username'], $_SESSION['pass']);

    if(!$merchant->authenticated())
        denyAccess();

    else {

        // fetch restaurant bookings
        if (isset($_GET['getRestaurantBookings'])) {
            echo json_encode([
                'orders' => ''
            ]);
        }

        else
            denyAccess();
    }
}
