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

        // fetch all orders
        if (isset($_GET['fetchAllOrders'])) {
            echo json_encode($merchant->fetchAllOrders());
        }

        else
            denyAccess();
    }
}
