-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 26, 2024 at 10:24 AM
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
(1, 'Cheesy Dip', 'A Cheesy Dip add-ons for Shawarma', 'cheesy_dip.jpg', 7.00, 1, '2024-04-25 00:34:59', '2024-04-25 00:34:59'),
(2, 'Spicy Dip', 'A Spicy Dip add-ons for Shawarma', 'spicy_dip.jpg', 7.00, 1, '2024-04-25 00:34:59', '2024-04-25 00:34:59'),
(3, 'Add Yakult', 'An additional Yakult to enrich your beverage.', 'add_yakult.jpg', 15.00, 1, '2024-04-25 00:34:59', '2024-04-25 00:34:59');

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
(1, 'shawarma.jpg', 'Shawarma', 'Delicious Shawarma wraps and more', '2024-04-25 00:34:59', '2024-04-25 00:34:59'),
(2, 'fruit_soda_&_tea.jpg', 'Fruit Soda & Tea', 'Refreshing fruit soda and tea in various flavors', '2024-04-25 00:34:59', '2024-04-25 00:34:59'),
(3, 'yakult_series.jpg', 'Yakult Series', 'Healthy Yakult infused drinks', '2024-04-25 00:34:59', '2024-04-25 00:34:59');

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
(1, 2, NULL, NULL),
(3, 3, NULL, NULL);

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
(2, 4, NULL, NULL),
(2, 5, NULL, NULL),
(2, 6, NULL, NULL),
(2, 7, NULL, NULL),
(2, 8, NULL, NULL),
(2, 9, NULL, NULL),
(2, 10, NULL, NULL),
(3, 4, NULL, NULL),
(3, 5, NULL, NULL),
(3, 6, NULL, NULL),
(3, 7, NULL, NULL),
(3, 8, NULL, NULL),
(3, 9, NULL, NULL),
(3, 10, NULL, NULL);

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
(1, 1, '+1.434.515.6603', '417212', '2024-04-25 08:35:00', 1, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(2, 2, '+1-925-407-1047', '359254', '2024-04-25 08:35:00', 2, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(3, 3, '+16035426660', '582785', '2024-04-25 08:35:00', 3, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(4, 4, '1-279-680-1917', '900853', '2024-04-25 08:35:00', 1, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(5, 5, '+14046475775', '255586', '2024-04-25 08:35:00', 3, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(6, 6, '515.257.5472', '775987', '2024-04-25 08:35:00', 3, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(7, 7, '+1-737-295-2203', '725080', '2024-04-25 08:35:00', 2, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(8, 8, '(424) 834-6647', '470240', '2024-04-25 08:35:00', 2, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(9, 9, '660.555.8194', '676961', '2024-04-25 08:35:00', 1, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(10, 10, '(253) 351-7818', '348167', '2024-04-25 08:35:00', 3, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(11, 11, '848-217-8147', '450070', '2024-04-25 08:35:00', 1, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(12, 12, '(301) 281-1701', '694926', '2024-04-25 08:35:00', 3, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(13, 13, '+1-551-813-4674', '105819', '2024-04-25 08:35:00', 2, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(14, 14, '+15808971737', '323623', '2024-04-25 08:35:00', 2, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(15, 15, '1-858-921-3495', '488491', '2024-04-25 08:35:00', 2, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(16, 16, '959.499.6085', '592205', '2024-04-25 08:35:00', 1, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(17, 17, '626.909.3008', '404177', '2024-04-25 08:35:00', 1, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(18, 18, '+1-865-491-1620', '745259', '2024-04-25 08:35:00', 3, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(19, 19, '+1.747.444.8925', '379927', '2024-04-25 08:35:00', 2, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(20, 20, '248.792.5884', '435892', '2024-04-25 08:35:00', 3, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(21, 21, '+1.606.889.3013', '215911', '2024-04-25 08:35:00', 1, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(22, 22, '+1-305-333-3783', '544490', '2024-04-25 08:35:00', 1, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(23, 23, '+1-878-888-5920', '860292', '2024-04-25 08:35:00', 1, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(24, 24, '(743) 253-1544', '762141', '2024-04-25 08:35:00', 2, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(25, 25, '+1-702-874-5964', '847618', '2024-04-25 08:35:00', 2, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(26, 26, '+1 (469) 630-4519', '972265', '2024-04-25 08:35:00', 2, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(27, 27, '+13309858259', '225401', '2024-04-25 08:35:00', 3, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(28, 28, '360.999.4830', '273962', '2024-04-25 08:35:00', 2, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(29, 29, '551-961-7064', '703801', '2024-04-25 08:35:00', 2, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(30, 30, '+13522508167', '549056', '2024-04-25 08:35:00', 2, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(31, 31, '1-283-483-8920', '132594', '2024-04-25 08:35:00', 3, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(32, 32, '870-939-5951', '563011', '2024-04-25 08:35:00', 1, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(33, 33, '407-606-6140', '177887', '2024-04-25 08:35:00', 1, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(34, 34, '+1 (380) 926-4812', '434424', '2024-04-25 08:35:00', 3, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(35, 35, '(724) 815-3484', '949616', '2024-04-25 08:35:00', 2, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(36, 36, '463.893.3056', '354720', '2024-04-25 08:35:00', 3, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(37, 37, '1-215-581-8425', '959036', '2024-04-25 08:35:00', 3, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(38, 38, '1-334-880-7377', '837756', '2024-04-25 08:35:00', 2, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(39, 39, '+1-520-300-6325', '593332', '2024-04-25 08:35:00', 1, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(40, 40, '762-675-9052', '308473', '2024-04-25 08:35:00', 3, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(41, 41, '+1-283-216-3695', '475718', '2024-04-25 08:35:00', 1, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(42, 42, '1-828-552-7893', '181552', '2024-04-25 08:35:00', 3, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(43, 43, '+1 (480) 284-3341', '850839', '2024-04-25 08:35:00', 1, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(44, 44, '+1-507-754-3826', '866387', '2024-04-25 08:35:00', 1, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(45, 45, '+1.408.767.5114', '690444', '2024-04-25 08:35:00', 1, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(46, 46, '540.847.8788', '660979', '2024-04-25 08:35:00', 1, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(47, 47, '434-381-0914', '330353', '2024-04-25 08:35:00', 1, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(48, 48, '(315) 706-4162', '833383', '2024-04-25 08:35:00', 2, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(49, 49, '+1-747-879-8653', '801928', '2024-04-25 08:35:00', 1, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(50, 50, '+1-857-701-1406', '681742', '2024-04-25 08:35:00', 2, '2024-04-25 00:35:00', '2024-04-25 00:35:00');

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
(1, 'jane.doe@example.com', 'I really enjoyed the vegan options! Would love to see more variety in the future.', 'Thank you, Jane! We’re planning to expand our vegan menu soon.', '2024-04-15 00:35:00', '2024-04-16 00:35:00'),
(2, 'john.smith@example.com', 'The order process was a bit confusing. Could you make it more intuitive?', NULL, '2024-04-20 00:35:00', '2024-04-20 00:35:00'),
(3, 'alice.wonderland@example.com', 'Loved the ambiance and the friendly staff. Made my day!', 'We’re thrilled to hear you enjoyed your visit, Alice! Hope to see you again soon.', '2024-04-23 00:35:00', '2024-04-24 00:35:00');

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
(1, 'Pork', 'A delicious Pork flavor.', 'pork.jpg', 1, '2024-04-25 00:34:59', '2024-04-25 00:34:59'),
(2, 'Chicken', 'A delicious Chicken flavor.', 'chicken.jpg', 1, '2024-04-25 00:34:59', '2024-04-25 00:34:59'),
(3, 'Tilapia', 'A delicious Tilapia flavor.', 'tilapia.jpg', 1, '2024-04-25 00:34:59', '2024-04-25 00:34:59'),
(4, 'Kiwi', 'A delicious Kiwi flavor.', 'kiwi.jpg', 1, '2024-04-25 00:34:59', '2024-04-25 00:34:59'),
(5, 'Green Apple', 'A delicious Green Apple flavor.', 'green_apple.jpg', 1, '2024-04-25 00:34:59', '2024-04-25 00:34:59'),
(6, 'Strawberry', 'A delicious Strawberry flavor.', 'strawberry.jpg', 1, '2024-04-25 00:34:59', '2024-04-25 00:34:59'),
(7, 'Lychee', 'A delicious Lychee flavor.', 'lychee.jpg', 1, '2024-04-25 00:34:59', '2024-04-25 00:34:59'),
(8, 'Lemon', 'A delicious Lemon flavor.', 'lemon.jpg', 1, '2024-04-25 00:34:59', '2024-04-25 00:34:59'),
(9, 'Mango', 'A delicious Mango flavor.', 'mango.jpg', 1, '2024-04-25 00:34:59', '2024-04-25 00:34:59'),
(10, 'Blueberry', 'A delicious Blueberry flavor.', 'blueberry.jpg', 1, '2024-04-25 00:34:59', '2024-04-25 00:34:59');

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
(1, 1, 69, 10, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(2, 2, 62, 10, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(3, 3, 22, 10, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(4, 4, 22, 10, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(5, 5, 58, 10, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(6, 6, 86, 10, '2024-04-25 00:35:00', '2024-04-25 00:35:00');

-- --------------------------------------------------------

--
-- Table structure for table `merchants`
--

CREATE TABLE `merchants` (
  `id` int(255) UNSIGNED NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  `restaurant_id` int(255) UNSIGNED NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `type` varchar(255) NOT NULL,
  `related_id` int(11) NOT NULL,
  `status` varchar(255) NOT NULL DEFAULT 'pending',
  `message` text NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `notifications`
--

INSERT INTO `notifications` (`id`, `type`, `related_id`, `status`, `message`, `created_at`, `updated_at`) VALUES
(1, 'new_order', 1, 'delivered', 'Thank you for your order. Your order number is 1.', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(2, 'new_order', 2, 'delivered', 'Thank you for your order. Your order number is 2.', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(3, 'new_order', 3, 'delivered', 'Thank you for your order. Your order number is 3.', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(4, 'new_order', 4, 'delivered', 'Thank you for your order. Your order number is 4.', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(5, 'new_order', 5, 'delivered', 'Thank you for your order. Your order number is 5.', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(6, 'new_order', 6, 'delivered', 'Thank you for your order. Your order number is 6.', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(7, 'new_order', 7, 'delivered', 'Thank you for your order. Your order number is 7.', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(8, 'new_order', 8, 'delivered', 'Thank you for your order. Your order number is 8.', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(9, 'new_order', 9, 'delivered', 'Thank you for your order. Your order number is 9.', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(10, 'new_order', 10, 'delivered', 'Thank you for your order. Your order number is 10.', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(11, 'new_order', 11, 'delivered', 'Thank you for your order. Your order number is 11.', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(12, 'new_order', 12, 'delivered', 'Thank you for your order. Your order number is 12.', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(13, 'new_order', 13, 'delivered', 'Thank you for your order. Your order number is 13.', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(14, 'new_order', 14, 'delivered', 'Thank you for your order. Your order number is 14.', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(15, 'new_order', 15, 'delivered', 'Thank you for your order. Your order number is 15.', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(16, 'new_order', 16, 'delivered', 'Thank you for your order. Your order number is 16.', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(17, 'new_order', 17, 'delivered', 'Thank you for your order. Your order number is 17.', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(18, 'new_order', 18, 'delivered', 'Thank you for your order. Your order number is 18.', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(19, 'new_order', 19, 'delivered', 'Thank you for your order. Your order number is 19.', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(20, 'new_order', 20, 'delivered', 'Thank you for your order. Your order number is 20.', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(21, 'new_order', 21, 'delivered', 'Thank you for your order. Your order number is 21.', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(22, 'new_order', 22, 'delivered', 'Thank you for your order. Your order number is 22.', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(23, 'new_order', 23, 'delivered', 'Thank you for your order. Your order number is 23.', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(24, 'new_order', 24, 'delivered', 'Thank you for your order. Your order number is 24.', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(25, 'new_order', 25, 'delivered', 'Thank you for your order. Your order number is 25.', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(26, 'new_order', 26, 'delivered', 'Thank you for your order. Your order number is 26.', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(27, 'new_order', 27, 'delivered', 'Thank you for your order. Your order number is 27.', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(28, 'new_order', 28, 'delivered', 'Thank you for your order. Your order number is 28.', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(29, 'new_order', 29, 'delivered', 'Thank you for your order. Your order number is 29.', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(30, 'new_order', 30, 'delivered', 'Thank you for your order. Your order number is 30.', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(31, 'new_order', 31, 'delivered', 'Thank you for your order. Your order number is 31.', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(32, 'new_order', 32, 'delivered', 'Thank you for your order. Your order number is 32.', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(33, 'new_order', 33, 'delivered', 'Thank you for your order. Your order number is 33.', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(34, 'new_order', 34, 'delivered', 'Thank you for your order. Your order number is 34.', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(35, 'new_order', 35, 'delivered', 'Thank you for your order. Your order number is 35.', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(36, 'new_order', 36, 'delivered', 'Thank you for your order. Your order number is 36.', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(37, 'new_order', 37, 'delivered', 'Thank you for your order. Your order number is 37.', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(38, 'new_order', 38, 'delivered', 'Thank you for your order. Your order number is 38.', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(39, 'new_order', 39, 'delivered', 'Thank you for your order. Your order number is 39.', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(40, 'new_order', 40, 'delivered', 'Thank you for your order. Your order number is 40.', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(41, 'new_order', 41, 'delivered', 'Thank you for your order. Your order number is 41.', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(42, 'new_order', 42, 'delivered', 'Thank you for your order. Your order number is 42.', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(43, 'new_order', 43, 'delivered', 'Thank you for your order. Your order number is 43.', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(44, 'new_order', 44, 'delivered', 'Thank you for your order. Your order number is 44.', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(45, 'new_order', 45, 'delivered', 'Thank you for your order. Your order number is 45.', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(46, 'new_order', 46, 'delivered', 'Thank you for your order. Your order number is 46.', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(47, 'new_order', 47, 'delivered', 'Thank you for your order. Your order number is 47.', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(48, 'new_order', 48, 'delivered', 'Thank you for your order. Your order number is 48.', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(49, 'new_order', 49, 'delivered', 'Thank you for your order. Your order number is 49.', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(50, 'new_order', 50, 'delivered', 'Thank you for your order. Your order number is 50.', '2024-04-25 00:35:00', '2024-04-25 00:35:00');

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
(1, 'Cancelled', '+1.434.515.6603', 60.70, '69py66', 'Pending', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(2, 'Cancelled', '+1-925-407-1047', 378.04, '21gu88', 'Pending', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(3, 'Confirmed', '+16035426660', 423.61, '84qs85', 'Completed', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(4, 'Awaiting Preparation', '1-279-680-1917', 300.28, '13se14', 'Pending', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(5, 'Awaiting Payment', '+14046475775', 229.80, '60id40', 'Completed', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(6, 'Ready for Pickup', '515.257.5472', 427.36, '37ux85', 'Pending', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(7, 'Awaiting Preparation', '+1-737-295-2203', 379.13, '35um02', 'Pending', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(8, 'Awaiting Payment', '(424) 834-6647', 183.55, '33gy24', 'Completed', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(9, 'Awaiting Preparation', '660.555.8194', 218.64, '92hf48', 'Pending', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(10, 'Payment Received', '(253) 351-7818', 179.29, '72ww86', 'Pending', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(11, 'Awaiting Preparation', '848-217-8147', 306.72, '02da50', 'Pending', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(12, 'Payment Received', '(301) 281-1701', 399.00, '25on26', 'Pending', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(13, 'Confirmed', '+1-551-813-4674', 258.33, '23tl36', 'Pending', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(14, 'Awaiting Verification', '+15808971737', 119.89, '75uv29', 'Completed', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(15, 'Awaiting Verification', '1-858-921-3495', 326.29, '24av65', 'Completed', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(16, 'Cancelled', '959.499.6085', 315.40, '72vo92', 'Pending', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(17, 'Cancelled', '626.909.3008', 104.69, '95yq46', 'Completed', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(18, 'Ready for Pickup', '+1-865-491-1620', 462.20, '13cr99', 'Completed', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(19, 'Ready for Pickup', '+1.747.444.8925', 243.91, '92vu66', 'Completed', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(20, 'Awaiting Payment', '248.792.5884', 252.29, '37iu12', 'Completed', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(21, 'Awaiting Verification', '+1.606.889.3013', 276.72, '99xt23', 'Completed', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(22, 'Awaiting Preparation', '+1-305-333-3783', 222.83, '79fa78', 'Pending', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(23, 'Confirmed', '+1-878-888-5920', 126.05, '19vd80', 'Completed', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(24, 'Payment Received', '(743) 253-1544', 215.93, '46ej39', 'Completed', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(25, 'Awaiting Verification', '+1-702-874-5964', 142.12, '71ya04', 'Completed', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(26, 'Awaiting Payment', '+1 (469) 630-4519', 399.96, '73gu86', 'Pending', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(27, 'Ready for Pickup', '+13309858259', 433.09, '90go88', 'Pending', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(28, 'Ready for Pickup', '360.999.4830', 24.43, '03ji54', 'Pending', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(29, 'Confirmed', '551-961-7064', 445.98, '60mf19', 'Pending', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(30, 'Cancelled', '+13522508167', 416.88, '62wj24', 'Completed', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(31, 'Awaiting Payment', '1-283-483-8920', 271.08, '27sw09', 'Pending', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(32, 'Awaiting Verification', '870-939-5951', 324.99, '07qj97', 'Completed', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(33, 'Ready for Pickup', '407-606-6140', 263.27, '24af72', 'Completed', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(34, 'Confirmed', '+1 (380) 926-4812', 117.19, '98ai75', 'Pending', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(35, 'Confirmed', '(724) 815-3484', 96.87, '75ks67', 'Pending', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(36, 'Awaiting Preparation', '463.893.3056', 138.54, '60nk41', 'Completed', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(37, 'Confirmed', '1-215-581-8425', 129.86, '60or85', 'Pending', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(38, 'Confirmed', '1-334-880-7377', 111.94, '21bf45', 'Pending', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(39, 'Payment Received', '+1-520-300-6325', 330.66, '45ct89', 'Pending', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(40, 'Awaiting Payment', '762-675-9052', 203.21, '02yr50', 'Pending', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(41, 'Ready for Pickup', '+1-283-216-3695', 94.03, '94cp49', 'Pending', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(42, 'Payment Received', '1-828-552-7893', 141.98, '11dg10', 'Completed', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(43, 'Cancelled', '+1 (480) 284-3341', 158.59, '83df33', 'Pending', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(44, 'Ready for Pickup', '+1-507-754-3826', 88.79, '75el17', 'Pending', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(45, 'Awaiting Payment', '+1.408.767.5114', 462.64, '02ol14', 'Completed', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(46, 'Payment Received', '540.847.8788', 84.96, '41nz95', 'Completed', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(47, 'Cancelled', '434-381-0914', 498.57, '74mk65', 'Completed', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(48, 'Cancelled', '(315) 706-4162', 118.32, '09ba09', 'Completed', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(49, 'Cancelled', '+1-747-879-8653', 450.17, '85yh19', 'Pending', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(50, 'Awaiting Verification', '+1-857-701-1406', 466.11, '91zt35', 'Completed', '2024-04-25 00:35:00', '2024-04-25 00:35:00');

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
(1, 1, 1, '\"[1,2]\"', 6, 1, NULL, 63.00, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(2, 1, 6, '\"[3]\"', 6, 1, NULL, 54.00, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(3, 2, 4, '\"[]\"', 4, 1, NULL, 35.00, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(4, 2, 5, '\"[3]\"', 9, 1, NULL, 44.00, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(5, 2, 6, '\"[3]\"', 7, 1, NULL, 54.00, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(6, 3, 5, '\"[3]\"', 9, 4, NULL, 176.00, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(7, 3, 6, '\"[3]\"', 3, 1, NULL, 54.00, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(8, 4, 2, '\"[1,2]\"', 5, 3, NULL, 327.00, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(9, 5, 4, '\"[]\"', 1, 3, NULL, 105.00, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(10, 6, 1, '\"[1,2]\"', 2, 1, NULL, 63.00, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(11, 7, 1, '\"[1,2]\"', 9, 5, NULL, 315.00, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(12, 7, 2, '\"[1,2]\"', 7, 1, NULL, 109.00, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(13, 8, 4, '\"[]\"', 6, 3, NULL, 105.00, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(14, 8, 6, '\"[3]\"', 10, 3, NULL, 162.00, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(15, 9, 2, '\"[1,2]\"', 4, 4, NULL, 436.00, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(16, 9, 5, '\"[3]\"', 5, 1, NULL, 44.00, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(17, 10, 3, '\"[]\"', 8, 2, NULL, 50.00, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(18, 10, 5, '\"[3]\"', 8, 5, NULL, 220.00, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(19, 11, 2, '\"[1,2]\"', 4, 4, NULL, 436.00, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(20, 12, 1, '\"[1,2]\"', 4, 2, NULL, 126.00, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(21, 13, 1, '\"[1,2]\"', 1, 1, NULL, 63.00, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(22, 13, 2, '\"[1,2]\"', 10, 4, NULL, 436.00, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(23, 13, 5, '\"[3]\"', 10, 4, NULL, 176.00, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(24, 14, 1, '\"[1,2]\"', 9, 3, NULL, 189.00, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(25, 14, 5, '\"[3]\"', 3, 4, NULL, 176.00, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(26, 14, 6, '\"[3]\"', 8, 1, NULL, 54.00, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(27, 15, 1, '\"[1,2]\"', 1, 4, NULL, 252.00, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(28, 15, 5, '\"[3]\"', 10, 2, NULL, 88.00, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(29, 15, 6, '\"[3]\"', 3, 2, NULL, 108.00, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(30, 16, 6, '\"[3]\"', 9, 2, NULL, 108.00, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(31, 17, 1, '\"[1,2]\"', 10, 3, NULL, 189.00, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(32, 17, 3, '\"[]\"', 4, 3, NULL, 75.00, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(33, 17, 6, '\"[3]\"', 2, 1, NULL, 54.00, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(34, 18, 1, '\"[1,2]\"', 2, 3, NULL, 189.00, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(35, 18, 2, '\"[1,2]\"', 6, 3, NULL, 327.00, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(36, 18, 6, '\"[3]\"', 4, 5, NULL, 270.00, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(37, 19, 1, '\"[1,2]\"', 6, 4, NULL, 252.00, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(38, 20, 2, '\"[1,2]\"', 8, 4, NULL, 436.00, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(39, 21, 3, '\"[]\"', 8, 5, NULL, 125.00, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(40, 21, 4, '\"[]\"', 5, 4, NULL, 140.00, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(41, 21, 5, '\"[3]\"', 1, 2, NULL, 88.00, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(42, 22, 1, '\"[1,2]\"', 10, 2, NULL, 126.00, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(43, 22, 2, '\"[1,2]\"', 6, 2, NULL, 218.00, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(44, 23, 2, '\"[1,2]\"', 8, 2, NULL, 218.00, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(45, 23, 5, '\"[3]\"', 7, 1, NULL, 44.00, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(46, 24, 2, '\"[1,2]\"', 10, 5, NULL, 545.00, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(47, 24, 3, '\"[]\"', 2, 4, NULL, 100.00, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(48, 24, 4, '\"[]\"', 5, 3, NULL, 105.00, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(49, 25, 3, '\"[]\"', 6, 4, NULL, 100.00, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(50, 25, 6, '\"[3]\"', 10, 1, NULL, 54.00, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(51, 26, 1, '\"[1,2]\"', 3, 3, NULL, 189.00, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(52, 26, 6, '\"[3]\"', 2, 5, NULL, 270.00, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(53, 27, 1, '\"[1,2]\"', 7, 5, NULL, 315.00, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(54, 27, 4, '\"[]\"', 3, 4, NULL, 140.00, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(55, 27, 5, '\"[3]\"', 9, 5, NULL, 220.00, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(56, 28, 2, '\"[1,2]\"', 6, 1, NULL, 109.00, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(57, 28, 4, '\"[]\"', 10, 5, NULL, 175.00, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(58, 28, 5, '\"[3]\"', 1, 1, NULL, 44.00, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(59, 29, 3, '\"[]\"', 10, 2, NULL, 50.00, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(60, 29, 4, '\"[]\"', 10, 2, NULL, 70.00, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(61, 29, 6, '\"[3]\"', 9, 5, NULL, 270.00, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(62, 30, 3, '\"[]\"', 10, 2, NULL, 50.00, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(63, 30, 5, '\"[3]\"', 9, 3, NULL, 132.00, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(64, 30, 6, '\"[3]\"', 9, 5, NULL, 270.00, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(65, 31, 3, '\"[]\"', 4, 4, NULL, 100.00, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(66, 32, 2, '\"[1,2]\"', 10, 4, NULL, 436.00, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(67, 33, 2, '\"[1,2]\"', 4, 1, NULL, 109.00, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(68, 33, 6, '\"[3]\"', 4, 2, NULL, 108.00, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(69, 34, 3, '\"[]\"', 10, 4, NULL, 100.00, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(70, 34, 5, '\"[3]\"', 3, 4, NULL, 176.00, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(71, 35, 1, '\"[1,2]\"', 3, 4, NULL, 252.00, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(72, 36, 2, '\"[1,2]\"', 3, 4, NULL, 436.00, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(73, 36, 3, '\"[]\"', 6, 5, NULL, 125.00, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(74, 36, 4, '\"[]\"', 4, 4, NULL, 140.00, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(75, 37, 1, '\"[1,2]\"', 5, 4, NULL, 252.00, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(76, 37, 6, '\"[3]\"', 6, 2, NULL, 108.00, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(77, 38, 3, '\"[]\"', 6, 5, NULL, 125.00, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(78, 39, 4, '\"[]\"', 1, 3, NULL, 105.00, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(79, 39, 5, '\"[3]\"', 4, 3, NULL, 132.00, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(80, 39, 6, '\"[3]\"', 9, 4, NULL, 216.00, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(81, 40, 2, '\"[1,2]\"', 5, 5, NULL, 545.00, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(82, 40, 4, '\"[]\"', 5, 1, NULL, 35.00, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(83, 40, 5, '\"[3]\"', 9, 5, NULL, 220.00, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(84, 41, 1, '\"[1,2]\"', 8, 2, NULL, 126.00, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(85, 41, 5, '\"[3]\"', 6, 3, NULL, 132.00, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(86, 41, 6, '\"[3]\"', 8, 1, NULL, 54.00, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(87, 42, 2, '\"[1,2]\"', 1, 1, NULL, 109.00, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(88, 42, 6, '\"[3]\"', 5, 5, NULL, 270.00, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(89, 43, 6, '\"[3]\"', 1, 2, NULL, 108.00, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(90, 44, 2, '\"[1,2]\"', 10, 2, NULL, 218.00, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(91, 44, 5, '\"[3]\"', 2, 1, NULL, 44.00, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(92, 45, 3, '\"[]\"', 5, 3, NULL, 75.00, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(93, 45, 4, '\"[]\"', 4, 3, NULL, 105.00, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(94, 46, 1, '\"[1,2]\"', 2, 1, NULL, 63.00, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(95, 46, 5, '\"[3]\"', 1, 5, NULL, 220.00, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(96, 47, 2, '\"[1,2]\"', 7, 4, NULL, 436.00, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(97, 48, 2, '\"[1,2]\"', 3, 3, NULL, 327.00, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(98, 49, 1, '\"[1,2]\"', 5, 1, NULL, 63.00, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(99, 49, 4, '\"[]\"', 2, 5, NULL, 175.00, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(100, 49, 5, '\"[3]\"', 9, 3, NULL, 132.00, '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(101, 50, 5, '\"[3]\"', 6, 2, NULL, 88.00, '2024-04-25 00:35:00', '2024-04-25 00:35:00');

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
(1, 1, 60.70, 'Pending', 'Credit Card', 'DA020UIN26', '2024-04-25 08:35:00', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(2, 2, 378.04, 'Pending', 'Credit Card', 'XH395VOK55', '2024-04-25 08:35:00', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(3, 3, 423.61, 'Completed', 'Credit Card', 'RM646RVE44', '2024-04-25 08:35:00', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(4, 4, 300.28, 'Pending', 'Online', 'IJ442QKG47', '2024-04-25 08:35:00', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(5, 5, 229.80, 'Pending', 'Credit Card', 'BR904OGA59', '2024-04-25 08:35:00', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(6, 6, 427.36, 'Completed', 'Credit Card', 'FT454MTL65', '2024-04-25 08:35:00', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(7, 7, 379.13, 'Completed', 'Cash', 'FF010LQH91', '2024-04-25 08:35:00', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(8, 8, 183.55, 'Completed', 'Cash', 'NM124XZR05', '2024-04-25 08:35:00', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(9, 9, 218.64, 'Completed', 'Credit Card', 'RC866WKB38', '2024-04-25 08:35:00', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(10, 10, 179.29, 'Pending', 'Online', 'QD451MIL98', '2024-04-25 08:35:00', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(11, 11, 306.72, 'Completed', 'Credit Card', 'WZ132HBL55', '2024-04-25 08:35:00', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(12, 12, 399.00, 'Completed', 'Credit Card', 'GU419DMF72', '2024-04-25 08:35:00', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(13, 13, 258.33, 'Pending', 'Credit Card', 'UF431KPN59', '2024-04-25 08:35:00', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(14, 14, 119.89, 'Completed', 'Cash', 'CN225FFN46', '2024-04-25 08:35:00', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(15, 15, 326.29, 'Pending', 'Credit Card', 'UA622LRQ67', '2024-04-25 08:35:00', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(16, 16, 315.40, 'Completed', 'Cash', 'PF837IZK76', '2024-04-25 08:35:00', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(17, 17, 104.69, 'Completed', 'Online', 'HL693AHX60', '2024-04-25 08:35:00', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(18, 18, 462.20, 'Completed', 'Online', 'ZD244LIR76', '2024-04-25 08:35:00', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(19, 19, 243.91, 'Pending', 'Cash', 'PI661MRG38', '2024-04-25 08:35:00', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(20, 20, 252.29, 'Pending', 'Online', 'GT530CYM84', '2024-04-25 08:35:00', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(21, 21, 276.72, 'Completed', 'Online', 'FV186QBN76', '2024-04-25 08:35:00', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(22, 22, 222.83, 'Completed', 'Cash', 'SA662ISD36', '2024-04-25 08:35:00', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(23, 23, 126.05, 'Completed', 'Cash', 'EJ663NSG93', '2024-04-25 08:35:00', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(24, 24, 215.93, 'Completed', 'Credit Card', 'XO765YWC68', '2024-04-25 08:35:00', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(25, 25, 142.12, 'Completed', 'Credit Card', 'QS884EWK09', '2024-04-25 08:35:00', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(26, 26, 399.96, 'Pending', 'Cash', 'BB323ZEP60', '2024-04-25 08:35:00', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(27, 27, 433.09, 'Pending', 'Cash', 'NJ253TQA75', '2024-04-25 08:35:00', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(28, 28, 24.43, 'Completed', 'Cash', 'BE485LOY61', '2024-04-25 08:35:00', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(29, 29, 445.98, 'Pending', 'Online', 'ZI917XZF73', '2024-04-25 08:35:00', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(30, 30, 416.88, 'Completed', 'Credit Card', 'PT047QTV75', '2024-04-25 08:35:00', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(31, 31, 271.08, 'Completed', 'Cash', 'DP685QET71', '2024-04-25 08:35:00', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(32, 32, 324.99, 'Pending', 'Cash', 'NR408DAQ15', '2024-04-25 08:35:00', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(33, 33, 263.27, 'Pending', 'Cash', 'VB966SXQ76', '2024-04-25 08:35:00', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(34, 34, 117.19, 'Completed', 'Online', 'RU903ZFA06', '2024-04-25 08:35:00', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(35, 35, 96.87, 'Completed', 'Cash', 'AP530VYI78', '2024-04-25 08:35:00', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(36, 36, 138.54, 'Completed', 'Online', 'FW188ZAS47', '2024-04-25 08:35:00', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(37, 37, 129.86, 'Pending', 'Cash', 'TF725LFP21', '2024-04-25 08:35:00', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(38, 38, 111.94, 'Pending', 'Online', 'NV978BTG09', '2024-04-25 08:35:00', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(39, 39, 330.66, 'Completed', 'Cash', 'XI545RXQ61', '2024-04-25 08:35:00', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(40, 40, 203.21, 'Pending', 'Credit Card', 'AR487KVR67', '2024-04-25 08:35:00', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(41, 41, 94.03, 'Pending', 'Credit Card', 'JG917SDM04', '2024-04-25 08:35:00', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(42, 42, 141.98, 'Pending', 'Online', 'UE271TGH79', '2024-04-25 08:35:00', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(43, 43, 158.59, 'Pending', 'Online', 'WW120MQQ34', '2024-04-25 08:35:00', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(44, 44, 88.79, 'Pending', 'Online', 'VV194UBR86', '2024-04-25 08:35:00', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(45, 45, 462.64, 'Pending', 'Credit Card', 'OH189WPC29', '2024-04-25 08:35:00', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(46, 46, 84.96, 'Pending', 'Online', 'IC086RQT30', '2024-04-25 08:35:00', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(47, 47, 498.57, 'Pending', 'Online', 'VI421PSO77', '2024-04-25 08:35:00', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(48, 48, 118.32, 'Pending', 'Credit Card', 'WK047WFX58', '2024-04-25 08:35:00', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(49, 49, 450.17, 'Completed', 'Online', 'TP210QLR85', '2024-04-25 08:35:00', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(50, 50, 466.11, 'Completed', 'Cash', 'YJ021HBG08', '2024-04-25 08:35:00', '2024-04-25 00:35:00', '2024-04-25 00:35:00');

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
(1, 1, 'Shawarma Single Order', 'Enjoy our delicious shawarma single order with your favorite add-ons!', 49.00, 'shawarma_single_order.jpg', 1, '2024-04-25 00:34:59', '2024-04-25 00:34:59'),
(2, 1, 'Shawarma Buy One, Take One', 'Enjoy our delicious shawarma buy one, take one with your favorite add-ons!', 95.00, 'shawarma_buy_one,_take_one.jpg', 1, '2024-04-25 00:34:59', '2024-04-25 00:34:59'),
(3, 2, 'Fruit Soda - 12 oz', 'A delicious 12 oz Fruit Soda - 12 oz', 25.00, 'fruit_soda_-_12_oz.jpg', 1, '2024-04-25 00:34:59', '2024-04-25 00:34:59'),
(4, 2, 'Fruit Soda - 16 oz', 'A delicious 16 oz Fruit Soda - 16 oz', 35.00, 'fruit_soda_-_16_oz.jpg', 1, '2024-04-25 00:34:59', '2024-04-25 00:34:59'),
(5, 3, 'Yakult Series - 12 oz', 'A delicious 12 oz Yakult Series - 12 oz with added Yakult', 29.00, 'yakult_series_-_12_oz.jpg', 1, '2024-04-25 00:34:59', '2024-04-25 00:34:59'),
(6, 3, 'Yakult Series - 16 oz', 'A delicious 16 oz Yakult Series - 16 oz with added Yakult', 39.00, 'yakult_series_-_16_oz.jpg', 1, '2024-04-25 00:34:59', '2024-04-25 00:34:59');

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
(1, 1, '2024-04-25 08:35:00', 'Payment received for Order ID: 1. Total amount: 60.70.', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(2, 2, '2024-04-25 08:35:00', 'Payment received for Order ID: 2. Total amount: 378.04.', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(3, 3, '2024-04-25 08:35:00', 'Payment received for Order ID: 3. Total amount: 423.61.', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(4, 4, '2024-04-25 08:35:00', 'Payment received for Order ID: 4. Total amount: 300.28.', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(5, 5, '2024-04-25 08:35:00', 'Payment received for Order ID: 5. Total amount: 229.80.', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(6, 6, '2024-04-25 08:35:00', 'Payment received for Order ID: 6. Total amount: 427.36.', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(7, 7, '2024-04-25 08:35:00', 'Payment received for Order ID: 7. Total amount: 379.13.', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(8, 8, '2024-04-25 08:35:00', 'Payment received for Order ID: 8. Total amount: 183.55.', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(9, 9, '2024-04-25 08:35:00', 'Payment received for Order ID: 9. Total amount: 218.64.', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(10, 10, '2024-04-25 08:35:00', 'Payment received for Order ID: 10. Total amount: 179.29.', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(11, 11, '2024-04-25 08:35:00', 'Payment received for Order ID: 11. Total amount: 306.72.', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(12, 12, '2024-04-25 08:35:00', 'Payment received for Order ID: 12. Total amount: 399.00.', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(13, 13, '2024-04-25 08:35:00', 'Payment received for Order ID: 13. Total amount: 258.33.', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(14, 14, '2024-04-25 08:35:00', 'Payment received for Order ID: 14. Total amount: 119.89.', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(15, 15, '2024-04-25 08:35:00', 'Payment received for Order ID: 15. Total amount: 326.29.', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(16, 16, '2024-04-25 08:35:00', 'Payment received for Order ID: 16. Total amount: 315.40.', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(17, 17, '2024-04-25 08:35:00', 'Payment received for Order ID: 17. Total amount: 104.69.', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(18, 18, '2024-04-25 08:35:00', 'Payment received for Order ID: 18. Total amount: 462.20.', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(19, 19, '2024-04-25 08:35:00', 'Payment received for Order ID: 19. Total amount: 243.91.', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(20, 20, '2024-04-25 08:35:00', 'Payment received for Order ID: 20. Total amount: 252.29.', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(21, 21, '2024-04-25 08:35:00', 'Payment received for Order ID: 21. Total amount: 276.72.', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(22, 22, '2024-04-25 08:35:00', 'Payment received for Order ID: 22. Total amount: 222.83.', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(23, 23, '2024-04-25 08:35:00', 'Payment received for Order ID: 23. Total amount: 126.05.', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(24, 24, '2024-04-25 08:35:00', 'Payment received for Order ID: 24. Total amount: 215.93.', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(25, 25, '2024-04-25 08:35:00', 'Payment received for Order ID: 25. Total amount: 142.12.', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(26, 26, '2024-04-25 08:35:00', 'Payment received for Order ID: 26. Total amount: 399.96.', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(27, 27, '2024-04-25 08:35:00', 'Payment received for Order ID: 27. Total amount: 433.09.', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(28, 28, '2024-04-25 08:35:00', 'Payment received for Order ID: 28. Total amount: 24.43.', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(29, 29, '2024-04-25 08:35:00', 'Payment received for Order ID: 29. Total amount: 445.98.', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(30, 30, '2024-04-25 08:35:00', 'Payment received for Order ID: 30. Total amount: 416.88.', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(31, 31, '2024-04-25 08:35:00', 'Payment received for Order ID: 31. Total amount: 271.08.', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(32, 32, '2024-04-25 08:35:00', 'Payment received for Order ID: 32. Total amount: 324.99.', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(33, 33, '2024-04-25 08:35:00', 'Payment received for Order ID: 33. Total amount: 263.27.', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(34, 34, '2024-04-25 08:35:00', 'Payment received for Order ID: 34. Total amount: 117.19.', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(35, 35, '2024-04-25 08:35:00', 'Payment received for Order ID: 35. Total amount: 96.87.', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(36, 36, '2024-04-25 08:35:00', 'Payment received for Order ID: 36. Total amount: 138.54.', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(37, 37, '2024-04-25 08:35:00', 'Payment received for Order ID: 37. Total amount: 129.86.', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(38, 38, '2024-04-25 08:35:00', 'Payment received for Order ID: 38. Total amount: 111.94.', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(39, 39, '2024-04-25 08:35:00', 'Payment received for Order ID: 39. Total amount: 330.66.', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(40, 40, '2024-04-25 08:35:00', 'Payment received for Order ID: 40. Total amount: 203.21.', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(41, 41, '2024-04-25 08:35:00', 'Payment received for Order ID: 41. Total amount: 94.03.', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(42, 42, '2024-04-25 08:35:00', 'Payment received for Order ID: 42. Total amount: 141.98.', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(43, 43, '2024-04-25 08:35:00', 'Payment received for Order ID: 43. Total amount: 158.59.', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(44, 44, '2024-04-25 08:35:00', 'Payment received for Order ID: 44. Total amount: 88.79.', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(45, 45, '2024-04-25 08:35:00', 'Payment received for Order ID: 45. Total amount: 462.64.', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(46, 46, '2024-04-25 08:35:00', 'Payment received for Order ID: 46. Total amount: 84.96.', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(47, 47, '2024-04-25 08:35:00', 'Payment received for Order ID: 47. Total amount: 498.57.', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(48, 48, '2024-04-25 08:35:00', 'Payment received for Order ID: 48. Total amount: 118.32.', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(49, 49, '2024-04-25 08:35:00', 'Payment received for Order ID: 49. Total amount: 450.17.', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(50, 50, '2024-04-25 08:35:00', 'Payment received for Order ID: 50. Total amount: 466.11.', '2024-04-25 00:35:00', '2024-04-25 00:35:00');

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
-- Dumping data for table `transaction_slips`
--

INSERT INTO `transaction_slips` (`id`, `order_id`, `issued_at`, `code`, `created_at`, `updated_at`) VALUES
(1, 1, '2024-04-25 08:35:00', 'BADXJTGZCL', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(2, 2, '2024-04-25 08:35:00', 'H6MTIKKDSW', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(3, 3, '2024-04-25 08:35:00', 'OAMIC8XDJR', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(4, 4, '2024-04-25 08:35:00', 'IAVLEFOSJ9', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(5, 5, '2024-04-25 08:35:00', 'CDHW0AW4ZV', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(6, 6, '2024-04-25 08:35:00', 'PVUWLDMUBC', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(7, 7, '2024-04-25 08:35:00', 'KS1XU2VZKU', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(8, 8, '2024-04-25 08:35:00', 'X17YUIU3PI', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(9, 9, '2024-04-25 08:35:00', '2Q1OLS2HWT', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(10, 10, '2024-04-25 08:35:00', 'Y5J4S8H1IB', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(11, 11, '2024-04-25 08:35:00', 'LVZCXO3TIR', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(12, 12, '2024-04-25 08:35:00', 'PVWQ6W4FQX', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(13, 13, '2024-04-25 08:35:00', 'HBN6IVNJSG', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(14, 14, '2024-04-25 08:35:00', 'H35ZB2P86C', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(15, 15, '2024-04-25 08:35:00', 'TWO8TMHFBO', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(16, 16, '2024-04-25 08:35:00', 'OL2PG58EV2', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(17, 17, '2024-04-25 08:35:00', '6JRZF9MG6D', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(18, 18, '2024-04-25 08:35:00', '8QHBO4DDRG', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(19, 19, '2024-04-25 08:35:00', 'BS43YMKFIT', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(20, 20, '2024-04-25 08:35:00', '7XWQPIYGAU', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(21, 21, '2024-04-25 08:35:00', 'DDXT310YJS', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(22, 22, '2024-04-25 08:35:00', 'CFYD4MQTF6', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(23, 23, '2024-04-25 08:35:00', '3A85FIITCF', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(24, 24, '2024-04-25 08:35:00', 'ROSCQRRFTP', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(25, 25, '2024-04-25 08:35:00', 'PZ2VZ0SXVC', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(26, 26, '2024-04-25 08:35:00', 'MWGOQMLEDM', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(27, 27, '2024-04-25 08:35:00', 'E9HF1GDOPL', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(28, 28, '2024-04-25 08:35:00', 'NKEUITVHOV', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(29, 29, '2024-04-25 08:35:00', 'NT90BKNS3D', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(30, 30, '2024-04-25 08:35:00', '01OJ24WBTV', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(31, 31, '2024-04-25 08:35:00', 'AKIVZKKETF', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(32, 32, '2024-04-25 08:35:00', 'LE0N8P4BTA', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(33, 33, '2024-04-25 08:35:00', 'B7RAO10NWN', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(34, 34, '2024-04-25 08:35:00', 'UQOOIU1WNF', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(35, 35, '2024-04-25 08:35:00', '5NXJW62P0Q', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(36, 36, '2024-04-25 08:35:00', 'T9LHMHWL08', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(37, 37, '2024-04-25 08:35:00', 'ZZH9NRW4PY', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(38, 38, '2024-04-25 08:35:00', 'JMM7LBPJJJ', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(39, 39, '2024-04-25 08:35:00', '4BDIJWO6RF', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(40, 40, '2024-04-25 08:35:00', 'GYEE8C8NMB', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(41, 41, '2024-04-25 08:35:00', 'KY7LD1GKSN', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(42, 42, '2024-04-25 08:35:00', 'MD2MDTF775', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(43, 43, '2024-04-25 08:35:00', 'P2MLG0AEYQ', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(44, 44, '2024-04-25 08:35:00', 'YWXSFMD9HA', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(45, 45, '2024-04-25 08:35:00', 'LRFI40TB9Y', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(46, 46, '2024-04-25 08:35:00', '0KQS9XRLJR', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(47, 47, '2024-04-25 08:35:00', 'WC5ZRG1OEZ', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(48, 48, '2024-04-25 08:35:00', 'AQ3EDPBIVJ', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(49, 49, '2024-04-25 08:35:00', 'CDCVTAYISR', '2024-04-25 00:35:00', '2024-04-25 00:35:00'),
(50, 50, '2024-04-25 08:35:00', 'BL2AYXPA0N', '2024-04-25 00:35:00', '2024-04-25 00:35:00');

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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `id` int(255) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `customer_verifications`
--
ALTER TABLE `customer_verifications`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `merchants`
--
ALTER TABLE `merchants`
  MODIFY `id` int(255) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=102;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `receipts`
--
ALTER TABLE `receipts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

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
