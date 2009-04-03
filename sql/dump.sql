-- phpMyAdmin SQL Dump
-- version 2.11.7
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generato il: 03 Apr, 2009 at 09:38 AM
-- Versione MySQL: 5.0.67
-- Versione PHP: 5.2.6-2ubuntu4.1

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

--
-- Dump dei dati per la tabella `Area`
--

INSERT INTO `Area` (`id`, `name`, `description`, `world`, `nx`, `ny`, `lockid`, `cost`) VALUES
(1, 'HomeTown', 'Your adventure starts in your hometown, a village in the countryside.\r\nLife flows peacefully, day after day, but in your heart you know that soon you will have to adventure outside its borders.', 0, 3, 3, 3, 1),
(2, 'EastWoods', 'Eastern woods sorrounds the city.\r\nMany hunters walk in thes land in search of a prey ot simply to adventure in the deep black wood.', 0, 3, 3, 3, 2),
(3, 'NorthMountains', 'The way through the hills is long and tricky.\r\nMany traveller got lost into the snowy mountains during the winter, their bodies often found into the Big Deep when spring arrives.', 0, 3, 3, 3, 2);

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
  `req_wis` int(10) NOT NULL default '0',
  `req_dex` int(10) NOT NULL,
  `req_cha` int(10) NOT NULL default '0',
  `req_lev` int(10) NOT NULL default '0',
  `mod_str` int(10) NOT NULL default '0',
  `mod_int` int(10) NOT NULL default '0',
  `mod_wis` int(10) NOT NULL default '0',
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

--
-- Dump dei dati per la tabella `Item`
--

