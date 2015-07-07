-- phpMyAdmin SQL Dump
-- version 4.0.4.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Jul 07, 2015 at 08:36 PM
-- Server version: 5.5.32
-- PHP Version: 5.4.16

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

--
-- Database: `voatour`
--
CREATE DATABASE IF NOT EXISTS `voatour` DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;
USE `voatour`;

-- --------------------------------------------------------

--
-- Table structure for table `additionals`
--

CREATE TABLE IF NOT EXISTS `additionals` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `tours_id` int(10) unsigned NOT NULL,
  `interests` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `notes` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `tours_id` (`tours_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=2 ;

-- --------------------------------------------------------

--
-- Table structure for table `infos`
--

CREATE TABLE IF NOT EXISTS `infos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `visitors_id` int(10) unsigned NOT NULL,
  `phone` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `visitors_id` (`visitors_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=2 ;

-- --------------------------------------------------------

--
-- Table structure for table `tours`
--

CREATE TABLE IF NOT EXISTS `tours` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `visit_day` date NOT NULL,
  `num_visitors` int(10) unsigned NOT NULL,
  `type_of_tour` enum('Daily','Special') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'Daily',
  PRIMARY KEY (`id`),
  KEY `when` (`visit_day`),
  KEY `num_visitors` (`num_visitors`),
  KEY `type_of_tour` (`type_of_tour`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=5 ;

-- --------------------------------------------------------

--
-- Table structure for table `visitors`
--

CREATE TABLE IF NOT EXISTS `visitors` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `tours_id` int(10) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `tours_id` (`tours_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=3 ;
