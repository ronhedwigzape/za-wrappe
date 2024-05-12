<?php
require_once '_init.php';

// Get authenticated user
$authUser = getUser();

if (!$authUser)
    denyAccess();
else if ($authUser['userType'] !== 'merchant')
    denyAccess();
else {
    require_once 'models/Merchant.php';
    $merchant = new Merchant($authUser['username'], $_SESSION['pass']);

    if (!$merchant->authenticated())
        denyAccess();
    else {
        // Fetch all orders
        if (isset($_GET['fetchAllOrders'])) {
            echo json_encode($merchant->fetchAllOrders());
        }
        // Fetch sales reports
        else if (isset($_GET['fetchSalesReport'])) {
            echo json_encode($merchant->fetchSalesReport($_GET['fetchSalesReport']));
        }
        // Fetch notifications from customers
        else if (isset($_GET['fetchNotificationsFromCustomers'])) {
            echo json_encode($merchant->fetchNotificationsFromCustomers());
        }

        else if (isset($_POST['cancelOrder'])) {
            $orderId = $_POST['orderId'];
            $response = $merchant->cancelOrder($orderId);
            echo json_encode($response);
        }
        else if (isset($_POST['prepareOrder'])) {
            $orderId = $_POST['orderId'];
            $response = $merchant->prepareOrder($orderId);
            echo json_encode($response);
        }
        else if (isset($_POST['setOrderReadyForPickup'])) {
            $orderId = $_POST['orderId'];
            $response = $merchant->setOrderReadyForPickup($orderId);
            echo json_encode($response);
        }

        else if (isset($_POST['processPaymentAndGenerateReceipt'])) {
            $orderId = $_POST['orderId'];
            $amount = $_POST['amount'];
            $paymentMethod = $_POST['paymentMethod'];
            $transactionId = $_POST['transactionId'];
            $response = $merchant->processPaymentAndGenerateReceipt($orderId, $amount, $paymentMethod, $transactionId);
            echo json_encode($response);
            exit();
        }

        // Export orders to XLS
        else if (isset($_GET['exportOrdersToXLS'])) {
            $merchant->exportOrdersToXLS(); // This will trigger a download
        }
        // Import orders from XLS
        else if (isset($_POST['importOrdersFromXLS']) && isset($_FILES['orderFile'])) {
            $filePath = $_FILES['orderFile']['tmp_name'];
            echo json_encode($merchant->importOrdersFromXLS($filePath));
        }
        else {
            denyAccess();
        }
    }
}
