-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 01, 2024 at 05:00 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `za-wrappe-php`
--

-- --------------------------------------------------------

--
-- Table structure for table `add_ons`
--

CREATE TABLE `add_ons` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  `image_url` varchar(255) NOT NULL,
  `price` decimal(8,2) NOT NULL,
  `active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `add_ons`
--

INSERT INTO `add_ons` (`id`, `name`, `description`, `image_url`, `price`, `active`, `created_at`, `updated_at`) VALUES
(1, 'Garlic Sauce', 'A Garlic Sauce add-ons for Shawarma', 'cheesy_dip.jpg', 7.00, 1, '2024-04-27 21:27:41', '2024-04-27 21:27:41'),
(3, 'Add Yakult', 'An additional Yakult to enrich your beverage.', 'add_yakult.jpg', 15.00, 1, '2024-04-27 21:27:41', '2024-04-27 21:27:41');

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE `admins` (
  `id` tinyint(5) UNSIGNED NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `image_url`, `name`, `description`, `created_at`, `updated_at`) VALUES
(1, 'shawarma.jpg', 'Shawarma', 'Delicious Shawarma wraps and more', '2024-04-27 21:27:41', '2024-04-27 21:27:41'),
(3, 'shawarma.jpg', 'Shawarma Nachos', 'Crispy nachos topped with Shawarma', '2024-04-27 21:27:41', '2024-04-27 21:27:41'),
(4, 'fruit_soda_&_tea.jpg', 'Fruit Soda & Tea', 'Refreshing fruit soda and tea in various flavors', '2024-04-27 21:27:41', '2024-04-27 21:27:41'),
(5, 'yakult_series.jpg', 'Yakult Series', 'Healthy Yakult infused drinks', '2024-04-27 21:27:41', '2024-04-27 21:27:41');

-- --------------------------------------------------------

--
-- Table structure for table `category_add_on`
--

CREATE TABLE `category_add_on` (
  `category_id` bigint(20) UNSIGNED NOT NULL,
  `add_on_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `category_add_on`
--

