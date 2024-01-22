-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Dec 27, 2023 at 07:15 AM
-- Server version: 10.5.20-MariaDB
-- PHP Version: 7.3.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `id21608226_event_mgmt`
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
  `place` varchar(255) NOT NULL,
  `state` varchar(255) NOT NULL,
  `event_price` varchar(255) NOT NULL,
  `event_capacity` varchar(255) NOT NULL,
  `event_image` varchar(255) NOT NULL,
  `event_description` text NOT NULL,
  `uid` varchar(255) NOT NULL,
  `visibility` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `status` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `offline_event`
--

INSERT INTO `offline_event` (`id`, `event_name`, `event_start_date`, `event_end_date`, `event_venue`, `place`, `state`, `event_price`, `event_capacity`, `event_image`, `event_description`, `uid`, `visibility`, `token`, `status`) VALUES
(52, 'php', '15-12-2023', '15-12-2023', 'adk and kuttarum', 'Rama Kotayya Street, Vijayawada Central, Andhra Pradesh', 'Andhra Pradesh', '100', '600', 'https://parietal-insanities.000webhostapp.com/Event_Management/Organise/image_uploaded/1000132172.jpg', 'Your clipboard now supports images as well as text', '11', 'public', '1', '14'),
(53, 'Apple ', '31-12-2023', '01-01-2024', 'Vision pro', 'Kolacherry, Taliparamba 670601, Kerala', 'Kerala', '0', '99999', 'https://parietal-insanities.000webhostapp.com/Event_Management/Organise/image_uploaded/1000132176.jpg', 'The **annual sports meet** at Calicut University is a much-awaited event that brings together students from various departments and colleges. The event is usually held in the month of February and lasts for a week. The sports meet is a platform for students to showcase their athletic abilities and compete with their peers in various sports and games.\n\nI was not able to find any specific information about the most recent annual sports meet. However, I found some information about the **Inter-zone Athletics Championship** that was held on December 14, 2021, at the synthetic track in the Government College of Physical Education². \n\nI hope this information helps. Let me know if you have any other questions.\n\nSource: Conversation with Bing, 12/2/2023\n(1) Calicut University Inter-zone Athletics Championship to be held on Dec .... https://english.mathrubhumi.com/sports/news/keralasportsmeetkozhikode-1.6269103.\n(2) Palakkad Co-Operative Arts & Science College. https://pcascollege.com/.', '11', 'public', '1', '57'),
(54, 'butterfly ', '20-12-2023', '21-12-2023', 'butterfly ', 'Old Mundhwa Kharadi Road, Tukaram Nagar, Pune 411014, Maharashtra', 'Maharashtra', '100', '1000', 'https://parietal-insanities.000webhostapp.com/Event_Management/Organise/image_uploaded/1000132172.jpg', 'Room number 3239', '11', 'public', '1', '0'),
(55, 'Marathon ', '02-12-2023', '02-12-2023', 'Hyderabad Stadium ', 'Hyderabad, Telangana', 'Telangana', '1000', '1000', 'https://parietal-insanities.000webhostapp.com/Event_Management/Organise/image_uploaded/1000131900.jpg', '# Marathon\nWelcome everyone ', '11', 'public', '1', '0'),
(56, 'CTF ', '01-01-2024', '01-01-2024', 'Chennai Hall', 'Kamarajar Salai, Nachi Kuppam, Chennai 600004, Tamil Nadu', 'Tamil Nadu', '0', '100', 'https://parietal-insanities.000webhostapp.com/Event_Management/Organise/image_uploaded/1000132171.jpg', '**Greetings, hackers!**\n\nAre you ready to test your skills and compete with the best? Join us for the **Chennai CTF Challenge**, a thrilling event where you will face various cyber security puzzles and tasks. The challenge will take place on **December 10, 2023** at **IIT Madras**. Register now and get ready to hack!', '12', 'public', '1', '0'),
(57, 'Sports Day', '31-12-2023', '31-12-2023', 'Bangalore Stadium', 'Vinobha Nagar South, Bengaluru 560002, Karnataka', 'Karnataka', '199', '100', 'https://parietal-insanities.000webhostapp.com/Event_Management/Organise/image_uploaded/1000126258.jpg', 'You can display your clips as a single column - just tap on the settings icon above', '12', 'public', '1', '0'),
(58, 'something ', '28-12-2023', '29-12-2023', 'Kannur', 'Kannur, Kerala', 'Kerala', '700', '100', 'https://parietal-insanities.000webhostapp.com/Event_Management/Organise/image_uploaded/1000132347.jpg', 'please vist us', '12', 'public', '1', '0'),
(59, 'Offline Event', '17-12-2023', '18-12-2023', 'Goa', 'Velha Goa, Panaji 403110, Goa', 'Goa', '100', '100', 'https://parietal-insanities.000webhostapp.com/Event_Management/Organise/image_uploaded/1000116568.jpg', 'please visit Goa ', '12', 'private', 'xqzq', '0'),
(60, 'Get together ', '10-12-2023', '11-12-2023', 'Ahmedabad ', 'Valanda Ni Haveli, Manek Chowk, Danapith, Ahmedabad 380001, Gujarat', 'Gujarat', '50', '100', 'https://parietal-insanities.000webhostapp.com/Event_Management/Organise/image_uploaded/1000123533.jpg', 'please visit Ahmedabad ', '11', 'public', '1', '2');

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
  `event_description` text NOT NULL,
  `uid` varchar(255) NOT NULL,
  `visibility` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `status` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `online_event`