INSERT INTO `Item` (`id`, `name`, `descr`, `image`, `costAP`, `req_str`, `req_int`, `req_wis`, `req_dex`, `req_cha`, `req_lev`, `mod_str`, `mod_int`, `mod_wis`, `mod_dex`, `mod_cha`, `price`, `lev`, `spell`, `damage`, `initiative`, `durability`, `type`) VALUES
(14, 'no-item', 'unexisting item', 'empty', 1, 0, 5, 5, 5, 5, 1, 0, 0, 0, 0, 0, 0, 1, 1, '0', 0, 0, 0),
(15, 'Pugnale', 'Una piccola lama', 'dagger', 1, 8, 5, 5, 5, 5, 1, 0, 0, 0, 0, 0, 2, 1, 1, '1d4', 2, 10, 1),
(16, 'Martello', 'Un attrezzo da fabbro', 'hammer', 1, 8, 5, 5, 5, 5, 1, 0, 0, 0, 0, 0, 0, 1, 1, '1d3', 1, 5, 1),
(17, 'Piccone', 'Utile per la miniera', 'picc', 1, 9, 5, 5, 5, 5, 1, 0, 0, 0, 0, 0, 4, 1, 1, '1d5', 5, 20, 1),
(18, 'Spada corta', 'Utile per difendersi', 'sSword', 1, 10, 5, 5, 5, 5, 3, 0, 0, 0, 0, 0, 10, 1, 1, '1d6', 3, 15, 1),
(19, 'Mazza', 'Per chi non ama le armi affilate', 'mace', 1, 9, 5, 5, 5, 5, 3, 0, 0, 0, 0, 0, 5, 1, 1, '1d5', 2, 10, 1),
(20, 'Bastone', 'Asta rinforzata', 'staff', 1, 10, 5, 5, 5, 5, 3, 0, 0, 0, 0, 0, 0, 1, 1, '1d6', 6, 7, 1),
(21, 'Spada lunga', 'Finalmente una vera arma', 'lSword', 1, 11, 5, 5, 5, 5, 5, 0, 0, 0, 0, 0, 15, 1, 1, '1d8', 7, 20, 1),
(22, 'Ascia', 'Non solo per fare legna', 'axe', 1, 12, 5, 5, 5, 5, 5, 0, 0, 0, 0, 0, 10, 1, 1, '1d7', 8, 25, 1),
(23, 'Guanto Chiodato', 'Un guanto di ferro', 'gaunt', 1, 6, 5, 5, 5, 5, 1, 0, 0, 0, 0, 0, 0, 1, 1, '1d4', 1, 10, 1),
(24, 'Falcetto', 'Usato nei campi', 'sick', 1, 8, 5, 5, 5, 5, 3, 0, 0, 0, 0, 0, 6, 1, 1, '1d6', 5, 10, 1),
(25, 'Mezza Lancia', 'Una lancia per i combattimenti ravvicinati', 'sLance', 1, 11, 5, 5, 5, 5, 3, 0, 0, 0, 0, 0, 2, 1, 1, '1d6', 3, 10, 1),
(26, 'Morning Star', 'Una palla di ferro con catena ', 'morning', 1, 8, 5, 5, 6, 5, 3, 0, 0, 0, 0, 0, 8, 1, 1, '6', 1, 15, 1),
(27, 'Padded ', '', '', 1, 5, 5, 5, 5, 5, 1, 0, 0, 0, 0, 0, 5, 1, 1, '1', 0, -1, 4),
(28, 'Leather ', '', '', 1, 8, 5, 5, 5, 5, 1, 0, -1, 0, 0, 0, 10, 1, 1, '2', 0, -1, 4),
(29, 'Studded leather ', '', '', 1, 10, 5, 5, 5, 5, 1, 0, -1, 0, 0, 0, 25, 1, 1, '3', 0, -1, 4),
(30, 'Chain shirt ', '', '', 1, -1, 5, 5, 5, 5, 1, 0, -2, 0, 0, 0, 100, 1, 1, '4', 0, -1, 4),
(31, 'Hide ', '', '', 1, -1, 5, 5, 5, 5, 5, 0, -2, 0, 0, 0, 15, 2, 1, '3', 0, -1, 4),
(32, 'Scale mail ', '', '', 1, -1, 5, 5, 5, 5, 5, 0, -2, 0, 0, 0, 50, 2, 1, '4', 0, -1, 4),
(33, 'Chainmail ', '', '', 1, -1, 5, 5, 5, 5, 5, 0, -3, 0, 0, 0, 150, 2, 1, '5', 0, -1, 4),
(34, 'Breastplate ', '', '', 1, -1, 5, 5, 5, 5, 5, 0, -2, 0, 0, 0, 200, 2, 1, '5', 0, -1, 4),
(35, 'Splint mail ', '', '', 1, -1, 5, 5, 5, 5, 10, 0, -4, 0, 0, 0, 200, 3, 1, '6', 0, -1, 4),
(36, 'Banded mail ', '', '', 1, -1, 5, 5, 5, 5, 10, 0, -3, 0, 0, 0, 250, 3, 1, '6', 0, -1, 4),
(37, 'Half-plate ', '', '', 1, -1, 5, 5, 5, 5, 10, 0, -4, 0, 0, 0, 600, 3, 1, '7', 0, -1, 4),
(38, 'Full plate ', '', '', 1, -1, 5, 5, 5, 5, 10, 0, -3, 0, 0, 0, 1, 3, 1, '8', 0, -1, 4),
(39, 'Buckler ', '', '', 1, 6, 5, 5, 5, 5, 1, 0, -5, 0, 0, 0, 15, 1, 1, '1', 0, -1, 5),
(40, 'Shield, light wooden ', '', '', 1, 7, 5, 5, 5, 5, 1, 0, -5, 0, 0, 0, 3, 1, 1, '1', 0, -1, 5),
(41, 'Shield, light steel ', '', '', 1, 8, 5, 5, 5, 5, 1, 0, -5, 0, 0, 0, 9, 1, 1, '1', 0, -1, 5),
(42, 'Shield, heavy wooden ', '', '', 1, 9, 5, 5, 5, 5, 5, 0, -1, 0, 0, 0, 7, 2, 1, '2', 0, -1, 5),
(43, 'Shield, heavy steel ', '', '', 1, 10, 5, 5, 5, 5, 5, 0, -1, 0, 0, 0, 20, 2, 1, '2', 0, -1, 5),
(44, 'Shield, tower ', '', '', 1, 15, 5, 5, 5, 5, 10, 0, -5, 0, 0, 0, 30, 3, 1, '4', 0, -1, 5);

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

