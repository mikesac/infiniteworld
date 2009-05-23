-- phpMyAdmin SQL Dump
-- version 2.11.9.5
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generato il: 23 Mag, 2009 at 01:29 AM
-- Versione MySQL: 5.0.77
-- Versione PHP: 5.2.4

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

--
-- Database: `mikesac_mikesac`
--

--
-- Dump dei dati per la tabella `AreaItem`
--

INSERT INTO `AreaItem` (`id`, `name`, `icon`, `cost`, `areaid`, `areax`, `areay`, `x`, `y`, `arealock`, `questlock`, `url`, `direct`, `loop`, `hidemode`, `areaItemLevel`, `npcs`) VALUES
(1, 'Home', 'talk', 1, 1, 1, 1, 30, 0, '2,3', '', '/player/npcdialog.jsp', 0, 0, 0, 1, '51'),
(2, 'NorthMountains', 'map', 1, 1, 0, 0, 80, -50, '1,3,4', '', '/map?m=4', 1, 1, 0, 1, ''),
(3, 'EastWoods', 'map', 1, 1, 2, 1, 200, 150, '1,2,5', '', '/map?m=5', 1, 1, 0, 1, ''),
(4, 'HomeTown', 'map', 1, 3, 1, 2, 260, 60, '2,9', '', '/map?m=2', 1, 1, 0, 1, ''),
(5, 'HomeTown', 'map', 1, 2, 0, 2, 100, -20, '3,8', '', '/map?m=3', 1, 1, 0, 1, ''),
(6, 'Hunt Area (North)', 'fight', 1, 2, 1, 0, 200, 0, '7,8', '', '/mapfight', 1, 0, 0, 2, ''),
(7, 'Hunt Area (East)', 'fight', 1, 2, 2, 1, 200, 100, '6', '', '/mapfight', 1, 0, 0, 3, ''),
(8, 'Hunt Area', 'fight', 1, 2, 1, 1, 0, 0, '5,6', '', '/mapfight', 1, 0, 0, 1, ''),
(9, 'CickoLair', 'dungeon', 1, 3, 1, 2, -50, -50, '4,10', '', '/map?m=10', 0, 1, 0, 1, ''),
(10, 'NorthMountains', 'dungeon', 1, 4, 0, 0, 10, 10, '9,11', '', '/map?m=9', 0, 1, 0, 1, ''),
(11, 'CickoLair2', 'map', 1, 4, 2, 2, 120, 20, '10,12', '', '/map?m=12', 0, 1, 0, 1, ''),
(12, 'CickoLair2', 'map', 1, 5, 0, 1, 220, -50, '11,13', '', '/map?m=11', 0, 1, 0, 1, ''),
(13, 'CickoLair3', 'map', 1, 5, 1, 3, 100, 50, '12,14', '', '/map?m=14', 0, 1, 0, 1, ''),
(14, 'CickoLair3', 'map', 1, 6, 2, 0, 0, -10, '13,15', '', '/map?m=13', 0, 1, 0, 1, ''),
(15, 'CickoLair4', 'map', 1, 6, 0, 2, -50, -50, '14,16', '', '/map?m=16', 0, 1, 0, 1, ''),
(16, 'CickoLair4', 'map', 1, 7, 2, 2, 0, -50, '15,17', '', '/map?m=15', 0, 1, 0, 1, ''),
(17, 'FinalBoss', 'fight', 1, 7, 2, 0, -50, -50, '16', '', '/mapfight', 0, 1, 0, 1, '');
