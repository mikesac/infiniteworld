-- phpMyAdmin SQL Dump
-- version 2.11.7
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generato il: 09 Apr, 2009 at 09:06 AM
-- Versione MySQL: 5.0.67
-- Versione PHP: 5.2.6-2ubuntu4.1

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

--
-- Database: `mikesac_mikesac`
--

--
-- Dump dei dati per la tabella `Item`
--

INSERT INTO `Item` (`id`, `name`, `descr`, `image`, `costAP`, `req_str`, `req_int`, `req_dex`, `req_cha`, `req_lev`, `mod_str`, `mod_int`, `mod_dex`, `mod_cha`, `price`, `lev`, `spell`, `damage`, `initiative`, `durability`, `type`) VALUES
(14, 'no-item', 'unexisting item', 'empty', 1, 0, 5, 5, 5, 1, 0, 0, 0, 0, 0, 1, 1, '0', 0, 0, 0),
(15, 'Pugnale', 'Una piccola lama', 'dagger', 1, 8, 5, 5, 5, 1, 0, 0, 0, 0, 2, 1, 1, '1d4', 2, 10, 1),
(16, 'Martello', 'Un attrezzo da fabbro', 'hammer', 1, 8, 5, 5, 5, 1, 0, 0, 0, 0, 0, 1, 1, '1d3', 1, 5, 1),
(17, 'Piccone', 'Utile per la miniera', 'picc', 1, 9, 5, 5, 5, 1, 0, 0, 0, 0, 4, 1, 1, '1d5', 5, 20, 1),
(18, 'Spada corta', 'Utile per difendersi', 'sSword', 1, 10, 5, 5, 5, 3, 0, 0, 0, 0, 10, 1, 1, '1d6', 3, 15, 1),
(19, 'Mazza', 'Per chi non ama le armi affilate', 'mace', 1, 9, 5, 5, 5, 3, 0, 0, 0, 0, 5, 1, 1, '1d5', 2, 10, 1),
(20, 'Bastone', 'Asta rinforzata', 'staff', 1, 10, 5, 5, 5, 3, 0, 0, 0, 0, 0, 1, 1, '1d6', 6, 7, 1),
(21, 'Spada lunga', 'Finalmente una vera arma', 'lSword', 1, 11, 5, 5, 5, 5, 0, 0, 0, 0, 15, 1, 1, '1d8', 7, 20, 1),
(22, 'Ascia', 'Non solo per fare legna', 'axe', 1, 12, 5, 5, 5, 5, 0, 0, 0, 0, 10, 1, 1, '1d7', 8, 25, 1),
(23, 'Guanto Chiodato', 'Un guanto di ferro', 'gaunt', 1, 6, 5, 5, 5, 1, 0, 0, 0, 0, 0, 1, 1, '1d4', 1, 10, 1),
(24, 'Falcetto', 'Usato nei campi', 'sick', 1, 8, 5, 5, 5, 3, 0, 0, 0, 0, 6, 1, 1, '1d6', 5, 10, 1),
(25, 'Mezza Lancia', 'Una lancia per i combattimenti ravvicinati', 'sLance', 1, 11, 5, 5, 5, 3, 0, 0, 0, 0, 2, 1, 1, '1d6', 3, 10, 1),
(26, 'Morning Star', 'Una palla di ferro con catena ', 'morning', 1, 8, 5, 6, 5, 3, 0, 0, 0, 0, 8, 1, 1, '6', 1, 15, 1),
(27, 'Padded armour', 'armatura leggera utile per muoversi velocemente tra i boschi', 'padded', 1, 5, 5, 5, 5, 1, 0, 0, 0, 0, 5, 1, 1, '1', 0, -1, 3),
(28, 'Leather armour', 'armatura di cuoio. il giusto compromesso per non penalizzare forza e destrezza', 'leather', 1, 8, 5, 5, 5, 1, 0, -1, 0, 0, 10, 1, 1, '2', 0, -1, 3),
(29, 'Studded leather Armour', 'Armatura di pelle borchiata. Utile per difendersi da creature piccole e veloci', 'sleather', 1, 10, 5, 5, 5, 1, 0, -1, 0, 0, 25, 1, 1, '3', 0, -1, 3),
(30, 'Chain shirt armour', 'maglia di ferro leggera', 'chain', 1, -1, 5, 5, 5, 1, 0, -2, 0, 0, 100, 1, 1, '4', 0, -1, 3),
(31, 'Hide ', '', '', 1, -1, 5, 5, 5, 5, 0, -2, 0, 0, 15, 2, 1, '3', 0, -1, 3),
(32, 'Scale mail ', 'Armatura a scaglie di ferro', 'scale', 1, -1, 5, 5, 5, 5, 0, -2, 0, 0, 50, 2, 1, '4', 0, -1, 3),
(33, 'Chainmail Armour', 'maglia di ferro pesante', 'chainmail', 1, -1, 5, 5, 5, 5, 0, -3, 0, 0, 150, 2, 1, '5', 0, -1, 3),
(34, 'Breastplate ', 'Armatura composta da un corpetto di piastre posizionate solo nella parte anteriore del corpo', 'breast', 1, -1, 5, 5, 5, 5, 0, -2, 0, 0, 200, 2, 1, '5', 0, -1, 3),
(35, 'Splint mail ', 'Armatura di maglie di ferro che copre tutto il corpo come una tunica', 'splint', 1, -1, 5, 5, 5, 10, 0, -4, 0, 0, 200, 3, 1, '6', 0, -1, 3),
(36, 'Banded mail ', 'Armatura a bande di ferro. Copre solo parte superiore del corpo', 'banded', 1, -1, 5, 5, 5, 10, 0, -3, 0, 0, 250, 3, 1, '6', 0, -1, 3),
(37, 'Half-plate ', 'Armatura di piaste', 'hplate', 1, -1, 5, 5, 5, 10, 0, -4, 0, 0, 600, 3, 1, '7', 0, -1, 3),
(38, 'Full plate ', 'Armatura di piastre completa', 'fplate', 1, -1, 5, 5, 5, 10, 0, -3, 0, 0, 1, 3, 1, '8', 0, -1, 3),
(39, 'Buckler ', 'Scudo piccolo di legno', 'buckler', 1, 6, 5, 5, 5, 1, 0, -5, 0, 0, 15, 1, 1, '1', 0, -1, 2),
(40, 'Shield, light wooden ', 'scudo medio di legno', 'lshieldw', 1, 7, 5, 5, 5, 1, 0, -5, 0, 0, 3, 1, 1, '1', 0, -1, 2),
(41, 'Shield, light steel ', 'scudo d''acciaio leggero', 'lshields', 1, 8, 5, 5, 5, 1, 0, -5, 0, 0, 9, 1, 1, '1', 0, -1, 2),
(42, 'Shield, heavy wooden ', 'Scudo pesante di legno', 'hshieldw', 1, 9, 5, 5, 5, 5, 0, -1, 0, 0, 7, 2, 1, '2', 0, -1, 2),
(43, 'Shield, heavy steel ', 'Scudo d''acciaio pesante', 'hshields', 1, 10, 5, 5, 5, 5, 0, -1, 0, 0, 20, 2, 1, '2', 0, -1, 2),
(44, 'Shield, tower ', 'Scudo enorme', 'tower', 1, 15, 5, 5, 5, 10, 0, -5, 0, 0, 30, 3, 1, '4', 0, -1, 2);
