-- MySQL dump 10.13  Distrib 8.0.18, for Win64 (x86_64)
-- ------------------------------------------------------
-- Server version	5.5.62-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `advisor_t`
--

DROP TABLE IF EXISTS `advisor_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `advisor_t` (
  `advisor` varchar(10) COLLATE latin1_german1_ci NOT NULL,
  `indexnr` int(3) DEFAULT NULL,
  PRIMARY KEY (`advisor`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_german1_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `advisor_t`
--

LOCK TABLES `advisor_t` WRITE;
/*!40000 ALTER TABLE `advisor_t` DISABLE KEYS */;
INSERT INTO `advisor_t` VALUES ('Mainuser',10),('Training',20);
/*!40000 ALTER TABLE `advisor_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `calc_corr_t`
--

DROP TABLE IF EXISTS `calc_corr_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `calc_corr_t` (
  `calcset` varchar(20) CHARACTER SET latin1 NOT NULL,
  `corr_index` tinyint(4) NOT NULL DEFAULT '0',
  `isobar_fact` double DEFAULT NULL,
  `isobar_err` double DEFAULT NULL,
  `std_ra` double DEFAULT NULL,
  `std_ra_err` double DEFAULT NULL,
  `std_ba` double DEFAULT NULL,
  `std_ba_err` double DEFAULT NULL,
  `bl_ra` double DEFAULT NULL,
  `bl_ra_err` double DEFAULT NULL,
  `a_slope` double DEFAULT NULL,
  `a_slope_off` double DEFAULT NULL,
  `b_slope` double DEFAULT NULL,
  `b_slope_off` double DEFAULT NULL,
  `time_corr` double DEFAULT NULL,
  `first_run` varchar(12) CHARACTER SET latin1 DEFAULT NULL,
  `last_run` varchar(12) CHARACTER SET latin1 DEFAULT NULL,
  `bg_const` double DEFAULT '0',
  `bg_const_err` double DEFAULT '0',
  `bl_const` double DEFAULT '0',
  `bl_const_err` double DEFAULT '0',
  `bl_const_mass` double DEFAULT '0',
  PRIMARY KEY (`calcset`,`corr_index`),
  CONSTRAINT `calc_corr_t_ibfk_1` FOREIGN KEY (`calcset`) REFERENCES `calc_set_t` (`calcset`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_german1_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `calc_corr_t`
--

LOCK TABLES `calc_corr_t` WRITE;
/*!40000 ALTER TABLE `calc_corr_t` DISABLE KEYS */;
/*!40000 ALTER TABLE `calc_corr_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `calc_sample_t`
--

DROP TABLE IF EXISTS `calc_sample_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `calc_sample_t` (
  `calcset` varchar(20) CHARACTER SET latin1 NOT NULL,
  `sample_nr` int(5) NOT NULL,
  `prep_nr` int(5) NOT NULL,
  `target_nr` int(5) NOT NULL,
  `type` varchar(20) CHARACTER SET latin1 DEFAULT NULL,
  `prep_bl` double NOT NULL DEFAULT '0',
  `active` smallint(6) NOT NULL DEFAULT '1',
  `std_bl` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`calcset`,`target_nr`,`sample_nr`,`prep_nr`),
  CONSTRAINT `calc_sample_t_ibfk_1` FOREIGN KEY (`calcset`) REFERENCES `calc_set_t` (`calcset`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_german1_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `calc_sample_t`
--

LOCK TABLES `calc_sample_t` WRITE;
/*!40000 ALTER TABLE `calc_sample_t` DISABLE KEYS */;
/*!40000 ALTER TABLE `calc_sample_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `calc_set_t`
--

DROP TABLE IF EXISTS `calc_set_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `calc_set_t` (
  `calcset` varchar(20) CHARACTER SET latin1 NOT NULL,
  `a_off` double DEFAULT NULL,
  `a_err_abs` double DEFAULT NULL,
  `a_err_rel` double DEFAULT NULL,
  `b_off` double DEFAULT NULL,
  `b_err_abs` double DEFAULT NULL,
  `b_err_rel` double DEFAULT NULL,
  `iso_off` double DEFAULT NULL,
  `iso_err_abs` double DEFAULT NULL,
  `iso_err_rel` double DEFAULT NULL,
  `isobar` varchar(20) CHARACTER SET latin1 DEFAULT NULL,
  `magazine` varchar(12) CHARACTER SET latin1 DEFAULT NULL,
  `date_calc` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `user_calc` varchar(20) CHARACTER SET latin1 DEFAULT NULL,
  `charge` tinyint(4) DEFAULT NULL,
  `first_run` varchar(12) CHARACTER SET latin1 DEFAULT NULL,
  `last_run` varchar(12) CHARACTER SET latin1 DEFAULT NULL,
  `comment` text CHARACTER SET latin1,
  `fract` tinyint(1) DEFAULT '1',
  `edit` tinyint(1) DEFAULT '1',
  `deadtime` double DEFAULT NULL,
  `scatter` double DEFAULT NULL,
  `ba_nom` double NOT NULL DEFAULT '0.975',
  `ra_nom` double NOT NULL DEFAULT '100',
  `weighting` tinyint(4) NOT NULL DEFAULT '0',
  `poisson` tinyint(4) NOT NULL DEFAULT '1',
  `cycles` smallint(6) NOT NULL DEFAULT '0',
  `ra_norm` double NOT NULL DEFAULT '1',
  `ba_norm` double NOT NULL DEFAULT '0.975',
  PRIMARY KEY (`calcset`),
  KEY `calc_set_t_ibfk_1` (`magazine`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_german1_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `calc_set_t`
--

LOCK TABLES `calc_set_t` WRITE;
/*!40000 ALTER TABLE `calc_set_t` DISABLE KEYS */;
/*!40000 ALTER TABLE `calc_set_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fraction_t`
--

DROP TABLE IF EXISTS `fraction_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fraction_t` (
  `fraction` varchar(20) CHARACTER SET latin1 NOT NULL,
  `indexnr` int(3) DEFAULT NULL,
  PRIMARY KEY (`fraction`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_german1_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fraction_t`
