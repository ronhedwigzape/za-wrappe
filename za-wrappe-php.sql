-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 09, 2024 at 10:34 AM
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
(1, 'Cheesy Dip', 'A Cheesy Dip add-ons for Shawarma', 'cheesy_dip.jpg', 7.00, 1, '2024-04-27 21:27:41', '2024-04-27 21:27:41'),
(2, 'Spicy Dip', 'A Spicy Dip add-ons for Shawarma', 'spicy_dip.jpg', 7.00, 1, '2024-04-27 21:27:41', '2024-04-27 21:27:41'),
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
(2, 'shawarma.jpg', 'Shawarma Rice', 'Delicious Shawarma served on a bed of rice', '2024-04-27 21:27:41', '2024-04-27 21:27:41'),
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
(1, 2, NULL, NULL),
(2, 1, NULL, NULL),
(2, 2, NULL, NULL),
(3, 1, NULL, NULL),
(3, 2, NULL, NULL),
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
(2, 1, NULL, NULL),
(2, 2, NULL, NULL),
(2, 3, NULL, NULL),
(3, 1, NULL, NULL),
(3, 2, NULL, NULL),
(3, 3, NULL, NULL),
(4, 4, NULL, NULL),
(4, 5, NULL, NULL),
(4, 6, NULL, NULL),
(4, 7, NULL, NULL),
(4, 8, NULL, NULL),
(4, 9, NULL, NULL),
(4, 10, NULL, NULL),
(5, 4, NULL, NULL),
(5, 5, NULL, NULL),
(5, 6, NULL, NULL),
(5, 7, NULL, NULL),
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
(1, 1, '1-480-645-0461', '623823', '2024-04-28 05:27:43', 2, '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(2, 2, '832-256-9514', '690895', '2024-04-28 05:27:43', 1, '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(3, 3, '+15679256558', '775922', '2024-04-28 05:27:43', 1, '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(4, 4, '+1-986-843-0417', '799449', '2024-04-28 05:27:43', 2, '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(5, 5, '+18565316250', '666024', '2024-04-28 05:27:43', 3, '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(6, 6, '(838) 392-3720', '584782', '2024-04-28 05:27:43', 3, '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(7, 7, '+18065021461', '873668', '2024-04-28 05:27:43', 2, '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(8, 8, '630-465-0141', '949090', '2024-04-28 05:27:43', 1, '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(9, 9, '(904) 900-5648', '488494', '2024-04-28 05:27:43', 1, '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(10, 10, '551-700-6937', '149666', '2024-04-28 05:27:43', 3, '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(11, 11, '860-741-5419', '117616', '2024-04-28 05:27:43', 1, '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(12, 12, '512.649.0038', '507783', '2024-04-28 05:27:43', 2, '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(13, 13, '862-444-4857', '410442', '2024-04-28 05:27:43', 1, '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(14, 14, '440-404-6897', '643981', '2024-04-28 05:27:43', 2, '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(15, 15, '661-375-1306', '124328', '2024-04-28 05:27:43', 1, '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(16, 16, '580.490.2077', '474119', '2024-04-28 05:27:43', 3, '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(17, 17, '+1-267-458-9321', '582133', '2024-04-28 05:27:43', 1, '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(18, 18, '626.200.5543', '413110', '2024-04-28 05:27:43', 3, '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(19, 19, '1-820-919-3060', '475816', '2024-04-28 05:27:43', 3, '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(20, 20, '231.377.0831', '124465', '2024-04-28 05:27:43', 2, '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(21, 21, '973.503.8339', '208915', '2024-04-28 05:27:43', 2, '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(22, 22, '+12819102730', '986007', '2024-04-28 05:27:43', 1, '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(23, 23, '+1 (832) 994-8538', '418386', '2024-04-28 05:27:43', 2, '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(24, 24, '1-781-509-8692', '367475', '2024-04-28 05:27:43', 2, '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(25, 25, '+1 (743) 616-7155', '616228', '2024-04-28 05:27:43', 3, '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(26, 26, '+1 (740) 797-5265', '650197', '2024-04-28 05:27:43', 3, '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(27, 27, '(607) 917-0690', '832482', '2024-04-28 05:27:43', 2, '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(28, 28, '1-210-340-1190', '893980', '2024-04-28 05:27:43', 3, '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(29, 29, '(606) 441-9179', '219769', '2024-04-28 05:27:43', 3, '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(30, 30, '972.913.5975', '245887', '2024-04-28 05:27:43', 3, '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(31, 31, '+14787138320', '754726', '2024-04-28 05:27:43', 1, '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(32, 32, '+1-561-801-4188', '282418', '2024-04-28 05:27:43', 2, '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(33, 33, '(469) 410-8717', '397709', '2024-04-28 05:27:43', 3, '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(34, 34, '+1.570.339.1480', '938944', '2024-04-28 05:27:43', 3, '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(35, 35, '(430) 471-9356', '397215', '2024-04-28 05:27:43', 3, '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(36, 36, '301.831.7679', '382674', '2024-04-28 05:27:43', 2, '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(37, 37, '1-281-679-3026', '127881', '2024-04-28 05:27:43', 2, '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(38, 38, '617-409-5621', '784358', '2024-04-28 05:27:43', 1, '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(39, 39, '+1 (938) 632-4858', '518573', '2024-04-28 05:27:43', 2, '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(40, 40, '+1-321-453-2616', '386328', '2024-04-28 05:27:43', 2, '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(41, 41, '+1-623-347-6573', '910749', '2024-04-28 05:27:43', 1, '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(42, 42, '773-833-3810', '242041', '2024-04-28 05:27:43', 2, '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(43, 43, '1-586-414-8462', '521505', '2024-04-28 05:27:43', 3, '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(44, 44, '+1-520-980-3149', '882841', '2024-04-28 05:27:43', 2, '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(45, 45, '458-347-9087', '494715', '2024-04-28 05:27:43', 3, '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(46, 46, '+12258305574', '767299', '2024-04-28 05:27:43', 3, '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(47, 47, '814-917-2504', '480497', '2024-04-28 05:27:43', 2, '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(48, 48, '+1 (619) 282-1343', '705453', '2024-04-28 05:27:43', 2, '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(49, 49, '+1-815-257-5935', '234931', '2024-04-28 05:27:43', 2, '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(50, 50, '1-402-659-9626', '226464', '2024-04-28 05:27:43', 3, '2024-04-27 21:27:43', '2024-04-27 21:27:43');

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
(5, 'Green Apple', 'A delicious Green Apple flavor.', 'green_apple.jpg', 1, '2024-04-27 21:27:41', '2024-04-27 21:27:41'),
(6, 'Strawberry', 'A delicious Strawberry flavor.', 'strawberry.jpg', 1, '2024-04-27 21:27:41', '2024-04-27 21:27:41'),
(7, 'Lychee', 'A delicious Lychee flavor.', 'lychee.jpg', 1, '2024-04-27 21:27:41', '2024-04-27 21:27:41'),
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
(1, 1, 87, 10, '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(2, 2, 73, 10, '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(3, 3, 91, 10, '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(4, 4, 80, 10, '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(5, 5, 47, 10, '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(6, 6, 38, 10, '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(7, 7, 84, 10, '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(8, 8, 79, 10, '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(9, 9, 35, 10, '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(10, 10, 44, 10, '2024-04-27 21:27:43', '2024-04-27 21:27:43');

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
(1, 'customer_to_merchant', 1, 1, 'delivered', 'Thank you for your order. Your order number is 1.', '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(2, 'customer_to_merchant', 1, 1, 'delivered', 'Thank you for your order. Your order number is 2.', '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(3, 'customer_to_merchant', 1, 1, 'delivered', 'Thank you for your order. Your order number is 3.', '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(4, 'customer_to_merchant', 1, 1, 'delivered', 'Thank you for your order. Your order number is 4.', '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(5, 'customer_to_merchant', 1, 1, 'delivered', 'Thank you for your order. Your order number is 5.', '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(6, 'customer_to_merchant', 1, 1, 'delivered', 'Thank you for your order. Your order number is 6.', '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(7, 'customer_to_merchant', 1, 1, 'delivered', 'Thank you for your order. Your order number is 7.', '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(8, 'customer_to_merchant', 1, 1, 'delivered', 'Thank you for your order. Your order number is 8.', '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(9, 'customer_to_merchant', 1, 1, 'delivered', 'Thank you for your order. Your order number is 9.', '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(10, 'customer_to_merchant', 1, 1, 'delivered', 'Thank you for your order. Your order number is 10.', '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(11, 'customer_to_merchant', 1, 1, 'delivered', 'Thank you for your order. Your order number is 11.', '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(12, 'customer_to_merchant', 1, 1, 'delivered', 'Thank you for your order. Your order number is 12.', '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(13, 'customer_to_merchant', 1, 1, 'delivered', 'Thank you for your order. Your order number is 13.', '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(14, 'customer_to_merchant', 1, 1, 'delivered', 'Thank you for your order. Your order number is 14.', '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(15, 'customer_to_merchant', 1, 1, 'delivered', 'Thank you for your order. Your order number is 15.', '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(16, 'customer_to_merchant', 1, 1, 'delivered', 'Thank you for your order. Your order number is 16.', '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(17, 'customer_to_merchant', 1, 1, 'delivered', 'Thank you for your order. Your order number is 17.', '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(18, 'customer_to_merchant', 1, 1, 'delivered', 'Thank you for your order. Your order number is 18.', '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(19, 'customer_to_merchant', 1, 1, 'delivered', 'Thank you for your order. Your order number is 19.', '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(20, 'customer_to_merchant', 1, 1, 'delivered', 'Thank you for your order. Your order number is 20.', '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(21, 'customer_to_merchant', 1, 1, 'delivered', 'Thank you for your order. Your order number is 21.', '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(22, 'customer_to_merchant', 1, 1, 'delivered', 'Thank you for your order. Your order number is 22.', '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(23, 'customer_to_merchant', 1, 1, 'delivered', 'Thank you for your order. Your order number is 23.', '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(24, 'customer_to_merchant', 1, 1, 'delivered', 'Thank you for your order. Your order number is 24.', '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(25, 'customer_to_merchant', 1, 1, 'delivered', 'Thank you for your order. Your order number is 25.', '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(26, 'customer_to_merchant', 1, 1, 'delivered', 'Thank you for your order. Your order number is 26.', '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(27, 'customer_to_merchant', 1, 1, 'delivered', 'Thank you for your order. Your order number is 27.', '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(28, 'customer_to_merchant', 1, 1, 'delivered', 'Thank you for your order. Your order number is 28.', '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(29, 'customer_to_merchant', 1, 1, 'delivered', 'Thank you for your order. Your order number is 29.', '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(30, 'customer_to_merchant', 1, 1, 'delivered', 'Thank you for your order. Your order number is 30.', '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(31, 'new_order', 1, 1, 'delivered', 'Thank you for your order. Your order number is 31.', '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(32, 'new_order', 1, 1, 'delivered', 'Thank you for your order. Your order number is 32.', '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(33, 'new_order', 1, 1, 'delivered', 'Thank you for your order. Your order number is 33.', '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(34, 'new_order', 1, 1, 'delivered', 'Thank you for your order. Your order number is 34.', '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(35, 'new_order', 1, 1, 'delivered', 'Thank you for your order. Your order number is 35.', '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(36, 'new_order', 1, 1, 'delivered', 'Thank you for your order. Your order number is 36.', '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(37, 'new_order', 1, 1, 'delivered', 'Thank you for your order. Your order number is 37.', '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(38, 'new_order', 1, 1, 'delivered', 'Thank you for your order. Your order number is 38.', '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(39, 'new_order', 1, 1, 'delivered', 'Thank you for your order. Your order number is 39.', '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(40, 'new_order', 1, 1, 'delivered', 'Thank you for your order. Your order number is 40.', '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(41, 'new_order', 1, 1, 'delivered', 'Thank you for your order. Your order number is 41.', '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(42, 'new_order', 1, 1, 'delivered', 'Thank you for your order. Your order number is 42.', '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(43, 'new_order', 1, 1, 'delivered', 'Thank you for your order. Your order number is 43.', '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(44, 'new_order', 1, 1, 'delivered', 'Thank you for your order. Your order number is 44.', '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(45, 'new_order', 1, 1, 'delivered', 'Thank you for your order. Your order number is 45.', '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(46, 'new_order', 1, 1, 'delivered', 'Thank you for your order. Your order number is 46.', '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(47, 'new_order', 1, 1, 'delivered', 'Thank you for your order. Your order number is 47.', '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(48, 'new_order', 1, 1, 'delivered', 'Thank you for your order. Your order number is 48.', '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(49, 'new_order', 1, 1, 'delivered', 'Thank you for your order. Your order number is 49.', '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(50, 'new_order', 1, 1, 'delivered', 'Thank you for your order. Your order number is 50.', '2024-04-27 21:27:42', '2024-04-27 21:27:42');

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
(1, 'Awaiting Payment', '1-480-645-0461', 107.24, '21zd95', 'Pending', '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(2, 'Confirmed', '832-256-9514', 242.68, '29bb51', 'Completed', '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(3, 'Awaiting Verification', '+15679256558', 38.83, '67nm96', 'Completed', '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(4, 'Cancelled', '+1-986-843-0417', 472.19, '41ja49', 'Pending', '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(5, 'Awaiting Preparation', '+18565316250', 245.71, '46tz08', 'Pending', '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(6, 'Confirmed', '(838) 392-3720', 285.20, '91gt32', 'Completed', '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(7, 'Awaiting Preparation', '+18065021461', 317.38, '84zh23', 'Completed', '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(8, 'Awaiting Verification', '630-465-0141', 311.43, '58vk20', 'Completed', '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(9, 'Cancelled', '(904) 900-5648', 91.29, '53pk81', 'Completed', '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(10, 'Ready for Pickup', '551-700-6937', 93.51, '11ho02', 'Completed', '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(11, 'Awaiting Payment', '860-741-5419', 337.80, '72yp69', 'Pending', '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(12, 'Awaiting Preparation', '512.649.0038', 111.54, '91bw70', 'Completed', '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(13, 'Ready for Pickup', '862-444-4857', 343.85, '41hb02', 'Completed', '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(14, 'Ready for Pickup', '440-404-6897', 159.37, '67mi38', 'Completed', '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(15, 'Cancelled', '661-375-1306', 177.90, '92me77', 'Completed', '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(16, 'Awaiting Verification', '580.490.2077', 157.34, '92aj43', 'Pending', '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(17, 'Confirmed', '+1-267-458-9321', 397.14, '79ga61', 'Pending', '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(18, 'Awaiting Preparation', '626.200.5543', 463.39, '49zz86', 'Pending', '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(19, 'Awaiting Verification', '1-820-919-3060', 248.94, '22fh87', 'Pending', '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(20, 'Awaiting Verification', '231.377.0831', 28.87, '34xw86', 'Completed', '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(21, 'Awaiting Payment', '973.503.8339', 45.03, '17by83', 'Pending', '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(22, 'Ready for Pickup', '+12819102730', 315.60, '93gi21', 'Completed', '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(23, 'Payment Received', '+1 (832) 994-8538', 145.63, '86yj24', 'Pending', '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(24, 'Ready for Pickup', '1-781-509-8692', 14.85, '29yk58', 'Pending', '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(25, 'Cancelled', '+1 (743) 616-7155', 374.89, '55mi53', 'Completed', '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(26, 'Awaiting Verification', '+1 (740) 797-5265', 218.79, '33dp24', 'Pending', '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(27, 'Awaiting Payment', '(607) 917-0690', 189.34, '44ap74', 'Pending', '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(28, 'Ready for Pickup', '1-210-340-1190', 54.37, '56av75', 'Completed', '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(29, 'Confirmed', '(606) 441-9179', 63.03, '35xw31', 'Completed', '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(30, 'Cancelled', '972.913.5975', 371.47, '17gi07', 'Pending', '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(31, 'Awaiting Payment', '+14787138320', 435.55, '68py63', 'Pending', '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(32, 'Cancelled', '+1-561-801-4188', 307.50, '41ea33', 'Pending', '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(33, 'Awaiting Verification', '(469) 410-8717', 323.09, '80oh96', 'Completed', '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(34, 'Confirmed', '+1.570.339.1480', 365.37, '16zm19', 'Completed', '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(35, 'Awaiting Payment', '(430) 471-9356', 173.89, '87tn32', 'Completed', '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(36, 'Awaiting Verification', '301.831.7679', 78.69, '03vb82', 'Completed', '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(37, 'Confirmed', '1-281-679-3026', 287.10, '87tq66', 'Pending', '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(38, 'Payment Received', '617-409-5621', 51.57, '48je23', 'Completed', '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(39, 'Payment Received', '+1 (938) 632-4858', 362.48, '01he52', 'Completed', '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(40, 'Payment Received', '+1-321-453-2616', 117.38, '48wh33', 'Pending', '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(41, 'Cancelled', '+1-623-347-6573', 37.43, '78vg47', 'Completed', '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(42, 'Payment Received', '773-833-3810', 200.71, '79pl77', 'Completed', '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(43, 'Payment Received', '1-586-414-8462', 44.08, '05kn35', 'Completed', '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(44, 'Cancelled', '+1-520-980-3149', 362.66, '43qm95', 'Pending', '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(45, 'Cancelled', '458-347-9087', 209.53, '67rj21', 'Completed', '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(46, 'Payment Received', '+12258305574', 250.85, '81ia56', 'Pending', '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(47, 'Cancelled', '814-917-2504', 146.53, '76zt19', 'Completed', '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(48, 'Awaiting Verification', '+1 (619) 282-1343', 219.82, '75cq35', 'Pending', '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(49, 'Awaiting Verification', '+1-815-257-5935', 266.62, '52zk77', 'Pending', '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(50, 'Payment Received', '1-402-659-9626', 292.35, '33yj57', 'Pending', '2024-04-27 21:27:42', '2024-04-27 21:27:42');

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
(1, 1, 1, '\"[1,2]\"', 3, 5, NULL, 315.00, '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(2, 1, 4, '\"[]\"', 6, 1, NULL, 35.00, '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(3, 2, 1, '\"[1,2]\"', 4, 1, NULL, 63.00, '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(4, 2, 3, '\"[]\"', 10, 4, NULL, 100.00, '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(5, 2, 4, '\"[]\"', 8, 4, NULL, 140.00, '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(6, 3, 2, '\"[1,2]\"', 1, 5, NULL, 545.00, '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(7, 3, 7, '\"[]\"', 7, 2, NULL, 118.00, '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(8, 3, 8, '\"[]\"', 6, 2, NULL, 220.00, '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(9, 4, 8, '\"[]\"', 1, 3, NULL, 330.00, '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(10, 5, 10, '\"[]\"', 6, 5, NULL, 550.00, '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(11, 6, 1, '\"[1,2]\"', 9, 1, NULL, 63.00, '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(12, 7, 8, '\"[]\"', 1, 3, NULL, 330.00, '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(13, 8, 2, '\"[1,2]\"', 2, 4, NULL, 436.00, '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(14, 8, 8, '\"[]\"', 7, 5, NULL, 550.00, '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(15, 9, 7, '\"[]\"', 5, 1, NULL, 59.00, '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(16, 10, 1, '\"[1,2]\"', 3, 1, NULL, 63.00, '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(17, 10, 4, '\"[]\"', 8, 4, NULL, 140.00, '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(18, 10, 5, '\"[3]\"', 2, 1, NULL, 44.00, '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(19, 11, 3, '\"[]\"', 10, 2, NULL, 50.00, '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(20, 11, 5, '\"[3]\"', 7, 1, NULL, 44.00, '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(21, 11, 9, '\"[]\"', 8, 5, NULL, 295.00, '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(22, 12, 3, '\"[]\"', 7, 3, NULL, 75.00, '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(23, 12, 9, '\"[]\"', 4, 4, NULL, 236.00, '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(24, 13, 7, '\"[]\"', 8, 3, NULL, 177.00, '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(25, 14, 3, '\"[]\"', 10, 4, NULL, 100.00, '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(26, 14, 10, '\"[]\"', 9, 5, NULL, 550.00, '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(27, 15, 7, '\"[]\"', 4, 4, NULL, 236.00, '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(28, 15, 8, '\"[]\"', 4, 1, NULL, 110.00, '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(29, 16, 7, '\"[]\"', 5, 4, NULL, 236.00, '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(30, 17, 1, '\"[1,2]\"', 5, 4, NULL, 252.00, '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(31, 17, 7, '\"[]\"', 5, 4, NULL, 236.00, '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(32, 17, 10, '\"[]\"', 4, 1, NULL, 110.00, '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(33, 18, 10, '\"[]\"', 9, 4, NULL, 440.00, '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(34, 19, 2, '\"[1,2]\"', 2, 1, NULL, 109.00, '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(35, 19, 5, '\"[3]\"', 7, 5, NULL, 220.00, '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(36, 20, 5, '\"[3]\"', 10, 5, NULL, 220.00, '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(37, 20, 8, '\"[]\"', 7, 5, NULL, 550.00, '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(38, 21, 1, '\"[1,2]\"', 1, 3, NULL, 189.00, '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(39, 21, 7, '\"[]\"', 7, 4, NULL, 236.00, '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(40, 21, 9, '\"[]\"', 7, 2, NULL, 118.00, '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(41, 22, 7, '\"[]\"', 6, 5, NULL, 295.00, '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(42, 23, 4, '\"[]\"', 4, 2, NULL, 70.00, '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(43, 23, 9, '\"[]\"', 5, 5, NULL, 295.00, '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(44, 24, 2, '\"[1,2]\"', 4, 4, NULL, 436.00, '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(45, 24, 9, '\"[]\"', 9, 5, NULL, 295.00, '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(46, 25, 1, '\"[1,2]\"', 7, 4, NULL, 252.00, '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(47, 25, 2, '\"[1,2]\"', 4, 1, NULL, 109.00, '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(48, 25, 7, '\"[]\"', 10, 2, NULL, 118.00, '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(49, 26, 1, '\"[1,2]\"', 3, 2, NULL, 126.00, '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(50, 26, 6, '\"[3]\"', 9, 2, NULL, 108.00, '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(51, 26, 10, '\"[]\"', 4, 5, NULL, 550.00, '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(52, 27, 1, '\"[1,2]\"', 3, 4, NULL, 252.00, '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(53, 27, 3, '\"[]\"', 10, 4, NULL, 100.00, '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(54, 28, 3, '\"[]\"', 2, 2, NULL, 50.00, '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(55, 28, 4, '\"[]\"', 7, 4, NULL, 140.00, '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(56, 28, 6, '\"[3]\"', 2, 1, NULL, 54.00, '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(57, 29, 3, '\"[]\"', 4, 2, NULL, 50.00, '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(58, 30, 4, '\"[]\"', 9, 1, NULL, 35.00, '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(59, 30, 7, '\"[]\"', 3, 4, NULL, 236.00, '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(60, 31, 4, '\"[]\"', 9, 3, NULL, 105.00, '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(61, 31, 5, '\"[3]\"', 5, 5, NULL, 220.00, '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(62, 31, 10, '\"[]\"', 7, 5, NULL, 550.00, '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(63, 32, 3, '\"[]\"', 7, 5, NULL, 125.00, '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(64, 33, 4, '\"[]\"', 10, 1, NULL, 35.00, '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(65, 33, 8, '\"[]\"', 6, 3, NULL, 330.00, '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(66, 33, 9, '\"[]\"', 10, 1, NULL, 59.00, '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(67, 34, 2, '\"[1,2]\"', 7, 2, NULL, 218.00, '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(68, 34, 3, '\"[]\"', 6, 2, NULL, 50.00, '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(69, 35, 3, '\"[]\"', 8, 1, NULL, 25.00, '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(70, 36, 2, '\"[1,2]\"', 3, 3, NULL, 327.00, '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(71, 37, 4, '\"[]\"', 9, 2, NULL, 70.00, '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(72, 37, 5, '\"[3]\"', 8, 3, NULL, 132.00, '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(73, 37, 9, '\"[]\"', 5, 1, NULL, 59.00, '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(74, 38, 3, '\"[]\"', 6, 3, NULL, 75.00, '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(75, 38, 6, '\"[3]\"', 3, 2, NULL, 108.00, '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(76, 39, 8, '\"[]\"', 10, 2, NULL, 220.00, '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(77, 40, 2, '\"[1,2]\"', 5, 4, NULL, 436.00, '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(78, 40, 7, '\"[]\"', 5, 5, NULL, 295.00, '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(79, 40, 9, '\"[]\"', 10, 3, NULL, 177.00, '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(80, 41, 1, '\"[1,2]\"', 4, 3, NULL, 189.00, '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(81, 41, 4, '\"[]\"', 5, 5, NULL, 175.00, '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(82, 41, 6, '\"[3]\"', 4, 1, NULL, 54.00, '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(83, 42, 8, '\"[]\"', 8, 4, NULL, 440.00, '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(84, 43, 1, '\"[1,2]\"', 8, 5, NULL, 315.00, '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(85, 43, 9, '\"[]\"', 1, 1, NULL, 59.00, '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(86, 44, 1, '\"[1,2]\"', 8, 4, NULL, 252.00, '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(87, 45, 2, '\"[1,2]\"', 2, 1, NULL, 109.00, '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(88, 45, 3, '\"[]\"', 6, 2, NULL, 50.00, '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(89, 46, 1, '\"[1,2]\"', 8, 3, NULL, 189.00, '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(90, 46, 4, '\"[]\"', 1, 2, NULL, 70.00, '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(91, 46, 6, '\"[3]\"', 4, 4, NULL, 216.00, '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(92, 47, 6, '\"[3]\"', 10, 4, NULL, 216.00, '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(93, 48, 6, '\"[3]\"', 5, 1, NULL, 54.00, '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(94, 48, 7, '\"[]\"', 9, 1, NULL, 59.00, '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(95, 49, 2, '\"[1,2]\"', 4, 5, NULL, 545.00, '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(96, 49, 7, '\"[]\"', 4, 5, NULL, 295.00, '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(97, 49, 9, '\"[]\"', 7, 1, NULL, 59.00, '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(98, 50, 4, '\"[]\"', 1, 3, NULL, 105.00, '2024-04-27 21:27:42', '2024-04-27 21:27:42'),
(99, 50, 5, '\"[3]\"', 3, 2, NULL, 88.00, '2024-04-27 21:27:42', '2024-04-27 21:27:42');

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
(1, 1, 107.24, 'Pending', 'Online', 'SZ810RKG64', '2024-04-28 05:27:43', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(2, 2, 242.68, 'Completed', 'Cash', 'WR899JDM25', '2024-04-28 05:27:43', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(3, 3, 38.83, 'Completed', 'Online', 'GZ623CML76', '2024-04-28 05:27:43', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(4, 4, 472.19, 'Completed', 'Credit Card', 'PU314IFA54', '2024-04-28 05:27:43', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(5, 5, 245.71, 'Completed', 'Cash', 'FK660DAS06', '2024-04-28 05:27:43', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(6, 6, 285.20, 'Pending', 'Credit Card', 'DX096MUM28', '2024-04-28 05:27:43', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(7, 7, 317.38, 'Completed', 'Cash', 'JA520OKH62', '2024-04-28 05:27:43', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(8, 8, 311.43, 'Pending', 'Online', 'AT217HIG63', '2024-04-28 05:27:43', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(9, 9, 91.29, 'Pending', 'Cash', 'AX939NHT27', '2024-04-28 05:27:43', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(10, 10, 93.51, 'Completed', 'Online', 'MB327BPH48', '2024-04-28 05:27:43', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(11, 11, 337.80, 'Pending', 'Cash', 'IF539OER71', '2024-04-28 05:27:43', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(12, 12, 111.54, 'Pending', 'Credit Card', 'NS960UTX92', '2024-04-28 05:27:43', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(13, 13, 343.85, 'Completed', 'Cash', 'UJ636RVW86', '2024-04-28 05:27:43', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(14, 14, 159.37, 'Pending', 'Cash', 'MV112OFL82', '2024-04-28 05:27:43', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(15, 15, 177.90, 'Completed', 'Credit Card', 'FI917VDW60', '2024-04-28 05:27:43', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(16, 16, 157.34, 'Pending', 'Cash', 'OV960AKL56', '2024-04-28 05:27:43', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(17, 17, 397.14, 'Completed', 'Online', 'NM149GIQ92', '2024-04-28 05:27:43', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(18, 18, 463.39, 'Pending', 'Credit Card', 'XB922CTP17', '2024-04-28 05:27:43', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(19, 19, 248.94, 'Pending', 'Credit Card', 'TW737LIT27', '2024-04-28 05:27:43', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(20, 20, 28.87, 'Pending', 'Online', 'NQ753VRB09', '2024-04-28 05:27:43', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(21, 21, 45.03, 'Pending', 'Online', 'NH436KKB52', '2024-04-28 05:27:43', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(22, 22, 315.60, 'Pending', 'Online', 'PW383UAR86', '2024-04-28 05:27:43', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(23, 23, 145.63, 'Pending', 'Credit Card', 'BX162WNP75', '2024-04-28 05:27:43', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(24, 24, 14.85, 'Pending', 'Cash', 'YQ700BEZ04', '2024-04-28 05:27:43', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(25, 25, 374.89, 'Pending', 'Cash', 'OQ693YIG98', '2024-04-28 05:27:43', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(26, 26, 218.79, 'Pending', 'Cash', 'XI077QFS22', '2024-04-28 05:27:43', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(27, 27, 189.34, 'Completed', 'Cash', 'TW749NCJ61', '2024-04-28 05:27:43', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(28, 28, 54.37, 'Completed', 'Credit Card', 'HD517SLY64', '2024-04-28 05:27:43', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(29, 29, 63.03, 'Completed', 'Cash', 'PC621UFU12', '2024-04-28 05:27:43', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(30, 30, 371.47, 'Pending', 'Online', 'CT111ZMF95', '2024-04-28 05:27:43', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(31, 31, 435.55, 'Completed', 'Cash', 'JQ395SLT83', '2024-04-28 05:27:43', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(32, 32, 307.50, 'Completed', 'Cash', 'CL221MBF30', '2024-04-28 05:27:43', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(33, 33, 323.09, 'Completed', 'Credit Card', 'QP126QQR09', '2024-04-28 05:27:43', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(34, 34, 365.37, 'Pending', 'Credit Card', 'JY339BCF78', '2024-04-28 05:27:43', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(35, 35, 173.89, 'Pending', 'Cash', 'ID213YTF87', '2024-04-28 05:27:43', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(36, 36, 78.69, 'Pending', 'Credit Card', 'HW485RGE96', '2024-04-28 05:27:43', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(37, 37, 287.10, 'Completed', 'Cash', 'DG010KES16', '2024-04-28 05:27:43', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(38, 38, 51.57, 'Pending', 'Cash', 'ZX661GAL32', '2024-04-28 05:27:43', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(39, 39, 362.48, 'Pending', 'Credit Card', 'BH492GSH06', '2024-04-28 05:27:43', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(40, 40, 117.38, 'Completed', 'Credit Card', 'AT578EUH25', '2024-04-28 05:27:43', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(41, 41, 37.43, 'Completed', 'Credit Card', 'KX637NLS20', '2024-04-28 05:27:43', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(42, 42, 200.71, 'Completed', 'Online', 'EE675ZFP04', '2024-04-28 05:27:43', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(43, 43, 44.08, 'Completed', 'Online', 'LG453FPR75', '2024-04-28 05:27:43', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(44, 44, 362.66, 'Pending', 'Online', 'NT246XZS74', '2024-04-28 05:27:43', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(45, 45, 209.53, 'Pending', 'Credit Card', 'FT262LSO50', '2024-04-28 05:27:43', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(46, 46, 250.85, 'Pending', 'Cash', 'DD033GGB87', '2024-04-28 05:27:43', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(47, 47, 146.53, 'Completed', 'Cash', 'XD105TYU43', '2024-04-28 05:27:43', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(48, 48, 219.82, 'Pending', 'Cash', 'JT052YON31', '2024-04-28 05:27:43', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(49, 49, 266.62, 'Pending', 'Credit Card', 'YV944QLP32', '2024-04-28 05:27:43', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(50, 50, 292.35, 'Pending', 'Credit Card', 'TA165UUD50', '2024-04-28 05:27:43', '2024-04-27 21:27:43', '2024-04-27 21:27:43');

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
(3, 4, 'Fruit Soda - 12 oz', 'A delicious 12 oz Fruit Soda - 12 oz', 25.00, 'fruit_soda_-_12_oz.jpg', 1, '2024-04-27 21:27:41', '2024-04-27 21:27:41'),
(4, 4, 'Fruit Soda - 16 oz', 'A delicious 16 oz Fruit Soda - 16 oz', 35.00, 'fruit_soda_-_16_oz.jpg', 1, '2024-04-27 21:27:41', '2024-04-27 21:27:41'),
(5, 5, 'Yakult Series - 12 oz', 'A delicious 12 oz Yakult Series - 12 oz with added Yakult', 29.00, 'yakult_series_-_12_oz.jpg', 1, '2024-04-27 21:27:41', '2024-04-27 21:27:41'),
(6, 5, 'Yakult Series - 16 oz', 'A delicious 16 oz Yakult Series - 16 oz with added Yakult', 39.00, 'yakult_series_-_16_oz.jpg', 1, '2024-04-27 21:27:41', '2024-04-27 21:27:41'),
(7, 2, 'Shawarma Rice Single Order', 'Enjoy our shawarma rice single order with your favorite add-ons!', 49.00, 'shawarma_single_order.jpg', 1, '2024-04-27 21:27:41', '2024-04-27 21:27:41'),
(8, 2, 'Shawarma Rice Buy One, Take One', 'Enjoy our shawarma rice buy one, take one with your favorite add-ons!', 95.00, 'shawarma_buy_one,_take_one.jpg', 1, '2024-04-27 21:27:41', '2024-04-27 21:27:41'),
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
(1, 1, '2024-04-28 05:27:43', 'Payment received for Order ID: 1. Total amount: 107.24.', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(2, 2, '2024-04-28 05:27:43', 'Payment received for Order ID: 2. Total amount: 242.68.', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(3, 3, '2024-04-28 05:27:43', 'Payment received for Order ID: 3. Total amount: 38.83.', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(4, 4, '2024-04-28 05:27:43', 'Payment received for Order ID: 4. Total amount: 472.19.', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(5, 5, '2024-04-28 05:27:43', 'Payment received for Order ID: 5. Total amount: 245.71.', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(6, 6, '2024-04-28 05:27:43', 'Payment received for Order ID: 6. Total amount: 285.20.', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(7, 7, '2024-04-28 05:27:43', 'Payment received for Order ID: 7. Total amount: 317.38.', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(8, 8, '2024-04-28 05:27:43', 'Payment received for Order ID: 8. Total amount: 311.43.', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(9, 9, '2024-04-28 05:27:43', 'Payment received for Order ID: 9. Total amount: 91.29.', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(10, 10, '2024-04-28 05:27:43', 'Payment received for Order ID: 10. Total amount: 93.51.', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(11, 11, '2024-04-28 05:27:43', 'Payment received for Order ID: 11. Total amount: 337.80.', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(12, 12, '2024-04-28 05:27:43', 'Payment received for Order ID: 12. Total amount: 111.54.', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(13, 13, '2024-04-28 05:27:43', 'Payment received for Order ID: 13. Total amount: 343.85.', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(14, 14, '2024-04-28 05:27:43', 'Payment received for Order ID: 14. Total amount: 159.37.', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(15, 15, '2024-04-28 05:27:43', 'Payment received for Order ID: 15. Total amount: 177.90.', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(16, 16, '2024-04-28 05:27:43', 'Payment received for Order ID: 16. Total amount: 157.34.', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(17, 17, '2024-04-28 05:27:43', 'Payment received for Order ID: 17. Total amount: 397.14.', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(18, 18, '2024-04-28 05:27:43', 'Payment received for Order ID: 18. Total amount: 463.39.', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(19, 19, '2024-04-28 05:27:43', 'Payment received for Order ID: 19. Total amount: 248.94.', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(20, 20, '2024-04-28 05:27:43', 'Payment received for Order ID: 20. Total amount: 28.87.', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(21, 21, '2024-04-28 05:27:43', 'Payment received for Order ID: 21. Total amount: 45.03.', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(22, 22, '2024-04-28 05:27:43', 'Payment received for Order ID: 22. Total amount: 315.60.', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(23, 23, '2024-04-28 05:27:43', 'Payment received for Order ID: 23. Total amount: 145.63.', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(24, 24, '2024-04-28 05:27:43', 'Payment received for Order ID: 24. Total amount: 14.85.', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(25, 25, '2024-04-28 05:27:43', 'Payment received for Order ID: 25. Total amount: 374.89.', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(26, 26, '2024-04-28 05:27:43', 'Payment received for Order ID: 26. Total amount: 218.79.', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(27, 27, '2024-04-28 05:27:43', 'Payment received for Order ID: 27. Total amount: 189.34.', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(28, 28, '2024-04-28 05:27:43', 'Payment received for Order ID: 28. Total amount: 54.37.', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(29, 29, '2024-04-28 05:27:43', 'Payment received for Order ID: 29. Total amount: 63.03.', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(30, 30, '2024-04-28 05:27:43', 'Payment received for Order ID: 30. Total amount: 371.47.', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(31, 31, '2024-04-28 05:27:43', 'Payment received for Order ID: 31. Total amount: 435.55.', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(32, 32, '2024-04-28 05:27:43', 'Payment received for Order ID: 32. Total amount: 307.50.', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(33, 33, '2024-04-28 05:27:43', 'Payment received for Order ID: 33. Total amount: 323.09.', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(34, 34, '2024-04-28 05:27:43', 'Payment received for Order ID: 34. Total amount: 365.37.', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(35, 35, '2024-04-28 05:27:43', 'Payment received for Order ID: 35. Total amount: 173.89.', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(36, 36, '2024-04-28 05:27:43', 'Payment received for Order ID: 36. Total amount: 78.69.', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(37, 37, '2024-04-28 05:27:43', 'Payment received for Order ID: 37. Total amount: 287.10.', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(38, 38, '2024-04-28 05:27:43', 'Payment received for Order ID: 38. Total amount: 51.57.', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(39, 39, '2024-04-28 05:27:43', 'Payment received for Order ID: 39. Total amount: 362.48.', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(40, 40, '2024-04-28 05:27:43', 'Payment received for Order ID: 40. Total amount: 117.38.', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(41, 41, '2024-04-28 05:27:43', 'Payment received for Order ID: 41. Total amount: 37.43.', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(42, 42, '2024-04-28 05:27:43', 'Payment received for Order ID: 42. Total amount: 200.71.', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(43, 43, '2024-04-28 05:27:43', 'Payment received for Order ID: 43. Total amount: 44.08.', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(44, 44, '2024-04-28 05:27:43', 'Payment received for Order ID: 44. Total amount: 362.66.', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(45, 45, '2024-04-28 05:27:43', 'Payment received for Order ID: 45. Total amount: 209.53.', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(46, 46, '2024-04-28 05:27:43', 'Payment received for Order ID: 46. Total amount: 250.85.', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(47, 47, '2024-04-28 05:27:43', 'Payment received for Order ID: 47. Total amount: 146.53.', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(48, 48, '2024-04-28 05:27:43', 'Payment received for Order ID: 48. Total amount: 219.82.', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(49, 49, '2024-04-28 05:27:43', 'Payment received for Order ID: 49. Total amount: 266.62.', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(50, 50, '2024-04-28 05:27:43', 'Payment received for Order ID: 50. Total amount: 292.35.', '2024-04-27 21:27:43', '2024-04-27 21:27:43');

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
(1, 1, '2024-04-28 05:27:43', '96EH6YGFDB', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(2, 2, '2024-04-28 05:27:43', 'GJO4KIMJUW', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(3, 3, '2024-04-28 05:27:43', 'PRRS328WTU', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(4, 4, '2024-04-28 05:27:43', '0WCGCTTP6X', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(5, 5, '2024-04-28 05:27:43', 'OGEENHCE5F', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(6, 6, '2024-04-28 05:27:43', '7QXASS6EIC', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(7, 7, '2024-04-28 05:27:43', 'FPW9CS7HF1', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(8, 8, '2024-04-28 05:27:43', 'MYIZXHVWXN', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(9, 9, '2024-04-28 05:27:43', 'YTUXWSVLXW', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(10, 10, '2024-04-28 05:27:43', 'ELFHNTKZXT', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(11, 11, '2024-04-28 05:27:43', 'HJMNPODTUY', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(12, 12, '2024-04-28 05:27:43', '6NKZ91EN0K', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(13, 13, '2024-04-28 05:27:43', 'VDKWXAJPQX', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(14, 14, '2024-04-28 05:27:43', 'LVFT6NXLBI', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(15, 15, '2024-04-28 05:27:43', 'TLRUMZOOFR', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(16, 16, '2024-04-28 05:27:43', 'IG08OHVNNR', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(17, 17, '2024-04-28 05:27:43', '9OF2JEZ02E', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(18, 18, '2024-04-28 05:27:43', '7FKDFFD2VP', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(19, 19, '2024-04-28 05:27:43', '6652YBKGRD', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(20, 20, '2024-04-28 05:27:43', 'Q3S5FYPSBN', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(21, 21, '2024-04-28 05:27:43', 'ELAJXJAFI2', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(22, 22, '2024-04-28 05:27:43', 'YGCJP2UYBW', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(23, 23, '2024-04-28 05:27:43', '1WCUUXQTG9', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(24, 24, '2024-04-28 05:27:43', 'SYXUEYKB5Q', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(25, 25, '2024-04-28 05:27:43', 'XG7EVK87LC', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(26, 26, '2024-04-28 05:27:43', 'W2IVGPOYAJ', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(27, 27, '2024-04-28 05:27:43', 'BAEFOM8JAO', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(28, 28, '2024-04-28 05:27:43', 'RQCFEYCGBF', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(29, 29, '2024-04-28 05:27:43', 'HNUEZAIRL0', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(30, 30, '2024-04-28 05:27:43', 'IGDEB2LKNC', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(31, 31, '2024-04-28 05:27:43', 'WHBVAEWOFX', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(32, 32, '2024-04-28 05:27:43', 'RZJBOB0FFF', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(33, 33, '2024-04-28 05:27:43', 'VGSAHX1KNS', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(34, 34, '2024-04-28 05:27:43', 'XYX3DP2XRC', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(35, 35, '2024-04-28 05:27:43', 'KTXHCZ78XC', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(36, 36, '2024-04-28 05:27:43', 'EXFNM2ZLDD', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(37, 37, '2024-04-28 05:27:43', 'AAGXS25QYL', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(38, 38, '2024-04-28 05:27:43', 'VZCUUACTIE', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(39, 39, '2024-04-28 05:27:43', 'JOVGRSUQG6', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(40, 40, '2024-04-28 05:27:43', 'BNAVYDQYH2', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(41, 41, '2024-04-28 05:27:43', '1GPMWJXIPF', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(42, 42, '2024-04-28 05:27:43', 'CYPUWL6JD7', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(43, 43, '2024-04-28 05:27:43', 'QZVFHRFUXN', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(44, 44, '2024-04-28 05:27:43', 'OSAEMKDSPL', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(45, 45, '2024-04-28 05:27:43', 'VTQMRXBAZX', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(46, 46, '2024-04-28 05:27:43', 'Z4A6W4C7D4', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(47, 47, '2024-04-28 05:27:43', '6V0VBZLFWB', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(48, 48, '2024-04-28 05:27:43', '5DURT0UGJU', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(49, 49, '2024-04-28 05:27:43', 'KCYE897Y6J', '2024-04-27 21:27:43', '2024-04-27 21:27:43'),
(50, 50, '2024-04-28 05:27:43', '5WCG5KG7PM', '2024-04-27 21:27:43', '2024-04-27 21:27:43');

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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=100;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

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
