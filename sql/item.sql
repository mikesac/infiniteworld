-- phpMyAdmin SQL Dump
-- version 2.11.7
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generato il: 24 Apr, 2009 at 09:23 PM
-- Versione MySQL: 5.0.67
-- Versione PHP: 5.2.6-2ubuntu4.2

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

--
-- Database: `mikesac_mikesac`
--

-- --------------------------------------------------------

--
-- Struttura della tabella `AreaItem`
--

CREATE TABLE IF NOT EXISTS `AreaItem` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(64) NOT NULL default 'testAreaItem' COMMENT 'Area item name',
  `icon` varchar(64) NOT NULL default 'area',
  `areaid` int(11) NOT NULL default '1' COMMENT 'parent area',
  `ax` smallint(6) NOT NULL default '0' COMMENT 'parent area x',
  `ay` smallint(6) NOT NULL default '0' COMMENT 'parent area y',
  `x` int(11) NOT NULL default '0' COMMENT 'x coord',
  `y` int(11) NOT NULL default '0' COMMENT 'ycoord',
  `lockid` int(11) NOT NULL default '1' COMMENT 'lock id',
  `url` varchar(255) NOT NULL,
  `direct` tinyint(1) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `name` (`name`,`areaid`),
  KEY `fk_locks` (`lockid`),
  KEY `fk_area` (`areaid`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Item inside area' AUTO_INCREMENT=9 ;

--
-- Dump dei dati per la tabella `AreaItem`
--

INSERT INTO `AreaItem` (`id`, `name`, `icon`, `areaid`, `ax`, `ay`, `x`, `y`, `lockid`, `url`, `direct`) VALUES
(1, 'Market', 'trade', 1, 1, 1, 30, 0, 3, '/shop', 1),
(2, 'NorthMountains', 'map', 1, 0, 0, 80, -50, 3, '/map?m=NorthMountains', 1),
(3, 'EastWoods', 'map', 1, 2, 1, 200, 150, 3, '/map?m=EastWoods', 1),
(4, 'HomeTown', 'map', 3, 1, 2, 260, 60, 3, '/map?m=HomeTown', 1),
(5, 'HomeTown', 'map', 2, 0, 2, 100, -20, 3, '/map?m=HomeTown', 1),
(6, 'Hunt Area (North)', 'fight', 2, 1, 0, 200, 0, 3, '/mapfight?lv=1', 1),
(7, 'Hunt Area (East)', 'fight', 2, 2, 1, 200, 100, 3, '/mapfight?lv=2', 1),
(8, 'Hunt Area', 'fight', 2, 1, 1, 0, 0, 3, '/mapfight?lv=0', 1);

--
-- Limiti per le tabelle scaricate
--

--
-- Limiti per la tabella `AreaItem`
--
ALTER TABLE `AreaItem`
  ADD CONSTRAINT `AreaItem_ibfk_1` FOREIGN KEY (`areaid`) REFERENCES `Area` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `AreaItem_ibfk_2` FOREIGN KEY (`lockid`) REFERENCES `locks` (`id`);
