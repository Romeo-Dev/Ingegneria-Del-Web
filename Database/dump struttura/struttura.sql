CREATE DATABASE  IF NOT EXISTS `PollWeb` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `PollWeb`;
-- MySQL dump 10.13  Distrib 5.7.26, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: PollWeb
-- ------------------------------------------------------
-- Server version	5.7.26-0ubuntu0.18.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `domande`
--

DROP TABLE IF EXISTS `domande`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `domande` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `IDtipo` int(10) unsigned NOT NULL,
  `IDsondaggio` int(10) unsigned NOT NULL,
  `testo` text NOT NULL,
  `nota` text,
  `obbligatoria` tinyint(1) DEFAULT '0',
  `min` int(11) NOT NULL DEFAULT '0',
  `max` int(11) DEFAULT NULL,
  `regular_exp` varchar(100) DEFAULT NULL,
  `num_domanda` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `tipologia_domanda` (`IDtipo`),
  KEY `sondaggio_domanda` (`IDsondaggio`),
  CONSTRAINT `sondaggio_domanda` FOREIGN KEY (`IDsondaggio`) REFERENCES `sondaggi` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `tipologia_domanda` FOREIGN KEY (`IDtipo`) REFERENCES `tipologie` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary table structure for view `getNormalUser`
--

DROP TABLE IF EXISTS `getNormalUser`;
/*!50001 DROP VIEW IF EXISTS `getNormalUser`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `getNormalUser` AS SELECT 
 1 AS `nome`,
 1 AS `cognome`,
 1 AS `email`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `getUser`
--

DROP TABLE IF EXISTS `getUser`;
/*!50001 DROP VIEW IF EXISTS `getUser`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `getUser` AS SELECT 
 1 AS `ruolo`,
 1 AS `nome`,
 1 AS `cognome`,
 1 AS `email`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `gruppi`
--

DROP TABLE IF EXISTS `gruppi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gruppi` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ruolo` varchar(50) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `partecipano`
--

DROP TABLE IF EXISTS `partecipano`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `partecipano` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `IDpartecipante` int(10) unsigned NOT NULL,
  `IDsondaggio` int(10) unsigned NOT NULL,
  `pw_sondaggio` varchar(50) DEFAULT NULL,
  `completato` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `utente_partecipano` (`IDpartecipante`),
  KEY `sondaggio_partecipano` (`IDsondaggio`),
  CONSTRAINT `sondaggio_partecipano` FOREIGN KEY (`IDsondaggio`) REFERENCES `sondaggi` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `utente_partecipano` FOREIGN KEY (`IDpartecipante`) REFERENCES `utenti` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `risposte`
--

DROP TABLE IF EXISTS `risposte`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `risposte` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `IDdomanda` int(10) unsigned NOT NULL,
  `IDpartecipante` int(10) unsigned NOT NULL,
  `giorno` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `valore` varchar(255) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `utente_risposte` (`IDpartecipante`),
  KEY `domande_risposte` (`IDdomanda`),
  CONSTRAINT `domande_risposte` FOREIGN KEY (`IDdomanda`) REFERENCES `domande` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `utente_risposte` FOREIGN KEY (`IDpartecipante`) REFERENCES `utenti` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sondaggi`
--

DROP TABLE IF EXISTS `sondaggi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sondaggi` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `IDresponsabile` int(10) unsigned NOT NULL,
  `titolo` varchar(255) NOT NULL,
  `testo_apertura` text NOT NULL,
  `testo_chiusura` text NOT NULL,
  `riservato` tinyint(1) DEFAULT '0',
  `attivato` tinyint(1) DEFAULT '0',
  `url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `utente_sondaggio` (`IDresponsabile`),
  CONSTRAINT `utente_sondaggio` FOREIGN KEY (`IDresponsabile`) REFERENCES `utenti` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tipologie`
--

DROP TABLE IF EXISTS `tipologie`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tipologie` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `tipologia` varchar(100) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `utenti`
--

DROP TABLE IF EXISTS `utenti`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `utenti` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `IDruolo` int(10) unsigned NOT NULL DEFAULT '1',
  `nome` varchar(100) NOT NULL,
  `cognome` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `pw_utente` varchar(45) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `gruppo_utente` (`IDruolo`),
  CONSTRAINT `gruppo_utente` FOREIGN KEY (`IDruolo`) REFERENCES `gruppi` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Final view structure for view `getNormalUser`
--

/*!50001 DROP VIEW IF EXISTS `getNormalUser`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `getNormalUser` AS select `utenti`.`nome` AS `nome`,`utenti`.`cognome` AS `cognome`,`utenti`.`email` AS `email` from `utenti` where (`utenti`.`IDruolo` = 1) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `getUser`
--

/*!50001 DROP VIEW IF EXISTS `getUser`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `getUser` AS select `g`.`ruolo` AS `ruolo`,`u`.`nome` AS `nome`,`u`.`cognome` AS `cognome`,`u`.`email` AS `email` from (`gruppi` `g` join `utenti` `u` on((`g`.`ID` = `u`.`IDruolo`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-05-20 16:37:58