--

LOCK TABLES `fraction_t` WRITE;
/*!40000 ALTER TABLE `fraction_t` DISABLE KEYS */;
INSERT INTO `fraction_t` VALUES ('150-500 um',38),('32-63 um',21),('63-150 um',31),('<150 um',32),('<32 um',20),('<500 um',37),('<63 um',30),('>500 um',39),('alcohol',44),('alkane',40),('amino acids',50),('aragonite',60),('benthic',70),('black carbon',80),('bulk',84),('carbonate',90),('cellulose',91),('charcoal',92),('collagen',100),('compound',110),('cotton',120),('dentine',130),('detritus',140),('DIC',150),('DOC',154),('fatty acid',156),('fibre',160),('fine fraction',170),('GDCT',180),('GDGT',190),('gelatin',200),('humic acid',210),('kerogen',217),('linen',220),('lipids',224),('liquid',230),('litter',240),('macro remains',250),('organic matter',260),('planktonic',270),('pyrolysis product',278),('silk',280),('size fraction',285),('solid',290),('stalactite',300),('stalagmite',304),('TIC',310),('TLE',315),('TOC',320),('undefined',0),('vinegar',330),('waxes',340),('wine',350),('wool',360);
/*!40000 ALTER TABLE `fraction_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `material_t`
--

DROP TABLE IF EXISTS `material_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `material_t` (
  `material` varchar(20) CHARACTER SET latin1 NOT NULL,
  `indexnr` int(3) DEFAULT NULL,
  PRIMARY KEY (`material`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_german1_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `material_t`
--

LOCK TABLES `material_t` WRITE;
/*!40000 ALTER TABLE `material_t` DISABLE KEYS */;
INSERT INTO `material_t` VALUES ('aerosol',720),('barley mash',230),('biofuel',30),('biomarkers',40),('bone',44),('bulk sediment',48),('carbonate',50),('cellulose',60),('charcoal',64),('chironomids',70),('CO2',80),('co2atm',90),('coal',100),('collagen',110),('compound',120),('coprolite',130),('coral',140),('cremated bone',150),('diatom',160),('eggshell',170),('feather',180),('fiber',190),('food',200),('foraminifera',210),('fossil modern',220),('gas',230),('graphite',240),('groundwater',250),('gyttja',251),('hair',260),('hexenol',270),('horn',280),('humic acid',290),('iron',300),('ivory',310),('leather',320),('lignin',330),('liquid',340),('macrofossils',350),('methane',360),('mortar',370),('oil',380),('organic matter',390),('oxalic acid',400),('paint',410),('paper',420),('papyrus',430),('parchment',440),('pearl freshwater',450),('pearl marine',460),('peat',470),('Phthalic Acid',480),('Phthalic anhydride',490),('Phthalimide',494),('plastics',20),('POC',500),('pollen',510),('polyethylene',515),('pottery',520),('precursor',25),('reference',530),('resin',11),('roots',550),('seawater',560),('sediment',564),('seed',570),('shell marine',580),('shell terrestrial',590),('soil',600),('solid',610),('speleothem',615),('speleothom',620),('SPM',625),('SRF',630),('sucrose',640),('textile',650),('tissue',660),('toluene',670),('tooth',680),('undefined',0),('undefined fiber',690),('water',700),('wax',709),('wine',710),('wood',12);
/*!40000 ALTER TABLE `material_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `measprog_t`
--

DROP TABLE IF EXISTS `measprog_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `measprog_t` (
  `magazine` varchar(12) CHARACTER SET latin1 NOT NULL,
  `sequence` int(5) unsigned NOT NULL,
  `position` smallint(2) unsigned NOT NULL,
  `recno` int(5) unsigned NOT NULL,
  `prepdate` date DEFAULT NULL,
  PRIMARY KEY (`magazine`,`sequence`),
  UNIQUE KEY `Mag_Recno` (`magazine`,`recno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_german1_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `measprog_t`
--

LOCK TABLES `measprog_t` WRITE;
/*!40000 ALTER TABLE `measprog_t` DISABLE KEYS */;
INSERT INTO `measprog_t` VALUES ('DEFAULT',1,12,1,'2018-12-12'),('TEST1',1,1,1,'2019-11-19'),('TEST1',2,2,2,'2019-11-19'),('TEST1',3,4,3,'2019-11-19'),('TEST2',1,1,1,'2019-11-19'),('TEST2',2,2,2,'2019-11-19');
/*!40000 ALTER TABLE `measprog_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `method_t`
--

DROP TABLE IF EXISTS `method_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `method_t` (
  `method` varchar(20) CHARACTER SET latin1 NOT NULL,
  `descr` text CHARACTER SET latin1,
  `indexnr` int(3) DEFAULT NULL,
  PRIMARY KEY (`method`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_german1_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `method_t`
--

LOCK TABLES `method_t` WRITE;
/*!40000 ALTER TABLE `method_t` DISABLE KEYS */;
INSERT INTO `method_t` VALUES ('ABA 20°',NULL,10),('ABA 60°',NULL,2),('ABOX',NULL,20),('Acid 60°',NULL,1),('acidification',NULL,24),('alphacellulose',NULL,30),('cellulose BABAB',NULL,40),('cellulose BBB',NULL,42),('collagene',NULL,50),('column',NULL,60),('combustion',NULL,6),('cremated bones wash',NULL,51),('Cu oxid',NULL,80),('drying 60C',NULL,82),('filtration',NULL,84),('freeze drying',NULL,90),('fumigation',NULL,4),('gc',NULL,8),('heavy liquid',NULL,100),('hemicellulose',NULL,110),('hplc',NULL,120),('hypy',NULL,128),('insitu quartz',NULL,130),('leaching',NULL,140),('longin+base',NULL,150),('microwave extraction',NULL,160),('multivap',NULL,165),('NaOH absorption',NULL,167),('pollen',NULL,170),('pyrolysis',NULL,175),('ramped pyrolysis',NULL,178),('sieving',NULL,180),('soxhlet',NULL,190),('SrCl2 precipitation',NULL,206),('step comb',NULL,200),('ultra sonic',NULL,210),('ultrafiltration',NULL,220),('undefined',NULL,0),('WCO',NULL,230);
/*!40000 ALTER TABLE `method_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `preparation_t`
--

DROP TABLE IF EXISTS `preparation_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `preparation_t` (
  `prep_nr` int(5) NOT NULL DEFAULT '1',
  `sample_nr` int(5) NOT NULL DEFAULT '1',
  `batch` varchar(40) CHARACTER SET latin1 DEFAULT NULL,
  `prep_comment` text CHARACTER SET latin1,
  `weight_start` double DEFAULT NULL,
  `weight_medium` double DEFAULT NULL,
  `weight_end` double DEFAULT NULL,
  `step1_method` varchar(20) CHARACTER SET latin1 DEFAULT NULL,
  `step1_start` datetime DEFAULT NULL,
  `step1_end` datetime DEFAULT NULL,
  `step2_method` varchar(20) CHARACTER SET latin1 DEFAULT NULL,
  `step2_start` datetime DEFAULT NULL,
  `step2_end` datetime DEFAULT NULL,
  `step3_method` varchar(20) CHARACTER SET latin1 DEFAULT NULL,
  `step3_start` datetime DEFAULT NULL,
  `step3_end` datetime DEFAULT NULL,
  `step4_method` varchar(20) CHARACTER SET latin1 DEFAULT NULL,
  `step4_start` datetime DEFAULT NULL,
  `step4_end` datetime DEFAULT NULL,
  `step5_method` varchar(20) CHARACTER SET latin1 DEFAULT NULL,
  `step5_start` datetime DEFAULT NULL,
  `step5_end` datetime DEFAULT NULL,
  `cn_ratio` double DEFAULT NULL,
  `c_percent` double DEFAULT NULL,
  `n_percent` double DEFAULT NULL,
  `prep_end` date DEFAULT NULL,
  `stop` tinyint(1) DEFAULT '0',
  `old_info` varchar(8) CHARACTER SET latin1 DEFAULT NULL,
  PRIMARY KEY (`prep_nr`,`sample_nr`),
  KEY `preparation_t_ibfk_2` (`step1_method`),
  KEY `preparation_t_ibfk_3` (`step2_method`),
  KEY `preparation_t_ibfk_4` (`step3_method`),
  KEY `preparation_t_ibfk_5` (`step4_method`),
  KEY `preparation_t_ibfk_6` (`step5_method`),
  KEY `FK_preparation_t_1` (`sample_nr`),
  CONSTRAINT `FK_preparation_t_1` FOREIGN KEY (`sample_nr`) REFERENCES `sample_t` (`sample_nr`) ON UPDATE CASCADE,
  CONSTRAINT `preparation_t_ibfk_2` FOREIGN KEY (`step1_method`) REFERENCES `method_t` (`method`),
  CONSTRAINT `preparation_t_ibfk_3` FOREIGN KEY (`step2_method`) REFERENCES `method_t` (`method`),
  CONSTRAINT `preparation_t_ibfk_4` FOREIGN KEY (`step3_method`) REFERENCES `method_t` (`method`),
  CONSTRAINT `preparation_t_ibfk_5` FOREIGN KEY (`step4_method`) REFERENCES `method_t` (`method`),
  CONSTRAINT `preparation_t_ibfk_6` FOREIGN KEY (`step5_method`) REFERENCES `method_t` (`method`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_german1_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `preparation_t`
--

LOCK TABLES `preparation_t` WRITE;
/*!40000 ALTER TABLE `preparation_t` DISABLE KEYS */;
INSERT INTO `preparation_t` VALUES (1,18,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(1,19,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(1,20,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(1,21,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(1,22,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(1,23,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(1,24,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(1,25,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(1,26,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(1,27,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(1,28,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(1,29,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(1,30,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(1,31,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(1,32,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(1,33,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(1,34,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(1,35,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(1,36,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(1,37,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(1,38,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(1,39,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(1,40,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(1,1000,'','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,''),(2,18,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(2,19,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(2,20,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(2,21,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(2,22,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(2,23,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(2,24,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(2,25,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(2,26,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(2,27,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(2,28,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(2,29,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(2,30,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(2,31,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(2,32,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(2,33,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(2,34,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(2,35,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(2,36,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(2,37,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(2,38,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(2,39,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(2,40,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(3,18,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(3,19,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(3,20,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(3,21,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(3,22,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(3,23,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(3,24,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(3,25,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(3,26,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(3,27,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(3,28,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(3,29,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(3,30,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(3,31,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(3,32,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(3,33,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(3,34,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(3,35,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(3,36,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(3,37,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(3,38,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(3,39,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(3,40,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(4,18,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(4,19,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(4,20,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(4,21,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(4,22,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(4,23,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(4,24,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(4,25,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(4,26,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(4,27,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(4,28,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(4,29,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(4,30,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(4,31,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(4,32,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(4,33,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(4,34,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(4,35,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(4,36,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(4,37,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(4,38,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(4,39,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(4,40,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(5,18,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(5,19,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(5,20,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(5,21,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(5,22,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(5,23,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(5,24,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(5,25,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(5,26,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(5,27,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(5,28,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(5,29,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(5,30,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(5,31,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(5,32,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(5,33,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(5,34,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(5,35,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(5,36,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(5,37,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(5,38,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(5,39,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(5,40,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(6,18,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(6,19,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(6,20,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(6,21,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(6,22,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(6,23,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(6,24,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(6,25,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(6,26,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(6,27,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(6,28,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(6,29,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(6,30,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(6,31,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(6,32,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(6,33,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(6,34,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(6,35,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(6,36,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(6,37,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(6,38,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(6,39,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(6,40,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(7,18,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(7,19,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(7,20,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(7,21,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(7,22,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(7,23,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(7,24,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(7,25,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(7,26,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(7,27,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(7,28,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(7,29,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(7,30,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(7,31,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(7,32,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(7,33,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(7,34,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(7,35,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(7,36,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(7,37,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(7,38,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(7,39,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(7,40,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(8,18,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(8,19,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(8,20,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(8,21,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(8,22,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(8,23,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(8,24,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(8,25,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(8,26,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(8,27,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(8,28,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(8,29,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(8,30,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(8,31,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(8,32,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(8,33,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(8,34,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(8,35,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(8,36,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(8,37,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(8,38,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(8,39,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(8,40,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(9,18,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(9,19,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(9,20,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(9,21,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(9,22,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(9,23,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(9,24,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(9,25,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(9,26,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(9,27,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(9,28,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(9,29,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(9,30,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(9,31,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(9,32,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(9,33,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(9,34,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(9,35,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(9,36,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(9,37,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(9,38,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(9,39,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(9,40,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(10,18,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(10,19,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(10,20,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(10,21,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(10,22,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(10,23,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(10,24,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(10,25,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(10,26,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(10,27,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(10,28,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(10,29,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(10,30,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(10,31,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(10,32,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(10,33,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(10,34,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(10,35,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(10,36,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(10,37,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(10,38,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(10,39,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(10,40,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(11,18,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(11,19,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(11,20,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(11,21,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(11,22,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(11,23,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(11,24,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(11,25,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(11,26,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(11,27,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(11,28,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(11,29,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(11,30,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(11,31,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(11,32,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(11,33,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(11,34,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(11,35,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(11,36,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(11,37,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(11,38,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(11,39,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(11,40,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(12,18,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(12,19,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(12,20,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(12,21,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(12,22,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(12,23,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(12,24,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(12,25,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(12,26,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(12,27,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(12,28,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(12,29,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(12,30,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(12,31,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(12,32,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(12,33,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(12,34,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(12,35,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(12,36,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(12,37,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(12,38,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(12,39,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(12,40,NULL,'Do not delete this record. It is used as a default entry for tuning runs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL);
/*!40000 ALTER TABLE `preparation_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_t`
--

DROP TABLE IF EXISTS `project_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `project_t` (
  `project_nr` int(5) NOT NULL AUTO_INCREMENT,
  `project` varchar(30) CHARACTER SET latin1 NOT NULL,
  `advisor` varchar(10) COLLATE latin1_german1_ci DEFAULT NULL,
  `user_nr` int(5) NOT NULL,
  `invoice_nr` int(5) NOT NULL,
  `in_date` date DEFAULT NULL,
  `out_date` date DEFAULT NULL,
  `desired_date` date DEFAULT NULL,
  `priority` smallint(3) DEFAULT NULL,
  `report_type` varchar(20) CHARACTER SET latin1 DEFAULT NULL,
  `letter` varchar(120) CHARACTER SET latin1 DEFAULT NULL,
  `project_comment` text CHARACTER SET latin1,
  `status` varchar(20) CHARACTER SET latin1 DEFAULT NULL,
  `price` varchar(100) CHARACTER SET latin1 DEFAULT NULL,
  `project_type` varchar(20) CHARACTER SET latin1 DEFAULT NULL,
  `research` varchar(20) CHARACTER SET latin1 DEFAULT NULL,
  `invoice` int(8) unsigned DEFAULT NULL,
  `invoice_date` date DEFAULT NULL,
  PRIMARY KEY (`project_nr`),
  KEY `user_nr` (`user_nr`),
  KEY `invoice_nr` (`invoice_nr`),
  KEY `project_type` (`project_type`),
  KEY `report_type` (`report_type`),
  KEY `status` (`status`),
  KEY `research` (`research`),
  KEY `project_t_ibfk_7` (`advisor`),
  CONSTRAINT `project_t_ibfk_1` FOREIGN KEY (`user_nr`) REFERENCES `user_t` (`user_nr`),
  CONSTRAINT `project_t_ibfk_2` FOREIGN KEY (`invoice_nr`) REFERENCES `user_t` (`user_nr`),
  CONSTRAINT `project_t_ibfk_3` FOREIGN KEY (`project_type`) REFERENCES `projecttype_t` (`type`),
  CONSTRAINT `project_t_ibfk_4` FOREIGN KEY (`report_type`) REFERENCES `reporttype_t` (`type`),
  CONSTRAINT `project_t_ibfk_5` FOREIGN KEY (`status`) REFERENCES `projectstatus_t` (`status`),
  CONSTRAINT `project_t_ibfk_6` FOREIGN KEY (`research`) REFERENCES `research_t` (`research`),
  CONSTRAINT `project_t_ibfk_7` FOREIGN KEY (`advisor`) REFERENCES `advisor_t` (`advisor`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 COLLATE=latin1_german1_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_t`
--

LOCK TABLES `project_t` WRITE;
/*!40000 ALTER TABLE `project_t` DISABLE KEYS */;
INSERT INTO `project_t` VALUES (1,'Default',NULL,1,1,NULL,NULL,NULL,1,NULL,NULL,'',NULL,'','undefined',NULL,NULL,NULL);
/*!40000 ALTER TABLE `project_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `projectstatus_t`
--

DROP TABLE IF EXISTS `projectstatus_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `projectstatus_t` (
  `status` varchar(20) CHARACTER SET latin1 NOT NULL,
  `indexnr` int(3) DEFAULT NULL,
  PRIMARY KEY (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_german1_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `projectstatus_t`
--

LOCK TABLES `projectstatus_t` WRITE;
/*!40000 ALTER TABLE `projectstatus_t` DISABLE KEYS */;
INSERT INTO `projectstatus_t` VALUES ('closed',3),('planned',1),('running',2);
/*!40000 ALTER TABLE `projectstatus_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `projecttype_t`
--

DROP TABLE IF EXISTS `projecttype_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `projecttype_t` (
  `type` varchar(20) CHARACTER SET latin1 NOT NULL,
  `indexnr` int(3) DEFAULT NULL,
  PRIMARY KEY (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_german1_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `projecttype_t`
--

LOCK TABLES `projecttype_t` WRITE;
/*!40000 ALTER TABLE `projecttype_t` DISABLE KEYS */;
INSERT INTO `projecttype_t` VALUES ('commercial',40),('EU',10),('internal',30),('Research Contracts',1),('undefined',0);
/*!40000 ALTER TABLE `projecttype_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reporttype_t`
--

DROP TABLE IF EXISTS `reporttype_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reporttype_t` (
  `type` varchar(20) CHARACTER SET latin1 NOT NULL,
  `indexnr` int(3) DEFAULT NULL,
  PRIMARY KEY (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_german1_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reporttype_t`
--

LOCK TABLES `reporttype_t` WRITE;
/*!40000 ALTER TABLE `reporttype_t` DISABLE KEYS */;
INSERT INTO `reporttype_t` VALUES ('standard',10),('undefined',0);
/*!40000 ALTER TABLE `reporttype_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `research_t`
--

DROP TABLE IF EXISTS `research_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `research_t` (
  `research` varchar(20) CHARACTER SET latin1 NOT NULL,
  `indexnr` int(3) DEFAULT NULL,
  PRIMARY KEY (`research`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_german1_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `research_t`
--

LOCK TABLES `research_t` WRITE;
/*!40000 ALTER TABLE `research_t` DISABLE KEYS */;
INSERT INTO `research_t` VALUES ('air',40),('archeology',10),('art',70),('biogeochemistry',120),('bomb peak',90),('climate',20),('environment',130),('geochronology',80),('geology',100),('materials',9),('ocean',110),('physics',150),('plants',60),('reference material',160),('soil',50),('undefined',0),('water',30);
/*!40000 ALTER TABLE `research_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sample_t`
--

DROP TABLE IF EXISTS `sample_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sample_t` (
  `sample_nr` int(5) NOT NULL AUTO_INCREMENT,
  `project_nr` int(5) NOT NULL,
  `photo` varchar(120) CHARACTER SET latin1 DEFAULT NULL,
  `type` varchar(20) CHARACTER SET latin1 NOT NULL DEFAULT 'sample',
  `material` varchar(20) CHARACTER SET latin1 DEFAULT NULL,
  `fraction` varchar(20) CHARACTER SET latin1 DEFAULT NULL,
  `pre_sub_treat` varchar(40) CHARACTER SET latin1 DEFAULT NULL,
  `weight` double DEFAULT NULL,
  `preparation` varchar(100) CHARACTER SET latin1 DEFAULT NULL,
  `sampling_date` date DEFAULT NULL,
  `editable` tinyint(1) DEFAULT '1',
  `not_tobedated` tinyint(1) DEFAULT '0',
  `user_label` varchar(40) CHARACTER SET latin1 DEFAULT NULL,
  `user_label_nr` varchar(40) CHARACTER SET latin1 DEFAULT NULL,
  `user_desc1` varchar(255) CHARACTER SET latin1 DEFAULT NULL,
  `user_desc2` varchar(255) CHARACTER SET latin1 DEFAULT NULL,
  `residue` double DEFAULT NULL,
  `c14_age` double DEFAULT NULL,
  `c14_age_sig` double DEFAULT NULL,
  `av_fm` double DEFAULT NULL,
  `av_fm_sig` double DEFAULT NULL,
  `av_dc13` double DEFAULT NULL,
  `av_dc13_sig` double DEFAULT NULL,
  `av_dc13_irms` double DEFAULT NULL,
  `cal1sMin` int(4) DEFAULT NULL,
  `cal1sMax` int(4) DEFAULT NULL,
  `cal2sMin` int(4) DEFAULT NULL,
  `cal2sMax` int(4) DEFAULT NULL,
  `cal_curve` varchar(20) CHARACTER SET latin1 DEFAULT NULL,
  `delta_R` int(4) DEFAULT NULL,
  `calib` varchar(120) CHARACTER SET latin1 DEFAULT NULL,
  `old_info` varchar(70) CHARACTER SET latin1 DEFAULT NULL,
  `user_comment` varchar(100) CHARACTER SET latin1 DEFAULT NULL,
  PRIMARY KEY (`sample_nr`),
  KEY `type` (`type`),
  KEY `material` (`material`),
  KEY `fraction` (`fraction`),
  KEY `project` (`project_nr`) USING BTREE,
  CONSTRAINT `sample_t_ibfk_1` FOREIGN KEY (`project_nr`) REFERENCES `project_t` (`project_nr`) ON UPDATE CASCADE,
  CONSTRAINT `sample_t_ibfk_2` FOREIGN KEY (`type`) REFERENCES `sampletype_t` (`type`),
  CONSTRAINT `sample_t_ibfk_3` FOREIGN KEY (`material`) REFERENCES `material_t` (`material`),
  CONSTRAINT `sample_t_ibfk_4` FOREIGN KEY (`fraction`) REFERENCES `fraction_t` (`fraction`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=latin1 COLLATE=latin1_german1_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sample_t`
--

LOCK TABLES `sample_t` WRITE;
/*!40000 ALTER TABLE `sample_t` DISABLE KEYS */;
INSERT INTO `sample_t` VALUES (18,1,'Do not delete this record. It is used as a default entry for tuning runs.','sample','undefined','undefined',NULL,NULL,NULL,NULL,1,0,'Tuning default',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Do not delete this record. It is used as a default entry for tuning runs.'),(19,1,'Do not delete this record. It is used as a default entry for tuning runs.','sample','undefined','undefined',NULL,NULL,NULL,NULL,1,0,'Tuning default',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Do not delete this record. It is used as a default entry for tuning runs.'),(20,1,'Do not delete this record. It is used as a default entry for tuning runs.','sample','undefined','undefined',NULL,NULL,NULL,NULL,1,0,'Tuning default',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Do not delete this record. It is used as a default entry for tuning runs.'),(21,1,'Do not delete this record. It is used as a default entry for tuning runs.','sample','undefined','undefined',NULL,NULL,NULL,NULL,1,0,'Tuning default',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Do not delete this record. It is used as a default entry for tuning runs.'),(22,1,'Do not delete this record. It is used as a default entry for tuning runs.','sample','undefined','undefined',NULL,NULL,NULL,NULL,1,0,'Tuning default',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Do not delete this record. It is used as a default entry for tuning runs.'),(23,1,'Do not delete this record. It is used as a default entry for tuning runs.','sample','undefined','undefined',NULL,NULL,NULL,NULL,1,0,'Tuning default',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Do not delete this record. It is used as a default entry for tuning runs.'),(24,1,'Do not delete this record. It is used as a default entry for tuning runs.','sample','undefined','undefined',NULL,NULL,NULL,NULL,1,0,'Tuning default',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Do not delete this record. It is used as a default entry for tuning runs.'),(25,1,'Do not delete this record. It is used as a default entry for tuning runs.','sample','undefined','undefined',NULL,NULL,NULL,NULL,1,0,'Tuning default',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Do not delete this record. It is used as a default entry for tuning runs.'),(26,1,'Do not delete this record. It is used as a default entry for tuning runs.','sample','undefined','undefined',NULL,NULL,NULL,NULL,1,0,'Tuning default',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Do not delete this record. It is used as a default entry for tuning runs.'),(27,1,'Do not delete this record. It is used as a default entry for tuning runs.','sample','undefined','undefined',NULL,NULL,NULL,NULL,1,0,'Tuning default',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Do not delete this record. It is used as a default entry for tuning runs.'),(28,1,'Do not delete this record. It is used as a default entry for tuning runs.','sample','undefined','undefined',NULL,NULL,NULL,NULL,1,0,'Tuning default',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Do not delete this record. It is used as a default entry for tuning runs.'),(29,1,'Do not delete this record. It is used as a default entry for tuning runs.','sample','undefined','undefined',NULL,NULL,NULL,NULL,1,0,'Tuning default',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Do not delete this record. It is used as a default entry for tuning runs.'),(30,1,'Do not delete this record. It is used as a default entry for tuning runs.','sample','undefined','undefined',NULL,NULL,NULL,NULL,1,0,'Tuning default',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Do not delete this record. It is used as a default entry for tuning runs.'),(31,1,'Do not delete this record. It is used as a default entry for tuning runs.','sample','undefined','undefined',NULL,NULL,NULL,NULL,1,0,'Tuning default',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Do not delete this record. It is used as a default entry for tuning runs.'),(32,1,'Do not delete this record. It is used as a default entry for tuning runs.','sample','undefined','undefined',NULL,NULL,NULL,NULL,1,0,'Tuning default',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Do not delete this record. It is used as a default entry for tuning runs.'),(33,1,'Do not delete this record. It is used as a default entry for tuning runs.','sample','undefined','undefined',NULL,NULL,NULL,NULL,1,0,'Tuning default',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Do not delete this record. It is used as a default entry for tuning runs.'),(34,1,'Do not delete this record. It is used as a default entry for tuning runs.','sample','undefined','undefined',NULL,NULL,NULL,NULL,1,0,'Tuning default',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Do not delete this record. It is used as a default entry for tuning runs.'),(35,1,'Do not delete this record. It is used as a default entry for tuning runs.','sample','undefined','undefined',NULL,NULL,NULL,NULL,1,0,'Tuning default',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Do not delete this record. It is used as a default entry for tuning runs.'),(36,1,'Do not delete this record. It is used as a default entry for tuning runs.','sample','undefined','undefined',NULL,NULL,NULL,NULL,1,0,'Tuning default',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Do not delete this record. It is used as a default entry for tuning runs.'),(37,1,'Do not delete this record. It is used as a default entry for tuning runs.','sample','undefined','undefined',NULL,NULL,NULL,NULL,1,0,'Tuning default',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Do not delete this record. It is used as a default entry for tuning runs.'),(38,1,'Do not delete this record. It is used as a default entry for tuning runs.','sample','undefined','undefined',NULL,NULL,NULL,NULL,1,0,'Tuning default',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Do not delete this record. It is used as a default entry for tuning runs.'),(39,1,'Do not delete this record. It is used as a default entry for tuning runs.','sample','undefined','undefined',NULL,NULL,NULL,NULL,1,0,'Tuning default',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Do not delete this record. It is used as a default entry for tuning runs.'),(40,1,'Do not delete this record. It is used as a default entry for tuning runs.','sample','undefined','undefined',NULL,NULL,NULL,NULL,1,0,'Tuning default',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Do not delete this record. It is used as a default entry for tuning runs.'),(1000,1,NULL,'sample','undefined','bulk','',NULL,'',NULL,1,0,'','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',NULL,'','','');
/*!40000 ALTER TABLE `sample_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sampletype_t`
--

DROP TABLE IF EXISTS `sampletype_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sampletype_t` (
  `type` varchar(20) CHARACTER SET latin1 NOT NULL,
  `indexnr` int(3) DEFAULT NULL,
  `f14c` double DEFAULT NULL,
  `f14c_sig` double DEFAULT NULL,
  `d13c` double DEFAULT NULL,
  `d13c_sig` double DEFAULT NULL,
  `d13c_nom` double DEFAULT '-25',
  `blank` smallint(6) NOT NULL DEFAULT '0',
  `active` smallint(6) NOT NULL DEFAULT '0',
  PRIMARY KEY (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_german1_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sampletype_t`
--

LOCK TABLES `sampletype_t` WRITE;
/*!40000 ALTER TABLE `sampletype_t` DISABLE KEYS */;
INSERT INTO `sampletype_t` VALUES ('bl',30,NULL,NULL,NULL,NULL,-25,1,1),('bl_carb',40,NULL,NULL,NULL,NULL,-25,1,1),('co2atm',90,NULL,NULL,NULL,NULL,-25,0,0),('cstd',275,0.9447,0.0002,0.57,0.1,-25,0,0),('IAEA-C1',200,0,0.0001,2.42,0.33,-25,1,1),('IAEA-C2',210,0.4114,0.0003,-8.25,0.31,-25,0,0),('IAEA-C3',220,1.2941,0.0006,-24.724,0.041,-25,0,0),('IAEA-C4',230,0.0032,0.0012,-23.96,0.62,-25,0,0),('IAEA-C5',240,0.2305,0.0002,-25.49,0.72,-25,0,0),('IAEA-C6',250,1.506,0.002,-10.449,0.033,-25,0,0),('IAEA-C7',260,0.4953,0.0012,-14.48,0.21,-25,0,0),('IAEA-C8',270,0.1503,0.0017,-18.31,0.11,-25,0,0),('IAEA-C9',271,0.0017,0.0005,-23.9,1.5,-25,0,0),('lnz',110,1.0462,0.0025,-28.8,0.1,-25,0,1),('nb',400,NULL,NULL,NULL,NULL,-25,0,0),('oxa1',10,1.0526,0,-19.2,0.1,-19,0,1),('oxa2',20,1.34066,0.0005,-17.8,0.1,-25,0,1),('sample',0,NULL,NULL,NULL,NULL,-25,0,0),('sample_hp',60,NULL,NULL,NULL,NULL,-25,0,0),('standard',280,NULL,NULL,NULL,NULL,-25,0,0),('tree_hp',80,NULL,NULL,NULL,NULL,-25,0,0),('wilhelm',100,9.9278,0.0002,-23.5,NULL,-23.5,0,1);
/*!40000 ALTER TABLE `sampletype_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `target_t`
--

DROP TABLE IF EXISTS `target_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `target_t` (
  `target_nr` int(5) NOT NULL,
  `sample_nr` int(5) NOT NULL,
  `prep_nr` int(5) NOT NULL,
  `magazine` varchar(12) CHARACTER SET latin1 DEFAULT NULL,
  `position` smallint(2) DEFAULT NULL,
  `precis` smallint(3) DEFAULT NULL,
  `cycle_min` smallint(3) DEFAULT NULL,
  `cycle_max` smallint(3) DEFAULT NULL,
  `combustion` tinyint(1) DEFAULT '0',
  `catalyst` double DEFAULT NULL,
  `cathode_nr` varchar(12) CHARACTER SET latin1 DEFAULT NULL,
  `reactor_nr` smallint(6) DEFAULT '0',
  `co2_init` double DEFAULT NULL,
  `co2_final` double DEFAULT NULL,
  `hydro_init` smallint(3) DEFAULT NULL,
  `hydro_final` smallint(3) DEFAULT NULL,
  `react_time` smallint(3) DEFAULT NULL,
  `target_comment` text CHARACTER SET latin1,
  `target_pressed` date DEFAULT NULL,
  `stop` tinyint(1) DEFAULT '0',
  `old_info` varchar(8) CHARACTER SET latin1 DEFAULT NULL,
  `meas_comment` varchar(80) CHARACTER SET latin1 DEFAULT NULL,
  `fm` double DEFAULT NULL,
  `fm_sig` double DEFAULT NULL,
  `dc13` double DEFAULT NULL,
  `dc13_sig` double DEFAULT NULL,
  `calcset` varchar(20) CHARACTER SET latin1 DEFAULT NULL,
  `editallowed` tinyint(1) DEFAULT '1',
  `c14_age` double DEFAULT NULL,
  `c14_age_sig` double DEFAULT NULL,
  `cal1sMin` int(4) DEFAULT NULL,
  `cal1sMax` int(4) DEFAULT NULL,
  `cal2sMin` int(4) DEFAULT NULL,
  `cal2sMax` int(4) DEFAULT NULL,
  `weight` double DEFAULT NULL,
  `conc_n` double DEFAULT NULL,
  `graphitized` date DEFAULT NULL,
  `temp` double DEFAULT NULL,
  `conc_c` double DEFAULT NULL,
  PRIMARY KEY (`target_nr`,`sample_nr`,`prep_nr`),
  KEY `magaz_posi` (`magazine`,`position`) USING BTREE,
  KEY `FK_target_t_2` (`sample_nr`),
  KEY `FK_target_t_1` (`prep_nr`,`sample_nr`),
  CONSTRAINT `FK_target_t_1` FOREIGN KEY (`prep_nr`, `sample_nr`) REFERENCES `preparation_t` (`prep_nr`, `sample_nr`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_german1_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `target_t`
--

LOCK TABLES `target_t` WRITE;
/*!40000 ALTER TABLE `target_t` DISABLE KEYS */;
INSERT INTO `target_t`
VALUES (1,18,1,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
       (1,1000,1,'TEST1',1,NULL,NULL,100,0,NULL,'',0,NULL,NULL,NULL,NULL,NULL,'','2019-11-18',0,'','',NULL,NULL,NULL,NULL,'',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
       (2,1000,1,'TEST1',2,NULL,NULL,100,0,NULL,'',0,NULL,NULL,NULL,NULL,NULL,'','2019-11-18',0,'','',NULL,NULL,NULL,NULL,'',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
       (3,1000,1,'TEST1',4,NULL,NULL,100,0,NULL,'',0,NULL,NULL,NULL,NULL,NULL,'','2019-11-18',0,'','',NULL,NULL,NULL,NULL,'',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
       (4,1000,1,'TEST2',1,NULL,NULL,100,0,NULL,'',0,NULL,NULL,NULL,NULL,NULL,'','2019-11-18',0,'','',NULL,NULL,NULL,NULL,'',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
       (5,1000,1,'TEST2',2,NULL,NULL,100,0,NULL,'',0,NULL,NULL,NULL,NULL,NULL,'','2019-11-18',0,'','',NULL,NULL,NULL,NULL,'',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `target_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_t`
--

DROP TABLE IF EXISTS `user_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_t` (
  `user_nr` int(5) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(40) CHARACTER SET latin1 DEFAULT NULL,
  `last_name` varchar(60) CHARACTER SET latin1 NOT NULL,
  `organisation` varchar(255) CHARACTER SET latin1 DEFAULT NULL,
  `institute` varchar(255) CHARACTER SET latin1 DEFAULT NULL,
  `address_1` varchar(80) CHARACTER SET latin1 DEFAULT NULL,
  `address_2` varchar(80) CHARACTER SET latin1 DEFAULT NULL,
  `town` varchar(30) CHARACTER SET latin1 DEFAULT NULL,
  `postcode` varchar(10) CHARACTER SET latin1 DEFAULT NULL,
  `country` varchar(30) CHARACTER SET latin1 DEFAULT NULL,
  `phone_1` varchar(30) CHARACTER SET latin1 DEFAULT NULL,
  `phone_2` varchar(30) CHARACTER SET latin1 DEFAULT NULL,
  `fax` varchar(30) CHARACTER SET latin1 DEFAULT NULL,
  `email` varchar(80) CHARACTER SET latin1 DEFAULT NULL,
  `www` varchar(60) CHARACTER SET latin1 DEFAULT NULL,
  `account` varchar(40) CHARACTER SET latin1 DEFAULT NULL,
  `invoice` tinyint(1) DEFAULT '1',
  `correspondance` tinyint(1) DEFAULT '1',
  `user_comment` text CHARACTER SET latin1,
  `language` varchar(2) COLLATE latin1_german1_ci DEFAULT NULL,
  `title` varchar(20) COLLATE latin1_german1_ci DEFAULT NULL,
  `salutation` varchar(10) COLLATE latin1_german1_ci DEFAULT NULL,
  PRIMARY KEY (`user_nr`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 COLLATE=latin1_german1_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_t`
--

LOCK TABLES `user_t` WRITE;
/*!40000 ALTER TABLE `user_t` DISABLE KEYS */;
INSERT INTO `user_t` VALUES (1,'Default','Default','Default','Default',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,1,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `user_t` ENABLE KEYS */;
UNLOCK TABLES;

-- Dump completed on 2019-11-19  9:17:34
