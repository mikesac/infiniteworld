-- phpMyAdmin SQL Dump
-- version 2.11.7
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generato il: 12 Mag, 2009 at 09:01 AM
-- Versione MySQL: 5.0.75
-- Versione PHP: 5.2.6-3ubuntu4.1

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

--
-- Database: `mikesac_mikesac`
--

-- --------------------------------------------------------

--
-- Struttura della tabella `PlayerOwnQuest`
--

CREATE TABLE IF NOT EXISTS `PlayerOwnQuest` (
  `id` int(11) NOT NULL auto_increment,
  `questID` int(11) NOT NULL,
  `playerID` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `nCompleted` int(11) NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `questID` (`questID`,`playerID`),
  KEY `playerID` (`playerID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Limiti per le tabelle scaricate
--

--
-- Limiti per la tabella `PlayerOwnQuest`
--
ALTER TABLE `PlayerOwnQuest`
  ADD CONSTRAINT `PlayerOwnQuest_ibfk_2` FOREIGN KEY (`playerID`) REFERENCES `Player` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `PlayerOwnQuest_ibfk_1` FOREIGN KEY (`questID`) REFERENCES `Quest` (`id`) ON DELETE CASCADE;
