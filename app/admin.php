<?php
require_once '_init.php';

// get authenticated user
$authUser = getUser();

if(!$authUser)
    denyAccess();

else if($authUser['userType'] !== 'admin')
    denyAccess();

else {
    require_once 'models/Admin.php';
    $admin = new Admin($authUser['username'], $_SESSION['pass']);

    if(!$admin->authenticated())
        denyAccess();

//    else {
//       if (isset($_GET['bookings'])) {
//
//       }
//
//        else
//            denyAccess();
//    }
}
