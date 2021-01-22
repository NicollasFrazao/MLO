-- MySQL Administrator dump 1.4
--
-- ------------------------------------------------------
-- Server version	5.5.41


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


--
-- Create schema db_mlo_infinity
--

CREATE DATABASE IF NOT EXISTS db_mlo_infinity;
USE db_mlo_infinity;

--
-- Definition of table `tb_console`
--

DROP TABLE IF EXISTS `tb_console`;
CREATE TABLE `tb_console` (
  `cd_console` int(11) NOT NULL AUTO_INCREMENT,
  `nm_console` varchar(20) DEFAULT NULL,
  `cd_plataforma` int(11) DEFAULT NULL,
  PRIMARY KEY (`cd_console`),
  UNIQUE KEY `nm_console` (`nm_console`),
  KEY `fk_console_plataforma` (`cd_plataforma`),
  CONSTRAINT `fk_console_plataforma` FOREIGN KEY (`cd_plataforma`) REFERENCES `tb_plataforma` (`cd_plataforma`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tb_console`
--

/*!40000 ALTER TABLE `tb_console` DISABLE KEYS */;
INSERT INTO `tb_console` (`cd_console`,`nm_console`,`cd_plataforma`) VALUES 
 (1,'PS3',1),
 (2,'PS4',1),
 (3,'Xbox 360',2),
 (4,'Xbox One',2);
/*!40000 ALTER TABLE `tb_console` ENABLE KEYS */;


--
-- Definition of table `tb_mensagem`
--

DROP TABLE IF EXISTS `tb_mensagem`;
CREATE TABLE `tb_mensagem` (
  `cd_mensagem` int(11) NOT NULL AUTO_INCREMENT,
  `nm_mensagem` varchar(256) DEFAULT NULL,
  `dt_mensagem` datetime DEFAULT NULL,
  `cd_usuario` int(11) DEFAULT NULL,
  `cd_amigo` int(11) DEFAULT NULL,
  PRIMARY KEY (`cd_mensagem`),
  KEY `fk_mensagem_usuario` (`cd_usuario`),
  KEY `fk_mensagem_amigo` (`cd_amigo`),
  CONSTRAINT `fk_mensagem_usuario` FOREIGN KEY (`cd_usuario`) REFERENCES `usuario_amigo` (`cd_usuario`),
  CONSTRAINT `fk_mensagem_amigo` FOREIGN KEY (`cd_amigo`) REFERENCES `usuario_amigo` (`cd_amigo`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tb_mensagem`
--

/*!40000 ALTER TABLE `tb_mensagem` DISABLE KEYS */;
INSERT INTO `tb_mensagem` (`cd_mensagem`,`nm_mensagem`,`dt_mensagem`,`cd_usuario`,`cd_amigo`) VALUES 
 (1,'aijiodjaodajdaa','2015-06-05 21:45:58',1,1),
 (2,'iojsioduwodjadsad','2015-06-05 21:45:58',1,1),
 (3,'oi','2015-06-05 21:45:58',1,5),
 (4,'oi o/','2015-06-05 21:45:58',5,1),
 (5,'tudo bem??','2015-06-05 21:45:58',1,5),
 (6,'??','2015-06-06 13:33:09',1,5),
 (7,'ta ai??','2015-06-06 13:37:38',1,5),
 (8,'oi o/','2015-06-06 13:40:03',5,5),
 (9,'oi*','2015-06-06 13:40:07',5,5),
 (10,'oi','2015-06-06 13:44:46',1,5),
 (11,'ME RESPONDE POW','2015-06-06 13:45:02',1,5),
 (12,'.....','2015-06-06 13:45:13',1,5),
 (13,'....','2015-06-06 14:05:54',1,5),
 (14,'o','2015-06-06 14:10:54',1,5),
 (15,'ME RESPONDE POW','2015-06-06 14:13:09',1,5),
 (16,'Ok entao','2015-06-06 14:15:24',1,5),
 (17,'Ok entao...','2015-06-06 14:15:31',1,5),
 (18,'Ok então...','2015-06-06 14:29:48',1,5),
 (19,'To aqui k7','2015-06-06 14:55:04',5,1),
 (20,'Desculpa ae então o/','2015-06-06 14:55:26',1,5);
/*!40000 ALTER TABLE `tb_mensagem` ENABLE KEYS */;


--
-- Definition of table `tb_plataforma`
--

DROP TABLE IF EXISTS `tb_plataforma`;
CREATE TABLE `tb_plataforma` (
  `cd_plataforma` int(11) NOT NULL AUTO_INCREMENT,
  `nm_plataforma` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`cd_plataforma`),
  UNIQUE KEY `nm_plataforma` (`nm_plataforma`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tb_plataforma`
--

/*!40000 ALTER TABLE `tb_plataforma` DISABLE KEYS */;
INSERT INTO `tb_plataforma` (`cd_plataforma`,`nm_plataforma`) VALUES 
 (1,'PSN'),
 (2,'Xbox Live');
/*!40000 ALTER TABLE `tb_plataforma` ENABLE KEYS */;


--
-- Definition of table `tb_usuario`
--

DROP TABLE IF EXISTS `tb_usuario`;
CREATE TABLE `tb_usuario` (
  `cd_usuario` int(11) NOT NULL AUTO_INCREMENT,
  `nm_usuario` varchar(100) DEFAULT NULL,
  `nm_nickname` varchar(20) DEFAULT NULL,
  `cd_telefone` varchar(12) DEFAULT NULL,
  `dt_datanas` date DEFAULT NULL,
  `cd_senha` varchar(50) DEFAULT NULL,
  `nm_sexo` varchar(10) DEFAULT NULL,
  `nm_email` varchar(50) DEFAULT NULL,
  `cd_cpf` char(11) DEFAULT NULL,
  `ic_confirmado` tinyint(1) DEFAULT '0',
  `dt_cadastro` datetime DEFAULT NULL,
  `ic_tipo` tinyint(1) DEFAULT '0',
  `ic_logado` tinyint(1) DEFAULT '0',
  `dt_ultima_atividade` datetime DEFAULT NULL,
  PRIMARY KEY (`cd_usuario`),
  UNIQUE KEY `nm_email` (`nm_email`),
  UNIQUE KEY `cd_cpf` (`cd_cpf`),
  UNIQUE KEY `nm_nickname` (`nm_nickname`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tb_usuario`
--

/*!40000 ALTER TABLE `tb_usuario` DISABLE KEYS */;
INSERT INTO `tb_usuario` (`cd_usuario`,`nm_usuario`,`nm_nickname`,`cd_telefone`,`dt_datanas`,`cd_senha`,`nm_sexo`,`nm_email`,`cd_cpf`,`ic_confirmado`,`dt_cadastro`,`ic_tipo`,`ic_logado`,`dt_ultima_atividade`) VALUES 
 (1,'Nícollas Leite Frazão Santos','SnakeEyed','1335764231','1998-03-23','TmkxMzkxNzk2Mzky','Masculino','nicollasfrazao@hotmail.com','12345678909',0,'2015-06-01 19:24:24',0,0,'2015-06-06 14:07:27'),
 (5,'MLO Infinity','MLOInfinity','9999999999','1998-06-04','bWFzdGVybWxv','Masculino','mloinfinity@mloinfinity.com','74504212404',0,'2015-06-04 20:21:12',0,0,'2015-06-06 14:54:50');
/*!40000 ALTER TABLE `tb_usuario` ENABLE KEYS */;


--
-- Definition of trigger `tr_insert_usuario`
--

DROP TRIGGER /*!50030 IF EXISTS */ `tr_insert_usuario`;

DELIMITER $$

CREATE DEFINER = `root`@`localhost` TRIGGER `tr_insert_usuario` AFTER INSERT ON `tb_usuario` FOR EACH ROW begin
      insert into usuario_amigo(cd_usuario, cd_amigo, dt_amizade) values (new.cd_usuario, new.cd_usuario, now());
    end $$

DELIMITER ;

--
-- Definition of table `usuario_amigo`
--

DROP TABLE IF EXISTS `usuario_amigo`;
CREATE TABLE `usuario_amigo` (
  `cd_usuario` int(11) NOT NULL DEFAULT '0',
  `cd_amigo` int(11) NOT NULL DEFAULT '0',
  `dt_amizade` datetime DEFAULT NULL,
  PRIMARY KEY (`cd_usuario`,`cd_amigo`),
  KEY `fk_usuario_amigo_amigo` (`cd_amigo`),
  CONSTRAINT `fk_usuario_amigo_amigo` FOREIGN KEY (`cd_amigo`) REFERENCES `tb_usuario` (`cd_usuario`),
  CONSTRAINT `fk_usuario_amigo_usuario` FOREIGN KEY (`cd_usuario`) REFERENCES `tb_usuario` (`cd_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `usuario_amigo`
--

/*!40000 ALTER TABLE `usuario_amigo` DISABLE KEYS */;
INSERT INTO `usuario_amigo` (`cd_usuario`,`cd_amigo`,`dt_amizade`) VALUES 
 (1,1,'2015-06-04 19:43:53'),
 (1,5,'2015-06-04 20:21:41'),
 (5,1,'2015-06-04 20:21:12'),
 (5,5,'2015-06-04 20:21:12');
/*!40000 ALTER TABLE `usuario_amigo` ENABLE KEYS */;


--
-- Definition of table `usuario_plataforma`
--

DROP TABLE IF EXISTS `usuario_plataforma`;
CREATE TABLE `usuario_plataforma` (
  `cd_usuario` int(11) NOT NULL DEFAULT '0',
  `cd_plataforma` int(11) NOT NULL DEFAULT '0',
  `nm_nickname` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`cd_usuario`,`cd_plataforma`),
  KEY `fk_usuario_plataforma_plataforma` (`cd_plataforma`),
  CONSTRAINT `fk_usuario_plataforma_usuario` FOREIGN KEY (`cd_usuario`) REFERENCES `tb_usuario` (`cd_usuario`),
  CONSTRAINT `fk_usuario_plataforma_plataforma` FOREIGN KEY (`cd_plataforma`) REFERENCES `tb_plataforma` (`cd_plataforma`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `usuario_plataforma`
--

/*!40000 ALTER TABLE `usuario_plataforma` DISABLE KEYS */;
INSERT INTO `usuario_plataforma` (`cd_usuario`,`cd_plataforma`,`nm_nickname`) VALUES 
 (1,2,'SnakeEyed');
/*!40000 ALTER TABLE `usuario_plataforma` ENABLE KEYS */;




/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
