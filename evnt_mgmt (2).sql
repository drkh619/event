-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 02, 2023 at 05:51 AM
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
  `place` varchar(255) NOT NULL,
  `state` varchar(255) NOT NULL,
  `event_price` varchar(255) NOT NULL,
  `event_capacity` varchar(255) NOT NULL,
  `event_image` varchar(255) NOT NULL,
  `event_description` text NOT NULL,
  `uid` varchar(255) NOT NULL,
  `visibility` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `offline_event`
--

INSERT INTO `offline_event` (`id`, `event_name`, `event_start_date`, `event_end_date`, `event_venue`, `place`, `state`, `event_price`, `event_capacity`, `event_image`, `event_description`, `uid`, `visibility`, `token`) VALUES
(48, 'Marathon ', '06-01-2024', '07-01-2024', 'Marine drive ', 'Shanmugham Road, Marine Drive, Kanayannur 682031, Kerala', 'Kerala', '0', '1000', 'http://192.168.18.73/Event_Management/Organise/image_uploaded/1000131899.jpg', 'The **Marine Corps Marathon**, affectionately known as \"The People’s Marathon,\" is a prestigious 26.2-mile race held annually in **Arlington, Virginia** and **Washington, D.C.**. Here are the key details:\n\n1. **Participants**: More than **23,000 runners** from all 50 states, D.C., Puerto Rico, and 63 countries participate in this iconic event.\n2. **Race Categories**:\n    - **MCM Kids Run**: A one-mile fun run for kids aged 5-12, featuring family-friendly games and entertainment.\n    - **MCM 50K**: The largest ultramarathon in the country, covering the entire MCM course with a 4.87-mile diversion.\n    - **MCM 10K**: A 6.2-mile journey.\n    - **MCM Wheel and Hand Cycle**: For wheelchair and hand cycle participants.\n    - **Marine Corps Marathon**: The main event, starting at 7:55 a.m., with a scenic course ending at the Marine Corps War Memorial Circle.\n3. **Non-Running Events**:\n    - **MCM Health and Fitness Expo**: Explore exhibits and booths, sample healthy food, and try exercise equipment.\n    - **MCM Hall of Fame Dinner**: Honors new inductees into the MCM Hall of Fame.\n    - **MCM Dining In**: A pre-race meal to fuel runners.\n4. **Road Closures**: The marathon route includes Route 110 between Arlington National Cemetery and the Pentagon. ', '11', 'public', '1');

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
  `token` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `online_event`
--

INSERT INTO `online_event` (`id`, `event_name`, `event_start_date`, `event_end_date`, `event_link`, `event_price`, `event_capacity`, `event_image`, `event_description`, `uid`, `visibility`, `token`) VALUES
(125, ' dndnn ', '01-01-2024', '04-01-2024', 'jrjrej', '699', '859559', 'http://192.168.18.73/Event_Management/Organise/image_uploaded/1000131902.jpg', 'Djdjjdjd', '11', 'public', '1'),
(126, ' Hackathon ', '01-01-2024', '01-01-2024', 'https://google.com', '1000', '100', 'http://192.168.18.73/Event_Management/Organise/image_uploaded/1000131902.jpg', 'The **Marine Corps Marathon**, affectionately known as \"The People’s Marathon,\" is a prestigious 26.2-mile race held annually in **Arlington, Virginia** and **Washington, D.C.**. Here are the key details:\n\n1. **Participants**: More than **23,000 runners** from all 50 states, D.C., Puerto Rico, and 63 countries participate in this iconic event.\n2. **Race Categories**:\n    - **MCM Kids Run**: A one-mile fun run for kids aged 5-12, featuring family-friendly games and entertainment.\n    - **MCM 50K**: The largest ultramarathon in the country, covering the entire MCM course with a 4.87-mile diversion.\n    - **MCM 10K**: A 6.2-mile journey.\n    - **MCM Wheel and Hand Cycle**: For wheelchair and hand cycle participants.\n    - **Marine Corps Marathon**: The main event, starting at 7:55 a.m., with a scenic course ending at the Marine Corps War Memorial Circle.\n3. **Non-Running Events**:\n    - **MCM Health and Fitness Expo**: Explore exhibits and booths, sample healthy food, and try exercise equipment.\n    - **MCM Hall of Fame Dinner**: Honors new inductees into the MCM Hall of Fame.\n    - **MCM Dining In**: A pre-race meal to fuel runners.\n4. **Road Closures**: The marathon route includes Route 110 between Arlington National Cemetery. ', '11', 'public', '1');

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
(11, 'organiser', 'organiser@event.io', '999999', '$2y$10$PxjCRIonGH7/NalcxCJceumq6L/8CcmEgzlfhX/vfMSHgpqqcMpHW');

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
(3, 'test', 'test', '9949494', 'test'),
(4, 'user1', 'user@event.io', '999999', 'user123'),
(5, 'user', 'user@event.io', '999999', '$2y$10$59b5nT6KF6RSWgoHdfH9nuTdFNQYYkZkgilEWltyIYxvhJ..zZp9i');

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
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- AUTO_INCREMENT for table `online_event`
--
ALTER TABLE `online_event`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=127;

--
-- AUTO_INCREMENT for table `organiser_table`
--
ALTER TABLE `organiser_table`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `test`
--
ALTER TABLE `test`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `user_table`
--
ALTER TABLE `user_table`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `user_with_image`
--
ALTER TABLE `user_with_image`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
