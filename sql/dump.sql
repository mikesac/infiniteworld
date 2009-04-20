-- phpMyAdmin SQL Dump
-- version 2.11.9.4
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generato il: 20 Apr, 2009 at 10:36 AM
-- Versione MySQL: 5.0.67
-- Versione PHP: 5.2.4

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

--
-- Database: `mikesac_mikesac`
--

-- --------------------------------------------------------

--
-- Struttura della tabella `Area`
--

CREATE TABLE IF NOT EXISTS `Area` (
  `id` int(10) NOT NULL auto_increment,
  `name` varchar(255) NOT NULL COMMENT 'area name',
  `description` text NOT NULL,
  `world` int(10) NOT NULL COMMENT 'the world this area belongs to',
  `nx` int(10) NOT NULL COMMENT 'position in screen grid',
  `ny` int(10) NOT NULL COMMENT 'position in screen grid',
  `lockid` int(10) NOT NULL default '0' COMMENT 'lock for accessing the area',
  `cost` int(11) NOT NULL default '0' COMMENT 'AP cost to acces the area',
  PRIMARY KEY  (`id`),
  KEY `AreaLocks` (`lockid`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

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

-- --------------------------------------------------------

--
-- Struttura della tabella `Item`
--

CREATE TABLE IF NOT EXISTS `Item` (
  `id` int(10) NOT NULL auto_increment,
  `name` varchar(255) NOT NULL default 'NoItem' COMMENT 'item name',
  `descr` varchar(255) NOT NULL COMMENT 'item description',
  `image` varchar(255) NOT NULL COMMENT 'item image',
  `costAP` int(11) NOT NULL,
  `req_str` int(10) NOT NULL default '0' COMMENT 'required str',
  `req_int` int(10) NOT NULL default '0',
  `req_dex` int(10) NOT NULL,
  `req_cha` int(10) NOT NULL default '0',
  `req_lev` int(10) NOT NULL default '0',
  `mod_str` int(10) NOT NULL default '0',
  `mod_int` int(10) NOT NULL default '0',
  `mod_dex` int(10) NOT NULL default '0',
  `mod_cha` int(10) NOT NULL default '0',
  `price` float NOT NULL,
  `lev` int(10) NOT NULL default '0' COMMENT 'item level',
  `spell` int(10) NOT NULL,
  `damage` varchar(128) NOT NULL default '0',
  `initiative` int(10) NOT NULL default '1',
  `durability` int(10) NOT NULL default '1',
  `type` int(1) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  KEY `ItemSpecialSpell` (`spell`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=45 ;

-- --------------------------------------------------------

--
-- Struttura della tabella `locks`
--

CREATE TABLE IF NOT EXISTS `locks` (
  `id` int(10) NOT NULL auto_increment,
  `name` varchar(255) NOT NULL,
  `parentId` int(10) default NULL,
  PRIMARY KEY  (`id`),
  KEY `ExternalLock` (`parentId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

-- --------------------------------------------------------

--
-- Struttura della tabella `NPC`
--

CREATE TABLE IF NOT EXISTS `NPC` (
  `id` int(10) NOT NULL,
  `name` varchar(255) NOT NULL default 'Nobody' COMMENT 'NPC name',
  `image` varchar(255) NOT NULL default 'nopic.png' COMMENT 'NPC pic',
  `description` text NOT NULL,
  `base_str` int(10) NOT NULL default '5' COMMENT 'strength',
  `base_int` int(10) NOT NULL default '5' COMMENT 'intelligence',
  `base_dex` int(10) NOT NULL default '5' COMMENT 'agility',
  `base_cha` int(10) NOT NULL default '5' COMMENT 'charisma',
  `base_pl` int(10) NOT NULL default '20' COMMENT 'life points',
  `base_pm` int(10) NOT NULL default '5' COMMENT 'magic points',
  `base_pa` int(10) NOT NULL default '10' COMMENT 'action points',
  `base_pc` int(10) NOT NULL default '5' COMMENT 'charm points',
  `level` int(10) NOT NULL default '1' COMMENT 'NPC level',
  `px` int(10) NOT NULL default '1' COMMENT 'Experience points',
  `status` int(10) NOT NULL default '0' COMMENT 'status',
  `area` int(10) NOT NULL COMMENT 'NPC location',
  `gold` float NOT NULL COMMENT 'money',
  `xml_dialog` varchar(255) NOT NULL default 'basedialog.xml' COMMENT 'xml for dialogs',
  `xml_items` varchar(255) NOT NULL default 'baseitem.xml' COMMENT 'xml for item probability',
  `xml_behave` varchar(255) NOT NULL default 'baseact.xml' COMMENT 'xml for behaviour',
  `ismonster` tinyint(1) NOT NULL default '1' COMMENT 'Npc (0) or Monster (1)',
  `nattack` int(11) NOT NULL default '1',
  `attack` varchar(255) NOT NULL default 'Unarmed,1d1',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `NpcInArea` (`area`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struttura della tabella `Player`
--

CREATE TABLE IF NOT EXISTS `Player` (
  `id` int(10) NOT NULL auto_increment,
  `aid` varchar(16) NOT NULL default 'admin',
  `name` varchar(255) NOT NULL default 'Nobody' COMMENT 'Character name',
  `image` varchar(255) NOT NULL default 'nopic.png' COMMENT 'Avatar image for the PG',
  `base_str` int(11) NOT NULL default '5' COMMENT 'strength',
  `base_int` int(10) NOT NULL default '5' COMMENT 'intelligence',
  `base_dex` int(10) NOT NULL default '5' COMMENT 'agility',
  `base_cha` int(10) NOT NULL default '5' COMMENT 'charisma',
  `base_pl` int(10) NOT NULL default '20' COMMENT 'life points',
  `base_pm` int(10) NOT NULL default '5' COMMENT 'magic points',
  `base_pa` int(10) NOT NULL default '10' COMMENT 'action points',
  `base_pc` int(10) NOT NULL default '5' COMMENT 'charm points',
  `pl` int(11) NOT NULL,
  `pm` int(11) NOT NULL,
  `pa` int(11) NOT NULL,
  `pc` int(11) NOT NULL,
  `stats_mod` bigint(20) NOT NULL default '0',
  `level` int(10) NOT NULL default '1' COMMENT 'Player level',
  `px` int(10) NOT NULL default '1' COMMENT 'experience points',
  `assign` smallint(6) NOT NULL default '0',
  `status` int(10) NOT NULL default '0' COMMENT 'status',
  `area` int(10) NOT NULL default '0' COMMENT 'player location',
  `gold` float NOT NULL default '0.1' COMMENT 'money',
  `nattack` int(11) NOT NULL default '1',
  `attack` varchar(255) NOT NULL default '{"base":1}',
  `battle` varchar(512) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `PlayerLocation` (`area`),
  KEY `AccountName` (`aid`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=21 ;

-- --------------------------------------------------------

--
-- Struttura della tabella `PlayerKnowSpell`
--

CREATE TABLE IF NOT EXISTS `PlayerKnowSpell` (
  `id` int(11) NOT NULL auto_increment,
  `Playerid` int(10) NOT NULL,
  `Spellid` int(10) NOT NULL,
  `status` int(11) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  KEY `Knowing` (`Playerid`),
  KEY `Known` (`Spellid`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

-- --------------------------------------------------------

--
-- Struttura della tabella `PlayerOwnItem`
--

CREATE TABLE IF NOT EXISTS `PlayerOwnItem` (
  `id` int(11) NOT NULL auto_increment,
  `Playerid` int(10) NOT NULL,
  `Itemid` int(10) NOT NULL,
  `status` int(10) NOT NULL default '0' COMMENT 'status for equipped item',
  `bodypart` int(10) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  KEY `PlayerOwn` (`Playerid`),
  KEY `ItemOwned` (`Itemid`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=9 ;

-- --------------------------------------------------------

--
-- Struttura della tabella `Spell`
--

CREATE TABLE IF NOT EXISTS `Spell` (
  `id` int(10) NOT NULL auto_increment,
  `name` varchar(255) NOT NULL default 'NoSpell' COMMENT 'item name',
  `desc` varchar(255) NOT NULL default 'nospell' COMMENT 'item description',
  `image` varchar(255) NOT NULL COMMENT 'item image',
  `costMp` int(11) NOT NULL default '1',
  `req_str` int(10) NOT NULL default '0' COMMENT 'required str',
  `req_int` int(10) NOT NULL default '0',
  `req_dex` int(10) NOT NULL default '0',
  `req_cha` int(10) NOT NULL default '0',
  `req_lev` int(10) NOT NULL default '0',
  `mod_str` int(10) NOT NULL default '0',
  `mod_int` int(10) NOT NULL default '0',
  `mod_dex` int(10) NOT NULL default '0',
  `mod_cha` int(10) NOT NULL default '0',
  `price` float NOT NULL default '0',
  `lev` int(10) NOT NULL default '0' COMMENT 'item level',
  `duration` int(10) NOT NULL default '0',
  `spelltype` int(10) NOT NULL default '0',
  `damage` varchar(128) NOT NULL default '0',
  `savingthrow` int(11) NOT NULL default '-1',
  `initiative` int(11) NOT NULL default '1' COMMENT 'priority in combat',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=37 ;

-- --------------------------------------------------------

--
-- Struttura della tabella `SpellAffectPlayer`
--

CREATE TABLE IF NOT EXISTS `SpellAffectPlayer` (
  `id` int(11) NOT NULL auto_increment,
  `Playerid` int(10) NOT NULL,
  `Spellid` int(10) NOT NULL,
  `elapsing` bigint(20) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  KEY `Affected` (`Playerid`),
  KEY `Affecting` (`Spellid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Struttura della tabella `tomcat_roles`
--

CREATE TABLE IF NOT EXISTS `tomcat_roles` (
  `user` varchar(16) character set utf8 NOT NULL,
  `role` varchar(16) character set utf8 NOT NULL,
  PRIMARY KEY  (`user`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struttura della tabella `tomcat_users`
--

CREATE TABLE IF NOT EXISTS `tomcat_users` (
  `user` varchar(16) character set utf8 NOT NULL,
  `password` varchar(25) character set utf8 NOT NULL,
  `email` varchar(128) character set utf8 NOT NULL,
  PRIMARY KEY  (`user`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Limiti per le tabelle scaricate
--

--
-- Limiti per la tabella `Area`
--
ALTER TABLE `Area`
  ADD CONSTRAINT `Area_ibfk_1` FOREIGN KEY (`lockid`) REFERENCES `locks` (`id`) ON DELETE CASCADE;

--
-- Limiti per la tabella `AreaItem`
--
ALTER TABLE `AreaItem`
  ADD CONSTRAINT `AreaItem_ibfk_1` FOREIGN KEY (`areaid`) REFERENCES `Area` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `AreaItem_ibfk_2` FOREIGN KEY (`lockid`) REFERENCES `locks` (`id`);

--
-- Limiti per la tabella `Item`
--
ALTER TABLE `Item`
  ADD CONSTRAINT `Item_ibfk_1` FOREIGN KEY (`spell`) REFERENCES `Spell` (`id`) ON DELETE CASCADE;

--
-- Limiti per la tabella `locks`
--
ALTER TABLE `locks`
  ADD CONSTRAINT `locks_ibfk_1` FOREIGN KEY (`parentId`) REFERENCES `locks` (`id`);

--
-- Limiti per la tabella `NPC`
--
ALTER TABLE `NPC`
  ADD CONSTRAINT `NPC_ibfk_1` FOREIGN KEY (`area`) REFERENCES `Area` (`id`);

--
-- Limiti per la tabella `Player`
--
ALTER TABLE `Player`
  ADD CONSTRAINT `Player_ibfk_2` FOREIGN KEY (`aid`) REFERENCES `tomcat_users` (`user`) ON DELETE CASCADE,
  ADD CONSTRAINT `Player_ibfk_3` FOREIGN KEY (`area`) REFERENCES `Area` (`id`) ON DELETE CASCADE;

--
-- Limiti per la tabella `PlayerKnowSpell`
--
ALTER TABLE `PlayerKnowSpell`
  ADD CONSTRAINT `PlayerKnowSpell_ibfk_1` FOREIGN KEY (`Playerid`) REFERENCES `Player` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `PlayerKnowSpell_ibfk_2` FOREIGN KEY (`Spellid`) REFERENCES `Spell` (`id`) ON DELETE CASCADE;

--
-- Limiti per la tabella `PlayerOwnItem`
--
ALTER TABLE `PlayerOwnItem`
  ADD CONSTRAINT `PlayerOwnItem_ibfk_3` FOREIGN KEY (`Playerid`) REFERENCES `Player` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `PlayerOwnItem_ibfk_4` FOREIGN KEY (`Itemid`) REFERENCES `Item` (`id`) ON DELETE CASCADE;

--
-- Limiti per la tabella `SpellAffectPlayer`
--
ALTER TABLE `SpellAffectPlayer`
  ADD CONSTRAINT `SpellAffectPlayer_ibfk_1` FOREIGN KEY (`Playerid`) REFERENCES `Player` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `SpellAffectPlayer_ibfk_2` FOREIGN KEY (`Spellid`) REFERENCES `Spell` (`id`) ON DELETE CASCADE;

--
-- Limiti per la tabella `tomcat_roles`
--
ALTER TABLE `tomcat_roles`
  ADD CONSTRAINT `tomcat_roles_ibfk_1` FOREIGN KEY (`user`) REFERENCES `tomcat_users` (`user`) ON DELETE CASCADE ON UPDATE CASCADE;
