-- MySQL Administrator dump 1.4
--
-- ------------------------------------------------------
-- Server version	5.5.25


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
-- Definition of table `equipe_torneio`
--

DROP TABLE IF EXISTS `equipe_torneio`;
CREATE TABLE `equipe_torneio` (
  `cd_equipe` int(11) DEFAULT NULL,
  `cd_torneio` int(11) DEFAULT NULL,
  `cd_conta` int(11) DEFAULT NULL,
  KEY `fk_equipe_torneio_equipe` (`cd_equipe`),
  KEY `fk_equipe_torneio_torneio` (`cd_torneio`),
  KEY `fk_equipe_torneio_conta` (`cd_conta`),
  CONSTRAINT `fk_equipe_torneio_equipe` FOREIGN KEY (`cd_equipe`) REFERENCES `tb_equipe` (`cd_equipe`),
  CONSTRAINT `fk_equipe_torneio_torneio` FOREIGN KEY (`cd_torneio`) REFERENCES `tb_torneio` (`cd_torneio`),
  CONSTRAINT `fk_equipe_torneio_conta` FOREIGN KEY (`cd_conta`) REFERENCES `tb_conta` (`cd_conta`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `equipe_torneio`
--

/*!40000 ALTER TABLE `equipe_torneio` DISABLE KEYS */;
/*!40000 ALTER TABLE `equipe_torneio` ENABLE KEYS */;


--
-- Definition of table `jogador_equipe`
--

DROP TABLE IF EXISTS `jogador_equipe`;
CREATE TABLE `jogador_equipe` (
  `cd_jogador` int(11) DEFAULT NULL,
  `cd_equipe` int(11) DEFAULT NULL,
  KEY `fk_jogador_equipe_jogador` (`cd_jogador`),
  KEY `fk_jogador_equipe_equipe` (`cd_equipe`),
  CONSTRAINT `fk_jogador_equipe_jogador` FOREIGN KEY (`cd_jogador`) REFERENCES `tb_jogador` (`cd_jogador`),
  CONSTRAINT `fk_jogador_equipe_equipe` FOREIGN KEY (`cd_equipe`) REFERENCES `tb_equipe` (`cd_equipe`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `jogador_equipe`
--

/*!40000 ALTER TABLE `jogador_equipe` DISABLE KEYS */;
/*!40000 ALTER TABLE `jogador_equipe` ENABLE KEYS */;


--
-- Definition of table `tb_clube`
--

DROP TABLE IF EXISTS `tb_clube`;
CREATE TABLE `tb_clube` (
  `cd_clube` int(11) NOT NULL AUTO_INCREMENT,
  `nm_clube` varchar(30) DEFAULT NULL,
  `nm_pais` varchar(50) DEFAULT NULL,
  `nm_continente` varchar(20) DEFAULT NULL,
  `nm_liga` varchar(50) DEFAULT NULL,
  `nm_regiao` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`cd_clube`),
  UNIQUE KEY `nm_clube` (`nm_clube`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tb_clube`
--

/*!40000 ALTER TABLE `tb_clube` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_clube` ENABLE KEYS */;


--
-- Definition of table `tb_conta`
--

DROP TABLE IF EXISTS `tb_conta`;
CREATE TABLE `tb_conta` (
  `cd_conta` int(11) NOT NULL AUTO_INCREMENT,
  `nm_nickname` varchar(20) DEFAULT NULL,
  `nm_console` varchar(8) DEFAULT NULL,
  `cd_kpoints` int(11) DEFAULT NULL,
  `cd_usuario` int(11) DEFAULT NULL,
  PRIMARY KEY (`cd_conta`),
  UNIQUE KEY `nm_nickname` (`nm_nickname`),
  KEY `fk_conta_usuario` (`cd_usuario`),
  CONSTRAINT `fk_conta_usuario` FOREIGN KEY (`cd_usuario`) REFERENCES `tb_usuario` (`cd_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tb_conta`
--

/*!40000 ALTER TABLE `tb_conta` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_conta` ENABLE KEYS */;


--
-- Definition of table `tb_equipe`
--

DROP TABLE IF EXISTS `tb_equipe`;
CREATE TABLE `tb_equipe` (
  `cd_equipe` int(11) NOT NULL AUTO_INCREMENT,
  `ic_real_formada` tinyint(1) DEFAULT NULL,
  `cd_equipe_real` int(11) DEFAULT NULL,
  `cd_equipe_formada` int(11) DEFAULT NULL,
  PRIMARY KEY (`cd_equipe`),
  KEY `fk_equipe_equipe_real` (`cd_equipe_real`),
  KEY `fk_equipe_equipe_formada` (`cd_equipe_formada`),
  CONSTRAINT `fk_equipe_equipe_real` FOREIGN KEY (`cd_equipe_real`) REFERENCES `tb_equipe_real` (`cd_equipe_real`),
  CONSTRAINT `fk_equipe_equipe_formada` FOREIGN KEY (`cd_equipe_formada`) REFERENCES `tb_equipe_formada` (`cd_equipe_formada`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tb_equipe`
--

/*!40000 ALTER TABLE `tb_equipe` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_equipe` ENABLE KEYS */;


--
-- Definition of table `tb_equipe_formada`
--

DROP TABLE IF EXISTS `tb_equipe_formada`;
CREATE TABLE `tb_equipe_formada` (
  `cd_equipe_formada` int(11) NOT NULL AUTO_INCREMENT,
  `nm_equipe_formada` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`cd_equipe_formada`),
  UNIQUE KEY `nm_equipe_formada` (`nm_equipe_formada`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tb_equipe_formada`
--

/*!40000 ALTER TABLE `tb_equipe_formada` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_equipe_formada` ENABLE KEYS */;


--
-- Definition of table `tb_equipe_real`
--

DROP TABLE IF EXISTS `tb_equipe_real`;
CREATE TABLE `tb_equipe_real` (
  `cd_equipe_real` int(11) NOT NULL AUTO_INCREMENT,
  `ic_clube_selecao` tinyint(1) DEFAULT NULL,
  `cd_clube` int(11) DEFAULT NULL,
  `cd_selecao` int(11) DEFAULT NULL,
  PRIMARY KEY (`cd_equipe_real`),
  KEY `fk_equipe_real_clube` (`cd_clube`),
  KEY `fk_equipe_real_selecao` (`cd_selecao`),
  CONSTRAINT `fk_equipe_real_clube` FOREIGN KEY (`cd_clube`) REFERENCES `tb_clube` (`cd_clube`),
  CONSTRAINT `fk_equipe_real_selecao` FOREIGN KEY (`cd_selecao`) REFERENCES `tb_selecao` (`cd_selecao`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tb_equipe_real`
--

/*!40000 ALTER TABLE `tb_equipe_real` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_equipe_real` ENABLE KEYS */;


--
-- Definition of table `tb_fase`
--

DROP TABLE IF EXISTS `tb_fase`;
CREATE TABLE `tb_fase` (
  `cd_fase` int(11) NOT NULL AUTO_INCREMENT,
  `nm_fase` varchar(30) DEFAULT NULL,
  `dt_inicio` date DEFAULT NULL,
  `dt_termino` date DEFAULT NULL,
  `cd_torneio` int(11) DEFAULT NULL,
  PRIMARY KEY (`cd_fase`),
  KEY `fk_fase_torneio` (`cd_torneio`),
  CONSTRAINT `fk_fase_torneio` FOREIGN KEY (`cd_torneio`) REFERENCES `tb_torneio` (`cd_torneio`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tb_fase`
--

/*!40000 ALTER TABLE `tb_fase` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_fase` ENABLE KEYS */;


--
-- Definition of table `tb_jogador`
--

DROP TABLE IF EXISTS `tb_jogador`;
CREATE TABLE `tb_jogador` (
  `cd_jogador` int(11) NOT NULL AUTO_INCREMENT,
  `nm_jogador` varchar(100) DEFAULT NULL,
  `ds_posicao` varchar(30) DEFAULT NULL,
  `nm_pais` varchar(50) DEFAULT NULL,
  `nm_naturalizacao` varchar(50) DEFAULT NULL,
  `cd_altura` decimal(3,2) DEFAULT NULL,
  `cd_peso` decimal(5,2) DEFAULT NULL,
  `dt_nascimento` date DEFAULT NULL,
  `cd_overall` int(11) DEFAULT NULL,
  `ic_melhor_pe` tinyint(1) DEFAULT NULL,
  `cd_drible` int(11) DEFAULT NULL,
  `cd_finalizacao` int(11) DEFAULT NULL,
  `cd_cabecada` int(11) DEFAULT NULL,
  `cd_forca_chute` int(11) DEFAULT NULL,
  `cd_velocidade` int(11) DEFAULT NULL,
  PRIMARY KEY (`cd_jogador`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tb_jogador`
--

/*!40000 ALTER TABLE `tb_jogador` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_jogador` ENABLE KEYS */;


--
-- Definition of table `tb_partida`
--

DROP TABLE IF EXISTS `tb_partida`;
CREATE TABLE `tb_partida` (
  `cd_partida` int(11) NOT NULL AUTO_INCREMENT,
  `dt_partida` date DEFAULT NULL,
  `nm_time_casa` varchar(30) DEFAULT NULL,
  `nm_time_fora` varchar(30) DEFAULT NULL,
  `cd_gols_pro` int(11) DEFAULT NULL,
  `cd_gols_pre` int(11) DEFAULT NULL,
  `cd_cartoes_amarelos_casa` int(11) DEFAULT NULL,
  `cd_cartoes_amarelos_fora` int(11) DEFAULT NULL,
  `cd_fase` int(11) DEFAULT NULL,
  PRIMARY KEY (`cd_partida`),
  KEY `fk_partida_fase` (`cd_fase`),
  CONSTRAINT `fk_partida_fase` FOREIGN KEY (`cd_fase`) REFERENCES `tb_fase` (`cd_fase`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tb_partida`
--

/*!40000 ALTER TABLE `tb_partida` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_partida` ENABLE KEYS */;


--
-- Definition of table `tb_selecao`
--

DROP TABLE IF EXISTS `tb_selecao`;
CREATE TABLE `tb_selecao` (
  `cd_selecao` int(11) NOT NULL AUTO_INCREMENT,
  `nm_pais` varchar(50) DEFAULT NULL,
  `nm_continente` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`cd_selecao`),
  UNIQUE KEY `nm_pais` (`nm_pais`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tb_selecao`
--

/*!40000 ALTER TABLE `tb_selecao` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_selecao` ENABLE KEYS */;


--
-- Definition of table `tb_torneio`
--

DROP TABLE IF EXISTS `tb_torneio`;
CREATE TABLE `tb_torneio` (
  `cd_torneio` int(11) NOT NULL AUTO_INCREMENT,
  `nm_toneio` varchar(40) DEFAULT NULL,
  `dt_inicio` date DEFAULT NULL,
  `dt_termino` date DEFAULT NULL,
  `aa_jogo` year(4) DEFAULT NULL,
  `ic_psn_live` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`cd_torneio`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tb_torneio`
--

/*!40000 ALTER TABLE `tb_torneio` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_torneio` ENABLE KEYS */;


--
-- Definition of table `tb_usuario`
--

DROP TABLE IF EXISTS `tb_usuario`;
CREATE TABLE `tb_usuario` (
  `cd_usuario` int(11) NOT NULL AUTO_INCREMENT,
  `nm_usuario` varchar(100) DEFAULT NULL,
  `nm_nickname_usuario` varchar(20) DEFAULT NULL,
  `cd_telefone` varchar(12) DEFAULT NULL,
  `dt_nascimento` date DEFAULT NULL,
  `cd_senha` varchar(12) DEFAULT NULL,
  `nm_sexo` varchar(10) DEFAULT NULL,
  `nm_email` varchar(50) DEFAULT NULL,
  `cd_cpf` char(11) DEFAULT NULL,
  `ic_psn` tinyint(4) DEFAULT NULL,
  `ic_live` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`cd_usuario`),
  UNIQUE KEY `nm_nickname_usuario` (`nm_nickname_usuario`),
  UNIQUE KEY `nm_email` (`nm_email`),
  UNIQUE KEY `cd_cpf` (`cd_cpf`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tb_usuario`
--

/*!40000 ALTER TABLE `tb_usuario` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_usuario` ENABLE KEYS */;




/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
