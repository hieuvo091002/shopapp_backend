-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th5 25, 2024 lúc 05:43 PM
-- Phiên bản máy phục vụ: 10.4.32-MariaDB
-- Phiên bản PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `shopapp`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `categories`
--

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL DEFAULT '' COMMENT 'Tên danh mục, vd: đồ điện tử'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;

--
-- Đang đổ dữ liệu cho bảng `categories`
--

INSERT INTO `categories` (`id`, `name`) VALUES
(2, 'Điện thoại'),
(3, 'Laptop'),
(4, 'Ipad'),
(5, 'Tai Nghe'),
(6, 'Tivi'),
(7, 'Smartwatch');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `flyway_schema_history`
--

CREATE TABLE `flyway_schema_history` (
  `installed_rank` int(11) NOT NULL,
  `version` varchar(50) DEFAULT NULL,
  `description` varchar(200) NOT NULL,
  `type` varchar(20) NOT NULL,
  `script` varchar(1000) NOT NULL,
  `checksum` int(11) DEFAULT NULL,
  `installed_by` varchar(100) NOT NULL,
  `installed_on` timestamp NOT NULL DEFAULT current_timestamp(),
  `execution_time` int(11) NOT NULL,
  `success` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `flyway_schema_history`
--

INSERT INTO `flyway_schema_history` (`installed_rank`, `version`, `description`, `type`, `script`, `checksum`, `installed_by`, `installed_on`, `execution_time`, `success`) VALUES
(2, '1', 'alter some tables', 'SQL', 'V1__alter_some_tables.sql', 670188877, 'root', '2023-12-01 03:05:58', 605, 1),
(3, '2', 'change tokens', 'SQL', 'V2__change_tokens.sql', 1468721430, 'root', '2023-12-01 03:05:58', 27, 1),
(4, '3', 'refresh tokens', 'SQL', 'V3__refresh_tokens.sql', 1847335528, 'root', '2023-12-02 21:50:25', 36, 1);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `fullname` varchar(100) DEFAULT '',
  `email` varchar(100) DEFAULT '',
  `phone_number` varchar(20) NOT NULL,
  `address` varchar(200) NOT NULL,
  `note` varchar(100) DEFAULT '',
  `order_date` datetime DEFAULT current_timestamp(),
  `status` enum('pending','processing','shipped','delivered','cancelled') DEFAULT NULL COMMENT 'Trạng thái đơn hàng',
  `total_money` float DEFAULT 0,
  `shipping_method` varchar(100) DEFAULT NULL,
  `shipping_address` varchar(200) DEFAULT '',
  `shipping_date` date DEFAULT NULL,
  `tracking_number` varchar(100) DEFAULT NULL,
  `payment_method` varchar(100) DEFAULT NULL,
  `active` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;

--
-- Đang đổ dữ liệu cho bảng `orders`
--

INSERT INTO `orders` (`id`, `user_id`, `fullname`, `email`, `phone_number`, `address`, `note`, `order_date`, `status`, `total_money`, `shipping_method`, `shipping_address`, `shipping_date`, `tracking_number`, `payment_method`, `active`) VALUES
(44, 5, 'nguyen van a', 'hieuvo091002@gmail.com', '11223344', 'qnqqqqqqq', 'qqqqqqq', NULL, 'delivered', 29570000, 'express', NULL, NULL, NULL, 'cod', 1),
(46, 5, 'Nguyễn Văn test', 'hieuvo091002@gmail.com', '1111111', 'qnqqqqqqq', 'qqqqqqq', NULL, 'processing', 13790000, 'normal', NULL, NULL, NULL, 'cod', 1),
(47, 5, 'nguyen van b', 'h@gmail.con', '77777777', 'qqnqnnq', 'qqqqqq', '2024-05-24 00:00:00', 'pending', 17580000, 'express', NULL, '2024-05-24', NULL, 'cod', 1);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `order_details`
--

CREATE TABLE `order_details` (
  `id` int(11) NOT NULL,
  `order_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `price` float DEFAULT NULL CHECK (`price` >= 0),
  `number_of_products` int(11) DEFAULT NULL CHECK (`number_of_products` > 0),
  `total_money` float DEFAULT NULL CHECK (`total_money` >= 0),
  `color` varchar(20) DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;

--
-- Đang đổ dữ liệu cho bảng `order_details`
--

INSERT INTO `order_details` (`id`, `order_id`, `product_id`, `price`, `number_of_products`, `total_money`, `color`) VALUES
(73, 44, 976, 8490000, 2, NULL, NULL),
(74, 44, 975, 12590000, 1, NULL, NULL),
(77, 46, 974, 13790000, 1, NULL, NULL),
(78, 47, 976, 8490000, 1, NULL, NULL),
(79, 47, 977, 9090000, 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `name` varchar(350) DEFAULT NULL COMMENT 'Tên sản phẩm',
  `price` float NOT NULL CHECK (`price` >= 0),
  `thumbnail` varchar(300) DEFAULT '',
  `description` longtext DEFAULT '',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;

--
-- Đang đổ dữ liệu cho bảng `products`
--

INSERT INTO `products` (`id`, `name`, `price`, `thumbnail`, `description`, `created_at`, `updated_at`, `category_id`) VALUES
(974, 'iPhone 13', 13790000, '5f18abab-3da4-4bc6-bb4f-46edf518527e_ip13.jpg', 'iPhone 13 là phiên bản mới nhất của dòng điện thoại thông minh của Apple. Nó có thiết kế hiện đại với màn hình OLED Super Retina XDR, hỗ trợ 5G, chip A15 Bionic mạnh mẽ, camera chất lượng cao và pin có hiệu suất cao hơn so với các phiên bản trước đó.', '2024-05-09 07:27:33', '2024-05-09 07:55:03', 2),
(975, 'Samsung Galaxy S22 Ultra', 12590000, 'a82f793e-80eb-4e57-bfbb-f408c648be6a_s22utra.jpg', 'Samsung Galaxy S22 Ultra là một trong những điện thoại hàng đầu của Samsung, với màn hình Dynamic AMOLED 2X, hỗ trợ S Pen, camera siêu khủng, chip Snapdragon 8 Gen 1 hoặc Exynos 2200 (tùy khu vực), và nhiều tính năng cao cấp khác.', '2024-05-09 07:40:02', '2024-05-09 07:56:34', 2),
(976, 'Google Pixel 6 Pro', 8490000, 'efedfec8-91fa-4aa7-b1c6-37eb9bfe67ff_p6.jpg', 'Google Pixel 6 Pro là một trong những smartphone hàng đầu của Google, với màn hình OLED Smooth Display, camera Pixel cao cấp, chip Google Tensor, hỗ trợ 5G, và tích hợp nhiều tính năng AI và phần mềm độc quyền từ Google.', '2024-05-09 07:42:59', '2024-05-09 07:42:59', 2),
(977, 'Xiaomi Mi 11 Ultra 1', 9090000, 'a7b03ca8-7203-47b3-a81d-5220e922bc0f_xaomi2.jpg', 'Xiaomi Mi 11 Ultra là một trong những điện thoại cao cấp của Xiaomi, với màn hình AMOLED 120Hz, camera chính 108MP, camera selfie 20MP, chip Snapdragon 888, và pin 5.000mAh.', '2024-05-09 07:45:09', '2024-05-23 08:52:45', 2),
(978, 'iPhone 12', 11990000, '880d433b-8ccd-450e-8407-5b0df5ecc1bb_ip12.jpg', 'iPhone 12 được ra mắt vào năm 2020 với thiết kế sang trọng, màn hình Super Retina XDR OLED và chip Apple A14 Bionic. Nó có camera kép với khả năng chụp ảnh chất lượng cao và hỗ trợ quay video 4K', '2024-05-09 08:01:51', '2024-05-09 08:01:51', 2),
(979, 'iPhone 14', 16490000, '9be29b27-61d7-4d36-a0c0-c08055ff3d1c_ip14.jpg', 'iPhone 14 được ra mắt vào năm 2022 với thiết kế mới, màn hình Super Retina XDR OLED và chip Apple A15 Bionic. Nó có hệ thống camera nâng cấp và hỗ trợ quay video HDR 4K', '2024-05-09 08:06:27', '2024-05-09 08:06:27', 2),
(980, 'iPhone 15', 19250000, '3d442070-7eba-4d30-a1db-924f96d420c1_ip151.jpg', 'iPhone 15 ra mắt vào năm 2023 với màn hình Super Retina XDR OLED, chip Apple A16 Bionic và khả năng chụp ảnh siêu nét. Nó cũng hỗ trợ chống nước và bụi theo tiêu chuẩn IP68', '2024-05-09 08:09:02', '2024-05-09 08:09:02', 2),
(981, 'Lenovo ThinkPad X1 Extreme', 25990000, '2b59ac00-f628-4eb5-86fb-1c499026b962_lenovo.jpg', 'Lenovo ThinkPad X1 Extreme được ra mắt với thiết kế sang trọng, màn hình Super Retina XDR OLED và chip Intel Core i9 hoặc AMD Ryzen. Nó là một lựa chọn tốt cho công việc đa nhiệm và chơi game', '2024-05-09 09:17:47', '2024-05-09 09:17:47', 3),
(982, 'MSI Titan 18 HX A14VIG', 149990000, 'c1de0308-b0a7-4350-98ef-e8737473af11_msi.jpg', 'MSI Titan 18 HX A14VIG có màn hình lớn 18 inch, chip Intel Core i9 hoặc AMD Ryzen và card đồ họa Nvidia GeForce RTX. Đây là một laptop mạnh mẽ dành cho các tác vụ đòi hỏi hiệu suất cao', '2024-05-09 09:18:55', '2024-05-09 09:18:55', 3),
(983, 'Asus ROG Zephyrus Duo 16', 94990000, '4fd0039b-64f1-4d10-9ca9-f1013a1f7ae7_rog.jpg', 'Asus ROG Zephyrus Duo 16 (2023) có hai màn hình, chip AMD Ryzen 9 hoặc Intel Core i9 và card đồ họa Nvidia GeForce RTX. Đây là một laptop sáng tạo cho việc làm việc và giải trí', '2024-05-09 09:20:05', '2024-05-09 09:20:05', 3),
(984, 'iPad 10.2', 7090000, '7c4942da-b097-4290-b54c-e1bd5192da83_10.2.jpg', ' iPad 10.2 (9th gen.) được ra mắt với thiết kế sang trọng, màn hình Retina 10.2 inch và chip Apple A13 Bionic. Nó hỗ trợ Apple Pencil (1st generation) và có camera 8MP cho việc chụp ảnh và quay video', '2024-05-09 09:24:31', '2024-05-09 09:24:31', 4),
(985, 'iPad Pro 12.9', 14050000, '293967b5-60a5-4fe7-adc7-0ebe564f4fe0_12.9.jpg', 'iPad Pro 12.9 (6th gen.) có màn hình Liquid Retina XDR 12.9 inch, chip Apple M2, và hỗ trợ Apple Pencil (2nd generation). Đây là một phiên bản mạnh mẽ dành cho công việc sáng tạo và giải trí', '2024-05-09 09:25:40', '2024-05-09 09:25:40', 4),
(986, 'iPad 15', 30000000, '29231f1d-76cb-4bf5-95c3-0784e5793061_15.jpg', 'iPad 15 ra mắt với màn hình Liquid Retina XDR 10.9 inch, chip Apple M2 và hỗ trợ Apple Pencil (2nd generation). Đây là một phiên bản tiện lợi cho việc học tập và làm việc hàng ngày', '2024-05-09 09:26:59', '2024-05-09 09:26:59', 4),
(987, 'AirPods Pro', 4450000, '3d4b4d90-abb7-4620-8d7e-d5eb2c52aaca_ap.jpg', 'AirPods Pro (thế hệ thứ 2) được ra mắt với thiết kế sang trọng, hỗ trợ chống bụi, chống mồ hôi và chống nước (IP54). Nó có khả năng tùy chỉnh âm thanh, chế độ chống ồn, và tính năng theo dõi đầu chủ động. AirPods Pro cũng hỗ trợ điều khiển bằng thao tác chạm và kết nối không dây qua Bluetooth 5.3', '2024-05-09 09:30:49', '2024-05-09 09:30:49', 5),
(988, 'Sony WF-1000XM3', 5490000, '14ff81b6-9f74-4206-b969-c5160f9c438d_sony.jpg', ' Sony WF-1000XM3 là tai nghe không dây hoàn toàn (truly wireless) với khả năng chống ồn cao cấp. Nó hỗ trợ các định dạng âm thanh như SBC và AAC, và có thời lượng pin lên đến 6 giờ khi bật chế độ chống ồn', '2024-05-09 09:32:15', '2024-05-09 09:32:15', 5),
(989, 'HUAWEI FreeBuds 5i', 1390000, '92f977f6-2faf-4665-9e4a-7cb95da92f8a_hw.jpg', 'HUAWEI FreeBuds 5i có thời lượng pin lên đến 6 giờ khi bật chế độ chống ồn. Tai nghe này cũng hỗ trợ điều khiển bằng thao tác chạm và kết nối không dây qua Bluetooth', '2024-05-09 09:33:34', '2024-05-09 09:33:34', 5),
(990, 'Mi TV P1 55\"', 7990000, 'f2df42a9-cdc7-4ffa-aef3-77f557b23a85_p155.jpg', 'Mi TV P1 55\" có màn hình 4K UHD với độ phân giải 3.840 x 2.160 pixel. Nó hỗ trợ Dolby Vision, HDR10+ và HLG. Loa của tivi có công suất 10 W + 10 W và hỗ trợ Dolby Audio và DTS-HD. Mi TV P1 55\" cũng được tích hợp hệ điều hành Android TV™ 10 và đi kèm với điều khiển từ xa Bluetooth 360°', '2024-05-09 09:36:02', '2024-05-09 09:36:02', 6),
(991, 'TCL 40S5400', 5190000, '565697ab-1509-40e9-af0e-64c68cbf88d3_tlc40.jpg', 'TCL 40S5400 có màn hình 40 inch với độ phân giải 1920 x 1080 pixel. Nó hỗ trợ các định dạng TV tuner như Analog (NTSC/PAL/SECAM), DVB-T, DVB-T2, DVB-C, DVB-S và DVB-S2. Tivi này được trang bị CPU ARM Cortex-A55 và RAM 1.5 GB', '2024-05-09 09:37:10', '2024-05-09 09:37:10', 6),
(992, 'TCL 65P635', 9990000, 'fb5481e7-76d0-4bc4-8b65-4eb71bbb609c_tlv65.jpg', 'TCL 65P635 có màn hình 64.5 inch với độ phân giải 3840 x 2160 pixel. Nó hỗ trợ Dolby Vision, HDR10 và HLG. Tivi này có độ sáng 330 cd/m² và tỷ lệ tương phản tĩnh 5000:1', '2024-05-09 09:38:49', '2024-05-09 09:38:49', 6),
(993, 'Garmin Epix Pro Gen 2 42mm', 13990000, '8c4f69ad-ceea-4b12-912e-35e69d3945da_epix.jpg', ' Garmin Epix Pro Gen 2 42mm có màn hình 1.2 inch OLED/AMOLED và hỗ trợ NFC. Pin của nó có thể sử dụng trong khoảng 10 ngày', '2024-05-09 09:41:59', '2024-05-09 09:41:59', 7),
(1002, 'Huawei Watch Ultimate', 23500000, '1d5f2d32-43a5-4d11-b836-2a38b11cab1a_hww.jpg', 'Huawei Watch Ultimate có màn hình 1.5 inch OLED/AMOLED và hỗ trợ NFC. Pin của nó có thể sử dụng trong khoảng 14 ngày', '2024-05-09 09:43:12', '2024-05-09 09:43:12', 7),
(1003, 'Google Pixel Watch 26', 8600000, '1e8e1b7c-cb06-4bba-a79d-31d4ce2a1b9c_goopix.jpg', ' Google Pixel Watch 2 có màn hình 1.2 inch OLED/AMOLED và hỗ trợ NFC. Đây là một lựa chọn tốt cho người dùng Android', '2024-05-09 09:44:58', '2024-05-23 08:52:30', 7);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `product_images`
--

CREATE TABLE `product_images` (
  `id` int(11) NOT NULL,
  `product_id` int(11) DEFAULT NULL,
  `image_url` varchar(300) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;

--
-- Đang đổ dữ liệu cho bảng `product_images`
--

INSERT INTO `product_images` (`id`, `product_id`, `image_url`) VALUES
(144, 974, '5f18abab-3da4-4bc6-bb4f-46edf518527e_ip13.jpg'),
(145, 974, '02d2818f-666e-462c-ba92-ee75148eb2cd_de542401-7fe1-44e2-8e91-e2e67550a4e2_ip131.jpg'),
(147, 974, '78e09bfc-9381-421a-8e32-c7432330956d_ip132.jpg'),
(148, 975, '349185d8-1545-45ef-8d51-71725e1fbd4b_s22utra3.jpg'),
(149, 975, '96e65e74-9141-4c83-93a7-a3c9291787d4_s22utra2.jpg'),
(150, 975, '915a7a3e-e1e9-4322-8340-87df6fbe821a_a22utra1.jpg'),
(151, 975, 'a82f793e-80eb-4e57-bfbb-f408c648be6a_s22utra.jpg'),
(152, 976, '489c1856-71f9-43bd-9ae8-22eb07e457a5_p62.jpg'),
(153, 976, 'd2144752-9a2d-4c0b-933f-1454362534e3_p61.jpg'),
(154, 976, 'efedfec8-91fa-4aa7-b1c6-37eb9bfe67ff_p6.jpg'),
(155, 977, 'a7b03ca8-7203-47b3-a81d-5220e922bc0f_xaomi2.jpg'),
(156, 977, '9e4b967f-bcc9-4ea3-8f6f-20895382e1e9_xaomi1.jpg'),
(157, 977, '31aaacc8-413a-4194-a7d1-613026226e38_xaomi.jpg'),
(158, 978, '828751d7-aaea-46df-a9d8-dd0a3ad6333f_ip123.jpg'),
(159, 978, '372e6a22-c59b-42a1-8459-76effc4e9056_ip122.jpg'),
(160, 978, 'd83d5d3f-73f6-46fc-a42f-f55536728cbe_ip121.jpg'),
(161, 978, '880d433b-8ccd-450e-8407-5b0df5ecc1bb_ip12.jpg'),
(162, 979, 'e7819389-80c5-413d-a702-548d70389346_ip143.jpg'),
(163, 979, '1dea1f09-cfaa-4dbf-9cc2-0f675f7e022a_ip142.jpg'),
(164, 979, 'b7f915b2-ac09-4846-a20c-e2f355fa42b0_ip141.jpg'),
(165, 979, '9be29b27-61d7-4d36-a0c0-c08055ff3d1c_ip14.jpg'),
(166, 980, 'b324cfb6-5bcd-4eda-93d5-9f3f9d0026e6_ip153.jpg'),
(167, 980, '65463963-d19a-4aac-98c3-84304c713051_ip152.jpg'),
(168, 980, '3d442070-7eba-4d30-a1db-924f96d420c1_ip151.jpg'),
(169, 980, '14a852fd-5308-4066-acf6-57e0b01b2b44_ip15.jpg'),
(170, 981, '2b59ac00-f628-4eb5-86fb-1c499026b962_lenovo.jpg'),
(171, 982, 'c1de0308-b0a7-4350-98ef-e8737473af11_msi.jpg'),
(172, 983, '4fd0039b-64f1-4d10-9ca9-f1013a1f7ae7_rog.jpg'),
(173, 984, '7c4942da-b097-4290-b54c-e1bd5192da83_10.2.jpg'),
(174, 985, '293967b5-60a5-4fe7-adc7-0ebe564f4fe0_12.9.jpg'),
(175, 986, '29231f1d-76cb-4bf5-95c3-0784e5793061_15.jpg'),
(176, 987, '3d4b4d90-abb7-4620-8d7e-d5eb2c52aaca_ap.jpg'),
(177, 988, '14ff81b6-9f74-4206-b969-c5160f9c438d_sony.jpg'),
(178, 989, '92f977f6-2faf-4665-9e4a-7cb95da92f8a_hw.jpg'),
(179, 990, 'f2df42a9-cdc7-4ffa-aef3-77f557b23a85_p155.jpg'),
(180, 991, '565697ab-1509-40e9-af0e-64c68cbf88d3_tlc40.jpg'),
(181, 992, 'fb5481e7-76d0-4bc4-8b65-4eb71bbb609c_tlv65.jpg'),
(182, 993, '8c4f69ad-ceea-4b12-912e-35e69d3945da_epix.jpg'),
(190, 1002, '1d5f2d32-43a5-4d11-b836-2a38b11cab1a_hww.jpg'),
(192, 1003, '1e8e1b7c-cb06-4bba-a79d-31d4ce2a1b9c_goopix.jpg'),
(195, 986, 'ce115615-e26a-4b67-856c-334553b90773_kqchandoan.png');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `roles`
--

CREATE TABLE `roles` (
  `id` int(11) NOT NULL,
  `name` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;

--
-- Đang đổ dữ liệu cho bảng `roles`
--

INSERT INTO `roles` (`id`, `name`) VALUES
(1, 'user'),
(2, 'admin');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `social_accounts`
--

CREATE TABLE `social_accounts` (
  `id` int(11) NOT NULL,
  `provider` varchar(20) NOT NULL COMMENT 'Tên nhà social network',
  `provider_id` varchar(50) NOT NULL,
  `email` varchar(150) NOT NULL COMMENT 'Email tài khoản',
  `name` varchar(100) NOT NULL COMMENT 'Tên người dùng',
  `user_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tokens`
--

CREATE TABLE `tokens` (
  `id` int(11) NOT NULL,
  `token` varchar(255) NOT NULL,
  `token_type` varchar(50) NOT NULL,
  `expiration_date` datetime DEFAULT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expired` tinyint(1) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `is_mobile` tinyint(1) DEFAULT 0,
  `refresh_token` varchar(255) DEFAULT '',
  `refresh_expiration_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;

--
-- Đang đổ dữ liệu cho bảng `tokens`
--

INSERT INTO `tokens` (`id`, `token`, `token_type`, `expiration_date`, `revoked`, `expired`, `user_id`, `is_mobile`, `refresh_token`, `refresh_expiration_date`) VALUES
(7, 'eyJhbGciOiJIUzI1NiJ9.eyJwaG9uZU51bWJlciI6IjMzNDQ1NTY2IiwidXNlcklkIjo1LCJzdWIiOiIzMzQ0NTU2NiIsImV4cCI6MTcwNDAxODIzMX0.mA1bofNECAkMWbZqK0h_WJgVqlTOjfd5XoAiDAqAy7w', 'Bearer', '2023-12-31 10:23:51', 0, 0, 5, 1, '', NULL),
(15, 'eyJhbGciOiJIUzI1NiJ9.eyJwaG9uZU51bWJlciI6IjExMjIzMzQ0IiwidXNlcklkIjozLCJzdWIiOiIxMTIyMzM0NCIsImV4cCI6MTcwNDI1NjMyNH0.w-IXoFFHIMasMwayM0DxZraW3YRgoC_h61C6-74cXqU', 'Bearer', '2024-01-03 04:32:04', 0, 0, 3, 0, '624651d3-a3f6-4f99-89c1-94104ec22a74', '2024-02-02 04:32:04'),
(16, 'eyJhbGciOiJIUzI1NiJ9.eyJwaG9uZU51bWJlciI6IjExMjIzMzQ0IiwidXNlcklkIjozLCJzdWIiOiIxMTIyMzM0NCIsImV4cCI6MTcwNDI1NjM2MH0.U6A4ed5dxRAzMxwHluiR0-_Rxm0ngXfZ1RN-VaW_OpY', 'Bearer', '2024-01-03 04:32:40', 0, 0, 3, 0, '8caf32df-69e8-4489-9716-4e2a2944a1a8', '2024-02-02 04:32:40'),
(29, 'eyJhbGciOiJIUzI1NiJ9.eyJwaG9uZU51bWJlciI6IjA5NjQ4OTYyMzkiLCJ1c2VySWQiOjgsInN1YiI6IjA5NjQ4OTYyMzkiLCJleHAiOjE3MDQ3MDc1MTR9.B3iHckT44zN8zG3clXsURaemqWvfz7HJkR-e9b9VCo0', 'Bearer', '2024-01-08 09:51:55', 0, 0, 8, 0, '9cd17548-6634-43c4-a0a6-376266413e68', '2024-02-07 09:51:55'),
(32, 'eyJhbGciOiJIUzI1NiJ9.eyJwaG9uZU51bWJlciI6IjA5NjQ4OTYyMzkiLCJ1c2VySWQiOjgsInN1YiI6IjA5NjQ4OTYyMzkiLCJleHAiOjE3MDQ3MDc2MTV9.CkOUQe1k7XFjLfiMJgB7VLvVnZnEfkASP0cc7eVAJtQ', 'Bearer', '2024-01-08 09:53:35', 0, 0, 8, 0, '94ac5e7b-abaa-40d7-90df-0a044b7c705c', '2024-02-07 09:53:35'),
(33, 'eyJhbGciOiJIUzI1NiJ9.eyJwaG9uZU51bWJlciI6IjMzNDQ1NTY2IiwidXNlcklkIjo1LCJzdWIiOiIzMzQ0NTU2NiIsImV4cCI6MTcwNDcwNzY1MX0.CbZR3D0WZQCZx1Gj53_GKv7mrGayK4ZGqjO_-YNO_NM', 'Bearer', '2024-01-08 09:54:12', 0, 0, 5, 0, '635b4f9c-c28f-418c-b907-8ccc514924c4', '2024-02-07 09:54:12'),
(34, 'eyJhbGciOiJIUzI1NiJ9.eyJwaG9uZU51bWJlciI6IjA5NjQ4OTYyMzkiLCJ1c2VySWQiOjgsInN1YiI6IjA5NjQ4OTYyMzkiLCJleHAiOjE3MDQ3MDc4NzN9.NzGHRwdw9f1mK6OTe4a8Jsg6xdedeqoAQRb1FZO19Vo', 'Bearer', '2024-01-08 09:57:53', 0, 0, 8, 0, 'c9544702-4ea7-403a-9914-4159f952287a', '2024-02-07 09:57:53'),
(35, 'eyJhbGciOiJIUzI1NiJ9.eyJwaG9uZU51bWJlciI6IjMzNDQ1NTY2IiwidXNlcklkIjo1LCJzdWIiOiIzMzQ0NTU2NiIsImV4cCI6MTcwNDcwNzg5MH0.M1VOtWhQ1mmt04r9AKhHCQUCfc1-mWH_haJ720OXm_E', 'Bearer', '2024-01-08 09:58:11', 0, 0, 5, 0, 'd976b190-9db0-425b-87d8-df95d8221a15', '2024-02-07 09:58:11');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `fullname` varchar(100) DEFAULT '',
  `phone_number` varchar(10) NOT NULL,
  `address` varchar(200) DEFAULT '',
  `password` varchar(100) NOT NULL DEFAULT '',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `date_of_birth` date DEFAULT NULL,
  `facebook_account_id` int(11) DEFAULT 0,
  `google_account_id` int(11) DEFAULT 0,
  `role_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;

--
-- Đang đổ dữ liệu cho bảng `users`
--

INSERT INTO `users` (`id`, `fullname`, `phone_number`, `address`, `password`, `created_at`, `updated_at`, `is_active`, `date_of_birth`, `facebook_account_id`, `google_account_id`, `role_id`) VALUES
(2, 'Nguyễn Văn A', '012456878', 'Nhà a ngõ b', '$2a$10$WdSf5UuyxQMAHcO502qXredzcc8OZQo4XQZNp3UxeT6/bKbuJx/6y', '2023-08-03 05:36:11', '2023-08-03 05:36:11', 1, '1999-10-25', 0, 0, 2),
(3, 'Tài khoản admin 1', '11223344', 'Đây là admin nhé', '$2a$10$JFQT3HeFUKDl7c/l.iNFAeybFr7Wi3krwgVVR7ieif.2De5p9LGAG', '2023-08-06 00:34:35', '2023-08-06 00:34:35', 1, '1993-10-25', 0, 0, 2),
(5, 'Nguyễn Văn test', '33445566', 'Nhà a ngõ b 11', '$2a$10$XHa0X8WPCuUNWZAOozKK0ef4kp9Xh6/lxWHAAbDKwca9MZTnEP7OO', '2023-08-08 03:02:48', '2024-05-17 18:15:26', 1, '2000-10-24', 2, 3, 1),
(7, 'Nguyen Van Y', '123456789', 'Đây là user', '$2a$10$oZwu2RA2iiNVIaQZgdi7bueKc5YNWr39yu.gXdsavBzo5AOb1kP5e', '2023-11-16 00:52:29', '2023-11-16 00:52:29', 1, '2000-10-25', 0, 0, 1),
(8, 'Nguyen Duc Hoang-user', '0964896239', 'Bach mai, hanoi, vietnam', '$2a$10$cGkVz4/65tDn2M33Gx3GYOC3DKrRni4SK/m1So0rpIXQFiG/ltM5G', '2023-12-09 08:27:38', '2023-12-09 08:27:38', 1, '1979-10-25', 0, 0, 1),
(9, 'admin', '123123123', 'admin', '$2a$10$fvt8Dn7OnreGtJNQ45mppujIO/kpJm6FTjLWll5bNmuz/uGMi4t7O', '2024-05-08 07:53:55', '2024-05-08 07:53:55', 1, '2000-01-01', 0, 0, 2),
(10, 'hiu', '123456123', 'qnqqqq', '$2a$10$TilEEOcZFYzXO6xdW6LVL.8ZzJh/.4nnyaRBRWz/zpq5vJpoSELMS', '2024-05-19 14:58:50', '2024-05-19 14:58:50', 1, '2000-12-12', 0, 0, 1);

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Chỉ mục cho bảng `order_details`
--
ALTER TABLE `order_details`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Chỉ mục cho bảng `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `category_id` (`category_id`);

--
-- Chỉ mục cho bảng `product_images`
--
ALTER TABLE `product_images`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_product_images_product_id` (`product_id`);

--
-- Chỉ mục cho bảng `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `social_accounts`
--
ALTER TABLE `social_accounts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Chỉ mục cho bảng `tokens`
--
ALTER TABLE `tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `token` (`token`),
  ADD KEY `user_id` (`user_id`);

--
-- Chỉ mục cho bảng `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `role_id` (`role_id`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT cho bảng `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=48;

--
-- AUTO_INCREMENT cho bảng `order_details`
--
ALTER TABLE `order_details`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=80;

--
-- AUTO_INCREMENT cho bảng `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1008;

--
-- AUTO_INCREMENT cho bảng `product_images`
--
ALTER TABLE `product_images`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=198;

--
-- AUTO_INCREMENT cho bảng `social_accounts`
--
ALTER TABLE `social_accounts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `tokens`
--
ALTER TABLE `tokens`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT cho bảng `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Các ràng buộc cho bảng `order_details`
--
ALTER TABLE `order_details`
  ADD CONSTRAINT `order_details_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`),
  ADD CONSTRAINT `order_details_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

--
-- Các ràng buộc cho bảng `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`);

--
-- Các ràng buộc cho bảng `product_images`
--
ALTER TABLE `product_images`
  ADD CONSTRAINT `fk_product_images_product_id` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `product_images_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

--
-- Các ràng buộc cho bảng `social_accounts`
--
ALTER TABLE `social_accounts`
  ADD CONSTRAINT `social_accounts_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Các ràng buộc cho bảng `tokens`
--
ALTER TABLE `tokens`
  ADD CONSTRAINT `tokens_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Các ràng buộc cho bảng `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
