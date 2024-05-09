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
        parent::__construct($username, $password, 'customer');
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

    /***************************************************************************
     * Retrieves all categories from the database.
     *
     * This function fetches all rows from the 'categories' table and formats each category's details
     * into an associative array. The function returns an array of these category details.
     *
     * @return array Returns an array of associative arrays, each containing details of a category.
     */
    public function fetchCategories() {
        $stmt = $this->conn->prepare("SELECT * FROM categories");
        $stmt->execute();
        $result = $stmt->get_result();
        $categories = [];
        while ($row = $result->fetch_assoc()) {
            $categories[] = [
                'id' => $row['id'],
                'image_url' => $row['image_url'],
                'name' => $row['name'],
                'description' => $row['description'],
                'created_at' => $row['created_at'],
                'updated_at' => $row['updated_at']
            ];
        }
        return $categories;
    }

    /***************************************************************************
     * Retrieves details of a specific category by its ID.
     *
     * This function fetches a single category from the 'categories' table based on the given category ID.
     * If found, it returns an array of the category's details; if not, it returns null.
     *
     * @param int $categoryId The ID of the category to fetch.
     * @return array|null Returns an associative array containing the category's details, or null if not found.
     */
    public function fetchCategory($categoryId) {
        $stmt = $this->conn->prepare("SELECT * FROM categories WHERE id = ?");
        $stmt->bind_param("i", $categoryId);
        $stmt->execute();
        $result = $stmt->get_result();
        if ($category = $result->fetch_assoc()) {
            return [
                'id' => $category['id'],
                'image_url' => $category['image_url'],
                'name' => $category['name'],
                'description' => $category['description'],
                'created_at' => $category['created_at'],
                'updated_at' => $category['updated_at']
            ];
        }
        return null;
    }

    /***************************************************************************
     * Fetches all flavors associated with a specific category.
     *
     * This function retrieves flavors linked to a given category through a many-to-many relationship.
     * It returns an array of flavor details, each including relational data from the pivot table.
     *
     * @param int $categoryId The category ID for which to fetch flavors.
     * @return array Returns an array of associative arrays, each containing details of a flavor.
     */
    public function fetchCategoryFlavors($categoryId) {
        $stmt = $this->conn->prepare("SELECT f.*, cf.category_id FROM flavors f JOIN category_flavor cf ON f.id = cf.flavor_id WHERE cf.category_id = ?");
        $stmt->bind_param("i", $categoryId);
        $stmt->execute();
        $result = $stmt->get_result();
        $flavors = [];
        while ($row = $result->fetch_assoc()) {
            $flavors[] = [
                'id' => $row['id'],
                'name' => $row['name'],
                'description' => $row['description'],
                'image_url' => $row['image_url'],
                'active' => $row['active'],
                'created_at' => $row['created_at'],
                'updated_at' => $row['updated_at'],
                'pivot' => [
                    'category_id' => $row['category_id'],
                    'flavor_id' => $row['id']
                ]
            ];
        }
        return $flavors;
    }

    /***************************************************************************
     * Fetches all add-ons associated with a specific category.
     *
     * Similar to fetching flavors, this function retrieves add-ons linked to a specific category.
     * It returns detailed information for each add-on, including pricing and active status.
     *
     * @param int $categoryId The category ID for which to fetch add-ons.
     * @return array Returns an array of associative arrays, each containing details of an add-on.
     */
    public function fetchCategoryAddOns($categoryId) {
        $stmt = $this->conn->prepare("SELECT a.*, ca.category_id FROM add_ons a JOIN category_add_on ca ON a.id = ca.add_on_id WHERE ca.category_id = ?");
        $stmt->bind_param("i", $categoryId);
        $stmt->execute();
        $result = $stmt->get_result();
        $add_ons = [];
        while ($row = $result->fetch_assoc()) {
            $add_ons[] = [
                'id' => $row['id'],
                'name' => $row['name'],
                'description' => $row['description'],
                'image_url' => $row['image_url'],
                'price' => $row['price'],
                'active' => $row['active'],
                'created_at' => $row['created_at'],
                'updated_at' => $row['updated_at'],
                'pivot' => [
                    'category_id' => $row['category_id'],
                    'add_on_id' => $row['id']
                ]
            ];
        }
        return $add_ons;
    }

    /***************************************************************************
     * Retrieves products by category, including inventory details.
     *
     * This function fetches active products within a specified category and joins them with inventory data.
     * It returns an array of products, each including inventory details like stock count and low stock threshold.
     *
     * @param int $categoryId The category ID to filter products by.
     * @return array Returns an array of associative arrays, each containing product details and associated inventory data.
     */
    public function fetchProductsByCategory($categoryId) {
        $stmt = $this->conn->prepare("
            SELECT 
                p.*, 
                i.id AS inventory_id, 
                i.count, 
                i.low_stock_threshold, 
                i.created_at AS inventory_created_at, 
                i.updated_at AS inventory_updated_at 
            FROM 
                products p
            LEFT JOIN 
                inventories i ON p.id = i.product_id
            WHERE 
                p.category_id = ? AND 
                p.active = 1
        ");
        $stmt->bind_param("i", $categoryId);
        $stmt->execute();
        $result = $stmt->get_result();

        $products = [];

        while ($row = $result->fetch_assoc()) {
            $products[] = [
                'id' => $row['id'],
                'category_id' => $row['category_id'],
                'name' => $row['name'],
                'description' => $row['description'],
                'price' => $row['price'],
                'image_url' => $row['image_url'],
                'active' => $row['active'],
                'created_at' => $row['created_at'],
                'updated_at' => $row['updated_at'],
                'inventory' => [
                    'id' => $row['inventory_id'],
                    'product_id' => $row['id'],
                    'count' => $row['count'],
                    'low_stock_threshold' => $row['low_stock_threshold'],
                    'created_at' => $row['inventory_created_at'],
                    'updated_at' => $row['inventory_updated_at']
                ]
            ];
        }

        return $products;
    }

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
     * Generates a 10-character hexadecimal verification code.
     *
     * This method uses PHP's `random_bytes` function to generate a secure random byte sequence,
     * which is then converted to a hexadecimal string.
     *
     * @return string Returns the generated verification code.
     */
    private function generateVerificationCode() {
        return bin2hex(random_bytes(5));
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
     * Creates a new order in the database with associated order items.
     *
     * This function starts by initiating a transaction, then proceeds to calculate the total price of the order
     * based on the items included. It inserts a main order entry with a unique verification code. Subsequently,
     * it inserts each item of the order into the `order_items` table with details such as product ID, quantity,
     * add-ons, flavor, and the calculated subtotal for that item. If all operations are successful, it commits
     * the transaction. If an exception occurs, it rolls back the transaction and returns an error.
     *
     * @param array $orderData Contains all necessary information about the order, including customer contact,
     *                         items (each with product ID, quantity, add-ons, and flavor ID).
     * @return array Returns an associative array with a success message, order ID, verification code, and
     *               formatted total price if the order is successfully created, or an error message if it fails.
     * @throws Exception Propagates any exceptions thrown during the database operations.
     */
    public function createOrder($orderData) {
        require_once 'CustomerVerification.php';
        $this->conn->begin_transaction();
        try {
            $totalPrice = 0;
            $items = $orderData['items'];

            // Calculate total price for the order
            foreach ($items as $item) {
                $addOns = isset($item['add_ons']) ? $item['add_ons'] : [];
                $subtotal = $this->calculateSubtotal($item['product_id'], $item['quantity'], $addOns);
                $totalPrice += $subtotal;
            }

            // Insert the main order entry
            $verificationCode = $this->generateVerificationCode();
            $stmt = $this->conn->prepare("INSERT INTO orders (customer_contact, total_price, status, payment_status, verification_code, created_at, updated_at) VALUES (?, ?, 'Awaiting Payment', 'Pending', ?, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)");
            $stmt->bind_param("sds", $orderData['customer_contact'], $totalPrice, $verificationCode);
            $stmt->execute();
            $orderId = $this->conn->insert_id;

            // Handle each order item
            foreach ($items as $item) {
                $subtotal = $this->calculateSubtotal($item['product_id'], $item['quantity'], isset($item['add_ons']) ? $item['add_ons'] : []);
                $addOnIdsJson = json_encode(isset($item['add_ons']) ? $item['add_ons'] : []);
                $stmt = $this->conn->prepare("INSERT INTO order_items (order_id, product_id, quantity, add_on_ids, flavor_id, subtotal) VALUES (?, ?, ?, ?, ?, ?)");
                $stmt->bind_param("iiissd", $orderId, $item['product_id'], $item['quantity'], $addOnIdsJson, $item['flavor_id'], $subtotal);
                $stmt->execute();
            }

            // Create customer verification
            $customerVerification = new CustomerVerification();
            $customerVerification->orderId = $orderId;
            $customerVerification->customerContact = $orderData['customer_contact'];
            $customerVerification->verificationCode = $verificationCode;
            $customerVerification->attempts = 0;
            $customerVerification->save();

            // Send notification to the merchant
            $this->sendNotificationToMerchant(1, $orderId);

            // Commit transaction
            $this->conn->commit();
            return [
                "message" => "Order created successfully.",
                "order_id" => $orderId,
                "verification_code" => $verificationCode,
                "total_price" => number_format($totalPrice, 2)
            ];
        } catch (Exception $e) {
            // Rollback transaction in case of error
            $this->conn->rollback();
            return ["error" => "Failed to create order: " . $e->getMessage()];
        }
    }

    public function sendNotificationToMerchant($receiverId, $orderId) {
        require_once 'Notification.php';
        // Fetch the order details
        $order = $this->fetchOrder($orderId);

        // Prepare the notification message
        $message = "New order received. Order ID: $orderId\n\n";
        $message .= "Order Details:\n";
        $message .= "Customer Contact: " . $order['customer_contact'] . "\n";
        $message .= "Total Price: " . number_format($order['total_price'], 2) . "\n";
        $message .= "Verification Code: " . $order['verification_code'] . "\n";
        $message .= "Payment Status: " . $order['payment_status'] . "\n";
        $message .= "Created At: " . $order['created_at'] . "\n\n";

        $message .= "Order Items:\n";
        foreach ($order['order_items'] as $item) {
            $message .= "- Product: " . $item['product']['name'] . "\n";
            $message .= "  Quantity: " . $item['quantity'] . "\n";
            $message .= "  Subtotal: " . number_format($item['subtotal'], 2) . "\n";
            $addOnIds = json_decode($item['add_on_ids']);
            if (is_array($addOnIds) && !empty($addOnIds)) {
                $message .= "  Add-ons: " . implode(', ', $addOnIds) . "\n";
            } else {
                $message .= "  Add-ons: None\n";
            }
            $message .= "  Flavor: " . $item['flavor_id'] . "\n\n";
        }

        // Create the notification
        $notification = new Notification();
        $notification->type = 'customer_to_merchant';
        $notification->receiver_id = $receiverId;
        $notification->sender_id = $this->id;
        $notification->status = 'unread';
        $notification->message = $message;
        $notification->created_at = date('Y-m-d H:i:s');
        $notification->updated_at = date('Y-m-d H:i:s');
        $notification->save();
    }


}
