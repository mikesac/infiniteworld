-- phpMyAdmin SQL Dump
-- version 2.11.9.4
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generato il: 18 Apr, 2009 at 05:58 AM
-- Versione MySQL: 5.0.67
-- Versione PHP: 5.2.4

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

--
-- Database: `mikesac_mikesac`
--

--
-- Dump dei dati per la tabella `Spell`
--

INSERT INTO `Spell` (`id`, `name`, `desc`, `image`, `costMp`, `req_str`, `req_int`, `req_dex`, `req_cha`, `req_lev`, `mod_str`, `mod_int`, `mod_dex`, `mod_cha`, `price`, `lev`, `duration`, `spelltype`, `damage`, `savingthrow`, `initiative`) VALUES
(1, 'noSpell', 'No-spell', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0', -1, 1),
(2, 'Dardo Incantato', 'una freccia magica che non manca mai il bersaglio', 'mmissile', 3, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, '1d6', -1, 1),
(3, 'Cura Minore', 'Un incantesimo che sana le ferite piu lievi', 'heal1', 4, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 1, '1d6', -1, 1),
(4, 'Scudo Minore', 'Una bariera chemigliora la difesa', 'shield1', 5, 0, 0, 0, 0, 1, 0, 0, 5, 0, 0, 1, 10, 2, '0', -1, 1),
(5, 'Luce magica', 'Un bagliore di luce illumina a giorno una zona prescelta. L''incantesimo puo'' essere lanciato su una persona o su un oggetto', 'lucema', 3, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 12, 2, '0', -1, 1),
(6, 'Buio magico', 'Trasforma in oscurita una zona precisa o la visuale attorno ad un personaggio', 'buoioma', 3, 0, 0, 0, 0, 1, -1, 0, 0, 0, 0, 1, 12, 0, '0', -1, 1),
(7, 'charme', 'L''incantesimo permette di controllare una persona', 'charme', 5, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 10, 0, '0', -1, 1),
(8, 'Luce perenne', 'Illumina in maniera permanente una zona di 36m', 'lucepe', 6, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 2, 1000, 2, '0', -1, 1),
(10, 'Benedizione', 'Aiuta ad abbassare il tiro per colpire e il danno sul o sui nemici', 'ben', 6, 0, 0, 0, 0, 2, 1, 0, 1, 0, 0, 2, 36, 2, '0', -1, 1),
(11, 'Blocca persona', 'rallenta fino a quattro avversari, abbssando  la possibilità  di essere colpiti', 'blocca', 8, 0, 0, 0, 0, 2, 0, 0, -3, 0, 0, 2, 20, 1, '0', -1, 1),
(12, 'Silenzio', 'Chi usa questo incantesimo potra'' muoversi senza difficolta ed evitare spiacevoli incontri', 'silenzio', 6, 0, 0, 0, 0, 2, 0, 0, 2, 0, 0, 2, 12, 2, '0', -1, 1),
(13, 'luce perenne', 'luce acceccante usata come arma su un nemico', 'luceperenne', 9, 0, 0, 0, 0, 3, 0, 0, -4, 0, 0, 3, 12, 2, '0', -1, 1),
(14, 'cura cecità ', 'fa svanire l''effetto dell''incantesimo luce perenne e cura qualunque altro tipo di cecità ', 'luceperenne', 9, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 3, 100, 2, '0', -1, 1),
(15, 'infliggi malattia', 'L''incantesimo infligge un danno alla forza e alla destrezza del nemico, il quale potra'' evitare l''effetto solo con un tiro-salvezza', 'infliggimal', 10, 0, 0, 0, 0, 3, -2, 0, -1, 0, 0, 3, 100, 1, '0', -1, 1),
(16, 'scaccia maledizione', 'Annulla qualunque effetto, magico o meno, di una maledizione o malattia che grava sul proprio personaggio', 'scamal', 10, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 3, 100, 2, '0', -1, 1),
(17, 'incantesimo per colpire', 'Ad ogni attacco portato a segno ci sarà  un attacco ulteriore calcolabile con 1d6+1', 'incaaggiunt', 10, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 3, 100, 1, '1d6+1', -1, 1),
(18, 'Incantesimo dissolvi magia', 'Toglie qualuque effetto magico da oggetti o personaggi che sono stati colpiti da incantesimo', 'dissolvimag', 13, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 4, 100, 1, '0', -1, 1),
(19, 'Cura ferite maggiori', 'Cura ferite profonde', 'curagravi', 14, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 4, 1, 2, '2d6+2', -1, 1),
(20, 'Cura ferite enorme', 'cura profonde ferite con un 4d6+2', 'curaenornm', 20, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 6, 1, 1, '4d6+2', -1, 1),
(21, 'Cura ferite enorme', 'incantesimo del sonno', 'sonno', 4, 0, 0, 0, 0, 1, 0, 0, -2, 0, 0, 1, 13, 0, '0', -1, 1),
(22, 'Incantesimo del sonno', 'Il vostro avversario avrà  incredibilmente sonno al punto da non riuscire ad attaccarvi', 'sonno', 4, 0, 0, 0, 0, 1, 0, 0, -2, 0, 0, 1, 13, 0, '0', -1, 1),
(23, 'immagini illusorie', 'l''incantesimo crea un immagine uguale alla vostra per cui il primo attacco, se portato a segno non vi farà  alcun male ', 'illusion', 6, 0, 0, 0, 0, 2, 0, 0, 15, 0, 0, 2, 2, 2, '0', -1, 1),
(24, 'Ragna tela', 'Fino a 2 nemici avranno difficolta a muoversi e quindi ad attaccarsi', 'illusion', 7, 0, 0, 0, 0, 2, 0, 0, -4, 0, 0, 2, 10, 0, '0', -1, 1);
