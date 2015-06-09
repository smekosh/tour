-- phpMyAdmin SQL Dump
-- version 4.0.4.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Jun 09, 2015 at 10:23 PM
-- Server version: 5.5.32
-- PHP Version: 5.4.16

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

--
-- Database: `voatour`
--

-- --------------------------------------------------------

--
-- Table structure for table `tourists`
--

CREATE TABLE IF NOT EXISTS `tourists` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `visit_day` date NOT NULL,
  `num_visitors` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `when` (`visit_day`),
  KEY `num_visitors` (`num_visitors`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=2 ;
