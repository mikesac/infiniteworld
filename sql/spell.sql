-- phpMyAdmin SQL Dump
-- version 2.11.9.5
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generato il: 23 Mag, 2009 at 01:23 AM
-- Versione MySQL: 5.0.77
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
(6, 'Buio magico', 'Trasforma in oscurita una zona precisa o la visuale attorno ad un personaggio', 'buoioma', 3, 0, 0, 0, 0, 1, 0, 0, -3, 0, 0, 1, 12, 0, '0', -1, 1),
(7, 'charme', 'L''incantesimo permette di controllare una persona', 'charme', 5, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 10, 0, '0', -1, 1),
(10, 'Benedizione', 'Aiuta ad abbassare il tiro per colpire e il danno sul o sui nemici', 'ben', 6, 0, 0, 0, 0, 2, 2, 0, 3, 0, 0, 2, 36, 2, '0', -1, 1),
(11, 'Blocca persona', 'rallenta fino a quattro avversari, abbssando  la possibilità  di essere colpiti', 'blocca', 8, 0, 0, 0, 0, 2, 0, 0, -8, 0, 0, 2, 20, 1, '0', -1, 1),
(12, 'Silenzio', 'Chi usa questo incantesimo potra'' muoversi senza difficolta ed evitare spiacevoli incontri', 'silenzio', 6, 0, 0, 0, 0, 2, 0, 0, 2, 0, 0, 2, 12, 2, '0', -1, 1),
(13, 'luce perenne', 'luce acceccante usata come arma su un nemico', 'luceperenne', 9, 0, 0, 0, 0, 4, -3, 0, -6, 0, 0, 4, 12, 2, '0', -1, 1),
(14, 'cura cecità ', 'fa svanire l''effetto dell''incantesimo luce perenne e cura qualunque altro tipo di cecità ', 'ceci', 9, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 4, 1000, 2, '0', -1, 1),
(15, 'infliggi malattia', 'L''incantesimo infligge un danno alla forza e alla destrezza del nemico, il quale potra'' evitare l''effetto solo con un tiro-salvezza', 'infliggimal', 10, 0, 0, 0, 0, 4, -6, 0, -5, 0, 0, 4, 100, 0, '0', -1, 1),
(16, 'scaccia maledizione', 'Annulla qualunque effetto, magico o meno, di una maledizione o malattia che grava sul proprio personaggio', 'scamal', 10, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 4, 100, 2, '0', -1, 1),
(17, 'incantesimo per colpire', 'Ad ogni attacco portato a segno ci sarà  un attacco ulteriore calcolabile con 1d6+1', 'incaaggiunt', 13, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 4, 100, 0, '1d6+1d6', -1, 1),
(18, 'Incantesimo dissolvi magia', 'Toglie qualuque effetto magico da oggetti o personaggi che sono stati colpiti da incantesimo', 'dissolvimag', 13, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 4, 100, 1, '0', -1, 1),
(19, 'Cura ferite maggiori', 'Cura ferite profonde', 'curagravi', 14, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 5, 1, 2, '2d6+2', -1, 1),
(20, 'Cura ferite enorme', 'cura profonde ferite con un 4d6+2', 'curaenornm', 20, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 7, 1, 1, '4d6+2', -1, 1),
(22, 'Incantesimo del sonno', 'Il vostro avversario avra''  sonno al punto da non riuscire ad attaccarvi', 'sonno', 4, 0, 0, 0, 0, 1, 0, 0, -3, 0, 0, 1, 36, 0, '0', -1, 1),
(23, 'immagini illusorie', 'l''incantesimo crea un immagine uguale alla vostra per cui il primo attacco, se portato a segno non vi farà  alcun male ', 'illusion', 6, 0, 0, 0, 0, 2, 0, 0, 15, 0, 0, 2, 4, 2, '0', -1, 1),
(24, 'Ragnatela', 'Fino a 2 nemici avranno difficolta a muoversi e quindi ad attaccarsi', 'web', 7, 0, 0, 0, 0, 2, 0, 0, -4, 0, 0, 2, 10, 0, '0', -1, 1),
(25, 'Palla di fuoco', 'Proiettile infuocato che scoppia al contatto con il nemico', 'pallafuoco', 10, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 3, 1, 0, '6d6', -1, 1),
(26, 'Velocita', 'Aumenta la velocità  del giocatore favorendo così un secondo attacco e aumentando la propria destrezza', 'velo', 12, 0, 0, 0, 0, 3, 0, 0, 4, 0, 0, 3, 8, 2, '1d4+1d6', -1, 1),
(27, 'fulmine magico', 'un pontente fulmine, a colpo sicuro, ferisce gravemente il vostro nemico', 'fulmine', 13, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 3, 1, 0, '6d6+4', -1, 1),
(28, 'Confusione', 'Il nemico perde il senso dell''orientamente e non riconosce piu'' il suo nemico principale.', 'confusione', 19, 0, 0, 0, 0, 5, -1, -9, -2, 0, 0, 5, 8, 0, '0', -1, 1),
(29, 'Tempesta di ghiaccio', 'Una violenta tempesta si abbatte sul nemico', 'tempestaghi', 20, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 5, 1, 0, '9d6', -1, 1),
(30, 'muro di fuoco', 'un fmuro di fuoco ti protegge dai nemici e chiunque voglia sorpassarlo subisce gravi danni da ustione.', 'murofuo', 16, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 4, 10, 2, '3d6', -1, 1),
(31, 'nube mortale', 'una nube tossica circonda l''avversario o avversari limitrofi.', 'nubemort', 21, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 5, 50, 0, '1', -1, 1),
(32, 'Muro di pietra', 'Un muro di pietra si frappone tra te e l''avversario, aumentando così la propria difesa e infliggendo un danno al nemico', 'muropietra', 23, 0, 0, 0, 0, 6, 0, 0, -10, 0, 0, 6, 10, 0, '1d6', -1, 1),
(33, 'disintegrazione', 'disintegra senza possibilità  di dimezzare il danno', 'disint', 27, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 8, 1, 0, '65', -1, 1),
(34, 'incantesimo della morte', 'un pericoloso attacco magico infligge una ferita mortale che può essere dimezzata con un TS', 'incamort', 26, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 8, 1, 0, '9d10', -1, 1),
(35, 'Annientamento mentale', 'Terribile incantesimo che abbassa in maniera drastica l''intelligenza e i punti mana', 'anninet', 30, 0, 0, 0, 0, 9, 0, -12, 0, 0, 0, 9, 1, 0, '0', -1, 1),
(36, 'barriera', 'Crea una barriera di martelli roteanti che difendono il giocatore da qualunque attacco', 'barrier', 28, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 8, 10, 2, '6d10', -1, 1),
(37, 'guarigione', 'l''incantesimo restituisce, senza possibilità  d''errore, 50PF', 'guar', 26, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 7, 1, 1, '50', -1, 1),
(38, 'parola sacra', 'Il nemico se ha PF inferiori o uguali e sbaglia il Ts muore sul colpo, altrimenti dimezza i propri PF', 'parsacr', 29, 0, 0, 0, 0, 9, 0, 0, 0, 0, 0, 9, 1, 0, '0', -1, 1),
(39, 'Ristorazione', 'Il giocatore recupera tutti i propri Pf persi', 'risto', 30, 0, 0, 0, 0, 9, 0, 0, 0, 0, 0, 9, 1, 1, '10d100', -1, 1),
(40, 'Controllo vento', 'Il giocatore puo'' controllare il movimento e l''intensita'' dell''aria anche per evitare gli attacchi dei nemici oltre a procurare piccole ferite', 'controvent', 17, 0, 0, 0, 0, 5, 0, 0, -12, 0, 0, 5, 6, 0, '1d3', -1, 1),
(41, 'Moviemtno dell''aria', 'Con questo incantesimo il giocatore si muove tre volte più veloce i suoi standard favorendo così più attacchi per turno e facilitando la difesa', 'movair', 17, 0, 0, 0, 0, 5, 0, 0, 8, 0, 0, 5, 8, 2, '1d8+3+1d8+3+1d8+3', -1, 1),
(42, 'Morte volante', 'Uno sciame di 1000 insetti ricpore la vittima e per la prenda restano pochi secondi prima della morte inevitasbile', 'mortevol', 33, 0, 0, 0, 0, 10, 0, 0, 0, 0, 0, 10, 10, 0, '10d10', -1, 1),
(43, 'Conoscenza', 'Il giocatore riceve un bonus sull''intelligenza e quindi sui propri punti mana', 'cono', 28, 0, 0, 0, 0, 8, 0, 12, 0, 0, 0, 8, 5, 1, '0', -1, 1),
(44, 'Invisibilità  multipla', 'Per tre attacchi il giocatore non subirà  alcun danno', 'invimult', 28, 0, 0, 0, 0, 8, 0, 0, 25, 0, 0, 8, 3, 2, '0', -1, 1),
(45, 'Nube esplosiva', 'Ricoperto da una nube, l''avversio è vittima di mortali letali esplosioni', 'nubeespo', 31, 0, 0, 0, 0, 9, 0, 0, 0, 0, 0, 9, 3, 0, '100', -1, 1),
(46, 'Pioggia di meteore', '( meteoriti infuocati colpiscono il nemico infliggendo 8d6 di danno cadauno', 'pioggiamete', 34, 0, 0, 0, 0, 10, 0, 0, 0, 0, 0, 10, 1, 0, '8d6+8d6+8d6+8d6+8d6+8d6+8d6+8d6', -1, 1);
