-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 02, 2022 at 05:49 AM
-- Server version: 10.4.25-MariaDB
-- PHP Version: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `aspire`
--

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE `admins` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `username` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('active','inactive') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `admins`
--

INSERT INTO `admins` (`id`, `name`, `email`, `username`, `password`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Admin', 'admin@admin.com', 'haresh', '$2y$10$zDdFYJM/UM6XwZO.PRRmW.6CX7rBl078ixYEeKtAuUIjs0mdFiAhm', 'active', '2022-11-01 10:44:23', '2022-11-01 10:44:23');

-- --------------------------------------------------------

--
-- Table structure for table `estimated_loan_terms`
--

CREATE TABLE `estimated_loan_terms` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `loan_id` int(11) NOT NULL,
  `date` date NOT NULL,
  `amount` double(8,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `loans`
--

CREATE TABLE `loans` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(11) NOT NULL,
  `amount` double(8,2) NOT NULL,
  `term` int(11) NOT NULL,
  `term_amount` double(8,2) NOT NULL,
  `date` date NOT NULL,
  `request_status` enum('Pending','Approved','Rejected') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Pending',
  `loan_status` enum('Paid','Unpaid') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Unpaid',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `loan_terms`
--

CREATE TABLE `loan_terms` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `loan_id` int(11) NOT NULL,
  `date` date NOT NULL,
  `amount` double(8,2) NOT NULL,
  `loan_status` enum('Paid','Unpaid') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Unpaid',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2016_06_01_000001_create_oauth_auth_codes_table', 1),
(4, '2016_06_01_000002_create_oauth_access_tokens_table', 1),
(5, '2016_06_01_000003_create_oauth_refresh_tokens_table', 1),
(6, '2016_06_01_000004_create_oauth_clients_table', 1),
(7, '2016_06_01_000005_create_oauth_personal_access_clients_table', 1),
(8, '2019_08_19_000000_create_failed_jobs_table', 1),
(9, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(10, '2022_11_01_152741_create_admins_table', 1),
(11, '2022_11_01_173732_create_loans_table', 2),
(12, '2022_11_01_174046_create_loan_terms_table', 2),
(13, '2022_11_02_044403_create_estimated_loan_terms_table', 3);

-- --------------------------------------------------------

--
-- Table structure for table `oauth_access_tokens`
--

CREATE TABLE `oauth_access_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `client_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `oauth_access_tokens`
--

INSERT INTO `oauth_access_tokens` (`id`, `user_id`, `client_id`, `name`, `scopes`, `revoked`, `created_at`, `updated_at`, `expires_at`) VALUES
('1cbb95a7f670c6bf20ab258d4adaf47ca8b44cd1add4efe0895026661cf18591bd4294713ffdd720', 2, 1, 'MyApp', '[\"user\"]', 0, '2022-11-01 12:05:18', '2022-11-01 12:05:18', '2023-11-01 17:35:18'),
('2f61dacad896470089b6ae8a102dd19ef09c10b4306cd3b3654329c8749b05a8154607c843fa4445', 2, 1, 'MyApp', '[\"user\"]', 0, '2022-11-01 12:05:14', '2022-11-01 12:05:14', '2023-11-01 17:35:14'),
('469c6db519d8c4287c9055a4c6caa9a9b9414e9b718a8e1e655fb698b6d82c5aa7b97481c31b45d2', 1, 1, 'MyApp', '[\"user\"]', 0, '2022-11-01 14:20:27', '2022-11-01 14:20:28', '2023-11-01 19:50:27'),
('50844fa1b2f3b995f56256fc632eb2b190ff85769a9f3a68cd22f7bac475a7ce6eddc982c0b52079', 1, 1, 'MyApp', '[\"user\"]', 0, '2022-11-01 14:27:02', '2022-11-01 14:27:02', '2023-11-01 19:57:02'),
('589d7910ec1e311e734d908a4d8460a9b81869aca456b4c1109ac0fac41e10ff1d80d7dae4b9a9f4', 1, 1, 'MyApp', '[\"admin\"]', 0, '2022-11-01 10:49:47', '2022-11-01 10:49:47', '2023-11-01 16:19:47'),
('6ba5a7df6c2bd6159d8e72603c0486b7b1d724e196577f303c53e02c9f41f15a2a073072e2770597', 1, 1, 'MyApp', '[\"user\"]', 0, '2022-11-01 14:22:48', '2022-11-01 14:22:48', '2023-11-01 19:52:48'),
('6ebe02147c5afce0f5b2486b05e488effec356206902f9bae03ff94d8072a688d4bf219bbd86c2b5', 1, 1, 'MyApp', '[\"user\"]', 0, '2022-11-01 14:18:36', '2022-11-01 14:18:36', '2023-11-01 19:48:36'),
('7e3e0c960e78a6e51b484cc5b26c042c754fa702ec15487773153fcfc18bc67ae2c7793c96271af5', 1, 1, 'MyApp', '[\"user\"]', 0, '2022-11-01 14:08:10', '2022-11-01 14:08:10', '2023-11-01 19:38:10'),
('8046859bf3466dd1c6fef8a580c0ef7f5de5e71566c14f9f33a8ee0c49f1fa4492341e2435b3e80a', 1, 1, 'MyApp', '[\"admin\"]', 0, '2022-11-01 15:29:11', '2022-11-01 15:29:11', '2023-11-01 20:59:11'),
('9168f15e44da74372efe919bf63a04463b450e7ed6b9d22c3c1deff2849a59fd6464f3742b39b593', 2, 1, 'Token', '[]', 0, '2022-11-01 12:04:59', '2022-11-01 12:04:59', '2023-11-01 17:34:59'),
('95336914c764e1c0fbba30d1c801aa1275ccb0ed51c954b6291f365b3a83a72d39bd4160eaa3cd64', 1, 1, 'MyApp', '[\"user\"]', 0, '2022-11-01 12:14:23', '2022-11-01 12:14:23', '2023-11-01 17:44:23'),
('9742b11d9f907df5d29838e8a7f33d0eae9da32d4d9fc11ae39db8d3ddf5fc3f2b812c066699cc75', 1, 1, 'MyApp', '[\"admin\"]', 0, '2022-11-01 14:26:48', '2022-11-01 14:26:49', '2023-11-01 19:56:48'),
('acb44fad8722b72a881c1a461b74fbdf6cdf26f7527344b3aaf5dc5645797c6c852fa95566d0fa01', 1, 1, 'MyApp', '[\"user\"]', 0, '2022-11-01 15:28:32', '2022-11-01 15:28:32', '2023-11-01 20:58:32'),
('ae54b508cd0c4c84f7cdf03a031728d721d5161fa979a69ea6c3802046bca9217ff6bbe1d13539b9', 1, 1, 'MyApp', '[\"user\"]', 0, '2022-11-01 14:17:26', '2022-11-01 14:17:27', '2023-11-01 19:47:26'),
('c68b85bdcc164cb915bb8da61bd7c3fd758e787e4209a82d3add3006039d37f7788e81af84a74502', 1, 1, 'MyApp', '[\"user\"]', 0, '2022-11-01 10:48:49', '2022-11-01 10:48:49', '2023-11-01 16:18:49'),
('c9f414c9a54edd9f447b160d894ed687c508efd3bb713dcdf045aaa89f5e09048b0cd4ef0457aa7c', 1, 1, 'MyApp', '[\"user\"]', 0, '2022-11-01 14:33:56', '2022-11-01 14:33:57', '2023-11-01 20:03:56'),
('cac028bba5c3378c4f3ac7325d63b06b72334e86f7fb44318bd40feb9cf533376eb479e5a3214b41', 1, 1, 'MyApp', '[\"admin\"]', 0, '2022-11-01 12:36:33', '2022-11-01 12:36:33', '2023-11-01 18:06:33'),
('e2feb1ab32db0cd3a79bbc0226d018113da815dad5e3cc9aa7e6c0244a03c39103a64d0c459ee372', 1, 1, 'MyApp', '[\"user\"]', 0, '2022-11-01 14:21:30', '2022-11-01 14:21:31', '2023-11-01 19:51:30'),
('f423f8b58acca87c7f57bf45936ac3f56fb8d256c375a1e8b7f55ff1304c93e0e2525d03dfb77a55', 1, 1, 'MyApp', '[\"admin\"]', 0, '2022-11-01 14:26:00', '2022-11-01 14:26:01', '2023-11-01 19:56:00'),
('fae8d8afb57b5990670cd60e3204869f9a9a7fa53adf4ae0b3a5b12d9047eb250fc6e99651ebbd18', 1, 1, 'MyApp', '[\"user\"]', 0, '2022-11-01 14:08:50', '2022-11-01 14:08:50', '2023-11-01 19:38:50');

-- --------------------------------------------------------

--
-- Table structure for table `oauth_auth_codes`
--

CREATE TABLE `oauth_auth_codes` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `client_id` bigint(20) UNSIGNED NOT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `oauth_clients`
--

CREATE TABLE `oauth_clients` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `secret` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `provider` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `redirect` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `personal_access_client` tinyint(1) NOT NULL,
  `password_client` tinyint(1) NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `oauth_clients`
--

INSERT INTO `oauth_clients` (`id`, `user_id`, `name`, `secret`, `provider`, `redirect`, `personal_access_client`, `password_client`, `revoked`, `created_at`, `updated_at`) VALUES
(1, NULL, 'Laravel Personal Access Client', 'Ymzi8COG4hpKRqyxhAJfZGWHpk3H31izRkAPX708', NULL, 'http://localhost', 1, 0, 0, '2022-11-01 10:07:49', '2022-11-01 10:07:49'),
(2, NULL, 'Laravel Password Grant Client', 'SqaXTqRQoWjhkCNRlLihTGglf95b6fyqjbL7LxyB', 'users', 'http://localhost', 0, 1, 0, '2022-11-01 10:07:49', '2022-11-01 10:07:49');

-- --------------------------------------------------------

--
-- Table structure for table `oauth_personal_access_clients`
--

CREATE TABLE `oauth_personal_access_clients` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `client_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `oauth_personal_access_clients`
--

INSERT INTO `oauth_personal_access_clients` (`id`, `client_id`, `created_at`, `updated_at`) VALUES
(1, 1, '2022-11-01 10:07:49', '2022-11-01 10:07:49');

-- --------------------------------------------------------

--
-- Table structure for table `oauth_refresh_tokens`
--

CREATE TABLE `oauth_refresh_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `access_token_id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Romil Tatariya', 'tatariyaromil@gmail.com', NULL, '$2y$10$HdnmOGrpNXsArFeGR5TvruaUKsTa/nCfcIGtE5BWhALCPFTxxh0xK', NULL, '2022-11-01 10:44:23', '2022-11-01 10:44:23'),
(2, 'Ram', 'rambhai5103@gmail.com', NULL, '$2y$10$vGrIvXNWrzIdCEe282H4TO.E4t7ehrsKRxhFzigT5m.B4UDx08dC6', NULL, '2022-11-01 12:04:57', '2022-11-01 12:04:57');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `estimated_loan_terms`
--
ALTER TABLE `estimated_loan_terms`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `loans`
--
ALTER TABLE `loans`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `loan_terms`
--
ALTER TABLE `loan_terms`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `oauth_access_tokens`
--
ALTER TABLE `oauth_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_access_tokens_user_id_index` (`user_id`);

--
-- Indexes for table `oauth_auth_codes`
--
ALTER TABLE `oauth_auth_codes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_auth_codes_user_id_index` (`user_id`);

--
-- Indexes for table `oauth_clients`
--
ALTER TABLE `oauth_clients`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_clients_user_id_index` (`user_id`);

--
-- Indexes for table `oauth_personal_access_clients`
--
ALTER TABLE `oauth_personal_access_clients`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `oauth_refresh_tokens`
--
ALTER TABLE `oauth_refresh_tokens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_refresh_tokens_access_token_id_index` (`access_token_id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admins`
--
ALTER TABLE `admins`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `estimated_loan_terms`
--
ALTER TABLE `estimated_loan_terms`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `loans`
--
ALTER TABLE `loans`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `loan_terms`
--
ALTER TABLE `loan_terms`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `oauth_clients`
--
ALTER TABLE `oauth_clients`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `oauth_personal_access_clients`
--
ALTER TABLE `oauth_personal_access_clients`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
