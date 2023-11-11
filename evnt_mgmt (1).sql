-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 11, 2023 at 06:38 AM
-- Server version: 10.4.25-MariaDB
-- PHP Version: 7.4.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `evnt_mgmt`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `id` int(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`id`, `username`, `email`, `phone`, `password`) VALUES
(4, 'admin', 'test', '9949494', 'admin');

-- --------------------------------------------------------

--
-- Table structure for table `offline_event`
--

CREATE TABLE `offline_event` (
  `id` int(255) NOT NULL,
  `event_name` varchar(255) NOT NULL,
  `event_start_date` varchar(255) NOT NULL,
  `event_end_date` varchar(255) NOT NULL,
  `event_venue` varchar(255) NOT NULL,
  `event_price` varchar(255) NOT NULL,
  `event_capacity` varchar(255) NOT NULL,
  `event_image` varchar(255) NOT NULL,
  `event_description` varchar(255) NOT NULL,
  `uid` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `offline_event`
--

INSERT INTO `offline_event` (`id`, `event_name`, `event_start_date`, `event_end_date`, `event_venue`, `event_price`, `event_capacity`, `event_image`, `event_description`, `uid`) VALUES
(33, ' offlineEvent ', '2023-10-30', '2023-11-01', 'kannur', '366', '100', 'http://192.168.18.73/Event_Management/Organise/image_uploaded/1000124667.jpg', 'speaker if the year', '2'),
(34, ' offlineEvent ', '2023-11-04', '2023-11-07', 'Calicut ', '200', '100', 'http://192.168.18.73/Event_Management/Organise/image_uploaded/1000123549.jpg', 'poll', '2'),
(35, ' vuvu ', '2023-10-29', '2023-10-29', 'vuvuf', '0686', '6883', 'http://192.168.18.73/Event_Management/Organise/image_uploaded/1000124839.jpg', 'vufufu', '2');

-- --------------------------------------------------------

--
-- Table structure for table `online_event`
--

CREATE TABLE `online_event` (
  `id` int(255) NOT NULL,
  `event_name` varchar(255) NOT NULL,
  `event_start_date` varchar(255) NOT NULL,
  `event_end_date` varchar(255) NOT NULL,
  `event_link` varchar(255) NOT NULL,
  `event_price` varchar(255) NOT NULL,
  `event_capacity` varchar(255) NOT NULL,
  `event_image` varchar(255) NOT NULL,
  `event_description` varchar(255) NOT NULL,
  `uid` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `online_event`
--

INSERT INTO `online_event` (`id`, `event_name`, `event_start_date`, `event_end_date`, `event_link`, `event_price`, `event_capacity`, `event_image`, `event_description`, `uid`) VALUES
(85, ' onlineeventest ', '2023-11-01', '2023-11-06', 'google.com', '699', '100', 'http://192.168.18.73/Event_Management/Organise/image_uploaded/1000124028.jpg', 'good description ', '2'),
(86, ' eventName ', '2023-11-01', '2023-11-07', 'https:', '699', '1122', 'http://192.168.18.73/Event_Management/Organise/image_uploaded/1000124839.jpg', 'best event ', '2'),
(87, ' OnlineEvent123 ', '2023-11-14', '2023-11-18', 'ndnddn', '10000', '1', 'http://192.168.18.73/Event_Management/Organise/image_uploaded/1000124839.jpg', 'best event! not so best', '2'),
(88, ' onlineEventedited', '2023-10-31', '2023-11-02', 'https://google.con', '699', '200', 'http://192.168.18.73/Event_Management/Organise/image_uploaded/1000124810.jpg', 'description edit', '4');

-- --------------------------------------------------------

--
-- Table structure for table `organiser_table`
--

CREATE TABLE `organiser_table` (
  `id` int(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `organiser_table`
--

INSERT INTO `organiser_table` (`id`, `username`, `email`, `phone`, `password`) VALUES
(2, 'organiser', 'test', '9949494', 'organiser'),
(3, 'organiser2', 'org@gmail.fm', '64646', 'organiser2'),
(4, 'test', 'test@test.com', '94965766', 'test');

-- --------------------------------------------------------

--
-- Table structure for table `test`
--

CREATE TABLE `test` (
  `id` int(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `age` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `test`
--

INSERT INTO `test` (`id`, `name`, `age`) VALUES
(2, 'mnjhn', '22');

-- --------------------------------------------------------

--
-- Table structure for table `user_table`
--

CREATE TABLE `user_table` (
  `id` int(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user_table`
--

INSERT INTO `user_table` (`id`, `username`, `email`, `phone`, `password`) VALUES
(2, 'user', 'test', '9949494', 'user');

-- --------------------------------------------------------

--
-- Table structure for table `user_with_image`
--

CREATE TABLE `user_with_image` (
  `id` int(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `price` varchar(255) NOT NULL,
  `image` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user_with_image`
--

INSERT INTO `user_with_image` (`id`, `name`, `price`, `image`) VALUES
(21, ' test2 ', '200', 'http://192.168.29.104/event_Management/image_uploaded/WhatsApp Image 2022-10-15 at 8.21.02 PM.jpeg'),
(22, ' test2 ', '200', 'http://192.168.29.104/event_Management/image_uploaded/WhatsApp Image 2022-10-15 at 8.21.02 PM.jpeg'),
(23, '  ', '', 'http://192.168.29.104/test/image_uploaded/'),
(24, ' test2 ', '200', 'http://192.168.29.104/test/image_uploaded/WhatsApp Image 2022-10-15 at 8.21.02 PM.jpeg'),
(25, '  ', '', 'http://192.168.29.104/event_mngmnt2/image_uploaded/'),
(26, ' test2 ', '200', 'http://192.168.29.104/event_mngmnt2/image_uploaded/WhatsApp Image 2022-10-15 at 8.21.02 PM.jpeg'),
(27, '  ', '', 'http://192.168.29.104/event_mngmnt2/image_uploaded/'),
(28, ' yy ', '53', 'http://192.168.29.104/event_mngmnt2/image_uploaded/1000112783.jpg');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `offline_event`
--
ALTER TABLE `offline_event`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `online_event`
--
ALTER TABLE `online_event`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `organiser_table`
--
ALTER TABLE `organiser_table`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `test`
--
ALTER TABLE `test`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_table`
--
ALTER TABLE `user_table`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_with_image`
--
ALTER TABLE `user_with_image`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `offline_event`
--
ALTER TABLE `offline_event`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT for table `online_event`
--
ALTER TABLE `online_event`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=89;

--
-- AUTO_INCREMENT for table `organiser_table`
--
ALTER TABLE `organiser_table`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `test`
--
ALTER TABLE `test`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `user_table`
--
ALTER TABLE `user_table`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `user_with_image`
--
ALTER TABLE `user_with_image`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
