-- phpMyAdmin SQL Dump
-- version 4.2.11
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Aug 19, 2015 at 03:13 PM
-- Server version: 5.6.21
-- PHP Version: 5.6.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

--
-- Database: `voatour`
--

-- --------------------------------------------------------

--
-- Table structure for table `additionals`
--

CREATE TABLE IF NOT EXISTS `additionals` (
`id` int(10) unsigned NOT NULL,
  `tours_id` int(10) unsigned NOT NULL,
  `interests` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `notes` varchar(255) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `infos`
--

CREATE TABLE IF NOT EXISTS `infos` (
`id` int(11) NOT NULL,
  `visitors_id` int(10) unsigned NOT NULL,
  `phone` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(100) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tours`
--

CREATE TABLE IF NOT EXISTS `tours` (
`id` int(10) unsigned NOT NULL,
  `visit_day` date NOT NULL,
  `num_visitors` int(10) unsigned NOT NULL DEFAULT '0',
  `type_of_tour` enum('Daily','Special') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'Daily',
  `closed` enum('Yes','No') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'No',
  `source` enum('Form','Admin') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'Form'
) ENGINE=MyISAM AUTO_INCREMENT=87 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `visitors`
--

CREATE TABLE IF NOT EXISTS `visitors` (
`id` int(10) unsigned NOT NULL,
  `tours_id` int(10) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `additionals`
--
ALTER TABLE `additionals`
 ADD PRIMARY KEY (`id`), ADD KEY `tours_id` (`tours_id`);

--
-- Indexes for table `infos`
--
ALTER TABLE `infos`
 ADD PRIMARY KEY (`id`), ADD KEY `visitors_id` (`visitors_id`);

--
-- Indexes for table `tours`
--
ALTER TABLE `tours`
 ADD PRIMARY KEY (`id`), ADD KEY `when` (`visit_day`), ADD KEY `num_visitors` (`num_visitors`), ADD KEY `type_of_tour` (`type_of_tour`), ADD KEY `closed` (`closed`), ADD KEY `source` (`source`);

--
-- Indexes for table `visitors`
--
ALTER TABLE `visitors`
 ADD PRIMARY KEY (`id`), ADD KEY `tours_id` (`tours_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `additionals`
--
ALTER TABLE `additionals`
MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `infos`
--
ALTER TABLE `infos`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `tours`
--
ALTER TABLE `tours`
MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=87;
--
-- AUTO_INCREMENT for table `visitors`
--
ALTER TABLE `visitors`
MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