--

INSERT INTO `online_event` (`id`, `event_name`, `event_start_date`, `event_end_date`, `event_link`, `event_price`, `event_capacity`, `event_image`, `event_description`, `uid`, `visibility`, `token`, `status`) VALUES
(127, ' integos  ', '19-12-2023', '19-12-2023', 'integos.com', '10', '100', 'https://parietal-insanities.000webhostapp.com/Event_Management/Organise/image_uploaded/1000132170.jpg', 'The **annual sports meet** at Calicut University is a much-awaited event that brings together students from various departments and colleges. The event is usually held in the month of February and lasts for a week. The sports meet is a platform for students to showcase their athletic abilities and compete with their peers in various sports and games.\n\nI was not able to find any specific information about the most recent annual sports meet. However, I found some information about the **Inter-zone Athletics Championship** that was held on December 14, 2021, at the synthetic track in the Government College of Physical Education². \n\nI hope this information helps. Let me know if you have any other questions.\n\nSource: Conversation with Bing, 12/2/2023\n(1) Calicut University Inter-zone Athletics Championship to be held on Dec .... https://english.mathrubhumi.com/sports/news/keralasportsmeetkozhikode-1.6269103.\n(2) Palakkad Co-Operative Arts & Science College. https://pcascollege.com/.', '11', 'public', '1', '0'),
(128, ' nike ', '11-12-2023', '11-12-2023', 'nike.com', '1000', '100', 'https://parietal-insanities.000webhostapp.com/Event_Management/Organise/image_uploaded/1000132175.jpg', '# We are everything\nTo do nothing ', '11', 'private', '100', '0'),
(129, ' eventName ', '24-12-2023', '25-12-2023', 'https', '10000', '200', 'https://parietal-insanities.000webhostapp.com/Event_Management/Organise/image_uploaded/1000124835.jpg', 'best event of the eternity ', '11', 'public', '1', '0'),
(130, ' onlineclass ', '17-12-2023', '18-12-2023', 'linkhere.com', '8000', '100', 'https://parietal-insanities.000webhostapp.com/Event_Management/Organise/image_uploaded/1000132125.jpg', 'best event please visit us', '11', 'public', '1', '0'),
(131, ' best event ', '24-12-2023', '25-12-2023', 'joinhere.com', '6000', '100', 'https://parietal-insanities.000webhostapp.com/Event_Management/Organise/image_uploaded/1000132758.jpg', 'please visit us ', '11', 'public', '1', '0');

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `organiser_table`
--

INSERT INTO `organiser_table` (`id`, `username`, `email`, `phone`, `password`) VALUES
(11, 'organiser', 'organiser@event.io', '999999', '$2y$10$PxjCRIonGH7/NalcxCJceumq6L/8CcmEgzlfhX/vfMSHgpqqcMpHW'),
(12, 'organiser1', 'organiser1@event.io', '9996666', '$2y$10$eWz1fSPGA8K741Aikmfqw.302ojTOxjlqBxpDZPoBpki0kG8nHpbO');

-- --------------------------------------------------------

--
-- Table structure for table `payment_table`
--

CREATE TABLE `payment_table` (
  `id` int(255) NOT NULL,
  `uid` int(255) NOT NULL,
  `eventId` int(255) NOT NULL,
  `price` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `upi_id` varchar(255) NOT NULL,
  `card_number` varchar(255) NOT NULL,
  `cvv` varchar(255) NOT NULL,
  `expiry` varchar(255) NOT NULL,
  `billing` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `payment_table`
--

INSERT INTO `payment_table` (`id`, `uid`, `eventId`, `price`, `name`, `upi_id`, `card_number`, `cvv`, `expiry`, `billing`) VALUES
(1, 3, 2, '200', '999', '1000', '55646546545646546', '555', '2023-08-31', '52');

-- --------------------------------------------------------

--
-- Table structure for table `test`
--

CREATE TABLE `test` (
  `id` int(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `age` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user_table`
--

INSERT INTO `user_table` (`id`, `username`, `email`, `phone`, `password`) VALUES
(5, 'user', 'user@event.io', '999999', '$2y$10$59b5nT6KF6RSWgoHdfH9nuTdFNQYYkZkgilEWltyIYxvhJ..zZp9i'),
(6, 'user1', 'user1@event.io', '9696955', '$2y$10$2RMJm8TwPjDJUGHVXNAcke0HdmCVz.8tQdnrU3N5.nMFwDLscYk.2');

-- --------------------------------------------------------

--
-- Table structure for table `user_with_image`
--

CREATE TABLE `user_with_image` (
  `id` int(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `price` varchar(255) NOT NULL,
  `image` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
-- Indexes for table `payment_table`
--
ALTER TABLE `payment_table`
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
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;

--
-- AUTO_INCREMENT for table `online_event`
--
ALTER TABLE `online_event`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=132;

--
-- AUTO_INCREMENT for table `organiser_table`
--
ALTER TABLE `organiser_table`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `payment_table`
--
ALTER TABLE `payment_table`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `test`
--
ALTER TABLE `test`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `user_table`
--
ALTER TABLE `user_table`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `user_with_image`
--
ALTER TABLE `user_with_image`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