--
-- Dump dei dati per la tabella `locks`
--

INSERT INTO `locks` (`id`, `name`, `parentId`) VALUES
(3, 'noLock', NULL);

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
  `attack` varchar(255) NOT NULL default ' {"base":1}',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `NpcInArea` (`area`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dump dei dati per la tabella `NPC`
--

INSERT INTO `NPC` (`id`, `name`, `image`, `description`, `base_str`, `base_int`, `base_dex`, `base_cha`, `base_pl`, `base_pm`, `base_pa`, `base_pc`, `level`, `px`, `status`, `area`, `gold`, `xml_dialog`, `xml_items`, `xml_behave`, `ismonster`, `nattack`, `attack`) VALUES
(1, 'Goblin', 'goblin', 'Goblins are small humanoid monsters. They vary in height from about 3 to 3 ½ feet (91 - 106 cm) and weigh 40 to 45 pounds (21 - 24 kg). They walk upright even though their arms nearly reach their knees. Their eyes vary from red to yellow and are usually dull and glazed. They have a broad nose that sits on a flat face with pointed ears and a wide mouth. Their mouth contains small, but sharp fangs. Their skin pigment ranges from a deep red through nearly any shade of orange to yellow. Members of the same tribe tend to have the same skin color. Based on their ability scores and the encumbrance rules the average goblin would be able to lift about 60 pounds over his head.', 5, 5, 5, 5, 12, 6, 10, 5, 1, 10, 0, 1, 1, 'basedialog.xml', 'baseitem.xml', 'baseact.xml', 1, 1, 'Unarmed,1d1'),
(2, 'Hobgoblin', 'hobgoblin', 'Hobgoblins exist in perpetual war against all other races, believing that "lesser" species are fit only for battle fodder. In mixed groups, hobgoblin officers often lead units of goblins or orcs, whom they bully and make to feel inferior. Other peoples find them paranoid, insulting, and dismissive, while hobgoblins in turn treat all others as potential threats. Hobgoblin mercenaries may offer their services to powerful and wealthy members of other races, however.', 5, 5, 5, 5, 12, 6, 10, 5, 1, 10, 0, 1, 1, 'basedialog.xml', 'baseitem.xml', 'baseact.xml', 1, 1, 'Unarmed,1d1');

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
  PRIMARY KEY  (`id`),
  KEY `PlayerLocation` (`area`),
  KEY `AccountName` (`aid`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=16 ;

--
-- Dump dei dati per la tabella `Player`
--

INSERT INTO `Player` (`id`, `aid`, `name`, `image`, `base_str`, `base_int`, `base_dex`, `base_cha`, `base_pl`, `base_pm`, `base_pa`, `base_pc`, `pl`, `pm`, `pa`, `pc`, `stats_mod`, `level`, `px`, `assign`, `status`, `area`, `gold`, `nattack`, `attack`) VALUES
(13, 'mike', 'testChar', 'testChar_mike.jpg', 5, 5, 5, 5, 20, 5, 10, 5, 0, 6, 0, 6, 1238744033582, 1, 0, 0, 0, 2, 0, 1, 'Unarmed,1d1'),
(15, 'test1', 'testChar', 'testChar_test1.gif', 5, 5, 5, 5, 20, 5, 10, 5, 0, 0, 0, 0, 1236688783849, 1, 0, 0, 0, 1, 0, 1, 'Unarmed,1d1');

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

--
-- Dump dei dati per la tabella `PlayerKnowSpell`
--

INSERT INTO `PlayerKnowSpell` (`id`, `Playerid`, `Spellid`, `status`) VALUES
(1, 13, 2, 0),
(2, 13, 3, 0);

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

--
-- Dump dei dati per la tabella `PlayerOwnItem`
--

INSERT INTO `PlayerOwnItem` (`id`, `Playerid`, `Itemid`, `status`, `bodypart`) VALUES
(7, 13, 15, 0, 0),
(8, 13, 16, 0, 1);

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
  `req_wis` int(10) NOT NULL default '0',
  `req_dex` int(10) NOT NULL default '0',
  `req_cha` int(10) NOT NULL default '0',
  `req_lev` int(10) NOT NULL default '0',
  `mod_str` int(10) NOT NULL default '0',
  `mod_int` int(10) NOT NULL default '0',
  `mod_wis` int(10) NOT NULL default '0',
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- Dump dei dati per la tabella `Spell`
--

INSERT INTO `Spell` (`id`, `name`, `desc`, `image`, `costMp`, `req_str`, `req_int`, `req_wis`, `req_dex`, `req_cha`, `req_lev`, `mod_str`, `mod_int`, `mod_wis`, `mod_dex`, `mod_cha`, `price`, `lev`, `duration`, `spelltype`, `damage`, `savingthrow`, `initiative`) VALUES
(1, 'noSpell', 'No-spell', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0', -1, 1),
(2, 'Dardo Incantato', 'una freccia magica che non manca mai il bersaglio', 'mmissile', 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, '1d6', -1, 1),
(3, 'Cura Minore', 'Un incantesimo che sana le ferite piu lievi', 'heal1', 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 1, '1d6', -1, 1),
(4, 'Scudo Minore', 'Una bariera chemigliora la difesa', 'shield1', 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 5, 0, 0, 1, 10, 2, '0', -1, 1);

-- --------------------------------------------------------

--
-- Struttura della tabella `SpellAffectPlayer`
--

CREATE TABLE IF NOT EXISTS `SpellAffectPlayer` (
  `Playerid` int(10) NOT NULL,
  `Spellid` int(10) NOT NULL,
  PRIMARY KEY  (`Playerid`,`Spellid`),
  KEY `Affected` (`Playerid`),
  KEY `Affecting` (`Spellid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dump dei dati per la tabella `SpellAffectPlayer`
--


-- --------------------------------------------------------

--
-- Struttura della tabella `tomcat_roles`
--

CREATE TABLE IF NOT EXISTS `tomcat_roles` (
  `user` varchar(16) character set utf8 NOT NULL,
  `role` varchar(16) character set utf8 NOT NULL,
  PRIMARY KEY  (`user`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dump dei dati per la tabella `tomcat_roles`
--

INSERT INTO `tomcat_roles` (`user`, `role`) VALUES
('admin', 'manager'),
('mike', 'player'),
('test1', 'player'),
('test2', 'player');

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
-- Dump dei dati per la tabella `tomcat_users`
--

INSERT INTO `tomcat_users` (`user`, `password`, `email`) VALUES
('admin', 'sonoAdmin', 'admin@antopedia.org'),
('mike', 'mike', 'michele.sacchetti@gmail.com'),
('test1', 'test', 'test1@antopedia.org'),
('test2', 'test', 'test2@antopedia.org');

--
-- Limiti per le tabelle scaricate
--

--
-- Limiti per la tabella `Area`
--
ALTER TABLE `Area`
  ADD CONSTRAINT `Area_ibfk_1` FOREIGN KEY (`lockid`) REFERENCES `locks` (`id`);

--
-- Limiti per la tabella `AreaItem`
--
ALTER TABLE `AreaItem`
  ADD CONSTRAINT `AreaItem_ibfk_1` FOREIGN KEY (`areaid`) REFERENCES `Area` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `AreaItem_ibfk_2` FOREIGN KEY (`lockid`) REFERENCES `locks` (`id`);

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
  ADD CONSTRAINT `Player_ibfk_1` FOREIGN KEY (`aid`) REFERENCES `tomcat_users` (`user`) ON DELETE CASCADE,
  ADD CONSTRAINT `Player_ibfk_2` FOREIGN KEY (`area`) REFERENCES `Area` (`id`);

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
  ADD CONSTRAINT `PlayerOwnItem_ibfk_1` FOREIGN KEY (`Playerid`) REFERENCES `Player` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `PlayerOwnItem_ibfk_2` FOREIGN KEY (`Itemid`) REFERENCES `Item` (`id`) ON DELETE CASCADE;

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
  ADD CONSTRAINT `tomcat_roles_ibfk_1` FOREIGN KEY (`user`) REFERENCES `tomcat_users` (`user`) ON DELETE CASCADE;
