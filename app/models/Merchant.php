<?php

require_once 'User.php';

class Merchant extends User
{

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
     * Fetches detailed information for a specific order by ID.
     *
     * This function retrieves a complete order record along with its associated items, products,
     * and inventory details from the database. The information is aggregated into a single array.
     *
     * @param int $orderId The ID of the order to fetch.
     * @return array|null Returns an associative array containing detailed order information or null if not found.
     */
    public function fetchOrder($orderId) {
        $stmt = $this->conn->prepare("SELECT o.*, oi.*, p.*, i.* FROM orders o
            LEFT JOIN order_items oi ON o.id = oi.order_id
            LEFT JOIN products p ON oi.product_id = p.id
            LEFT JOIN inventories i ON p.id = i.product_id
            WHERE o.id = ?");
        $stmt->bind_param("i", $orderId);
        $stmt->execute();
        $result = $stmt->get_result();
        $order = null;
        while ($row = $result->fetch_assoc()) {
            if (!$order) {
                $order = [
                    'id' => $row['id'],
                    'status' => $row['status'],
                    'customer_contact' => $row['customer_contact'],
                    'total_price' => $row['total_price'],
                    'verification_code' => $row['verification_code'],
                    'payment_status' => $row['payment_status'],
                    'created_at' => $row['created_at'],
                    'updated_at' => $row['updated_at'],
                    'order_items' => []
                ];
            }
            if ($row['order_id']) {
                $order['order_items'][] = [
                    'id' => $row['order_id'],
                    'product_id' => $row['product_id'],
                    'quantity' => $row['quantity'],
                    'subtotal' => $row['subtotal'],
                    'add_on_ids' => $row['add_on_ids'],
                    'flavor_id' => $row['flavor_id'],
                    'product' => [
                        'id' => $row['product_id'],
                        'name' => $row['name'],
                        'category_id' => $row['category_id'],
                        'description' => $row['description'],
                        'price' => $row['price'],
                        'image_url' => $row['image_url'],
                        'active' => $row['active'],
                        'created_at' => $row['created_at'],
                        'updated_at' => $row['updated_at']
                    ],
                    'inventory' => [
                        'id' => $row['id'],
                        'count' => $row['count'],
                        'product_id' => $row['product_id'],
                        'low_stock_threshold' => $row['low_stock_threshold'],
                        'created_at' => $row['created_at'],
                        'updated_at' => $row['updated_at']
                    ]
                ];
            }
        }
        return $order;
    }

    /***************************************************************************
     * Fetches all orders from the database along with detailed information.
     *
     * This function retrieves all orders and their related details including order items, product details,
     * and inventory status, structuring them into a comprehensive array of orders.
     *
     * @return array Returns an array of associative arrays, each containing detailed information about an order.
     */
    public function fetchAllOrders() {
        $stmt = $this->conn->prepare("
            SELECT 
                o.*, oi.*, p.*, i.* 
            FROM 
                orders o
            LEFT JOIN 
                order_items oi ON o.id = oi.order_id
            LEFT JOIN 
                products p ON oi.product_id = p.id
            LEFT JOIN 
                inventories i ON p.id = i.product_id
        ");
        $stmt->execute();
        $result = $stmt->get_result();

        $orders = [];

        while ($row = $result->fetch_assoc()) {
            $orderId = $row['id'];
            if (!isset($orders[$orderId])) {
                $orders[$orderId] = [
                    'id' => $row['id'],
                    'status' => $row['status'],
                    'customer_contact' => $row['customer_contact'],
                    'total_price' => $row['total_price'],
                    'verification_code' => $row['verification_code'],
                    'payment_status' => $row['payment_status'],
                    'created_at' => $row['created_at'],
                    'updated_at' => $row['updated_at'],
                    'order_items' => []
                ];
            }

            if ($row['order_id']) {
                $orders[$orderId]['order_items'][] = [
                    'id' => $row['oi_id'],
                    'order_id' => $row['order_id'],
                    'product_id' => $row['product_id'],
                    'quantity' => $row['quantity'],
                    'subtotal' => $row['subtotal'],
                    'add_on_ids' => $row['add_on_ids'],
                    'flavor_id' => $row['flavor_id'],
                    'product' => [
                        'id' => $row['product_id'],
                        'name' => $row['name'],
                        'category_id' => $row['category_id'],
                        'description' => $row['description'],
                        'price' => $row['price'],
                        'image_url' => $row['image_url'],
                        'active' => $row['active'],
                        'created_at' => $row['created_at'],
                        'updated_at' => $row['updated_at']
                    ],
                    'inventory' => [
                        'id' => $row['inventory_id'],
                        'count' => $row['count'],
                        'product_id' => $row['product_id'],
                        'low_stock_threshold' => $row['low_stock_threshold'],
                        'created_at' => $row['created_at'],
                        'updated_at' => $row['updated_at']
                    ]
                ];
            }
        }

        return array_values($orders);
    }

    /***************************************************************************
     * Retrieves the price of a product by its ID from the database.
     *
     * This method executes a prepared statement to fetch the price of a specified product
     * from the `products` table. If the product is found, it returns its price; otherwise, it returns 0.
     *
     * @param int $productId The ID of the product for which the price is to be fetched.
     * @return float Returns the price of the product, or 0 if the product is not found.
     */
    private function getProductPrice($productId) {
        $stmt = $this->conn->prepare("SELECT price FROM products WHERE id = ?");
        $stmt->bind_param("i", $productId);
        $stmt->execute();
        $result = $stmt->get_result();
        if ($row = $result->fetch_assoc()) {
            return $row['price'];
        }
        return 0;
    }

    /***************************************************************************
     * Calculates the total price of selected add-ons by their IDs.
     *
     * This method sums up the prices of active add-ons specified by their IDs. It handles multiple add-ons
     * and returns the total additional cost.
     *
     * @param array $addOnIds An array of add-on IDs for which the prices are to be summed.
     * @return float Returns the total price of the add-ons.
     */
    private function getAddOnsPrice($addOnIds) {
        if (empty($addOnIds)) {
            return 0;
        }
        $totalAddOnsPrice = 0;
        foreach ($addOnIds as $addOnId) {
            $stmt = $this->conn->prepare("SELECT price FROM add_ons WHERE id = ? AND active = 1");
            $stmt->bind_param("i", $addOnId);
            $stmt->execute();
            $result = $stmt->get_result();
            if ($row = $result->fetch_assoc()) {
                $totalAddOnsPrice += $row['price'];
            }
        }
        return $totalAddOnsPrice;
    }

    /***************************************************************************
     * Calculates the subtotal for a product including its add-ons, based on quantity.
     *
     * This method calculates the total cost of a product, considering the base product price,
     * add-on prices, and the specified quantity. It leverages other private methods to fetch
     * product and add-on prices.
     *
     * @param int $productId The product ID.
     * @param int $quantity The quantity of the product.
     * @param array $addOnIds Array of add-on IDs to include in pricing.
     * @return float Returns the calculated subtotal.
     */
    private function calculateSubtotal($productId, $quantity, $addOnIds) {
        $productPrice = $this->getProductPrice($productId);
        $addOnsPrice = $this->getAddOnsPrice($addOnIds);
        return ($productPrice + $addOnsPrice) * $quantity;
    }

    /***************************************************************************
     * Updates an existing order with new item details.
     *
     * This function updates specified items within an order, recalculating subtotals and the order's total price.
     * It manages database transactions to ensure data consistency and integrity during the update process.
     *
     * @param int $orderId The ID of the order to update.
     * @param array $items An array of items with their updated details to be processed.
     * @return array Returns a response indicating the success of the update along with updated order details.
     * @throws Exception Propagates any exceptions thrown during the database operations.
     */
    public function updateOrder($orderId, $items) {
        $this->conn->begin_transaction();
        try {
            $totalPrice = 0;

            foreach ($items as $item) {
                // Retrieve and update the order item
                $stmt = $this->conn->prepare("SELECT product_id, quantity FROM order_items WHERE id = ?");
                $stmt->bind_param("i", $item['order_item_id']);
                $stmt->execute();
                $result = $stmt->get_result();
                if ($row = $result->fetch_assoc()) {
                    // Calculate new subtotal
                    $newSubtotal = $this->calculateSubtotal($row['product_id'], $item['quantity'], $item['add_ons']);

                    // Update the order item
                    $addOnIdsJson = json_encode($item['add_ons']);
                    $updateStmt = $this->conn->prepare("UPDATE order_items SET quantity = ?, add_on_ids = ?, flavor_id = ?, subtotal = ? WHERE id = ?");
                    $updateStmt->bind_param("issdi", $item['quantity'], $addOnIdsJson, $item['flavor_id'], $newSubtotal, $item['order_item_id']);
                    $updateStmt->execute();

                    // Add to total price
                    $totalPrice += $newSubtotal;
                } else {
                    throw new Exception("Order item not found.");
                }
            }

            // Update the total price in the order
            $updateOrderStmt = $this->conn->prepare("UPDATE orders SET total_price = ? WHERE id = ?");
            $updateOrderStmt->bind_param("di", $totalPrice, $orderId);
            $updateOrderStmt->execute();

            // Commit the transaction
            $this->conn->commit();
            return [
                "message" => "Order updated successfully.",
                "order_id" => $orderId,
                "total_price" => number_format($totalPrice, 2)
            ];
        } catch (Exception $e) {
            $this->conn->rollback();
            return ["error" => "Failed to update order: " . $e->getMessage()];
        }
    }

    /***************************************************************************
     * Updates the status of a specific order in the database.
     *
     * This function updates the status field of an order, useful for changing order states like processing,
     * shipping, or completed.
     *
     * @param int $orderId The ID of the order whose status is to be updated.
     * @param string $newStatus The new status to assign to the order.
     * @return array Returns a response message indicating the success or failure of the update.
     */
    public function updateOrderStatus($orderId, $newStatus) {
        // Check if the order exists
        $stmt = $this->conn->prepare("SELECT id FROM orders WHERE id = ?");
        $stmt->bind_param("i", $orderId);
        $stmt->execute();
        $result = $stmt->get_result();

        if ($result->num_rows == 0) {
            return ["error" => "Order not found."];
        }

        $updateStmt = $this->conn->prepare("UPDATE orders SET status = ? WHERE id = ?");
        $updateStmt->bind_param("si", $newStatus, $orderId);
        $success = $updateStmt->execute();

        if ($success) {
            return [
                "message" => "Order status updated successfully.",
                "order_id" => $orderId,
                "new_status" => $newStatus
            ];
        } else {
            return ["error" => "Failed to update order status."];
        }
    }

    /***************************************************************************
     * Adds a new item to an existing order.
     *
     * This function inserts a new item into an order, calculating the necessary totals and subtotals based on
     * product and add-on prices.
     *
     * @param int $orderId The ID of the order to which the item is being added.
     * @param int $productId The ID of the product to add.
     * @param int $quantity The quantity of the product.
     * @param array $addOns An array of add-on IDs applied to the product.
     * @param int $flavorId The ID of the flavor, if applicable.
     * @return array Returns a message indicating success or failure along with the newly added order item details.
     */
    public function addItemToOrder($orderId, $productId, $quantity, $addOns, $flavorId) {
        $productPrice = $this->fetchProductPrice($productId);
        $addOnsPrice = $this->calculateAddOnsPrice($addOns, $quantity);
        $subtotal = ($productPrice * $quantity) + $addOnsPrice;

        $add_on_ids = json_encode($addOns);
        $stmt = $this->conn->prepare("INSERT INTO order_items (order_id, product_id, quantity, add_on_ids, flavor_id, subtotal) VALUES (?, ?, ?, ?, ?, ?)");
        $stmt->bind_param("iiisii", $orderId, $productId, $quantity, $add_on_ids, $flavorId, $subtotal);
        $success = $stmt->execute();

        if ($success) {
            $orderItemId = $stmt->insert_id;
            return [
                "message" => "Item added to order successfully",
                "order_item" => $this->fetchOrderItem($orderItemId)
            ];
        } else {
            return ["error" => "Failed to add item to order."];
        }
    }

    /***************************************************************************
     * Updates an existing order item with new quantity or add-ons.
     *
     * This function recalculates and updates the subtotal for an order item based on changes to quantity
     * or add-ons, updating the relevant records in the database.
     *
     * @param int $orderId The ID of the order containing the item.
     * @param int $orderItemId The ID of the order item to update.
     * @param int $quantity The updated quantity of the item.
     * @param array $addOns An updated list of add-on IDs.
     * @param int $flavorId The flavor ID, if applicable.
     * @return array Returns a message indicating the success or failure of the update.
     */
    public function updateOrderItem($orderId, $orderItemId, $quantity, $addOns, $flavorId) {
        $productPrice = $this->fetchProductPriceFromOrderItem($orderItemId);
        $addOnsPrice = $this->calculateAddOnsPrice($addOns, $quantity);
        $subtotal = ($productPrice * $quantity) + $addOnsPrice;

        $add_on_ids = json_encode($addOns);
        $stmt = $this->conn->prepare("UPDATE order_items SET quantity = ?, add_on_ids = ?, flavor_id = ?, subtotal = ? WHERE id = ? AND order_id = ?");
        $stmt->bind_param("isiisi", $quantity, $add_on_ids, $flavorId, $subtotal, $orderItemId, $orderId);
        $success = $stmt->execute();

        if ($success) {
            return ["message" => "Order item updated successfully."];
        } else {
            return ["error" => "Failed to update order item."];
        }
    }

    /***************************************************************************
     * Deletes an item from an order.
     *
     * This function removes an order item from the database, ensuring the integrity of the order
     * by adjusting totals accordingly.
     *
     * @param int $orderId The ID of the order containing the item to delete.
     * @param int $orderItemId The ID of the item to remove.
     * @return array Returns a response indicating the success or failure of the deletion.
     */
    public function deleteOrderItem($orderId, $orderItemId) {
        $stmt = $this->conn->prepare("DELETE FROM order_items WHERE id = ? AND order_id = ?");
        $stmt->bind_param("ii", $orderItemId, $orderId);
        $success = $stmt->execute();

        if ($success) {
            return ["message" => "Order item deleted successfully."];
        } else {
            return ["error" => "Failed to delete order item."];
        }
    }

    /***************************************************************************
     * Confirms payment for an order, updating its status in the database.
     *
     * This function marks an order as paid and updates its status to 'Payment Received'. It confirms the payment
     * and fetches the updated order details.
     *
     * @param int $orderId The ID of the order for which payment is being confirmed.
     * @return array Returns a message indicating the success of the payment confirmation along with the updated order details.
     */
    public function confirmPayment($orderId) {
        $stmt = $this->conn->prepare("UPDATE orders SET status = 'Payment Received', payment_status = 'Completed' WHERE id = ?");
        $stmt->bind_param("i", $orderId);
        $success = $stmt->execute();

        if ($success) {
            return [
                "message" => "Payment confirmed",
                "order" => $this->fetchOrder($orderId)
            ];
        } else {
            return ["error" => "Failed to confirm payment."];
        }
    }

    /***************************************************************************
     * Cancels an order, changing its status in the database to 'Cancelled'.
     *
     * This function updates the status of an order to 'Cancelled', reflecting changes such as halted processing or shipping.
     *
     * @param int $orderId The ID of the order to cancel.
     * @return array Returns a message indicating the success or failure of the cancellation.
     */
    public function cancelOrder($orderId) {
        $stmt = $this->conn->prepare("UPDATE orders SET status = 'Cancelled' WHERE id = ?");
        $stmt->bind_param("i", $orderId);
        $success = $stmt->execute();

        if ($success) {
            return ["message" => "Order canceled successfully."];
        } else {
            return ["error" => "Failed to cancel order."];
        }
    }

    /***************************************************************************
     * Generates a sales report based on a specified time frame.
     *
     * This function fetches aggregated order and payment data within a given time frame, such as daily, weekly, or monthly.
     * It returns a detailed report including the number of orders, total revenue, and breakdown by payment method and status.
     *
     * @param string $timeFrame Specifies the time frame for the report ('daily', 'weekly', or 'monthly').
     * @return array Returns an array containing detailed sales data grouped by date.
     */
    public function fetchSalesReport($timeFrame) {
        $dateInterval = $this->getDateInterval($timeFrame);

        $query = "SELECT DATE(o.created_at) as date, COUNT(o.id) as order_count, SUM(o.total_price) as total_revenue, 
                  p.payment_method, p.transaction_status
                  FROM orders o
                  LEFT JOIN payments p ON o.id = p.order_id
                  WHERE o.created_at >= ?
                  GROUP BY DATE(o.created_at), p.payment_method, p.transaction_status
                  ORDER BY DATE(o.created_at)";

        $stmt = $this->conn->prepare($query);
        $stmt->bind_param("s", $dateInterval);
        $stmt->execute();
        $result = $stmt->get_result();

        $salesData = [];
        while ($row = $result->fetch_assoc()) {
            $date = $row['date'];
            if (!isset($salesData[$date])) {
                $salesData[$date] = [
                    'date' => $date,
                    'order_count' => 0,
                    'total_revenue' => 0,
                    'payments' => []
                ];
            }
            $salesData[$date]['order_count'] += $row['order_count'];
            $salesData[$date]['total_revenue'] += $row['total_revenue'];
            $salesData[$date]['payments'][] = [
                'payment_method' => $row['payment_method'],
                'transaction_status' => $row['transaction_status'],
                'count' => $row['order_count'],
                'revenue' => $row['total_revenue']
            ];
        }

        return [
            'time_frame' => $timeFrame,
            'sales_report' => array_values($salesData)
        ];
    }

    /***************************************************************************
     * Determines the start date for a sales report based on the specified time frame.
     *
     * This private function calculates the starting date from which to begin the sales report, adjusting based on whether
     * the report is daily, weekly, or monthly.
     *
     * @param string $timeFrame The time frame for which the start date is required.
     * @return string Returns the calculated start date as a string.
     */
    private function getDateInterval($timeFrame) {
        $today = new DateTime();
        switch ($timeFrame) {
            case 'daily':
                return $today->format('Y-m-d');
            case 'weekly':
                return $today->modify('-1 week')->format('Y-m-d');
            case 'monthly':
                return $today->modify('-1 month')->format('Y-m-d');
            default:
                return $today->format('Y-m-d');
        }
    }

}
