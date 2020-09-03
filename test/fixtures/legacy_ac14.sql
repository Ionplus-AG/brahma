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
-- Table structure for table `workana`
--

DROP TABLE IF EXISTS `workana`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `workana` (
  `RECNO` int(11) NOT NULL,
  `RUN` varchar(8) NOT NULL,
  `CYCLE` smallint(6) NOT NULL,
  `RUNTIME` double DEFAULT NULL,
  `TIMEDAT` datetime DEFAULT NULL,
  `R` int(11) DEFAULT NULL,
  `G1` int(11) DEFAULT NULL,
  `G2` int(11) DEFAULT NULL,
  `A` double DEFAULT NULL,
  `B` double DEFAULT NULL,
  `ANA` double DEFAULT NULL,
  `ANB` double DEFAULT NULL,
  `ISO` double DEFAULT NULL,
  `RA` double DEFAULT NULL,
  `BA` double DEFAULT NULL,
  `RB` double DEFAULT NULL,
  `G1A` double DEFAULT NULL,
  `G1B` double DEFAULT NULL,
  `G2A` double DEFAULT NULL,
  `G2B` double DEFAULT NULL,
  `ANBANA` double DEFAULT NULL,
  `TRA` double DEFAULT NULL,
  `SCA1` double DEFAULT NULL,
  `SCA2` double DEFAULT NULL,
  `SCA3` double DEFAULT NULL,
  `SCA4` double DEFAULT NULL,
  `SCA5` double DEFAULT NULL,
  `SCA6` double DEFAULT NULL,
  `SCA7` double DEFAULT NULL,
  `SCA8` double DEFAULT NULL,
  `SCA9` double DEFAULT NULL,
  `SCA10` double DEFAULT NULL,
  `SCA11` double DEFAULT NULL,
  `SCA12` double DEFAULT NULL,
  `SCA13` double DEFAULT NULL,
  `SCA14` double DEFAULT NULL,
  `SCA15` double DEFAULT NULL,
  `SCA16` double DEFAULT NULL,
  `CYCLTRUE` varchar(1) DEFAULT NULL,
  `AGE` double DEFAULT NULL,
  `AGEDEL` double DEFAULT NULL,
  `SCANDEV1` varchar(20) DEFAULT NULL,
  `SCANDAC1` double DEFAULT NULL,
  `SCANADC1` double DEFAULT NULL,
  `SCANDEV2` varchar(20) DEFAULT NULL,
  `SCANDAC2` double DEFAULT NULL,
  `SCANADC2` double DEFAULT NULL,
  `STRIPPR` double DEFAULT NULL,
  `DEV1ADC1` double DEFAULT NULL,
  `DEV1ADC2` double DEFAULT NULL,
  `DEV2ADC1` double DEFAULT NULL,
  `DEV2ADC2` double DEFAULT NULL,
  `DEV3ADC1` double DEFAULT NULL,
  `DEV3ADC2` double DEFAULT NULL,
  `DEV4ADC1` double DEFAULT NULL,
  `DEV4ADC2` double DEFAULT NULL,
  `DEV5ADC1` double DEFAULT NULL,
  `DEV5ADC2` double DEFAULT NULL,
  `DEV6ADC1` double DEFAULT NULL,
  `DEV6ADC2` double DEFAULT NULL,
  `DEV7ADC1` double DEFAULT NULL,
  `DEV7ADC2` double DEFAULT NULL,
  `DEV8ADC1` double DEFAULT NULL,
  `DEV8ADC2` double DEFAULT NULL,
  `DEV9ADC1` double DEFAULT NULL,
  `DEV9ADC2` double DEFAULT NULL,
  `DEV10ADC1` double DEFAULT NULL,
  `DEV10ADC2` double DEFAULT NULL,
  `DEV11ADC1` double DEFAULT NULL,
  `DEV11ADC2` double DEFAULT NULL,
  `DEV12ADC1` double DEFAULT NULL,
  `DEV12ADC2` double DEFAULT NULL,
  `DEV13ADC1` double DEFAULT NULL,
  `DEV13ADC2` double DEFAULT NULL,
  `DEV14ADC1` double DEFAULT NULL,
  `DEV14ADC2` double DEFAULT NULL,
  `DEV15ADC1` double DEFAULT NULL,
  `DEV15ADC2` double DEFAULT NULL,
  `DEV16ADC1` double DEFAULT NULL,
  `DEV16ADC2` double DEFAULT NULL,
  `DEV17ADC1` double DEFAULT NULL,
  `DEV17ADC2` double DEFAULT NULL,
  `DEV18ADC1` double DEFAULT NULL,
  `DEV18ADC2` double DEFAULT NULL,
  `DEV19ADC1` double DEFAULT NULL,
  `DEV19ADC2` double DEFAULT NULL,
  `DEV20ADC1` double DEFAULT NULL,
  `DEV20ADC2` double DEFAULT NULL,
  `DEV21ADC1` double DEFAULT NULL,
  `DEV21ADC2` double DEFAULT NULL,
  `DEV22ADC1` double DEFAULT NULL,
  `DEV22ADC2` double DEFAULT NULL,
  `DEV23ADC1` double DEFAULT NULL,
  `DEV23ADC2` double DEFAULT NULL,
  `DEV24ADC1` double DEFAULT NULL,
  `DEV24ADC2` double DEFAULT NULL,
  `DEV25ADC1` double DEFAULT NULL,
  `DEV25ADC2` double DEFAULT NULL,
  PRIMARY KEY (`RUN`,`CYCLE`),
  KEY `Run_Index` (`RUN`),
  KEY `Recno_Index` (`RECNO`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `workana`
--

LOCK TABLES `workana` WRITE;
/*!40000 ALTER TABLE `workana` DISABLE KEYS */;
INSERT INTO `workana` VALUES (1,'AC10000',1,10,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(2,'AC10001',1,10.008198,'2019-11-18 21:21:24',256,0,0,4.3893196557462195,0.04911899033272523,9.035228959299166,NULL,0.00018239227681146996,0.0000000000009336782114590884,1.119057033552381,0.00000000008343437228531431,0,0,0,0,NULL,48.58006006841342,46214,44930,50065,19255,256,10008198,0,0,0,0,0,0,0,0,0,NULL,NULL,NULL,NULL,'',0,0,'',0,0,-1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(3,'AC10001',2,10.00307,'2019-11-18 21:21:34',256,0,0,4.389321778214089,0.049118642741678306,9.03516480440505,NULL,0.00018240093291359554,0.0000000000009341564029884917,1.119048573414536,0.00000000008347773503147541,0,0,0,0,NULL,48.58042850611975,46190,44907,50039,19246,256,10003070,0,0,0,0,0,0,0,0,0,NULL,NULL,NULL,NULL,'',0,0,'',0,0,-1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(4,'AC10001',3,10.002704,'2019-11-18 21:21:44',256,0,0,4.389286097039361,0.0491194733823974,9.035102828195258,NULL,0.00018239797558740117,0.0000000000009341981780477697,1.1190765946090693,0.00000000008347937777879418,0,0,0,0,NULL,48.58036682595356,46188,44905,50038,19245,256,10002704,0,0,0,0,0,0,0,0,0,NULL,NULL,NULL,NULL,'',0,0,'',0,0,-1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(5,'AC10001',4,9.996573,'2019-11-18 21:21:55',256,0,0,4.389338496302684,0.04911914327389996,9.03516489100815,NULL,0.0001823959340866115,0.0000000000009347599721445264,1.1190557145518623,0.00000000008353113790396586,0,0,0,0,NULL,48.5806130740456,46160,44878,50007,19233,256,9996573,0,0,0,0,0,0,0,0,0,NULL,NULL,NULL,NULL,'',0,0,'',0,0,-1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(6,'AC10001',5,10.000487,'2019-11-18 21:22:05',256,0,0,4.389381367127421,0.049118563852440386,9.035150248182916,NULL,0.00018240063008931467,0.000000000000934384998736774,1.1190315842750627,0.00000000008349943038847223,0,0,0,0,NULL,48.581166295604014,46178,44896,50026,19241,256,10000487,0,0,0,0,0,0,0,0,0,NULL,NULL,NULL,NULL,'',0,0,'',0,0,-1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(7,'AC10001',6,9.994890999999999,'2019-11-18 21:22:15',256,0,0,4.389293580090069,0.049118557035289334,9.03511822189957,NULL,0.00018239829628957438,0.0000000000009349268462702129,1.11905380989078,0.00000000008354619214972888,0,0,0,0,NULL,48.58036687833456,46152,44870,49998,19230,256,9994891,0,0,0,0,0,0,0,0,0,NULL,NULL,NULL,NULL,'',0,0,'',0,0,-1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(8,'AC10001',7,9.990666,'2019-11-18 21:22:26',256,0,0,4.389290303569353,0.04911869211421942,9.035220154492205,NULL,0.00018239958577336086,0.0000000000009353229201064142,1.1190577227092111,0.0000000000835812935406067,0,0,0,0,NULL,48.57978254560902,46133,44851,49977,19222,256,9990666,0,0,0,0,0,0,0,0,0,NULL,NULL,NULL,NULL,'',0,0,'',0,0,-1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(9,'AC10001',8,10.007501999999999,'2019-11-18 21:22:36',256,0,0,4.389332103056288,0.04911947164137465,9.035271699171282,NULL,0.00018239566477228783,0.0000000000009337404988303825,1.1190648255385551,0.00000000008343935735635472,0,0,0,0,NULL,48.57996803193953,46211,44927,50062,19254,256,10007502,0,0,0,0,0,0,0,0,0,NULL,NULL,NULL,NULL,'',0,0,'',0,0,-1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(10,'AC10001',9,10.016138999999999,'2019-11-18 21:22:46',256,0,0,4.389354630561737,0.049119265837365075,9.035295157145883,NULL,0.00018239948646878805,0.0000000000009329305385205868,1.1190543934491557,0.00000000008336775620397708,0,0,0,0,NULL,48.580091233547144,46251,44966,50105,19271,256,10016139,0,0,0,0,0,0,0,0,0,NULL,NULL,NULL,NULL,'',0,0,'',0,0,-1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11,'AC10001',10,9.999609,'2019-11-18 21:22:57',256,0,0,4.389375534583403,0.049118955936677124,9.035161094798807,NULL,0.00018239752274313924,0.000000000000934468282654929,1.1190420038038285,0.00000000008350609534570644,0,0,0,0,NULL,48.581043420578254,46174,44892,50022,19239,256,9999609,0,0,0,0,0,0,0,0,0,NULL,NULL,NULL,NULL,'',0,0,'',0,0,-1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(12,'AC10001',11,9.996641,'2019-11-18 21:23:07',256,0,0,4.389307958543275,0.04911880299542616,9.035102070785578,NULL,0.00018239462535465662,0.0000000000009347601170079924,1.1190557477249268,0.0000000000835311483729374,0,0,0,0,NULL,48.580612860321956,46160,44878,50007,19233,256,9996641,0,0,0,0,0,0,0,0,0,NULL,NULL,NULL,NULL,'',0,0,'',0,0,-1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(13,'AC10001',12,10.011555999999999,'2019-11-18 21:23:17',256,0,0,4.389312150878446,0.049119192043674334,9.035127886214692,NULL,0.00018239766525802783,0.000000000000933366640083952,1.119063542424158,0.00000000008340604484907602,0,0,0,0,NULL,48.58052045478427,46229,44945,50082,19262,256,10011556,0,0,0,0,0,0,0,0,0,NULL,NULL,NULL,NULL,'',0,0,'',0,0,-1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `workana` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `workconfig`
--

DROP TABLE IF EXISTS `workconfig`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `workconfig` (
  `VARNAME` varchar(20) NOT NULL,
  `IVALUE` int(11) DEFAULT NULL,
  `FVALUE` double DEFAULT NULL,
  `CVALUE` varchar(100) DEFAULT NULL,
  `VARITYPE` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`VARNAME`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `workconfig`
--

LOCK TABLES `workconfig` WRITE;
/*!40000 ALTER TABLE `workconfig` DISABLE KEYS */;
INSERT INTO `workconfig` VALUES ('1-DUMMY',NULL,NULL,'VARITYPE=1:  READ ONLY CONST.',1),('5-DUMMY',NULL,NULL,'VARITYPE=5:  R/W VARIABLES',5),('ACCURACY',1,NULL,NULL,5),('ACTBARCODE',NULL,NULL,' ',5),('ACTCOMMENT',NULL,NULL,'',5),('ACTCYCLE',13,NULL,NULL,5),('ACTLABEL',NULL,NULL,'1000.1.1',5),('ACTMAGAZ',NULL,NULL,'TEST',5),('ACTPASS',6,NULL,NULL,5),('ACTPREP_NR',1,NULL,NULL,5),('ACTRUN',NULL,NULL,'AC10001',5),('ACTSAMPLE_NR',1000,NULL,NULL,5),('ACTSAMPTYPE',NULL,NULL,'sample',5),('ACTSEQU',1,NULL,'SEQUENCE NR OF MEASPROG',5),('ACTSEQURECNO',1,NULL,'RECNO OF MEASPROG',5),('ACTTARGET_NR',1,NULL,NULL,5),('ACTUSLABEL',NULL,NULL,'',5),('ACTUSNAME',NULL,NULL,'--',5),('AGE_AVAIL',1,NULL,NULL,1),('ANA_AVAIL',1,NULL,NULL,1),('ANA_FMAX',NULL,0.1,'MHz',1),('ANA_IMAX',NULL,100,'uA (is calculated by squirrel)',1),('ANA_K',NULL,1,NULL,1),('ANA_NR',1,NULL,'Base 1, Scaler is NOT cascaded',1),('ANA_OFFS',NULL,0.1,NULL,1),('ANA_QMAX',NULL,101000,'pC (= uA * usec), IntTimeB=505 usec',1),('ANB_AVAIL',0,NULL,'Current ANA B, C13 + C12H, LE',1),('ANB_FMAX',NULL,0.1,'MHz',1),('ANB_IMAX',NULL,0.01,'uA (20000 USEC)',1),('ANB_K',NULL,1,NULL,1),('ANB_NR',2,NULL,'Base 1, Scaler is NOT cascaded',1),('ANB_OFFS',NULL,0,NULL,1),('ANB_QMAX',NULL,200,'pC (= uA * usec), IntTimeC=1 usec',1),('ATOMGR_AVAIL',0,NULL,NULL,1),('A_AVAIL',1,NULL,NULL,1),('A_FMAX',NULL,0.1,'MHz',1),('A_IMAX',NULL,40,'uA (is calculated by squirrel)',1),('A_K',NULL,1,NULL,1),('A_NR',2,NULL,'Base 1, Scaler is NOT cascaded',1),('A_OFFS',NULL,0.0135,'uA',1),('A_QMAX',NULL,2000,'pC (= uA * usec), IntTimeA=20 usec',1),('BARCODE_AVAIL',0,NULL,'COM3',1),('BINARYFILES',0,NULL,NULL,1),('BURNINCYCLE',2,NULL,NULL,5),('BURNINTIME',4,NULL,'Burn in time in sec.',5),('B_AVAIL',1,NULL,NULL,1),('B_FMAX',NULL,0.1,'MHz',1),('B_IMAX',NULL,0.4,'uA (is calculated by squirrel)',1),('B_K',NULL,1,NULL,1),('B_NR',3,NULL,'Base 1, Scaler is NOT cascaded',1),('B_OFFS',NULL,0.00042,NULL,1),('B_QMAX',NULL,505,'pC (= uA * usec), IntTimeB=505 usec',1),('CHARGE',1,NULL,NULL,1),('CHECKDEVFILE',NULL,NULL,'micadas_test.chd',5),('CHECKSTRIPPER',0,NULL,'Check the Stripper Pressure',5),('DATAPATH',NULL,NULL,'C:\\Micadas\\Data\\',1),('DELETECYCLEFILE',1,NULL,'1 = DELETE FILES; 0=DON\'T DEL.',1),('G12_AVAIL',0,NULL,NULL,1),('G_AVAIL',1,NULL,NULL,1),('HOMEPOSITION',1,NULL,'192.168.1.10',5),('ISOTOP',NULL,NULL,'C14',1),('ISO_AVAIL',1,NULL,'Current BH, C13H, HE-side',1),('ISO_FMAX',NULL,0.1,'MHz',1),('ISO_IMAX',NULL,0.01,'uA (is calculated by squirrel)',1),('ISO_K',NULL,1,NULL,1),('ISO_NR',4,NULL,'Base 1, Scaler is NOT cascaded',1),('ISO_OFFS',NULL,0.000009,'uA',1),('ISO_QMAX',NULL,0.01,'pC (= uA * usec),  IntTimeC=1',1),('MAILADDRESS',NULL,NULL,'fahrni@ionplus.ch',5),('MAILCONFIG',0,NULL,'1111111',5),('MAXCYCLE',10,NULL,NULL,5),('MAXPASS',26,NULL,NULL,5),('MEASPROG',0,0,NULL,5),('MEASSTATUS',0,NULL,NULL,5),('MINCYCLE',10,NULL,NULL,5),('MPACONFIG',0,NULL,'C:\\Micadas\\Squirrel\\init.mpa',5),('MPAFORMAT',0,NULL,'0=binary, 1=asc, 2=spe, 3=csv',5),('MPAGATE1ADC',400,1,'sca_5',5),('MPAGATE2ADC',1,1,'None',5),('MPAGATE3ADC',1,2,'None',5),('MPAHOST',NULL,NULL,'unknown',5),('MPA_PORT',49153,NULL,NULL,1),('OPERATIONMODE',1,1,'IVALUE: 1=Single, 2=Auto, 3=Scan; FVALUE: 1=ReadFromDB, 0=Don\'t ReadFromDB',5),('PANDA3_HOST',NULL,NULL,'127.0.0.1',1),('PANDA3_PORT',50000,NULL,NULL,1),('PANDA_CHANGERFILE',NULL,NULL,'unknown',5),('PANDA_CONFIGCHANGER',0,NULL,NULL,1),('REF_F',NULL,1000,'KHZ',1),('REF_NR',6,NULL,'Base 1, Scaler is NOT cascaded',1),('RUNPREFIX',NULL,NULL,'AC',5),('RUNTIME',10,NULL,NULL,5),('SAMPCHANG_PORT',2000,NULL,NULL,1),('SCANDEV2CYCLES',1,NULL,NULL,5),('SCANDEVICE1',7,NULL,'LE-Magnet',5),('SCANDEVICE2',0,NULL,'none',5),('SCANSTEP1',250,NULL,NULL,5),('SCANSTEP2',250,NULL,NULL,5),('SCANWAITTIME',2000,NULL,'Milliseconds',5),('SMSPROVIDER',NULL,NULL,'unknown.ch',1),('SMTPFROM',NULL,NULL,'squirrel@ionplus.ch',1),('SMTPHOST',25,1,'mail.unknown.ch',1),('SMTPPASSW',NULL,NULL,'',1),('SMTPSUBJECT',NULL,NULL,'ac14',1),('SMTPUSERNAME',NULL,NULL,'xx',1),('SMTPUSETLS',0,NULL,NULL,1),('SOURCEPOTSTEP1',70,NULL,'Step 1 by reducing the source potentials',1),('SOURCEPOTSTEP2',40,NULL,'Step 2 by reducing the source potentials',1),('STRIPPR',20,0.0000005715,'IVALUE=Deviation',5),('TCPSERVER_PORT',50001,NULL,NULL,1),('UNCOMPRESSED',1,NULL,NULL,1),('USEMPA',0,NULL,NULL,1),('USEPANDA',1,NULL,NULL,1),('WRITELOGFILE',1,NULL,'C:\\Micadas\\Logfiles\\',1);
/*!40000 ALTER TABLE `workconfig` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `workfinal`
--

DROP TABLE IF EXISTS `workfinal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `workfinal` (
  `RECNO` int(11) NOT NULL,
  `RUNTIME` double DEFAULT NULL,
  `R` int(11) DEFAULT NULL,
  `RDEL` double DEFAULT NULL,
  `G1` int(11) DEFAULT NULL,
  `G1DEL` double DEFAULT NULL,
  `G2` int(11) DEFAULT NULL,
  `G2DEL` double DEFAULT NULL,
  `A` double DEFAULT NULL,
  `B` double DEFAULT NULL,
  `ANA` double DEFAULT NULL,
  `ANB` double DEFAULT NULL,
  `ISO` double DEFAULT NULL,
  `RA` double DEFAULT NULL,
  `RADEL` double DEFAULT NULL,
  `RASIG` double DEFAULT NULL,
  `BA` double DEFAULT NULL,
  `BADEL` double DEFAULT NULL,
  `BASIG` double DEFAULT NULL,
  `RB` double DEFAULT NULL,
  `RBDEL` double DEFAULT NULL,
  `RBSIG` double DEFAULT NULL,
  `G1A` double DEFAULT NULL,
  `G1B` double DEFAULT NULL,
  `G2A` double DEFAULT NULL,
  `G2B` double DEFAULT NULL,
  `ANBANA` double DEFAULT NULL,
  `ANBANDEL` double DEFAULT NULL,
  `ANBANSIG` double DEFAULT NULL,
  `TRA` double DEFAULT NULL,
  `TRASIG` double DEFAULT NULL,
  `AGE` double DEFAULT NULL,
  `AGEDEL` double DEFAULT NULL,
  `SAMPLE_NR` int(5) DEFAULT NULL,
  `PREP_NR` int(5) DEFAULT NULL,
  `TARGET_NR` int(5) DEFAULT NULL,
  PRIMARY KEY (`RECNO`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `workfinal`
--

LOCK TABLES `workfinal` WRITE;
/*!40000 ALTER TABLE `workfinal` DISABLE KEYS */;
INSERT INTO `workfinal` VALUES (1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(2,120.02803599999999,3072,1.8042195912175807,0,100,0,100,4.389326143768612,0.04911897939761341,9.035175688453322,NULL,0.00018239754951918067,0.0000000000009342239937560172,NULL,NULL,1.1190551303039098,1,NULL,0.00000000008348328601303889,NULL,NULL,0,0,0,0,NULL,NULL,NULL,48.5804183052023,NULL,NULL,NULL,1000,1,1);
/*!40000 ALTER TABLE `workfinal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `workproto`
--

DROP TABLE IF EXISTS `workproto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `workproto` (
  `RECNO` int(11) NOT NULL,
  `RUN` varchar(8) NOT NULL,
  `TIMEDAT` datetime DEFAULT NULL,
  `RUNTIME` double DEFAULT NULL,
  `CYCLES` smallint(6) DEFAULT NULL,
  `R` int(11) DEFAULT NULL,
  `RDEL` double DEFAULT NULL,
  `G1` int(11) DEFAULT NULL,
  `G1DEL` double DEFAULT NULL,
  `G2` int(11) DEFAULT NULL,
  `G2DEL` double DEFAULT NULL,
  `A` double DEFAULT NULL,
  `B` double DEFAULT NULL,
  `ANA` double DEFAULT NULL,
  `ANB` double DEFAULT NULL,
  `ISO` double DEFAULT NULL,
  `RA` double DEFAULT NULL,
  `RADEL` double DEFAULT NULL,
  `RASIG` double DEFAULT NULL,
  `BA` double DEFAULT NULL,
  `BADEL` double DEFAULT NULL,
  `BASIG` double DEFAULT NULL,
  `RB` double DEFAULT NULL,
  `RBDEL` double DEFAULT NULL,
  `RBSIG` double DEFAULT NULL,
  `G1A` double DEFAULT NULL,
  `G1B` double DEFAULT NULL,
  `G2A` double DEFAULT NULL,
  `G2B` double DEFAULT NULL,
  `ANBANA` double DEFAULT NULL,
  `ANBANDEL` double DEFAULT NULL,
  `ANBANSIG` double DEFAULT NULL,
  `TRA` double DEFAULT NULL,
  `TRASIG` double DEFAULT NULL,
  `AGE` double DEFAULT NULL,
  `AGEDEL` double DEFAULT NULL,
  `RATRUE` varchar(1) DEFAULT NULL,
  `BATRUE` varchar(1) DEFAULT NULL,
  `SAMPLE_NR` int(5) DEFAULT NULL,
  `PREP_NR` int(5) DEFAULT NULL,
  `TARGET_NR` int(5) DEFAULT NULL,
  `MEAS_COMMENT` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`RUN`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `workproto`
--

LOCK TABLES `workproto` WRITE;
/*!40000 ALTER TABLE `workproto` DISABLE KEYS */;
INSERT INTO `workproto` VALUES (1,'AC10000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(2,'AC10001','2019-11-18 06:20:15',120.02803599999999,12,3072,1.8042195912175807,0,100,0,100,4.389326143768612,0.04911897939761341,9.035175688453322,NULL,0.00018239754951918067,0.0000000000009342239937560172,NULL,0.021464940610508434,1.1190551303039098,0.28867513417365703,0.00029190671631099927,0.00000000008348328601303889,NULL,0.021522649053038308,0,0,0,0,NULL,NULL,NULL,48.5804183052023,0.0002459021622200897,NULL,NULL,NULL,NULL,1000,1,1,NULL),(3,'AC10002','2019-11-18 06:20:15',120.02803599999999,12,3072,1.8042195912175807,0,100,0,100,4.389326143768612,0.04911897939761341,9.035175688453322,NULL,0.00018239754951918067,0.0000000000009342239937560172,NULL,0.021464940610508434,1.1190551303039098,0.28867513417365703,0.00029190671631099927,0.00000000008348328601303889,NULL,0.021522649053038308,0,0,0,0,NULL,NULL,NULL,48.5804183052023,0.0002459021622200897,NULL,NULL,NULL,NULL,1000,1,1,NULL),(4,'AC10003','2019-11-18 06:20:15',120.02803599999999,12,3072,1.8042195912175807,0,100,0,100,4.389326143768612,0.04911897939761341,9.035175688453322,NULL,0.00018239754951918067,0.0000000000009342239937560172,NULL,0.021464940610508434,1.1190551303039098,0.28867513417365703,0.00029190671631099927,0.00000000008348328601303889,NULL,0.021522649053038308,0,0,0,0,NULL,NULL,NULL,48.5804183052023,0.0002459021622200897,NULL,NULL,NULL,NULL,1000,1,1,NULL),(5,'AC10004','2019-11-18 06:20:15',120.02803599999999,12,3072,1.8042195912175807,0,100,0,100,4.389326143768612,0.04911897939761341,9.035175688453322,NULL,0.00018239754951918067,0.0000000000009342239937560172,NULL,0.021464940610508434,1.1190551303039098,0.28867513417365703,0.00029190671631099927,0.00000000008348328601303889,NULL,0.021522649053038308,0,0,0,0,NULL,NULL,NULL,48.5804183052023,0.0002459021622200897,NULL,NULL,NULL,NULL,1000,1,1,NULL),(6,'AC10005','2019-11-18 06:20:15',120.02803599999999,12,3072,1.8042195912175807,0,100,0,100,4.389326143768612,0.04911897939761341,9.035175688453322,NULL,0.00018239754951918067,0.0000000000009342239937560172,NULL,0.021464940610508434,1.1190551303039098,0.28867513417365703,0.00029190671631099927,0.00000000008348328601303889,NULL,0.021522649053038308,0,0,0,0,NULL,NULL,NULL,48.5804183052023,0.0002459021622200897,NULL,NULL,NULL,NULL,1000,1,2,NULL),(7,'AC10006','2019-11-18 06:20:15',120.02803599999999,12,3072,1.8042195912175807,0,100,0,100,4.389326143768612,0.04911897939761341,9.035175688453322,NULL,0.00018239754951918067,0.0000000000009342239937560172,NULL,0.021464940610508434,1.1190551303039098,0.28867513417365703,0.00029190671631099927,0.00000000008348328601303889,NULL,0.021522649053038308,0,0,0,0,NULL,NULL,NULL,48.5804183052023,0.0002459021622200897,NULL,NULL,NULL,NULL,1000,1,2,NULL);
/*!40000 ALTER TABLE `workproto` ENABLE KEYS */;
UNLOCK TABLES;

-- Dump completed on 2019-11-19  9:17:34