INSERT INTO `category_add_on` (`category_id`, `add_on_id`, `created_at`, `updated_at`) VALUES
(1, 1, NULL, NULL),
(3, 1, NULL, NULL),
(5, 3, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `category_flavor`
--

CREATE TABLE `category_flavor` (
  `category_id` bigint(20) UNSIGNED NOT NULL,
  `flavor_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `category_flavor`
--

INSERT INTO `category_flavor` (`category_id`, `flavor_id`, `created_at`, `updated_at`) VALUES
(1, 1, NULL, NULL),
(1, 2, NULL, NULL),
(1, 3, NULL, NULL),
(3, 1, NULL, NULL),
(3, 2, NULL, NULL),
(3, 3, NULL, NULL),
(4, 4, NULL, NULL),
(4, 8, NULL, NULL),
(4, 9, NULL, NULL),
(4, 10, NULL, NULL),
(5, 4, NULL, NULL),
(5, 8, NULL, NULL),
(5, 9, NULL, NULL),
(5, 10, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `id` int(255) UNSIGNED NOT NULL,
  `avatar` varchar(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`id`, `avatar`, `username`, `password`, `name`, `email`, `phone`, `address`, `created_at`, `updated_at`) VALUES
(1, 'avatar.png', 'customer', 'customer', 'customer', 'customer@za-wrappe.com', '09123456789', '@ Za-Wrappe', '2024-04-25 01:28:25', '2024-04-25 01:32:06');

-- --------------------------------------------------------

--
-- Table structure for table `customer_verifications`
--

CREATE TABLE `customer_verifications` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `order_id` bigint(20) UNSIGNED NOT NULL,
  `customer_contact` varchar(255) NOT NULL,
  `verification_code` varchar(255) NOT NULL,
  `verified_at` datetime DEFAULT NULL,
  `attempts` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `customer_verifications`
--

INSERT INTO `customer_verifications` (`id`, `order_id`, `customer_contact`, `verification_code`, `verified_at`, `attempts`, `created_at`, `updated_at`) VALUES
(58, 17, '09111111111', '07cd844f77', NULL, 0, NULL, NULL),
(59, 18, '09468666666', '776793b8d4', NULL, 0, NULL, NULL),
(60, 19, '09888788777', '193d105e43', NULL, 0, NULL, NULL),
(61, 20, '09837373833', '4effd6eea3', NULL, 0, NULL, NULL),
(62, 21, '', 'f53a964948', NULL, 0, NULL, NULL),
(63, 22, '', '36defec848', NULL, 0, NULL, NULL),
(64, 23, 'ron', '026103e2a5', NULL, 0, NULL, NULL),
(65, 24, 'ronron', 'e5ad6d28db', NULL, 0, NULL, NULL),
(66, 25, '', '2a66075c9c', NULL, 0, NULL, NULL),
(67, 26, '', '6149bbace3', NULL, 0, NULL, NULL),
(68, 27, '', '7333682391', NULL, 0, NULL, NULL),
(69, 28, '', 'bc5a3a328c', NULL, 0, NULL, NULL),
(70, 29, 'ron ron', '9fc6230fe7', NULL, 0, NULL, NULL),
(71, 30, 'luimhar', 'a2fc6f9728', NULL, 0, NULL, NULL),
(72, 31, 'sheilabalbuena', 'f5390bf9c1', NULL, 0, NULL, NULL),
(73, 32, 'Krizette', 'fca4c9285d', NULL, 0, NULL, NULL),
(74, 33, 'earljames acal', 'c7368ee38f', NULL, 0, NULL, NULL),
(75, 34, 'ron', '7e19e12b47', NULL, 0, NULL, NULL),
(76, 35, '', '2443b0fdfd', NULL, 0, NULL, NULL),
(77, 36, '', '627dfa1360', NULL, 0, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `feedbacks`
--

CREATE TABLE `feedbacks` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `customer_contact` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `response` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `feedbacks`
--

INSERT INTO `feedbacks` (`id`, `customer_contact`, `message`, `response`, `created_at`, `updated_at`) VALUES
(1, 'jane.doe@example.com', 'I really enjoyed the vegan options! Would love to see more variety in the future.', 'Thank you, Jane! We’re planning to expand our vegan menu soon.', '2024-04-17 21:27:43', '2024-04-18 21:27:43'),
(2, 'john.smith@example.com', 'The order process was a bit confusing. Could you make it more intuitive?', NULL, '2024-04-22 21:27:43', '2024-04-22 21:27:43'),
(3, 'alice.wonderland@example.com', 'Loved the ambiance and the friendly staff. Made my day!', 'We’re thrilled to hear you enjoyed your visit, Alice! Hope to see you again soon.', '2024-04-25 21:27:43', '2024-04-26 21:27:43');

-- --------------------------------------------------------

--
-- Table structure for table `flavors`
--

CREATE TABLE `flavors` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  `image_url` varchar(255) NOT NULL,
  `active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `flavors`
--

INSERT INTO `flavors` (`id`, `name`, `description`, `image_url`, `active`, `created_at`, `updated_at`) VALUES
(1, 'Pork', 'A delicious Pork flavor.', 'pork.jpg', 1, '2024-04-27 21:27:41', '2024-04-27 21:27:41'),
(2, 'Chicken', 'A delicious Chicken flavor.', 'chicken.jpg', 1, '2024-04-27 21:27:41', '2024-04-27 21:27:41'),
(3, 'Tilapia', 'A delicious Tilapia flavor.', 'tilapia.jpg', 1, '2024-04-27 21:27:41', '2024-04-27 21:27:41'),
(4, 'Kiwi', 'A delicious Kiwi flavor.', 'kiwi.jpg', 1, '2024-04-27 21:27:41', '2024-04-27 21:27:41'),
(8, 'Lemon', 'A delicious Lemon flavor.', 'lemon.jpg', 1, '2024-04-27 21:27:41', '2024-04-27 21:27:41'),
(9, 'Mango', 'A delicious Mango flavor.', 'mango.jpg', 1, '2024-04-27 21:27:41', '2024-04-27 21:27:41'),
(10, 'Blueberry', 'A delicious Blueberry flavor.', 'blueberry.jpg', 1, '2024-04-27 21:27:41', '2024-04-27 21:27:41');

-- --------------------------------------------------------

--
-- Table structure for table `inventories`
--

CREATE TABLE `inventories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `count` int(11) NOT NULL,
  `low_stock_threshold` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `inventories`
--

INSERT INTO `inventories` (`id`, `product_id`, `count`, `low_stock_threshold`, `created_at`, `updated_at`) VALUES
(1, 1, 85, 10, '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(2, 2, 72, 10, '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(4, 4, 77, 10, '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(6, 6, 32, 10, '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(9, 9, 30, 10, '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(10, 10, 42, 10, '2024-04-27 21:27:43', '2024-04-27 21:27:43');

-- --------------------------------------------------------

--
-- Table structure for table `merchants`
--

CREATE TABLE `merchants` (
  `id` int(255) UNSIGNED NOT NULL,
  `avatar` varchar(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `merchants`
--

INSERT INTO `merchants` (`id`, `avatar`, `username`, `password`, `name`, `email`, `phone`, `address`, `created_at`, `updated_at`) VALUES
(1, 'avatar.png', 'merchant', 'merchant', 'Za-Wrappe Merchant', 'merchant@za-wrappe.com', '09123456789', '@Za-Wrappe', '2024-04-28 11:43:52', '2024-04-28 11:46:05');

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `type` varchar(255) NOT NULL,
  `receiver_id` int(255) UNSIGNED NOT NULL,
  `sender_id` int(255) UNSIGNED NOT NULL,
  `status` varchar(255) NOT NULL DEFAULT 'pending',
  `message` text NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `notifications`
--

INSERT INTO `notifications` (`id`, `type`, `receiver_id`, `sender_id`, `status`, `message`, `created_at`, `updated_at`) VALUES
(56, 'customer_to_merchant', 1, 1, 'unread', 'New order received. Order ID: 17\n\nOrder Details:\nCustomer Contact: 09111111111\nTotal Price: 151.00\nVerification Code: 07cd844f77\nPayment Status: Pending\nCreated At: 2024-04-28 05:27:43\n\nOrder Items:\n- Product: Yakult Series - 12 oz\n  Quantity: 2\n  Subtotal: 88.00\n  Add-ons: 3\n  Flavor: 7\n\n- Product: Shawarma Nachos Single Order\n  Quantity: 1\n  Subtotal: 63.00\n  Add-ons: 2, 1\n  Flavor: 2\n\n', '2024-05-09 20:42:40', '2024-05-09 20:42:40'),
(57, 'customer_to_merchant', 1, 1, 'unread', 'New order received. Order ID: 18\n\nOrder Details:\nCustomer Contact: 09468666666\nTotal Price: 296.00\nVerification Code: 776793b8d4\nPayment Status: Pending\nCreated At: 2024-04-28 05:27:43\n\nOrder Items:\n- Product: Shawarma Nachos Single Order\n  Quantity: 4\n  Subtotal: 252.00\n  Add-ons: 1, 2\n  Flavor: 2\n\n- Product: Yakult Series - 12 oz\n  Quantity: 1\n  Subtotal: 44.00\n  Add-ons: 3\n  Flavor: 6\n\n', '2024-05-09 20:52:14', '2024-05-09 20:52:14'),
(58, 'customer_to_merchant', 1, 1, 'unread', 'New order received. Order ID: 19\n\nOrder Details:\nCustomer Contact: 09888788777\nTotal Price: 166.00\nVerification Code: 193d105e43\nPayment Status: Pending\nCreated At: 2024-04-28 05:27:43\n\nOrder Items:\n- Product: Yakult Series - 16 oz\n  Quantity: 1\n  Subtotal: 54.00\n  Add-ons: 3\n  Flavor: 4\n\n- Product: Shawarma Single Order\n  Quantity: 2\n  Subtotal: 112.00\n  Add-ons: 1\n  Flavor: 1\n\n', '2024-05-10 22:45:08', '2024-05-10 22:45:08'),
(59, 'customer_to_merchant', 1, 1, 'unread', 'New order received. Order ID: 20\n\nOrder Details:\nCustomer Contact: 09837373833\nTotal Price: 25.00\nVerification Code: 4effd6eea3\nPayment Status: Pending\nCreated At: 2024-04-28 05:27:43\n\nOrder Items:\n- Product: Fruit Soda - 12 oz\n  Quantity: 1\n  Subtotal: 25.00\n  Add-ons: None\n  Flavor: 4\n\n', '2024-05-11 01:06:16', '2024-05-11 01:06:16'),
(60, 'customer_to_merchant', 1, 1, 'unread', 'New order received. Order ID: 21\n\nOrder Details:\nCustomer Contact: \nTotal Price: 204.00\nVerification Code: f53a964948\nPayment Status: Pending\nCreated At: 2024-04-28 05:27:43\n\nOrder Items:\n- Product: Shawarma Rice Buy One, Take One\n  Quantity: 1\n  Subtotal: 102.00\n  Add-ons: 1\n  Flavor: 3\n\n- Product: Shawarma Buy One, Take One\n  Quantity: 1\n  Subtotal: 102.00\n  Add-ons: 2\n  Flavor: 1\n\n', '2024-05-24 09:32:06', '2024-05-24 09:32:06'),
(61, 'customer_to_merchant', 1, 1, 'unread', 'New order received. Order ID: 22\n\nOrder Details:\nCustomer Contact: \nTotal Price: 54.00\nVerification Code: 36defec848\nPayment Status: Pending\nCreated At: 2024-04-28 05:27:43\n\nOrder Items:\n- Product: Yakult Series - 16 oz\n  Quantity: 1\n  Subtotal: 54.00\n  Add-ons: 3\n  Flavor: 4\n\n', '2024-05-24 09:39:29', '2024-05-24 09:39:29'),
(62, 'customer_to_merchant', 1, 1, 'unread', 'New order received. Order ID: 23\n\nOrder Details:\nCustomer Contact: ron\nTotal Price: 35.00\nVerification Code: 026103e2a5\nPayment Status: Pending\nCreated At: 2024-04-28 05:27:43\n\nOrder Items:\n- Product: Fruit Soda - 16 oz\n  Quantity: 1\n  Subtotal: 35.00\n  Add-ons: None\n  Flavor: 5\n\n', '2024-05-24 10:01:14', '2024-05-24 10:01:14'),
(63, 'customer_to_merchant', 1, 1, 'unread', 'New order received. Order ID: 24\n\nOrder Details:\nCustomer Contact: ronron\nTotal Price: 326.00\nVerification Code: e5ad6d28db\nPayment Status: Pending\nCreated At: 2024-04-28 05:27:43\n\nOrder Items:\n- Product: Yakult Series - 16 oz\n  Quantity: 1\n  Subtotal: 54.00\n  Add-ons: 3\n  Flavor: 7\n\n- Product: Shawarma Nachos Buy One, Take One\n  Quantity: 2\n  Subtotal: 218.00\n  Add-ons: 2, 1\n  Flavor: 1\n\n- Product: Yakult Series - 16 oz\n  Quantity: 1\n  Subtotal: 54.00\n  Add-ons: 3\n  Flavor: 4\n\n', '2024-05-24 13:57:04', '2024-05-24 13:57:04'),
(64, 'customer_to_merchant', 1, 1, 'unread', 'New order received. Order ID: 25\n\nOrder Details:\nCustomer Contact: \nTotal Price: 102.00\nVerification Code: 2a66075c9c\nPayment Status: Pending\nCreated At: 2024-04-28 05:27:43\n\nOrder Items:\n- Product: Shawarma Rice Buy One, Take One\n  Quantity: 1\n  Subtotal: 102.00\n  Add-ons: 2\n  Flavor: 1\n\n', '2024-05-24 20:12:39', '2024-05-24 20:12:39'),
(65, 'customer_to_merchant', 1, 1, 'unread', 'New order received. Order ID: 26\n\nOrder Details:\nCustomer Contact: \nTotal Price: 63.00\nVerification Code: 6149bbace3\nPayment Status: Pending\nCreated At: 2024-04-28 05:27:43\n\nOrder Items:\n- Product: Shawarma Nachos Single Order\n  Quantity: 1\n  Subtotal: 63.00\n  Add-ons: 2, 1\n  Flavor: 1\n\n', '2024-05-24 20:22:48', '2024-05-24 20:22:48'),
(66, 'customer_to_merchant', 1, 1, 'unread', 'New order received. Order ID: 27\n\nOrder Details:\nCustomer Contact: \nTotal Price: 91.00\nVerification Code: 7333682391\nPayment Status: Pending\nCreated At: 2024-04-28 05:27:43\n\nOrder Items:\n- Product: Fruit Soda - 16 oz\n  Quantity: 1\n  Subtotal: 35.00\n  Add-ons: None\n  Flavor: 4\n\n- Product: Shawarma Nachos Single Order\n  Quantity: 1\n  Subtotal: 56.00\n  Add-ons: 1\n  Flavor: 1\n\n', '2024-05-24 20:32:09', '2024-05-24 20:32:09'),
(67, 'customer_to_merchant', 1, 1, 'unread', 'New order received. Order ID: 28\n\nOrder Details:\nCustomer Contact: \nTotal Price: 56.00\nVerification Code: bc5a3a328c\nPayment Status: Pending\nCreated At: 2024-04-28 05:27:43\n\nOrder Items:\n- Product: Shawarma Nachos Single Order\n  Quantity: 1\n  Subtotal: 56.00\n  Add-ons: 1\n  Flavor: 3\n\n', '2024-05-24 20:34:28', '2024-05-24 20:34:28'),
(68, 'customer_to_merchant', 1, 1, 'unread', 'New order received. Order ID: 29\n\nOrder Details:\nCustomer Contact: ron ron\nTotal Price: 44.00\nVerification Code: 9fc6230fe7\nPayment Status: Pending\nCreated At: 2024-04-28 05:27:43\n\nOrder Items:\n- Product: Yakult Series - 12 oz\n  Quantity: 1\n  Subtotal: 44.00\n  Add-ons: 3\n  Flavor: 5\n\n', '2024-05-24 20:36:42', '2024-05-24 20:36:42'),
(69, 'customer_to_merchant', 1, 1, 'unread', 'New order received. Order ID: 30\n\nOrder Details:\nCustomer Contact: luimhar\nTotal Price: 56.00\nVerification Code: a2fc6f9728\nPayment Status: Pending\nCreated At: 2024-04-28 05:27:43\n\nOrder Items:\n- Product: Shawarma Nachos Single Order\n  Quantity: 1\n  Subtotal: 56.00\n  Add-ons: 2\n  Flavor: 2\n\n', '2024-05-24 20:38:39', '2024-05-24 20:38:39'),
(70, 'customer_to_merchant', 1, 1, 'unread', 'New order received. Order ID: 31\n\nOrder Details:\nCustomer Contact: sheilabalbuena\nTotal Price: 56.00\nVerification Code: f5390bf9c1\nPayment Status: Pending\nCreated At: 2024-04-28 05:27:43\n\nOrder Items:\n- Product: Shawarma Nachos Single Order\n  Quantity: 1\n  Subtotal: 56.00\n  Add-ons: 2\n  Flavor: 1\n\n', '2024-05-24 20:40:37', '2024-05-24 20:40:37'),
(71, 'customer_to_merchant', 1, 1, 'unread', 'New order received. Order ID: 32\n\nOrder Details:\nCustomer Contact: Krizette\nTotal Price: 54.00\nVerification Code: fca4c9285d\nPayment Status: Pending\nCreated At: 2024-04-28 05:27:43\n\nOrder Items:\n- Product: Yakult Series - 16 oz\n  Quantity: 1\n  Subtotal: 54.00\n  Add-ons: 3\n  Flavor: 4\n\n', '2024-05-24 20:42:35', '2024-05-24 20:42:35'),
(72, 'customer_to_merchant', 1, 1, 'unread', 'New order received. Order ID: 33\n\nOrder Details:\nCustomer Contact: earljames acal\nTotal Price: 29.00\nVerification Code: c7368ee38f\nPayment Status: Pending\nCreated At: 2024-04-28 05:27:43\n\nOrder Items:\n- Product: Yakult Series - 12 oz\n  Quantity: 1\n  Subtotal: 29.00\n  Add-ons: None\n  Flavor: 4\n\n', '2024-05-24 20:44:31', '2024-05-24 20:44:31'),
(73, 'customer_to_merchant', 1, 1, 'unread', 'New order received. Order ID: 34\n\nOrder Details:\nCustomer Contact: ron\nTotal Price: 54.00\nVerification Code: 7e19e12b47\nPayment Status: Pending\nCreated At: 2024-04-28 05:27:43\n\nOrder Items:\n- Product: Yakult Series - 16 oz\n  Quantity: 1\n  Subtotal: 54.00\n  Add-ons: 3\n  Flavor: 6\n\n', '2024-05-24 20:47:03', '2024-05-24 20:47:03'),
(74, 'customer_to_merchant', 1, 1, 'unread', 'New order received. Order ID: 35\n\nOrder Details:\nCustomer Contact: \nTotal Price: 35.00\nVerification Code: 2443b0fdfd\nPayment Status: Pending\nCreated At: 2024-04-28 05:27:43\n\nOrder Items:\n- Product: Fruit Soda - 16 oz\n  Quantity: 1\n  Subtotal: 35.00\n  Add-ons: None\n  Flavor: 4\n\n', '2024-05-25 03:33:04', '2024-05-25 03:33:04'),
(75, 'customer_to_merchant', 1, 1, 'unread', 'New order received. Order ID: 36\n\nOrder Details:\nCustomer Contact: \nTotal Price: 25.00\nVerification Code: 627dfa1360\nPayment Status: Pending\nCreated At: 2024-04-28 05:27:43\n\nOrder Items:\n- Product: Fruit Soda - 12 oz\n  Quantity: 1\n  Subtotal: 25.00\n  Add-ons: None\n  Flavor: 4\n\n', '2024-05-25 03:37:01', '2024-05-25 03:37:01');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `status` varchar(255) NOT NULL,
  `customer_contact` varchar(255) NOT NULL,
  `total_price` decimal(8,2) NOT NULL,
  `verification_code` varchar(255) NOT NULL,
  `payment_status` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `status`, `customer_contact`, `total_price`, `verification_code`, `payment_status`, `created_at`, `updated_at`) VALUES
(17, 'Payment Received', '09111111111', 151.00, '07cd844f77', 'Pending', '2024-05-09 20:42:40', '2024-05-09 20:42:40'),
(18, 'Preparing Order', '09468666666', 296.00, '776793b8d4', 'Pending', '2024-05-09 20:52:14', '2024-05-09 20:52:14'),
(19, 'Payment Received', '09888788777', 166.00, '193d105e43', 'Pending', '2024-05-10 22:45:08', '2024-05-10 22:45:08'),
(20, 'Awaiting Payment', '09837373833', 25.00, '4effd6eea3', 'Pending', '2024-05-11 01:06:16', '2024-05-11 01:06:16'),
(21, 'Awaiting Payment', '', 204.00, 'f53a964948', 'Pending', '2024-05-24 09:32:06', '2024-05-24 09:32:06'),
(22, 'Awaiting Payment', '', 54.00, '36defec848', 'Pending', '2024-05-24 09:39:29', '2024-05-24 09:39:29'),
(23, 'Awaiting Payment', 'ron', 35.00, '026103e2a5', 'Pending', '2024-05-24 10:01:14', '2024-05-24 10:01:14'),
(24, 'Awaiting Payment', 'ronron', 326.00, 'e5ad6d28db', 'Pending', '2024-05-24 13:57:04', '2024-05-24 13:57:04'),
(25, 'Awaiting Payment', '', 102.00, '2a66075c9c', 'Pending', '2024-05-24 20:12:39', '2024-05-24 20:12:39'),
(26, 'Awaiting Payment', '', 63.00, '6149bbace3', 'Pending', '2024-05-24 20:22:48', '2024-05-24 20:22:48'),
(27, 'Awaiting Payment', '', 91.00, '7333682391', 'Pending', '2024-05-24 20:32:09', '2024-05-24 20:32:09'),
(28, 'Awaiting Payment', '', 56.00, 'bc5a3a328c', 'Pending', '2024-05-24 20:34:28', '2024-05-24 20:34:28'),
(29, 'Awaiting Payment', 'ron ron', 44.00, '9fc6230fe7', 'Pending', '2024-05-24 20:36:42', '2024-05-24 20:36:42'),
(30, 'Awaiting Payment', 'luimhar', 56.00, 'a2fc6f9728', 'Pending', '2024-05-24 20:38:39', '2024-05-24 20:38:39'),
(31, 'Awaiting Payment', 'sheilabalbuena', 56.00, 'f5390bf9c1', 'Pending', '2024-05-24 20:40:37', '2024-05-24 20:40:37'),
(32, 'Awaiting Payment', 'Krizette', 54.00, 'fca4c9285d', 'Pending', '2024-05-24 20:42:35', '2024-05-24 20:42:35'),
(33, 'Awaiting Payment', 'earljames acal', 29.00, 'c7368ee38f', 'Pending', '2024-05-24 20:44:31', '2024-05-24 20:44:31'),
(34, 'Awaiting Payment', 'ron', 54.00, '7e19e12b47', 'Pending', '2024-05-24 20:47:03', '2024-05-24 20:47:03'),
(35, 'Awaiting Payment', '', 35.00, '2443b0fdfd', 'Pending', '2024-05-25 03:33:04', '2024-05-25 03:33:04'),
(36, 'Awaiting Payment', '', 25.00, '627dfa1360', 'Pending', '2024-05-25 03:37:01', '2024-05-25 03:37:01');

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

CREATE TABLE `order_items` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `order_id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `add_on_ids` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`add_on_ids`)),
  `flavor_id` bigint(20) UNSIGNED DEFAULT NULL,
  `quantity` int(10) UNSIGNED NOT NULL,
  `customizations` text DEFAULT NULL,
  `subtotal` decimal(8,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `order_items`
--

INSERT INTO `order_items` (`id`, `order_id`, `product_id`, `add_on_ids`, `flavor_id`, `quantity`, `customizations`, `subtotal`, `created_at`, `updated_at`) VALUES
(125, 17, 9, '[\"2\",\"1\"]', 2, 1, NULL, 63.00, NULL, NULL),
(126, 18, 9, '[\"1\",\"2\"]', 2, 4, NULL, 252.00, NULL, NULL),
(128, 19, 6, '[\"3\"]', 4, 1, NULL, 54.00, NULL, NULL),
(129, 19, 1, '[\"1\"]', 1, 2, NULL, 112.00, NULL, NULL),
(132, 21, 2, '[\"2\"]', 1, 1, NULL, 102.00, NULL, NULL),
(133, 22, 6, '[\"3\"]', 4, 1, NULL, 54.00, NULL, NULL),
(134, 23, 4, '[]', 5, 1, NULL, 35.00, NULL, NULL),
(135, 24, 6, '[\"3\"]', 7, 1, NULL, 54.00, NULL, NULL),
(136, 24, 10, '[\"2\",\"1\"]', 1, 2, NULL, 218.00, NULL, NULL),
(137, 24, 6, '[\"3\"]', 4, 1, NULL, 54.00, NULL, NULL),
(139, 26, 9, '[\"2\",\"1\"]', 1, 1, NULL, 63.00, NULL, NULL),
(140, 27, 4, '[]', 4, 1, NULL, 35.00, NULL, NULL),
(141, 27, 9, '[\"1\"]', 1, 1, NULL, 56.00, NULL, NULL),
(142, 28, 9, '[\"1\"]', 3, 1, NULL, 56.00, NULL, NULL),
(144, 30, 9, '[\"2\"]', 2, 1, NULL, 56.00, NULL, NULL),
(145, 31, 9, '[\"2\"]', 1, 1, NULL, 56.00, NULL, NULL),
(146, 32, 6, '[\"3\"]', 4, 1, NULL, 54.00, NULL, NULL),
(148, 34, 6, '[\"3\"]', 6, 1, NULL, 54.00, NULL, NULL),
(149, 35, 4, '[]', 4, 1, NULL, 35.00, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `order_id` bigint(20) UNSIGNED NOT NULL,
  `amount` decimal(8,2) NOT NULL,
  `transaction_status` varchar(255) NOT NULL,
  `payment_method` varchar(255) NOT NULL,
  `transaction_id` varchar(255) NOT NULL,
  `processed_at` datetime NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `payments`
--

INSERT INTO `payments` (`id`, `order_id`, `amount`, `transaction_status`, `payment_method`, `transaction_id`, `processed_at`, `created_at`, `updated_at`) VALUES
(51, 18, 296.00, 'Completed', 'Cash', 'ZA-WRAPPEX123', '2024-05-11 03:56:45', NULL, NULL),
(52, 17, 151.00, 'Completed', 'Cash', 'ZA-WRAPPEX123', '2024-05-11 04:02:30', NULL, NULL),
(53, 18, 296.00, 'Completed', 'Cash', 'ZA-WRAPPEX123', '2024-05-11 04:32:42', NULL, NULL),
(54, 17, 151.00, 'Completed', 'Cash', 'ZA-WRAPPEX123', '2024-05-11 04:51:49', NULL, NULL),
(55, 19, 166.00, 'Completed', 'Cash', 'ZA-WRAPPEX123', '2024-05-11 07:49:08', NULL, NULL),
(56, 19, 166.00, 'Completed', 'Cash', 'ZA-WRAPPEX123', '2024-05-11 07:53:16', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `category_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `price` decimal(8,2) NOT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `category_id`, `name`, `description`, `price`, `image_url`, `active`, `created_at`, `updated_at`) VALUES
(1, 1, 'Shawarma Single Order', 'Enjoy our delicious shawarma single order with your favorite add-ons!', 49.00, 'shawarma_single_order.jpg', 1, '2024-04-27 21:27:41', '2024-04-27 21:27:41'),
(2, 1, 'Shawarma Buy One, Take One', 'Enjoy our delicious shawarma buy one, take one with your favorite add-ons!', 95.00, 'shawarma_buy_one,_take_one.jpg', 1, '2024-04-27 21:27:41', '2024-04-27 21:27:41'),
(4, 4, 'Fruit Soda - 16 oz', 'A delicious 16 oz Fruit Soda - 16 oz', 35.00, 'fruit_soda_-_16_oz.jpg', 1, '2024-04-27 21:27:41', '2024-04-27 21:27:41'),
(6, 5, 'Yakult Series - 16 oz', 'A delicious 16 oz Yakult Series - 16 oz with added Yakult', 39.00, 'yakult_series_-_16_oz.jpg', 1, '2024-04-27 21:27:41', '2024-04-27 21:27:41'),
(9, 3, 'Shawarma Nachos Single Order', 'Enjoy our shawarma nachos single order with your favorite add-ons!', 49.00, 'shawarma_single_order.jpg', 1, '2024-04-27 21:27:41', '2024-04-27 21:27:41'),
(10, 3, 'Shawarma Nachos Buy One, Take One', 'Enjoy our shawarma nachos buy one, take one with your favorite add-ons!', 95.00, 'shawarma_buy_one,_take_one.jpg', 1, '2024-04-27 21:27:41', '2024-04-27 21:27:41');

-- --------------------------------------------------------

--
-- Table structure for table `receipts`
--

CREATE TABLE `receipts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `payment_id` bigint(20) UNSIGNED NOT NULL,
  `issued_at` datetime NOT NULL,
  `details` text NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `receipts`
--

INSERT INTO `receipts` (`id`, `payment_id`, `issued_at`, `details`, `created_at`, `updated_at`) VALUES
(51, 51, '2024-05-11 03:56:45', 'Receipt for Order #18', NULL, NULL),
(52, 52, '2024-05-11 04:02:30', 'Receipt for Order #17', NULL, NULL),
(53, 53, '2024-05-11 04:32:42', 'Receipt for Order #18', NULL, NULL),
(54, 54, '2024-05-11 04:51:49', 'Receipt for Order #17', NULL, NULL),
(55, 55, '2024-05-11 07:49:08', 'Receipt for Order #19', NULL, NULL),
(56, 56, '2024-05-11 07:53:16', 'Receipt for Order #19', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `transaction_slips`
--

CREATE TABLE `transaction_slips` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `order_id` bigint(20) UNSIGNED NOT NULL,
  `issued_at` datetime NOT NULL,
  `code` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `add_ons`
--
ALTER TABLE `add_ons`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `category_add_on`
--
ALTER TABLE `category_add_on`
  ADD PRIMARY KEY (`category_id`,`add_on_id`),
  ADD KEY `category_add_on_add_on_id_foreign` (`add_on_id`);

--
-- Indexes for table `category_flavor`
--
ALTER TABLE `category_flavor`
  ADD PRIMARY KEY (`category_id`,`flavor_id`),
  ADD KEY `category_flavor_flavor_id_foreign` (`flavor_id`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `customer_verifications`
--
ALTER TABLE `customer_verifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `customer_verifications_order_id_foreign` (`order_id`);

--
-- Indexes for table `feedbacks`
--
ALTER TABLE `feedbacks`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `flavors`
--
ALTER TABLE `flavors`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `inventories`
--
ALTER TABLE `inventories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `inventories_product_id_foreign` (`product_id`);

--
-- Indexes for table `merchants`
--
ALTER TABLE `merchants`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `orders_verification_code_unique` (`verification_code`);

--
-- Indexes for table `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_items_order_id_foreign` (`order_id`),
  ADD KEY `order_items_product_id_foreign` (`product_id`),
  ADD KEY `order_items_flavor_id_foreign` (`flavor_id`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `payments_order_id_foreign` (`order_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `products_category_id_foreign` (`category_id`);

--
-- Indexes for table `receipts`
--
ALTER TABLE `receipts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `receipts_payment_id_foreign` (`payment_id`);

--
-- Indexes for table `transaction_slips`
--
ALTER TABLE `transaction_slips`
  ADD PRIMARY KEY (`id`),
  ADD KEY `transaction_slips_order_id_foreign` (`order_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `add_ons`
--
ALTER TABLE `add_ons`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `admins`
--
ALTER TABLE `admins`
  MODIFY `id` tinyint(5) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `id` int(255) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `customer_verifications`
--
ALTER TABLE `customer_verifications`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=78;

--
-- AUTO_INCREMENT for table `feedbacks`
--
ALTER TABLE `feedbacks`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `flavors`
--
ALTER TABLE `flavors`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `inventories`
--
ALTER TABLE `inventories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `merchants`
--
ALTER TABLE `merchants`
  MODIFY `id` int(255) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=76;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=151;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=57;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `receipts`
--
ALTER TABLE `receipts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=57;

--
-- AUTO_INCREMENT for table `transaction_slips`
--
ALTER TABLE `transaction_slips`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `category_add_on`
--
ALTER TABLE `category_add_on`
  ADD CONSTRAINT `category_add_on_add_on_id_foreign` FOREIGN KEY (`add_on_id`) REFERENCES `add_ons` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `category_add_on_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `category_flavor`
--
ALTER TABLE `category_flavor`
  ADD CONSTRAINT `category_flavor_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `category_flavor_flavor_id_foreign` FOREIGN KEY (`flavor_id`) REFERENCES `flavors` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `customer_verifications`
--
ALTER TABLE `customer_verifications`
  ADD CONSTRAINT `customer_verifications_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`);

--
-- Constraints for table `inventories`
--
ALTER TABLE `inventories`
  ADD CONSTRAINT `inventories_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

--
-- Constraints for table `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `order_items_flavor_id_foreign` FOREIGN KEY (`flavor_id`) REFERENCES `flavors` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `order_items_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`),
  ADD CONSTRAINT `order_items_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

--
-- Constraints for table `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `payments_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`);

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`);

--
-- Constraints for table `receipts`
--
ALTER TABLE `receipts`
  ADD CONSTRAINT `receipts_payment_id_foreign` FOREIGN KEY (`payment_id`) REFERENCES `payments` (`id`);

--
-- Constraints for table `transaction_slips`
--
ALTER TABLE `transaction_slips`
  ADD CONSTRAINT `transaction_slips_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
