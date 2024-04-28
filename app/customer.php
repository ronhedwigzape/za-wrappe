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
        if (isset($_GET['fetchCategories'])) {
            echo json_encode($customer->fetchCategories());
        }

        else if (isset($_GET['fetchProductsByCategory'])) {
            echo json_encode($customer->fetchProductsByCategory($_GET['fetchProductsByCategory']));
        }

        else if (isset($_GET['fetchCategoryFlavors'])) {
            echo json_encode($customer->fetchCategoryFlavors($_GET['fetchCategoryFlavors']));
        }

        else if (isset($_GET['fetchCategoryAddOns'])) {
            echo json_encode($customer->fetchCategoryAddOns($_GET['fetchCategoryAddOns']));
        }

        else
            denyAccess();
    }
}
