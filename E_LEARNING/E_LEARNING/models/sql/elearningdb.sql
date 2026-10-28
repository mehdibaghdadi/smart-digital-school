-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: localhost    Database: elearningdb
-- ------------------------------------------------------
-- Server version	8.2.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `content_type`
--

DROP TABLE IF EXISTS `content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `content_type` (
  `id` int NOT NULL,
  `content_type` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `content_type`
--

LOCK TABLES `content_type` WRITE;
/*!40000 ALTER TABLE `content_type` DISABLE KEYS */;
INSERT INTO `content_type` VALUES (1,'vidéo'),(2,'audio'),(3,'fichier'),(4,'rédaction'),(5,'youtube');
/*!40000 ALTER TABLE `content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `country`
--

DROP TABLE IF EXISTS `country`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `country` (
  `id` int NOT NULL AUTO_INCREMENT,
  `country_fr` varchar(100) NOT NULL,
  `country_en` varchar(100) NOT NULL,
  `country_es` varchar(100) NOT NULL,
  `country_ar` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=196 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `country`
--

LOCK TABLES `country` WRITE;
/*!40000 ALTER TABLE `country` DISABLE KEYS */;
INSERT INTO `country` VALUES (1,'Afghanistan','Afghanistan','Afganistán','Afghanistan'),(2,'Albanie','Albania','Albania','Albania'),(3,'Algérie','Algeria','Argelia','Algeria'),(4,'Andorre','Andorra','Andorra','Andorra'),(5,'Angola','Angola','Angola','Angola'),(6,'Antigua-et-Barbuda','Antigua and Barbuda','Antigua y Barbuda','Antigua and Barbuda'),(7,'Argentine','Argentina','Argentina','Argentina'),(8,'Arménie','Armenia','Armenia','Armenia'),(9,'Australie','Australia','Australia','Australia'),(10,'Autriche','Austria','Austria','Austria'),(11,'Azerbaïdjan','Azerbaijan','Azerbaiyán','Azerbaijan'),(12,'Bahamas','Bahamas','Bahamas','Bahamas'),(13,'Bahreïn','Bahrain','Baréin','Bahrain'),(14,'Bangladesh','Bangladesh','Bangladés','Bangladesh'),(15,'Barbade','Barbados','Barbados','Barbados'),(16,'Biélorussie','Belarus','Bielorrusia','Belarus'),(17,'Belgique','Belgium','Bélgica','Belgium'),(18,'Belize','Belize','Belice','Belize'),(19,'Bénin','Benin','Benín','Benin'),(20,'Bhoutan','Bhutan','Bután','Bhutan'),(21,'Bolivie','Bolivia','Bolivia','Bolivia'),(22,'Bosnie-Herzégovine','Bosnia and Herzegovina','Bosnia y Herzegovina','Bosnia and Herzegovina'),(23,'Botswana','Botswana','Botsuana','Botswana'),(24,'Brésil','Brazil','Brasil','Brazil'),(25,'Brunei','Brunei','Brunéi','Brunei'),(26,'Bulgarie','Bulgaria','Bulgaria','Bulgaria'),(27,'Burkina Faso','Burkina Faso','Burkina Faso','Burkina Faso'),(28,'Burundi','Burundi','Burundi','Burundi'),(29,'Cabo Verde','Cabo Verde','Cabo Verde','Cabo Verde'),(30,'Cambodge','Cambodia','Camboya','Cambodia'),(31,'Cameroun','Cameroon','Camerún','Cameroon'),(32,'Canada','Canada','Canadá','Canada'),(33,'République centrafricaine','Central African Republic','República Centroafricana','Central African Republic'),(34,'Tchad','Chad','Chad','Chad'),(35,'Chili','Chile','Chile','Chile'),(36,'Chine','China','China','China'),(37,'Colombie','Colombia','Colombia','Colombia'),(38,'Comores','Comoros','Comoras','Comoros'),(39,'Congo (République démocratique du)','Congo (Democratic Republic of the)','Congo (República Democrática del)','Congo (Democratic Republic of the)'),(40,'Congo (République du)','Congo','Congo','Congo'),(41,'Costa Rica','Costa Rica','Costa Rica','Costa Rica'),(42,'Croatie','Croatia','Croacia','Croatia'),(43,'Cuba','Cuba','Cuba','Cuba'),(44,'Chypre','Cyprus','Chipre','Cyprus'),(45,'République tchèque','Czech Republic','República Checa','Czech Republic'),(46,'Danemark','Denmark','Dinamarca','Denmark'),(47,'Djibouti','Djibouti','Yibuti','Djibouti'),(48,'Dominique','Dominica','Dominica','Dominica'),(49,'République dominicaine','Dominican Republic','República Dominicana','Dominican Republic'),(50,'Équateur','Ecuador','Ecuador','Ecuador'),(51,'Égypte','Egypt','Egipto','Egypt'),(52,'Salvador','El Salvador','El Salvador','El Salvador'),(53,'Guinée équatoriale','Equatorial Guinea','Guinea Ecuatorial','Equatorial Guinea'),(54,'Érythrée','Eritrea','Eritrea','Eritrea'),(55,'Estonie','Estonia','Estonia','Estonia'),(56,'Éthiopie','Ethiopia','Etiopía','Ethiopia'),(57,'Fidji','Fiji','Fiyi','Fiji'),(58,'Finlande','Finland','Finlandia','Finland'),(59,'France','France','Francia','France'),(60,'Gabon','Gabon','Gabón','Gabon'),(61,'Gambie','Gambia','Gambia','Gambia'),(62,'Géorgie','Georgia','Georgia','Georgia'),(63,'Allemagne','Germany','Alemania','Germany'),(64,'Ghana','Ghana','Ghana','Ghana'),(65,'Grèce','Greece','Grecia','Greece'),(66,'Grenade','Grenada','Granada','Grenada'),(67,'Guatemala','Guatemala','Guatemala','Guatemala'),(68,'Guinée','Guinea','Guinea','Guinea'),(69,'Guinée-Bissau','Guinea-Bissau','Guinea-Bisáu','Guinea-Bissau'),(70,'Guyana','Guyana','Guyana','Guyana'),(71,'Haïti','Haiti','Haití','Haiti'),(72,'Honduras','Honduras','Honduras','Honduras'),(73,'Hongrie','Hungary','Hungría','Hungary'),(74,'Islande','Iceland','Islandia','Iceland'),(75,'Inde','India','India','India'),(76,'Indonésie','Indonesia','Indonesia','Indonesia'),(77,'Iran','Iran','Irán','Iran'),(78,'Irak','Iraq','Irak','Iraq'),(79,'Irlande','Ireland','Irlanda','Ireland'),(80,'Israël','Israel','Israel','Israel'),(81,'Italie','Italy','Italia','Italy'),(82,'Jamaïque','Jamaica','Jamaica','Jamaica'),(83,'Japon','Japan','Japón','Japan'),(84,'Jordanie','Jordan','Jordania','Jordan'),(85,'Kazakhstan','Kazakhstan','Kazajistán','Kazakhstan'),(86,'Kenya','Kenya','Kenia','Kenya'),(87,'Kiribati','Kiribati','Kiribati','Kiribati'),(88,'Kosovo','Kosovo','Kosovo','Kosovo'),(89,'Koweït','Kuwait','Kuwait','Kuwait'),(90,'Kirghizistan','Kyrgyzstan','Kirguistán','Kyrgyzstan'),(91,'Laos','Laos','Laos','Laos'),(92,'Lettonie','Latvia','Letonia','Latvia'),(93,'Liban','Lebanon','Líbano','Lebanon'),(94,'Lesotho','Lesotho','Lesoto','Lesotho'),(95,'Liberia','Liberia','Liberia','Liberia'),(96,'Libye','Libya','Libia','Libya'),(97,'Liechtenstein','Liechtenstein','Liechtenstein','Liechtenstein'),(98,'Lituanie','Lithuania','Lituania','Lithuania'),(99,'Luxembourg','Luxembourg','Luxemburgo','Luxembourg'),(100,'Macédoine (ARYM)','Macedonia (FYROM)','Macedonia del Norte','Macedonia (FYROM)'),(101,'Madagascar','Madagascar','Madagascar','Madagascar'),(102,'Malawi','Malawi','Malawi','Malawi'),(103,'Malaisie','Malaysia','Malasia','Malaysia'),(104,'Maldives','Maldives','Maldivas','Maldives'),(105,'Mali','Mali','Mali','Mali'),(106,'Malte','Malta','Malta','Malta'),(107,'Îles Marshall','Marshall Islands','Islas Marshall','Marshall Islands'),(108,'Mauritanie','Mauritania','Mauritania','Mauritania'),(109,'Maurice','Mauritius','Mauricio','Mauritius'),(110,'Mexique','Mexico','México','Mexico'),(111,'Micronésie','Micronesia','Micronesia','Micronesia'),(112,'Moldavie','Moldova','Moldavia','Moldova'),(113,'Monaco','Monaco','Mónaco','Monaco'),(114,'Mongolie','Mongolia','Mongolia','Mongolia'),(115,'Monténégro','Montenegro','Montenegro','Montenegro'),(116,'Maroc','Morocco','Marruecos','Morocco'),(117,'Mozambique','Mozambique','Mozambique','Mozambique'),(118,'Myanmar (Birmanie)','Myanmar (Burma)','Myanmar (Birmania)','Myanmar (Burma)'),(119,'Namibie','Namibia','Namibia','Namibia'),(120,'Nauru','Nauru','Nauru','Nauru'),(121,'Népal','Nepal','Nepal','Nepal'),(122,'Pays-Bas','Netherlands','Países Bajos','Netherlands'),(123,'Nouvelle-Zélande','New Zealand','Nueva Zelanda','New Zealand'),(124,'Nicaragua','Nicaragua','Nicaragua','Nicaragua'),(125,'Niger','Niger','Níger','Niger'),(126,'Nigéria','Nigeria','Nigeria','Nigeria'),(127,'Corée du Nord','North Korea','Corea del Norte','North Korea'),(128,'Norvège','Norway','Noruega','Norway'),(129,'Oman','Oman','Omán','Oman'),(130,'Pakistan','Pakistan','Pakistán','Pakistan'),(131,'Palau','Palau','Palaos','Palau'),(132,'Palestine','Palestine','Palestina','Palestine'),(133,'Panama','Panama','Panamá','Panama'),(134,'Papouasie-Nouvelle-Guinée','Papua New Guinea','Papúa Nueva Guinea','Papua New Guinea'),(135,'Paraguay','Paraguay','Paraguay','Paraguay'),(136,'Pérou','Peru','Perú','Peru'),(137,'Philippines','Philippines','Filipinas','Philippines'),(138,'Pologne','Poland','Polonia','Poland'),(139,'Portugal','Portugal','Portugal','Portugal'),(140,'Qatar','Qatar','Catar','Qatar'),(141,'Roumanie','Romania','Rumania','Romania'),(142,'Russie','Russia','Rusia','Russia'),(143,'Rwanda','Rwanda','Ruanda','Rwanda'),(144,'Saint-Christophe-et-Niévès','Saint Kitts and Nevis','San Cristóbal y Nieves','Saint Kitts and Nevis'),(145,'Sainte-Lucie','Saint Lucia','Santa Lucía','Saint Lucia'),(146,'Saint-Vincent-et-les-Grenadines','Saint Vincent and the Grenadines','San Vicente y las Granadinas','Saint Vincent and the Grenadines'),(147,'Samoa','Samoa','Samoa','Samoa'),(148,'Saint-Marin','San Marino','San Marino','San Marino'),(149,'Sao Tomé-et-Principe','São Tomé and Príncipe','Santo Tomé y Príncipe','São Tomé and Príncipe'),(150,'Arabie saoudite','Saudi Arabia','Arabia Saudita','Saudi Arabia'),(151,'Sénégal','Senegal','Senegal','Senegal'),(152,'Serbie','Serbia','Serbia','Serbia'),(153,'Seychelles','Seychelles','Seychelles','Seychelles'),(154,'Sierra Leone','Sierra Leone','Sierra Leona','Sierra Leone'),(155,'Singapour','Singapore','Singapur','Singapore'),(156,'Slovaquie','Slovakia','Eslovaquia','Slovakia'),(157,'Slovénie','Slovenia','Eslovenia','Slovenia'),(158,'Îles Salomon','Solomon Islands','Islas Salomón','Solomon Islands'),(159,'Somalie','Somalia','Somalia','Somalia'),(160,'Afrique du Sud','South Africa','Sudáfrica','South Africa'),(161,'Corée du Sud','South Korea','Corea del Sur','South Korea'),(162,'Soudan du Sud','South Sudan','Sudán del Sur','South Sudan'),(163,'Espagne','Spain','España','Spain'),(164,'Sri Lanka','Sri Lanka','Sri Lanka','Sri Lanka'),(165,'Soudan','Sudan','Sudán','Sudan'),(166,'Suriname','Suriname','Surinam','Suriname'),(167,'Swaziland','Swaziland','Suazilandia','Swaziland'),(168,'Suède','Sweden','Suecia','Sweden'),(169,'Suisse','Switzerland','Suiza','Switzerland'),(170,'Syrie','Syria','Siria','Syria'),(171,'Tadjikistan','Tajikistan','Tayikistán','Tajikistan'),(172,'Tanzanie','Tanzania','Tanzania','Tanzania'),(173,'Thaïlande','Thailand','Tailandia','Thailand'),(174,'Timor-Leste','Timor-Leste','Timor Oriental','Timor-Leste'),(175,'Togo','Togo','Togo','Togo'),(176,'Tonga','Tonga','Tonga','Tonga'),(177,'Trinité-et-Tobago','Trinidad and Tobago','Trinidad y Tobago','Trinidad and Tobago'),(178,'Tunisie','Tunisia','Túnez','Tunisia'),(179,'Turquie','Turkey','Turquía','Turkey'),(180,'Turkménistan','Turkmenistan','Turkmenistán','Turkmenistan'),(181,'Tuvalu','Tuvalu','Tuvalu','Tuvalu'),(182,'Ouganda','Uganda','Uganda','Uganda'),(183,'Ukraine','Ukraine','Ucrania','Ukraine'),(184,'Émirats arabes unis','United Arab Emirates','Emiratos Árabes Unidos','United Arab Emirates'),(185,'Royaume-Uni','United Kingdom','Reino Unido','United Kingdom'),(186,'États-Unis','United States','Estados Unidos','United States'),(187,'Uruguay','Uruguay','Uruguay','Uruguay'),(188,'Ouzbékistan','Uzbekistan','Uzbekistán','Uzbekistan'),(189,'Vanuatu','Vanuatu','Vanuatu','Vanuatu'),(190,'Vatican','Vatican City','Ciudad del Vaticano','Vatican City'),(191,'Venezuela','Venezuela','Venezuela','Venezuela'),(192,'Vietnam','Vietnam','Vietnam','Vietnam'),(193,'Yémen','Yemen','Yemen','Yemen'),(194,'Zambie','Zambia','Zambia','Zambia'),(195,'Zimbabwe','Zimbabwe','Zimbabue','Zimbabwe');
/*!40000 ALTER TABLE `country` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `country_city`
--

DROP TABLE IF EXISTS `country_city`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `country_city` (
  `id` int NOT NULL AUTO_INCREMENT,
  `city` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `region_id` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=405 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `country_city`
--

LOCK TABLES `country_city` WRITE;
/*!40000 ALTER TABLE `country_city` DISABLE KEYS */;
INSERT INTO `country_city` VALUES (1,'Aïn Harrouda',6),(2,'Ben Yakhlef',6),(3,'Bouskoura',6),(4,'Casablanca',6),(5,'Médiouna',6),(6,'Mohammadia',6),(7,'Tit Mellil',6),(8,'Ben Yakhlef',6),(9,'Bejaâd',5),(10,'Ben Ahmed',6),(11,'Benslimane',6),(12,'Berrechid',6),(13,'Boujniba',5),(14,'Boulanouare',5),(15,'Bouznika',6),(16,'Deroua',6),(17,'El Borouj',6),(18,'El Gara',6),(19,'Guisser',6),(20,'Hattane',5),(21,'Khouribga',5),(22,'Loulad',6),(23,'Oued Zem',5),(24,'Oulad Abbou',6),(25,'Oulad H\'Riz Sahel',6),(26,'Oulad M\'rah',6),(27,'Oulad Saïd',6),(28,'Oulad Sidi Ben Daoud',6),(29,'Ras El Aïn',6),(30,'Settat',6),(31,'Sidi Rahhal Chataï',6),(32,'Soualem',6),(33,'Azemmour',6),(34,'Bir Jdid',6),(35,'Bouguedra',7),(36,'Echemmaia',7),(37,'El Jadida',6),(38,'Hrara',7),(39,'Ighoud',7),(40,'Jamâat Shaim',7),(41,'Jorf Lasfar',6),(42,'Khemis Zemamra',6),(43,'Laaounate',6),(44,'Moulay Abdallah',6),(45,'Oualidia',6),(46,'Oulad Amrane',6),(47,'Oulad Frej',6),(48,'Oulad Ghadbane',6),(49,'Safi',7),(50,'Sebt El Maârif',6),(51,'Sebt Gzoula',7),(52,'Sidi Ahmed',7),(53,'Sidi Ali Ban Hamdouche',6),(54,'Sidi Bennour',6),(55,'Sidi Bouzid',6),(56,'Sidi Smaïl',6),(57,'Youssoufia',7),(58,'Fès',3),(59,'Aïn Cheggag',3),(60,'Bhalil',3),(61,'Boulemane',3),(62,'El Menzel',3),(63,'Guigou',3),(64,'Imouzzer Kandar',3),(65,'Imouzzer Marmoucha',3),(66,'Missour',3),(67,'Moulay Yaâcoub',3),(68,'Ouled Tayeb',3),(69,'Outat El Haj',3),(70,'Ribate El Kheir',3),(71,'Séfrou',3),(72,'Skhinate',3),(73,'Tafajight',3),(74,'Arbaoua',4),(75,'Aïn Dorij',1),(76,'Dar Gueddari',4),(77,'Had Kourt',4),(78,'Jorf El Melha',4),(79,'Kénitra',4),(80,'Khenichet',4),(81,'Lalla Mimouna',4),(82,'Mechra Bel Ksiri',4),(83,'Mehdia',4),(84,'Moulay Bousselham',4),(85,'Sidi Allal Tazi',4),(86,'Sidi Kacem',4),(87,'Sidi Slimane',4),(88,'Sidi Taibi',4),(89,'Sidi Yahya El Gharb',4),(90,'Souk El Arbaa',4),(91,'Akka',9),(92,'Assa',10),(93,'Bouizakarne',10),(94,'El Ouatia',10),(95,'Es-Semara',11),(96,'Fam El Hisn',9),(97,'Foum Zguid',9),(98,'Guelmim',10),(99,'Taghjijt',10),(100,'Tan-Tan',10),(101,'Tata',9),(102,'Zag',10),(103,'Marrakech',7),(104,'Ait Daoud',7),(115,'Amizmiz',7),(116,'Assahrij',7),(117,'Aït Ourir',7),(118,'Ben Guerir',7),(119,'Chichaoua',7),(120,'El Hanchane',7),(121,'El Kelaâ des Sraghna',7),(122,'Essaouira',7),(123,'Fraïta',7),(124,'Ghmate',7),(125,'Ighounane',8),(126,'Imintanoute',7),(127,'Kattara',7),(128,'Lalla Takerkoust',7),(129,'Loudaya',7),(130,'Lâattaouia',7),(131,'Moulay Brahim',7),(132,'Mzouda',7),(133,'Ounagha',7),(134,'Sid L\'Mokhtar',7),(135,'Sid Zouin',7),(136,'Sidi Abdallah Ghiat',7),(137,'Sidi Bou Othmane',7),(138,'Sidi Rahhal',7),(139,'Skhour Rehamna',7),(140,'Smimou',7),(141,'Tafetachte',7),(142,'Tahannaout',7),(143,'Talmest',7),(144,'Tamallalt',7),(145,'Tamanar',7),(146,'Tamansourt',7),(147,'Tameslouht',7),(148,'Tanalt',9),(149,'Zeubelemok',7),(150,'Meknès‎',3),(151,'Khénifra',5),(152,'Agourai',3),(153,'Ain Taoujdate',3),(154,'MyAliCherif',8),(155,'Rissani',8),(156,'Amalou Ighriben',5),(157,'Aoufous',8),(158,'Arfoud',8),(159,'Azrou',3),(160,'Aïn Jemaa',3),(161,'Aïn Karma',3),(162,'Aïn Leuh',3),(163,'Aït Boubidmane',3),(164,'Aït Ishaq',5),(165,'Boudnib',8),(166,'Boufakrane',3),(167,'Boumia',8),(168,'El Hajeb',3),(169,'Elkbab',5),(170,'Er-Rich',5),(171,'Errachidia',8),(172,'Gardmit',8),(173,'Goulmima',8),(174,'Gourrama',8),(175,'Had Bouhssoussen',5),(176,'Haj Kaddour',3),(177,'Ifrane',3),(178,'Itzer',8),(179,'Jorf',8),(180,'Kehf Nsour',5),(181,'Kerrouchen',5),(182,'M\'haya',3),(183,'M\'rirt',5),(184,'Midelt',8),(185,'Moulay Ali Cherif',8),(186,'Moulay Bouazza',5),(187,'Moulay Idriss Zerhoun',3),(188,'Moussaoua',3),(189,'N\'Zalat Bni Amar',3),(190,'Ouaoumana',5),(191,'Oued Ifrane',3),(192,'Sabaa Aiyoun',3),(193,'Sebt Jahjouh',3),(194,'Sidi Addi',3),(195,'Tichoute',8),(196,'Tighassaline',5),(197,'Tighza',5),(198,'Timahdite',3),(199,'Tinejdad',8),(200,'Tizguite',3),(201,'Toulal',3),(202,'Tounfite',8),(203,'Zaouia d\'Ifrane',3),(204,'Zaïda',8),(205,'Ahfir',2),(206,'Aklim',2),(207,'Al Aroui',2),(208,'Aïn Bni Mathar',2),(209,'Aïn Erreggada',2),(210,'Ben Taïeb',2),(211,'Berkane',2),(212,'Bni Ansar',2),(213,'Bni Chiker',2),(214,'Bni Drar',2),(215,'Bni Tadjite',2),(216,'Bouanane',2),(217,'Bouarfa',2),(218,'Bouhdila',2),(219,'Dar El Kebdani',2),(220,'Debdou',2),(221,'Douar Kannine',2),(222,'Driouch',2),(223,'El Aïoun Sidi Mellouk',2),(224,'Farkhana',2),(225,'Figuig',2),(226,'Ihddaden',2),(227,'Jaâdar',2),(228,'Jerada',2),(229,'Kariat Arekmane',2),(230,'Kassita',2),(231,'Kerouna',2),(232,'Laâtamna',2),(233,'Madagh',2),(234,'Midar',2),(235,'Nador',2),(236,'Naima',2),(237,'Oued Heimer',2),(238,'Oujda',2),(239,'Ras El Ma',2),(240,'Saïdia',2),(241,'Selouane',2),(242,'Sidi Boubker',2),(243,'Sidi Slimane Echcharaa',2),(244,'Talsint',2),(245,'Taourirt',2),(246,'Tendrara',2),(247,'Tiztoutine',2),(248,'Touima',2),(249,'Touissit',2),(250,'Zaïo',2),(251,'Zeghanghane',2),(252,'Rabat',4),(253,'Salé',4),(254,'Ain El Aouda',4),(255,'Harhoura',4),(256,'Khémisset',4),(257,'Oulmès',4),(258,'Rommani',4),(259,'Sidi Allal El Bahraoui',4),(260,'Sidi Bouknadel',4),(261,'Skhirate',4),(262,'Tamesna',4),(263,'Témara',4),(264,'Tiddas',4),(265,'Tiflet',4),(266,'Touarga',4),(267,'Agadir',9),(268,'Agdz',8),(269,'Agni Izimmer',9),(270,'Aït Melloul',9),(271,'Alnif',8),(272,'Anzi',9),(273,'Aoulouz',9),(274,'Aourir',9),(275,'Arazane',9),(276,'Aït Baha',9),(277,'Aït Iaâza',9),(278,'Aït Yalla',8),(279,'Ben Sergao',9),(280,'Biougra',9),(281,'Boumalne-Dadès',8),(282,'Dcheira El Jihadia',9),(283,'Drargua',9),(284,'El Guerdane',9),(285,'Harte Lyamine',8),(286,'Ida Ougnidif',9),(287,'Ifri',8),(288,'Igdamen',9),(289,'Ighil n\'Oumgoun',8),(290,'Imassine',8),(291,'Inezgane',9),(292,'Irherm',9),(293,'Kelaat-M\'Gouna',8),(294,'Lakhsas',9),(295,'Lakhsass',9),(296,'Lqliâa',9),(297,'M\'semrir',8),(298,'Massa (Maroc)',9),(299,'Megousse',9),(300,'Ouarzazate',8),(301,'Oulad Berhil',9),(302,'Oulad Teïma',9),(303,'Sarghine',8),(304,'Sidi Ifni',10),(305,'Skoura',8),(306,'Tabounte',8),(307,'Tafraout',9),(308,'Taghzout',1),(309,'Tagzen',9),(310,'Taliouine',9),(311,'Tamegroute',8),(312,'Tamraght',9),(313,'Tanoumrite Nkob Zagora',8),(314,'Taourirt ait zaghar',8),(315,'Taroudannt',9),(316,'Temsia',9),(317,'Tifnit',9),(318,'Tisgdal',9),(319,'Tiznit',9),(320,'Toundoute',8),(321,'Zagora',8),(322,'Afourar',5),(323,'Aghbala',5),(324,'Azilal',5),(325,'Aït Majden',5),(326,'Beni Ayat',5),(327,'Béni Mellal',5),(328,'Bin elouidane',5),(329,'Bradia',5),(330,'Bzou',5),(331,'Dar Oulad Zidouh',5),(332,'Demnate',5),(333,'Dra\'a',8),(334,'El Ksiba',5),(335,'Foum Jamaa',5),(336,'Fquih Ben Salah',5),(337,'Kasba Tadla',5),(338,'Ouaouizeght',5),(339,'Oulad Ayad',5),(340,'Oulad M\'Barek',5),(341,'Oulad Yaich',5),(342,'Sidi Jaber',5),(343,'Souk Sebt Oulad Nemma',5),(344,'Zaouïat Cheikh',5),(345,'Tanger‎',1),(346,'Tétouan‎',1),(347,'Akchour',1),(348,'Assilah',1),(349,'Bab Berred',1),(350,'Bab Taza',1),(351,'Brikcha',1),(352,'Chefchaouen',1),(353,'Dar Bni Karrich',1),(354,'Dar Chaoui',1),(355,'Fnideq',1),(356,'Gueznaia',1),(357,'Jebha',1),(358,'Karia',3),(359,'Khémis Sahel',1),(360,'Ksar El Kébir',1),(361,'Larache',1),(362,'M\'diq',1),(363,'Martil',1),(364,'Moqrisset',1),(365,'Oued Laou',1),(366,'Oued Rmel',1),(367,'Ouazzane',1),(368,'Point Cires',1),(369,'Sidi Lyamani',1),(370,'Sidi Mohamed ben Abdallah el-Raisuni',1),(371,'Zinat',1),(372,'Ajdir‎',1),(373,'Aknoul‎',3),(374,'Al Hoceïma‎',1),(375,'Aït Hichem‎',1),(376,'Bni Bouayach‎',1),(377,'Bni Hadifa‎',1),(378,'Ghafsai‎',3),(379,'Guercif‎',2),(380,'Imzouren‎',1),(381,'Inahnahen‎',1),(382,'Issaguen (Ketama)‎',1),(383,'Karia (El Jadida)‎',6),(384,'Karia Ba Mohamed‎',3),(385,'Oued Amlil‎',3),(386,'Oulad Zbair‎',3),(387,'Tahla‎',3),(388,'Tala Tazegwaght‎',1),(389,'Tamassint‎',1),(390,'Taounate‎',3),(391,'Targuist‎',1),(392,'Taza‎',3),(393,'Taïnaste‎',3),(394,'Thar Es-Souk‎',3),(395,'Tissa‎',3),(396,'Tizi Ouasli‎',3),(397,'Laayoune‎',11),(398,'El Marsa‎',11),(399,'Tarfaya‎',11),(400,'Boujdour‎',11),(401,'Awsard',12),(402,'Oued-Eddahab',12),(403,'Stehat',1),(404,'Aït Attab',5);
/*!40000 ALTER TABLE `country_city` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `country_region`
--

DROP TABLE IF EXISTS `country_region`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `country_region` (
  `id` int NOT NULL AUTO_INCREMENT,
  `region` varchar(40) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `country_region`
--

LOCK TABLES `country_region` WRITE;
/*!40000 ALTER TABLE `country_region` DISABLE KEYS */;
INSERT INTO `country_region` VALUES (1,'Tanger-Tétouan-Al Hoceïma'),(2,'l\'Oriental'),(3,'Fès-Meknès'),(4,'Rabat-Salé-Kénitra'),(5,'Béni Mellal-Khénifra'),(6,'Casablanca-Settat'),(7,'Marrakech-Safi'),(8,'Drâa-Tafilalet'),(9,'Souss-Massa'),(10,'Guelmim-Oued Noun'),(11,'Laâyoune-Sakia El Hamra'),(12,'Dakhla-Oued Ed Dahab');
/*!40000 ALTER TABLE `country_region` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `country_region_city`
--

DROP TABLE IF EXISTS `country_region_city`;
/*!50001 DROP VIEW IF EXISTS `country_region_city`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `country_region_city` AS SELECT 
 1 AS `region`,
 1 AS `id`,
 1 AS `city`,
 1 AS `region_id`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `course`
--

DROP TABLE IF EXISTS `course`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `course` (
  `id` int NOT NULL AUTO_INCREMENT,
  `course_title` varchar(1000) NOT NULL,
  `course_brief` varchar(4000) NOT NULL,
  `instructor_id` int NOT NULL,
  `num_of_chapters` int NOT NULL,
  `course_fee` int NOT NULL,
  `language_id` int NOT NULL,
  `school_subject_id` int NOT NULL,
  `is_visible` bit(1) NOT NULL DEFAULT b'1',
  `date_creation` datetime NOT NULL,
  `date_update` datetime NOT NULL,
  `date_start_course` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `date_end_course` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `course_instructor` (`instructor_id`),
  KEY `course_language` (`language_id`),
  KEY `course_school_subject_idx` (`school_subject_id`),
  CONSTRAINT `course_instructor` FOREIGN KEY (`instructor_id`) REFERENCES `instructor` (`id`),
  CONSTRAINT `course_language` FOREIGN KEY (`language_id`) REFERENCES `language` (`id`),
  CONSTRAINT `course_school_subject` FOREIGN KEY (`school_subject_id`) REFERENCES `school_subject` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course`
--

LOCK TABLES `course` WRITE;
/*!40000 ALTER TABLE `course` DISABLE KEYS */;
INSERT INTO `course` VALUES (1,'Introduction à l\'Intelligence Artificielle','<div><div>Objectives The objective of this study is to investigate the proportion of p bbbbbbbbb bhbjjhhijij</div></div>',1,5,0,2,1,_binary '','2025-11-25 22:33:26','2025-12-03 13:43:08','2025-12-06 12:51:00',NULL),(2,'Machine Learning : notions et algorithmes','Régression, classification, sélection de features et évaluation.',1,3,0,2,1,_binary '','2025-11-25 22:33:26','2025-12-03 12:56:58','2025-11-24 22:33:00',NULL),(3,'Deep Learning pour vision par ordinateur','<font color=\"#333333\" face=\"Roboto, Arial, sans-serif\">Objectives The objective of this study is to investigate the proportion of potentially low-value knee MRI in Norway and to provide an estimate of the related costs. Design Register study based on conditional data extraction and analysis of data from Control and Reimbursement of Healthcare Claims registry in Norway. Setting MRI in public specialist healthcare with universal health coverage (Norway). Participants 48 212 MRIs for 41 456 unique patients and 45 946 reimbursement claims. Outcome measures Proportion of MRIs of the knee that (1) did not have a relevant tentative diagnosis prior to the knee MRI, (2) did not have a relevant alternative image of the knee before the MRI or (3) did not have a relevant code from the specialist care within 6 months after the MRI, and those that had combinations of 1, 2 and 3. Estimated costs for those that had combinations of 1, 2 and 3. Results Very few patients (6.4%) had a relevant diagnosis code or prior imaging examination when having the MRI and only 14.6% got a knee-related diagnosis code from the specialist care within 6 months after the MRI. 21.8% of the patients had knee X-ray, CT or ultrasound within 6 months before the MRI. Between 58% and 85% of patients having knee MRIs in Norway have no relevant examinations or diagnoses six months prior to or after the MRI examination.</font>',1,3,0,2,1,_binary '','2025-11-25 22:33:26','2025-12-03 13:07:03','2025-11-25 23:33:00',NULL),(4,'NLP : traitement du langage naturel','Tokenisation, embeddings, modèles seq2seq, Transformers.',1,3,0,2,1,_binary '','2025-11-25 22:33:26','2025-11-25 22:33:26','2025-11-25 22:33:26',NULL),(5,'Apprentissage non supervisé et clustering','k-means, DBSCAN, PCA et cas d\'usage.',1,3,0,2,1,_binary '','2025-11-25 22:33:26','2025-11-25 22:33:26','2025-11-25 22:33:26',NULL),(6,'Modèles probabilistes et bayésiens','Bayes, modèles graphiques et inférence.',1,3,0,2,1,_binary '','2025-11-25 22:33:26','2025-11-25 22:33:26','2025-11-25 22:33:26',NULL),(7,'MLOps : mise en production de modèles','CI/CD, monitoring, versioning, déploiement.',1,3,0,2,1,_binary '','2025-11-25 22:33:26','2025-11-25 22:33:26','2025-11-25 22:33:26',NULL),(8,'Éthique et IA responsable','Biais, explicabilité, confidentialité et règlementation.',1,3,0,2,1,_binary '','2025-11-25 22:33:26','2025-11-25 22:33:26','2025-11-25 22:33:26',NULL),(9,'Apprentissage par renforcement','Formulation RL, Q-learning, policy gradients.',1,3,0,2,1,_binary '','2025-11-25 22:33:26','2025-11-25 22:33:26','2025-11-25 22:33:26',NULL),(10,'Feature Engineering avancé','Extraction, transformation, encodages et pipelines.',1,3,0,2,1,_binary '','2025-11-25 22:33:26','2025-11-25 22:33:26','2025-11-25 22:33:26',NULL),(11,'Computer Vision avancé : détection et segmentation','Instance segmentation, Mask R-CNN, post-processing.',1,3,0,2,1,_binary '','2025-11-25 22:33:26','2025-11-25 22:33:26','2025-11-25 22:33:26',NULL),(12,'Time Series & Forecasting','Séries temporelles, ARIMA, LSTM, evaluation temporelle.',1,3,0,2,1,_binary '','2025-11-25 22:33:26','2025-11-25 22:33:26','2025-11-25 22:33:26',NULL),(13,'AutoML et optimisation d\'hyperparamètres','Recherche d\'hyperparamètres, AutoML practicals.',1,3,0,2,1,_binary '','2025-11-25 22:33:26','2025-11-25 22:33:26','2025-11-25 22:33:26',NULL),(14,'Représentations et embeddings','Word2Vec, GloVe, BERT embeddings, visualisation.',1,3,0,2,1,_binary '','2025-11-25 22:33:26','2025-11-25 22:33:26','2025-11-25 22:33:26',NULL),(15,'Graph ML : GNN et applications','GNN, node classification, link prediction.',1,3,0,2,1,_binary '','2025-11-25 22:33:26','2025-11-25 22:33:26','2025-11-25 22:33:26',NULL),(16,'IA et robotique : perception et contrôle','Capteurs, SLAM, contrôle basique.',1,3,0,2,1,_binary '','2025-11-25 22:33:26','2025-11-25 22:33:26','2025-11-25 22:33:26',NULL),(17,'Sécurité des modèles ML','Adversarial attacks, defence strategies, robustness.',1,3,0,2,1,_binary '','2025-11-25 22:33:26','2025-11-25 22:33:26','2025-11-25 22:33:26',NULL),(18,'Pratiques avancées de data labeling','Stratégies de labellisation, quality control, active learning.',1,3,0,2,1,_binary '','2025-11-25 22:33:26','2025-11-25 22:33:26','2025-11-25 22:33:26',NULL),(19,'IA pour la santé','Applications médicales, privacy, réglementation HIPAA/GDPR (introduc.).',1,3,0,2,1,_binary '','2025-11-25 22:33:26','2025-11-25 22:33:26','2025-11-25 22:33:26',NULL),(20,'Projet capstone : construire une solution IA complète','Méthodologie projet, étapes, livrables et évaluation.',1,3,0,2,1,_binary '','2025-11-25 22:33:26','2025-11-25 22:33:26','2025-11-25 22:33:26',NULL),(23,'Spectre et décomposition fonctionnelle des opérateurs linéaires','Ce parcours pédagogique explore les fondements de l\'analyse spectrale dans les espaces de Hilbert et Banach, en abordant la caractérisation des valeurs propres, le spectre continu et les méthodes de décomposition. Les outils de calcul fonctionnel seront présentés avec des applications concrètes en physique mathématique et en théorie des opérateurs. Des exercices progressifs permettront de maîtriser les théorèmes spectraux pour les opérateurs auto-adjoints et compacts.',1,3,0,1,1,_binary '','2025-12-11 16:27:17','2025-12-11 16:27:17','2025-12-11 16:27:17',NULL),(24,'Spectre et décomposition fonctionnelle des opérateurs linéaires','Ce parcours pédagogique explore les fondements de l\'analyse spectrale dans les espaces de Hilbert et Banach, en abordant la caractérisation des valeurs propres, le spectre continu et les méthodes de décomposition. Les outils de calcul fonctionnel seront présentés avec des applications concrètes en physique mathématique et en théorie des opérateurs. Des exercices progressifs permettront de maîtriser les théorèmes spectraux pour les opérateurs auto-adjoints et compacts.',1,3,0,1,1,_binary '','2025-12-11 17:07:30','2025-12-11 17:07:30','2025-12-11 17:07:30',NULL),(25,'Exploration approfondie du Dictionnaire Larousse français avancée','Ce module de deux heures s\'adresse aux étudiants souhaitant maîtriser l\'utilisation experte du Dictionnaire Larousse. Il couvre l\'histoire de cette référence, sa structure complexe, les subtilités des définitions, les marques d\'usage, les synonymes et antonymes, ainsi que des techniques de recherche avancée pour optimiser son utilisation dans un cadre académique et professionnel.',1,2,0,1,1,_binary '','2025-12-11 17:13:48','2025-12-11 17:13:48','2025-12-11 17:13:48',NULL),(26,'Analyse spectrale et décomposition fonctionnelle des opérateurs linéaires','Ce cours intermédiaire de deux heures explore la théorie spectrale des opérateurs linéaires agissant sur des espaces vectoriels. Il aborde les notions fondamentales de spectre, de valeurs propres, et de décompositions fonctionnelles, avec des exercices pratiques pour consolider la compréhension. Les étudiants acquerront une maîtrise des outils analytiques essentiels pour étudier la structure des opérateurs en dimension finie et infinie, en mettant l\'accent sur les applications en analyse fonctionnelle.',1,3,0,2,1,_binary '','2025-12-11 17:22:27','2025-12-11 17:22:27','2025-12-11 17:22:27',NULL),(27,'Maîtriser la plateforme DeepSeek pour l\'apprentissage automatique','Cette formation intermédiaire de quatre heures permet aux étudiants d\'acquérir une expertise pratique dans l\'utilisation de DeepSeek. Les participants exploreront les fonctionnalités principales, implémenteront des modèles de base et optimiseront leurs workflows. Le parcours combine théorie fondamentale et exercices appliqués pour garantir une maîtrise opérationnelle des outils et concepts essentiels.',1,5,0,2,1,_binary '','2025-12-11 17:29:43','2025-12-24 23:46:35','2025-12-11 17:29:00',NULL),(28,'test','<p>test</p>',1,0,0,2,1,_binary '','2025-12-25 12:45:33','2025-12-27 01:26:03','2025-12-27 12:00:00','2026-12-25 00:00:00'),(29,'Analyse spectrale et décomposition fonctionnelle des opérateurs linéaires','Ce cours intermédiaire de deux heures présente les fondements de l\'analyse spectrale et des méthodes de décomposition pour les opérateurs linéaires. Il s\'adresse aux étudiants possédant des bases en algèbre linéaire et en analyse fonctionnelle. L\'objectif est de comprendre les concepts de spectre, de valeurs propres généralisées et d\'utiliser le calcul fonctionnel pour décomposer des opérateurs. Les notions de résolvante, de projecteurs spectraux et les théorèmes de décomposition pour les opérateurs auto-adjoints et compacts seront étudiés en détail à travers des exemples théoriques et pratiques.',1,3,0,2,1,_binary '','2025-12-27 20:43:08','2025-12-27 20:43:08','2025-12-27 20:43:08',NULL),(30,'Analyse spectrale et décomposition fonctionnelle des opérateurs linéaires','Ce cours intermédiaire de deux heures présente les fondements de l\'analyse spectrale et des méthodes de décomposition pour les opérateurs linéaires. Il s\'adresse aux étudiants possédant des bases en algèbre linéaire et en analyse fonctionnelle. L\'objectif est de comprendre les concepts de spectre, de valeurs propres généralisées et d\'utiliser le calcul fonctionnel pour décomposer des opérateurs. Les notions de résolvante, de projecteurs spectraux et les théorèmes de décomposition pour les opérateurs auto-adjoints et compacts seront étudiés en détail à travers des exemples théoriques et pratiques.',1,3,0,2,1,_binary '','2025-12-27 20:43:37','2025-12-27 20:43:37','2025-12-27 20:43:37',NULL),(32,'Spectral Analysis and Functional Decomposition of Linear Operators','This intermediate course provides a systematic study of the spectral properties of linear operators on Banach and Hilbert spaces. Fundamental concepts include resolvent sets, spectra, spectral theorems for self-adjoint and normal operators, and the powerful functional calculus. Participants will explore decomposition techniques like the spectral decomposition theorem, understanding how operators can be broken down into simpler parts. The course aims to equip students with the analytical tools necessary for applications in differential equations, quantum mechanics, and numerical analysis, building on a prerequisite knowledge of functional analysis.',1,5,0,2,1,_binary '','2025-12-27 23:11:42','2025-12-27 23:11:42','2025-12-27 23:11:42',NULL);
/*!40000 ALTER TABLE `course` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_chapter`
--

DROP TABLE IF EXISTS `course_chapter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `course_chapter` (
  `id` int NOT NULL AUTO_INCREMENT,
  `course_id` int NOT NULL,
  `chapter_title` varchar(1000) NOT NULL,
  `chapter_description` varchar(4000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `num_of_reading` int NOT NULL,
  `num_of_contents` int NOT NULL,
  `is_visible` bit(1) NOT NULL DEFAULT b'1',
  `sequence` int NOT NULL,
  `date_chapter_creation` datetime DEFAULT CURRENT_TIMESTAMP,
  `date_chapter_update` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `course_content_course` (`course_id`),
  CONSTRAINT `course_content_course` FOREIGN KEY (`course_id`) REFERENCES `course` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=93 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_chapter`
--

LOCK TABLES `course_chapter` WRITE;
/*!40000 ALTER TABLE `course_chapter` DISABLE KEYS */;
INSERT INTO `course_chapter` VALUES (1,1,'Applications pratiques',NULL,0,2,_binary '',3,'2025-11-25 22:33:26','2025-11-25 22:33:26'),(2,1,'Méthodes',NULL,0,2,_binary '',2,'2025-11-25 22:33:26','2025-11-25 22:33:26'),(3,1,'Fondamentaux','Pour mener à bien ce test, vous serez connecté à Measurement Lab (M-Lab). Votre adresse IP sera communiquée à ce service et traitée conformément à ses règles de confidentialité. M-Lab procède au test et publie toutes les données correspondantes afin de promouvoir la recherche sur Internet. Ces informations comprennent votre adresse IP ainsi que les résultats du test, mais aucune autre information vous concernant en tant qu\'internaute.',0,2,_binary '',1,'2025-11-25 22:33:26','2025-12-03 11:48:29'),(4,2,'Applications pratiques',NULL,0,2,_binary '',3,'2025-11-25 22:33:26','2025-11-25 22:33:26'),(5,2,'Méthodes',NULL,0,2,_binary '',2,'2025-11-25 22:33:26','2025-11-25 22:33:26'),(6,2,'Fondamentaux',NULL,0,2,_binary '',1,'2025-11-25 22:33:26','2025-12-04 21:37:33'),(7,3,'Applications pratiques',NULL,0,2,_binary '',3,'2025-11-25 22:33:26','2025-11-25 22:33:26'),(8,3,'Méthodes',NULL,0,2,_binary '',2,'2025-11-25 22:33:26','2025-11-25 22:33:26'),(9,3,'Fondamentaux',NULL,0,2,_binary '',1,'2025-11-25 22:33:26','2025-11-25 22:33:26'),(10,4,'Applications pratiques',NULL,0,2,_binary '',3,'2025-11-25 22:33:26','2025-11-25 22:33:26'),(11,4,'Méthodes',NULL,0,2,_binary '',2,'2025-11-25 22:33:26','2025-11-25 22:33:26'),(12,4,'Fondamentaux',NULL,0,2,_binary '',1,'2025-11-25 22:33:26','2025-11-25 22:33:26'),(13,5,'Applications pratiques',NULL,0,2,_binary '',3,'2025-11-25 22:33:26','2025-11-25 22:33:26'),(14,5,'Méthodes',NULL,0,2,_binary '',2,'2025-11-25 22:33:26','2025-11-25 22:33:26'),(15,5,'Fondamentaux',NULL,0,2,_binary '',1,'2025-11-25 22:33:26','2025-11-25 22:33:26'),(16,6,'Applications pratiques',NULL,0,2,_binary '',3,'2025-11-25 22:33:26','2025-11-25 22:33:26'),(17,6,'Méthodes',NULL,0,2,_binary '',2,'2025-11-25 22:33:26','2025-11-25 22:33:26'),(18,6,'Fondamentaux',NULL,0,2,_binary '',1,'2025-11-25 22:33:26','2025-11-25 22:33:26'),(19,7,'Applications pratiques',NULL,0,2,_binary '',3,'2025-11-25 22:33:26','2025-11-25 22:33:26'),(20,7,'Méthodes',NULL,0,2,_binary '',2,'2025-11-25 22:33:26','2025-11-25 22:33:26'),(21,7,'Fondamentaux',NULL,0,2,_binary '',1,'2025-11-25 22:33:26','2025-11-25 22:33:26'),(22,8,'Applications pratiques',NULL,0,2,_binary '',3,'2025-11-25 22:33:26','2025-11-25 22:33:26'),(23,8,'Méthodes',NULL,0,2,_binary '',2,'2025-11-25 22:33:26','2025-11-25 22:33:26'),(24,8,'Fondamentaux',NULL,0,2,_binary '',1,'2025-11-25 22:33:26','2025-11-25 22:33:26'),(25,9,'Applications pratiques',NULL,0,2,_binary '',3,'2025-11-25 22:33:26','2025-11-25 22:33:26'),(26,9,'Méthodes',NULL,0,2,_binary '',2,'2025-11-25 22:33:26','2025-11-25 22:33:26'),(27,9,'Fondamentaux',NULL,0,2,_binary '',1,'2025-11-25 22:33:26','2025-11-25 22:33:26'),(28,10,'Applications pratiques',NULL,0,2,_binary '',3,'2025-11-25 22:33:26','2025-11-25 22:33:26'),(29,10,'Méthodes',NULL,0,2,_binary '',2,'2025-11-25 22:33:26','2025-11-25 22:33:26'),(30,10,'Fondamentaux','mmmmmmm',0,3,_binary '',1,'2025-11-25 22:33:26','2025-12-25 12:25:58'),(31,11,'Applications pratiques',NULL,0,2,_binary '',3,'2025-11-25 22:33:26','2025-11-25 22:33:26'),(32,11,'Méthodes',NULL,0,2,_binary '',2,'2025-11-25 22:33:26','2025-11-25 22:33:26'),(33,11,'Fondamentaux',NULL,0,2,_binary '',1,'2025-11-25 22:33:26','2025-11-25 22:33:26'),(34,12,'Applications pratiques',NULL,0,2,_binary '',3,'2025-11-25 22:33:26','2025-11-25 22:33:26'),(35,12,'Méthodes',NULL,0,2,_binary '',2,'2025-11-25 22:33:26','2025-11-25 22:33:26'),(36,12,'Fondamentaux',NULL,0,2,_binary '',1,'2025-11-25 22:33:26','2025-11-25 22:33:26'),(37,13,'Applications pratiques',NULL,0,2,_binary '',3,'2025-11-25 22:33:26','2025-11-25 22:33:26'),(38,13,'Méthodes',NULL,0,2,_binary '',2,'2025-11-25 22:33:26','2025-11-25 22:33:26'),(39,13,'Fondamentaux',NULL,0,2,_binary '',1,'2025-11-25 22:33:26','2025-11-25 22:33:26'),(40,14,'Applications pratiques',NULL,0,2,_binary '',3,'2025-11-25 22:33:26','2025-11-25 22:33:26'),(41,14,'Méthodes',NULL,0,2,_binary '',2,'2025-11-25 22:33:26','2025-11-25 22:33:26'),(42,14,'Fondamentaux',NULL,0,2,_binary '',1,'2025-11-25 22:33:26','2025-11-25 22:33:26'),(43,15,'Applications pratiques',NULL,0,2,_binary '',3,'2025-11-25 22:33:26','2025-11-25 22:33:26'),(44,15,'Méthodes',NULL,0,2,_binary '',2,'2025-11-25 22:33:26','2025-11-25 22:33:26'),(45,15,'Fondamentaux',NULL,0,2,_binary '',1,'2025-11-25 22:33:26','2025-11-25 22:33:26'),(46,16,'Applications pratiques',NULL,0,2,_binary '',3,'2025-11-25 22:33:26','2025-11-25 22:33:26'),(47,16,'Méthodes',NULL,0,2,_binary '',2,'2025-11-25 22:33:26','2025-11-25 22:33:26'),(48,16,'Fondamentaux',NULL,0,2,_binary '',1,'2025-11-25 22:33:26','2025-11-25 22:33:26'),(49,17,'Applications pratiques',NULL,0,2,_binary '',3,'2025-11-25 22:33:26','2025-11-25 22:33:26'),(50,17,'Méthodes',NULL,0,2,_binary '',2,'2025-11-25 22:33:26','2025-11-25 22:33:26'),(51,17,'Fondamentaux',NULL,0,2,_binary '',1,'2025-11-25 22:33:26','2025-11-25 22:33:26'),(52,18,'Applications pratiques',NULL,0,2,_binary '',3,'2025-11-25 22:33:26','2025-11-25 22:33:26'),(53,18,'Méthodes',NULL,0,2,_binary '',2,'2025-11-25 22:33:26','2025-11-25 22:33:26'),(54,18,'Fondamentaux',NULL,0,2,_binary '',1,'2025-11-25 22:33:26','2025-11-25 22:33:26'),(55,19,'Applications pratiques',NULL,0,2,_binary '',3,'2025-11-25 22:33:26','2025-11-25 22:33:26'),(56,19,'Méthodes',NULL,0,2,_binary '',2,'2025-11-25 22:33:26','2025-11-25 22:33:26'),(57,19,'Fondamentaux',NULL,0,2,_binary '',1,'2025-11-25 22:33:26','2025-11-25 22:33:26'),(58,20,'Applications pratiques',NULL,0,2,_binary '',3,'2025-11-25 22:33:26','2025-11-25 22:33:26'),(59,20,'Méthodes',NULL,0,2,_binary '',2,'2025-11-25 22:33:26','2025-11-25 22:33:26'),(60,20,'Fondamentaux',NULL,0,2,_binary '',1,'2025-11-25 22:33:26','2025-11-25 22:33:26'),(61,1,'chapitre de test','text-transform-none text-size-default text-transform-none text-size-defaulttex t-transform-none text-size-default',0,0,_binary '',4,'2025-12-02 23:43:56','2025-12-02 23:43:56'),(62,1,'kkjkjkjkjk','lklklklkl',0,0,_binary '',5,'2025-12-02 23:45:38','2025-12-02 23:45:46'),(63,23,'Concepts fondamentaux de l\'analyse spectrale : définitions du spectre, résolvante et propriétés topologiques des ensembles spectraux dans les espaces normés','L\'étude des opérateurs linéaires nécessite une compréhension approfondie des différentes parties du spectre, y compris le spectre ponctuel, continu et résiduel. Ce module introduit la fonction résolvante et son domaine de définition, ainsi que les liens entre spectralité et continuité des opérateurs. Des exemples concrets dans les espaces de dimension finie et infinie illustrent ces notions.',0,3,_binary '',1,'2025-12-11 16:27:18','2025-12-11 16:27:18'),(64,23,'Décomposition spectrale des opérateurs auto-adjoints et normaux : théorème spectral, mesures projectives et intégration fonctionnelle','Les opérateurs auto-adjoints sur les espaces de Hilbert admettent une décomposition spectrale canonique via une mesure à valeurs projecteurs. Ce module détaille la construction de la mesure spectrale et son utilisation pour définir f(T) pour des fonctions boréliennes. Les applications incluent la diagonalisation des opérateurs compacts auto-adjoints et la formulation du théorème spectral pour les opérateurs non bornés.',0,3,_binary '',2,'2025-12-11 16:27:18','2025-12-11 16:27:18'),(65,23,'Extensions aux opérateurs non bornés et applications en physique mathématique : Hamiltoniens, groupes unitaires et équations d\'évolution','Les opérateurs différentiels en physique mathématique sont souvent non bornés mais auto-adjoints. Ce module aborde leur analyse spectrale via les extensions auto-adjointes et le calcul fonctionnel. Les applications couvrent les Hamiltoniens quantiques, les groupes d\'évolution unitaires et la résolution des équations de Schrödinger. Des techniques de perturbation singulière et de théorie des semigroupes sont introduites.',0,3,_binary '',3,'2025-12-11 16:27:18','2025-12-11 16:27:18'),(66,24,'Concepts fondamentaux de l\'analyse spectrale : définitions du spectre, résolvante et propriétés topologiques des ensembles spectraux dans les espaces normés','L\'étude des opérateurs linéaires nécessite une compréhension approfondie des différentes parties du spectre, y compris le spectre ponctuel, continu et résiduel. Ce module introduit la fonction résolvante et son domaine de définition, ainsi que les liens entre spectralité et continuité des opérateurs. Des exemples concrets dans les espaces de dimension finie et infinie illustrent ces notions.',0,3,_binary '',1,'2025-12-11 17:07:30','2025-12-11 17:07:30'),(67,24,'Décomposition spectrale des opérateurs auto-adjoints et normaux : théorème spectral, mesures projectives et intégration fonctionnelle','Les opérateurs auto-adjoints sur les espaces de Hilbert admettent une décomposition spectrale canonique via une mesure à valeurs projecteurs. Ce module détaille la construction de la mesure spectrale et son utilisation pour définir f(T) pour des fonctions boréliennes. Les applications incluent la diagonalisation des opérateurs compacts auto-adjoints et la formulation du théorème spectral pour les opérateurs non bornés.',0,3,_binary '',2,'2025-12-11 17:07:30','2025-12-11 17:07:30'),(68,24,'Extensions aux opérateurs non bornés et applications en physique mathématique : Hamiltoniens, groupes unitaires et équations d\'évolution','Les opérateurs différentiels en physique mathématique sont souvent non bornés mais auto-adjoints. Ce module aborde leur analyse spectrale via les extensions auto-adjointes et le calcul fonctionnel. Les applications couvrent les Hamiltoniens quantiques, les groupes d\'évolution unitaires et la résolution des équations de Schrödinger. Des techniques de perturbation singulière et de théorie des semigroupes sont introduites.',0,3,_binary '',3,'2025-12-11 17:07:30','2025-12-11 17:07:30'),(69,25,'Origines, structure et navigation experte dans le Dictionnaire Larousse, incluant l\'analyse des différentes sections et des méthodes de recherche avancées','Une immersion dans l\'univers du Larousse débute par son historique et son évolution éditoriale. Ensuite, une étude détaillée de sa macrostructure et de sa microstructure permet de comprendre l\'organisation des articles, des abréviations et des symboles. Enfin, des stratégies de recherche rapide et efficace sont présentées pour exploiter pleinement les informations lexicales et encyclopédiques.',0,3,_binary '',1,'2025-12-11 17:13:48','2025-12-11 17:13:48'),(70,25,'Exploitation linguistique approfondie : analyse sémantique, marques d\'usage, registres de langue et application à la rédaction de textes académiques','Ce module se concentre sur l\'exploitation fine des informations linguistiques. Il aborde l\'analyse des nuances sémantiques entre les définitions, le décodage systématique des marques d\'usage (familier, vieilli, technique), la distinction entre les différents registres de langue et l\'application de ces connaissances pour améliorer la précision et la richesse lexicale dans la rédaction universitaire.',0,3,_binary '',2,'2025-12-11 17:13:48','2025-12-11 17:13:48'),(71,26,'Fondements de l\'analyse spectrale : définitions du spectre, résolvante, et propriétés élémentaires des opérateurs linéaires bornés sur des espaces de Banach','Ce premier module établit les bases nécessaires à l\'étude spectrale en introduisant les concepts d\'opérateur linéaire borné, d\'ensemble résolvant et de spectre. Il présente les propriétés topologiques fondamentales du spectre et initie à l\'utilisation de la résolvante comme outil analytique central dans l\'étude des opérateurs.',0,3,_binary '',1,'2025-12-11 17:22:27','2025-12-11 17:22:27'),(72,26,'Théorèmes de décomposition spectrale pour les opérateurs compacts et application au calcul fonctionnel dans les espaces de Hilbert','Ce module approfondit l\'analyse en se concentrant sur les opérateurs compacts, qui permettent des décompositions spectrales explicites. Il présente le théorème spectral pour les opérateurs compacts auto-adjoints et étend ces résultats au calcul fonctionnel via les intégrales spectrales, préparant le terrain pour la théorie plus générale.',0,3,_binary '',2,'2025-12-11 17:22:27','2025-12-11 17:22:27'),(73,26,'Théorie spectrale avancée : mesure spectrale, théorème spectral pour les opérateurs auto-adjoints non bornés et applications aux équations aux dérivées partielles','Le module final aborde la théorie spectrale générale pour les opérateurs auto-adjoints, éventuellement non bornés, via le concept de mesure spectrale. Il présente le théorème spectral sous sa forme intégrale et explore des applications significatives en physique mathématique, comme la quantification des opérateurs différentiels.',0,3,_binary '',3,'2025-12-11 17:22:27','2025-12-11 17:22:27'),(74,27,'Découverte approfondie de l\'environnement DeepSeek : interface utilisateur, configuration système et bonnes pratiques pour une prise en main efficace','Ce module initie les apprenants aux fondamentaux de la plateforme en présentant son architecture technique et ses capacités. Une attention particulière est portée à l\'installation des dépendances, la gestion des ressources computationnelles et l\'organisation des projets. Les étudiants développeront une compréhension solide des principes de base nécessaires aux modules avancés.',0,3,_binary '',1,'2025-12-11 17:29:43','2025-12-11 17:29:43'),(75,27,'Développement de modèles sur DeepSeek : implémentation from scratch, utilisation des APIs et techniques de débogage systématique','Ce module pratique guide les étudiants dans la création et l\'entraînement de modèles simples jusqu\'à des architectures complexes. L\'accent est mis sur la compréhension des abstractions fournies par la plateforme et leur utilisation judicieuse. Des exercices progressifs renforcent la maîtrise des concepts à travers des implémentations concrètes et l\'analyse des résultats.',0,3,_binary '',2,'2025-12-11 17:29:43','2025-12-23 23:03:14'),(76,27,'Optimisation production et déploiement : compression modèles, inference distribuée et monitoring performances en environnement réel','Ce module final traite des aspects opérationnels pour passer du prototype à la production. Les étudiants apprendront à optimiser les modèles pour différentes contraintes hardware, à concevoir des APIs de servir et à monitorer les performances en temps réel. Des études de cas industrielles illustrent les défis communs et leurs solutions éprouvées.',0,3,_binary '',3,'2025-12-11 17:29:43','2025-12-11 17:29:43'),(77,27,'test','ttt tttt',0,0,_binary '',4,'2025-12-25 00:05:08','2025-12-25 00:05:08'),(78,27,'yhyhyh','v yuyuyu yyhu',0,0,_binary '',5,'2025-12-25 00:08:07','2025-12-25 00:08:07'),(79,29,'Fondements de l\'analyse spectrale avec une introduction aux espaces de Banach, aux opérateurs bornés et à la définition du spectre dans un contexte général','Cette première partie établit les bases nécessaires à la compréhension de l\'analyse spectrale. Nous aborderons les propriétés des espaces de Banach et de Hilbert, la définition et les exemples d\'opérateurs linéaires bornés. La notion centrale de spectre d\'un opérateur sera introduite, en distinguant le spectre ponctuel, continu et résiduel. Des exercices permettront de manipuler la résolvante et de calculer des spectres sur des exemples concrets.',0,3,_binary '',1,'2025-12-27 20:43:08','2025-12-27 20:43:08'),(80,29,'Opérateurs compacts et leur théorie spectrale, propriétés des valeurs propres et liens avec la décomposition en éléments simples','Ce module se concentre sur une classe importante d\'opérateurs : les opérateurs compacts. Leur théorie spectrale présente des similitudes frappantes avec le cas de dimension finie. Nous étudierons les propriétés de leur spectre, qui est au plus dénombrable et n\'a pour point d\'accumulation que possiblement zéro. La décomposition de Riesz pour les opérateurs compacts et le rôle des espaces propres généralisés seront analysés en profondeur, avec des applications à la résolution d\'équations intégrales.',0,3,_binary '',2,'2025-12-27 20:43:08','2025-12-27 20:43:08'),(81,29,'Opérateurs auto-adjoints sur espaces de Hilbert, théorème spectral et applications du calcul fonctionnel à la décomposition','Ce module final aborde le cœur de l\'analyse spectrale pour les opérateurs auto-adjoints sur les espaces de Hilbert. Le théorème spectral, sous ses formes multiples, est présenté comme un outil puissant de décomposition. Nous explorerons le calcul fonctionnel, qui permet de définir f(T) pour une fonction f mesurable et un opérateur auto-adjoint T. Les applications incluent la définition des projecteurs spectraux, l\'intégration par rapport à une mesure spectrale et la décomposition spectrale intégrale, fondamentale en mécanique quantique.',0,4,_binary '',3,'2025-12-27 20:43:08','2025-12-27 20:43:08'),(82,30,'Fondements de l\'analyse spectrale avec une introduction aux espaces de Banach, aux opérateurs bornés et à la définition du spectre dans un contexte général','Cette première partie établit les bases nécessaires à la compréhension de l\'analyse spectrale. Nous aborderons les propriétés des espaces de Banach et de Hilbert, la définition et les exemples d\'opérateurs linéaires bornés. La notion centrale de spectre d\'un opérateur sera introduite, en distinguant le spectre ponctuel, continu et résiduel. Des exercices permettront de manipuler la résolvante et de calculer des spectres sur des exemples concrets.',0,0,_binary '',1,'2025-12-27 20:43:37','2025-12-27 23:51:51'),(83,30,'Opérateurs compacts et leur théorie spectrale, propriétés des valeurs propres et liens avec la décomposition en éléments simples','Ce module se concentre sur une classe importante d\'opérateurs : les opérateurs compacts. Leur théorie spectrale présente des similitudes frappantes avec le cas de dimension finie. Nous étudierons les propriétés de leur spectre, qui est au plus dénombrable et n\'a pour point d\'accumulation que possiblement zéro. La décomposition de Riesz pour les opérateurs compacts et le rôle des espaces propres généralisés seront analysés en profondeur, avec des applications à la résolution d\'équations intégrales.',0,3,_binary '',2,'2025-12-27 20:43:37','2025-12-27 20:43:37'),(84,30,'Opérateurs auto-adjoints sur espaces de Hilbert, théorème spectral et applications du calcul fonctionnel à la décomposition','Ce module final aborde le cœur de l\'analyse spectrale pour les opérateurs auto-adjoints sur les espaces de Hilbert. Le théorème spectral, sous ses formes multiples, est présenté comme un outil puissant de décomposition. Nous explorerons le calcul fonctionnel, qui permet de définir f(T) pour une fonction f mesurable et un opérateur auto-adjoint T. Les applications incluent la définition des projecteurs spectraux, l\'intégration par rapport à une mesure spectrale et la décomposition spectrale intégrale, fondamentale en mécanique quantique.',0,4,_binary '',3,'2025-12-27 20:43:37','2025-12-27 20:43:37'),(88,32,'Core concepts of linear operators on Banach and Hilbert spaces including boundedness, continuity, and fundamental examples for spectral theory','This initial module establishes the essential groundwork by rigorously defining linear operators on infinite-dimensional spaces. It covers the critical properties of boundedness and continuity, distinguishing between Banach and Hilbert space contexts. Important operator classes such as compact and finite-rank operators are introduced, alongside canonical examples that motivate the need for spectral analysis. The module concludes with an examination of the closed graph theorem and its implications, ensuring a solid foundation for subsequent topics.',0,3,_binary '',1,'2025-12-27 23:11:43','2025-12-27 23:11:43'),(89,32,'Spectral theory fundamentals encompassing the spectrum, resolvent, and the distinct parts of the spectrum for bounded operators','This module delves into the core of spectral theory, defining the spectrum of a bounded linear operator and its partition into point, continuous, and residual spectra. The resolvent function and its analytic properties are studied in detail, providing tools for investigating operator behavior. Significant theorems, such as the spectral radius formula, are proven and applied. The module also contrasts the spectral properties of operators on Banach spaces versus the more structured setting of Hilbert spaces, setting the stage for decomposition theorems.',0,3,_binary '',2,'2025-12-27 23:11:43','2025-12-27 23:11:43'),(90,32,'Self-adjoint and normal operators on Hilbert spaces with a focus on their spectral theorems and decomposition properties','Focusing on Hilbert spaces, this module examines the special classes of self-adjoint and normal operators, which possess exceptionally well-behaved spectral properties. The celebrated spectral theorem is presented in several equivalent forms, demonstrating how these operators can be represented as multiplication operators. The module explores the construction of projection-valued measures and the resulting functional calculus, enabling the definition of functions of an operator. Applications in quantum mechanics, where observables are modeled by self-adjoint operators, are highlighted.',0,3,_binary '',3,'2025-12-27 23:11:43','2025-12-27 23:11:43'),(91,32,'Unbounded operators, their domains, and the extension of spectral theory to closed densely defined operators on Hilbert spaces','Many important operators, such as differential operators, are unbounded. This module extends spectral theory to this broader class, focusing on closed and densely defined operators. Key concepts include the adjoint of an unbounded operator, self-adjoint extensions, and the spectrum in this context. The module covers fundamental results like the Hellinger-Toeplitz theorem and the theory of spectral measures for unbounded self-adjoint operators. The challenge of defining a functional calculus for unbounded operators is addressed, linking back to the bounded case via resolvents.',0,3,_binary '',4,'2025-12-27 23:11:43','2025-12-27 23:11:43'),(92,32,'Advanced decomposition techniques including polar decomposition, singular value decomposition, and applications to operator algebras','The final module explores sophisticated decomposition methods that factor operators into simpler, structurally revealing components. The polar decomposition breaks an operator into a partial isometry and a positive operator, analogous to the polar form of a complex number. For compact operators, the singular value decomposition provides a series expansion in terms of its singular values and vectors. The module also touches upon the decomposition of operators within C*-algebras and von Neumann algebras, connecting spectral theory to broader mathematical structures.',0,3,_binary '',5,'2025-12-27 23:11:43','2025-12-27 23:11:43');
/*!40000 ALTER TABLE `course_chapter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_chapter_content`
--

DROP TABLE IF EXISTS `course_chapter_content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `course_chapter_content` (
  `id` int NOT NULL AUTO_INCREMENT,
  `course_chapter_id` int NOT NULL,
  `content_type_id` int NOT NULL,
  `is_important` bit(1) NOT NULL DEFAULT b'1',
  `time_required_in_sec` int NOT NULL,
  `is_open_for_free` char(1) NOT NULL,
  `is_visible` bit(1) NOT NULL DEFAULT b'1',
  `content_url` varchar(2000) DEFAULT NULL,
  `content_text` mediumtext,
  `content_brief` varchar(4000) DEFAULT NULL,
  `date_creation` datetime NOT NULL,
  `date_update` datetime NOT NULL,
  `sequence` int NOT NULL,
  `content_cover_url` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `file_size_in_bytes` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `course_chapter_cnt_cnt_type` (`content_type_id`),
  KEY `course_chapter_cnt_crs_chapter` (`course_chapter_id`),
  CONSTRAINT `course_chapter_cnt_cnt_type` FOREIGN KEY (`content_type_id`) REFERENCES `content_type` (`id`),
  CONSTRAINT `course_chapter_cnt_crs_chapter` FOREIGN KEY (`course_chapter_id`) REFERENCES `course_chapter` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=230 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_chapter_content`
--

LOCK TABLES `course_chapter_content` WRITE;
/*!40000 ALTER TABLE `course_chapter_content` DISABLE KEYS */;
INSERT INTO `course_chapter_content` VALUES (1,60,4,_binary '',900,'Y',_binary '',NULL,'Cours: Projet capstone : construire une solution IA complète\n\nChapitre: Fondamentaux\n\nCe chapitre présente les notions fondamentales. Nous définissons les concepts clés, le vocabulaire et le contexte technique. Vous apprendrez la terminologie, les métriques d\'évaluation et verrez des exemples concrets pour comprendre pourquoi ces méthodes sont utiles.\n\nExercice / Objectifs : Lecture et compréhension. Résumer les points clés.','Contenu: Texte introductif','2025-11-25 22:33:26','2025-11-25 22:33:26',1,NULL,NULL),(2,59,4,_binary '',900,'Y',_binary '',NULL,'Cours: Projet capstone : construire une solution IA complète\n\nChapitre: Méthodes\n\nCe chapitre décrit les méthodes principales et leurs fondements mathématiques. Nous couvrons les algorithmes, le prétraitement des données, le choix des features et les bonnes pratiques d\'implémentation. Un petit guide pas-à-pas montre comment implémenter un modèle de base.\n\nExercice / Objectifs : Lecture et compréhension. Résumer les points clés.','Contenu: Méthode détaillée','2025-11-25 22:33:26','2025-11-25 22:33:26',1,NULL,NULL),(3,58,4,_binary '',900,'Y',_binary '',NULL,'Cours: Projet capstone : construire une solution IA complète\n\nChapitre: Applications pratiques\n\nCe chapitre montre des cas pratiques et un mini-projet. Il détaille un pipeline complet, propose des exercices guidés et des pistes d\'évaluation pour mesurer la performance en condition réelle.\n\nExercice / Objectifs : Lecture et compréhension. Résumer les points clés.','Contenu: Projet & exercices','2025-11-25 22:33:26','2025-11-25 22:33:26',1,NULL,NULL),(4,57,4,_binary '',900,'Y',_binary '',NULL,'Cours: IA pour la santé\n\nChapitre: Fondamentaux\n\nCe chapitre présente les notions fondamentales. Nous définissons les concepts clés, le vocabulaire et le contexte technique. Vous apprendrez la terminologie, les métriques d\'évaluation et verrez des exemples concrets pour comprendre pourquoi ces méthodes sont utiles.\n\nExercice / Objectifs : Lecture et compréhension. Résumer les points clés.','Contenu: Texte introductif','2025-11-25 22:33:26','2025-11-25 22:33:26',1,NULL,NULL),(5,56,4,_binary '',900,'Y',_binary '',NULL,'Cours: IA pour la santé\n\nChapitre: Méthodes\n\nCe chapitre décrit les méthodes principales et leurs fondements mathématiques. Nous couvrons les algorithmes, le prétraitement des données, le choix des features et les bonnes pratiques d\'implémentation. Un petit guide pas-à-pas montre comment implémenter un modèle de base.\n\nExercice / Objectifs : Lecture et compréhension. Résumer les points clés.','Contenu: Méthode détaillée','2025-11-25 22:33:26','2025-11-25 22:33:26',1,NULL,NULL),(6,55,4,_binary '',900,'Y',_binary '',NULL,'Cours: IA pour la santé\n\nChapitre: Applications pratiques\n\nCe chapitre montre des cas pratiques et un mini-projet. Il détaille un pipeline complet, propose des exercices guidés et des pistes d\'évaluation pour mesurer la performance en condition réelle.\n\nExercice / Objectifs : Lecture et compréhension. Résumer les points clés.','Contenu: Projet & exercices','2025-11-25 22:33:26','2025-11-25 22:33:26',1,NULL,NULL),(7,54,4,_binary '',900,'Y',_binary '',NULL,'Cours: Pratiques avancées de data labeling\n\nChapitre: Fondamentaux\n\nCe chapitre présente les notions fondamentales. Nous définissons les concepts clés, le vocabulaire et le contexte technique. Vous apprendrez la terminologie, les métriques d\'évaluation et verrez des exemples concrets pour comprendre pourquoi ces méthodes sont utiles.\n\nExercice / Objectifs : Lecture et compréhension. Résumer les points clés.','Contenu: Texte introductif','2025-11-25 22:33:26','2025-11-25 22:33:26',1,NULL,NULL),(8,53,4,_binary '',900,'Y',_binary '',NULL,'Cours: Pratiques avancées de data labeling\n\nChapitre: Méthodes\n\nCe chapitre décrit les méthodes principales et leurs fondements mathématiques. Nous couvrons les algorithmes, le prétraitement des données, le choix des features et les bonnes pratiques d\'implémentation. Un petit guide pas-à-pas montre comment implémenter un modèle de base.\n\nExercice / Objectifs : Lecture et compréhension. Résumer les points clés.','Contenu: Méthode détaillée','2025-11-25 22:33:26','2025-11-25 22:33:26',1,NULL,NULL),(9,52,4,_binary '',900,'Y',_binary '',NULL,'Cours: Pratiques avancées de data labeling\n\nChapitre: Applications pratiques\n\nCe chapitre montre des cas pratiques et un mini-projet. Il détaille un pipeline complet, propose des exercices guidés et des pistes d\'évaluation pour mesurer la performance en condition réelle.\n\nExercice / Objectifs : Lecture et compréhension. Résumer les points clés.','Contenu: Projet & exercices','2025-11-25 22:33:26','2025-11-25 22:33:26',1,NULL,NULL),(10,51,4,_binary '',900,'Y',_binary '',NULL,'Cours: Sécurité des modèles ML\n\nChapitre: Fondamentaux\n\nCe chapitre présente les notions fondamentales. Nous définissons les concepts clés, le vocabulaire et le contexte technique. Vous apprendrez la terminologie, les métriques d\'évaluation et verrez des exemples concrets pour comprendre pourquoi ces méthodes sont utiles.\n\nExercice / Objectifs : Lecture et compréhension. Résumer les points clés.','Contenu: Texte introductif','2025-11-25 22:33:26','2025-11-25 22:33:26',1,NULL,NULL),(11,50,4,_binary '',900,'Y',_binary '',NULL,'Cours: Sécurité des modèles ML\n\nChapitre: Méthodes\n\nCe chapitre décrit les méthodes principales et leurs fondements mathématiques. Nous couvrons les algorithmes, le prétraitement des données, le choix des features et les bonnes pratiques d\'implémentation. Un petit guide pas-à-pas montre comment implémenter un modèle de base.\n\nExercice / Objectifs : Lecture et compréhension. Résumer les points clés.','Contenu: Méthode détaillée','2025-11-25 22:33:26','2025-11-25 22:33:26',1,NULL,NULL),(12,49,4,_binary '',900,'Y',_binary '',NULL,'Cours: Sécurité des modèles ML\n\nChapitre: Applications pratiques\n\nCe chapitre montre des cas pratiques et un mini-projet. Il détaille un pipeline complet, propose des exercices guidés et des pistes d\'évaluation pour mesurer la performance en condition réelle.\n\nExercice / Objectifs : Lecture et compréhension. Résumer les points clés.','Contenu: Projet & exercices','2025-11-25 22:33:26','2025-11-25 22:33:26',1,NULL,NULL),(13,48,4,_binary '',900,'Y',_binary '',NULL,'Cours: IA et robotique : perception et contrôle\n\nChapitre: Fondamentaux\n\nCe chapitre présente les notions fondamentales. Nous définissons les concepts clés, le vocabulaire et le contexte technique. Vous apprendrez la terminologie, les métriques d\'évaluation et verrez des exemples concrets pour comprendre pourquoi ces méthodes sont utiles.\n\nExercice / Objectifs : Lecture et compréhension. Résumer les points clés.','Contenu: Texte introductif','2025-11-25 22:33:26','2025-11-25 22:33:26',1,NULL,NULL),(14,47,4,_binary '',900,'Y',_binary '',NULL,'Cours: IA et robotique : perception et contrôle\n\nChapitre: Méthodes\n\nCe chapitre décrit les méthodes principales et leurs fondements mathématiques. Nous couvrons les algorithmes, le prétraitement des données, le choix des features et les bonnes pratiques d\'implémentation. Un petit guide pas-à-pas montre comment implémenter un modèle de base.\n\nExercice / Objectifs : Lecture et compréhension. Résumer les points clés.','Contenu: Méthode détaillée','2025-11-25 22:33:26','2025-11-25 22:33:26',1,NULL,NULL),(15,46,4,_binary '',900,'Y',_binary '',NULL,'Cours: IA et robotique : perception et contrôle\n\nChapitre: Applications pratiques\n\nCe chapitre montre des cas pratiques et un mini-projet. Il détaille un pipeline complet, propose des exercices guidés et des pistes d\'évaluation pour mesurer la performance en condition réelle.\n\nExercice / Objectifs : Lecture et compréhension. Résumer les points clés.','Contenu: Projet & exercices','2025-11-25 22:33:26','2025-11-25 22:33:26',1,NULL,NULL),(16,45,4,_binary '',900,'Y',_binary '',NULL,'Cours: Graph ML : GNN et applications\n\nChapitre: Fondamentaux\n\nCe chapitre présente les notions fondamentales. Nous définissons les concepts clés, le vocabulaire et le contexte technique. Vous apprendrez la terminologie, les métriques d\'évaluation et verrez des exemples concrets pour comprendre pourquoi ces méthodes sont utiles.\n\nExercice / Objectifs : Lecture et compréhension. Résumer les points clés.','Contenu: Texte introductif','2025-11-25 22:33:26','2025-11-25 22:33:26',1,NULL,NULL),(17,44,4,_binary '',900,'Y',_binary '',NULL,'Cours: Graph ML : GNN et applications\n\nChapitre: Méthodes\n\nCe chapitre décrit les méthodes principales et leurs fondements mathématiques. Nous couvrons les algorithmes, le prétraitement des données, le choix des features et les bonnes pratiques d\'implémentation. Un petit guide pas-à-pas montre comment implémenter un modèle de base.\n\nExercice / Objectifs : Lecture et compréhension. Résumer les points clés.','Contenu: Méthode détaillée','2025-11-25 22:33:26','2025-11-25 22:33:26',1,NULL,NULL),(18,43,4,_binary '',900,'Y',_binary '',NULL,'Cours: Graph ML : GNN et applications\n\nChapitre: Applications pratiques\n\nCe chapitre montre des cas pratiques et un mini-projet. Il détaille un pipeline complet, propose des exercices guidés et des pistes d\'évaluation pour mesurer la performance en condition réelle.\n\nExercice / Objectifs : Lecture et compréhension. Résumer les points clés.','Contenu: Projet & exercices','2025-11-25 22:33:26','2025-11-25 22:33:26',1,NULL,NULL),(19,42,4,_binary '',900,'Y',_binary '',NULL,'Cours: Représentations et embeddings\n\nChapitre: Fondamentaux\n\nCe chapitre présente les notions fondamentales. Nous définissons les concepts clés, le vocabulaire et le contexte technique. Vous apprendrez la terminologie, les métriques d\'évaluation et verrez des exemples concrets pour comprendre pourquoi ces méthodes sont utiles.\n\nExercice / Objectifs : Lecture et compréhension. Résumer les points clés.','Contenu: Texte introductif','2025-11-25 22:33:26','2025-11-25 22:33:26',1,NULL,NULL),(20,41,4,_binary '',900,'Y',_binary '',NULL,'Cours: Représentations et embeddings\n\nChapitre: Méthodes\n\nCe chapitre décrit les méthodes principales et leurs fondements mathématiques. Nous couvrons les algorithmes, le prétraitement des données, le choix des features et les bonnes pratiques d\'implémentation. Un petit guide pas-à-pas montre comment implémenter un modèle de base.\n\nExercice / Objectifs : Lecture et compréhension. Résumer les points clés.','Contenu: Méthode détaillée','2025-11-25 22:33:26','2025-11-25 22:33:26',1,NULL,NULL),(21,40,4,_binary '',900,'Y',_binary '',NULL,'Cours: Représentations et embeddings\n\nChapitre: Applications pratiques\n\nCe chapitre montre des cas pratiques et un mini-projet. Il détaille un pipeline complet, propose des exercices guidés et des pistes d\'évaluation pour mesurer la performance en condition réelle.\n\nExercice / Objectifs : Lecture et compréhension. Résumer les points clés.','Contenu: Projet & exercices','2025-11-25 22:33:26','2025-11-25 22:33:26',1,NULL,NULL),(22,39,4,_binary '',900,'Y',_binary '',NULL,'Cours: AutoML et optimisation d\'hyperparamètres\n\nChapitre: Fondamentaux\n\nCe chapitre présente les notions fondamentales. Nous définissons les concepts clés, le vocabulaire et le contexte technique. Vous apprendrez la terminologie, les métriques d\'évaluation et verrez des exemples concrets pour comprendre pourquoi ces méthodes sont utiles.\n\nExercice / Objectifs : Lecture et compréhension. Résumer les points clés.','Contenu: Texte introductif','2025-11-25 22:33:26','2025-11-25 22:33:26',1,NULL,NULL),(23,38,4,_binary '',900,'Y',_binary '',NULL,'Cours: AutoML et optimisation d\'hyperparamètres\n\nChapitre: Méthodes\n\nCe chapitre décrit les méthodes principales et leurs fondements mathématiques. Nous couvrons les algorithmes, le prétraitement des données, le choix des features et les bonnes pratiques d\'implémentation. Un petit guide pas-à-pas montre comment implémenter un modèle de base.\n\nExercice / Objectifs : Lecture et compréhension. Résumer les points clés.','Contenu: Méthode détaillée','2025-11-25 22:33:26','2025-11-25 22:33:26',1,NULL,NULL),(24,37,4,_binary '',900,'Y',_binary '',NULL,'Cours: AutoML et optimisation d\'hyperparamètres\n\nChapitre: Applications pratiques\n\nCe chapitre montre des cas pratiques et un mini-projet. Il détaille un pipeline complet, propose des exercices guidés et des pistes d\'évaluation pour mesurer la performance en condition réelle.\n\nExercice / Objectifs : Lecture et compréhension. Résumer les points clés.','Contenu: Projet & exercices','2025-11-25 22:33:26','2025-11-25 22:33:26',1,NULL,NULL),(25,36,4,_binary '',900,'Y',_binary '',NULL,'Cours: Time Series & Forecasting\n\nChapitre: Fondamentaux\n\nCe chapitre présente les notions fondamentales. Nous définissons les concepts clés, le vocabulaire et le contexte technique. Vous apprendrez la terminologie, les métriques d\'évaluation et verrez des exemples concrets pour comprendre pourquoi ces méthodes sont utiles.\n\nExercice / Objectifs : Lecture et compréhension. Résumer les points clés.','Contenu: Texte introductif','2025-11-25 22:33:26','2025-11-25 22:33:26',1,NULL,NULL),(26,35,4,_binary '',900,'Y',_binary '',NULL,'Cours: Time Series & Forecasting\n\nChapitre: Méthodes\n\nCe chapitre décrit les méthodes principales et leurs fondements mathématiques. Nous couvrons les algorithmes, le prétraitement des données, le choix des features et les bonnes pratiques d\'implémentation. Un petit guide pas-à-pas montre comment implémenter un modèle de base.\n\nExercice / Objectifs : Lecture et compréhension. Résumer les points clés.','Contenu: Méthode détaillée','2025-11-25 22:33:26','2025-11-25 22:33:26',1,NULL,NULL),(27,34,4,_binary '',900,'Y',_binary '',NULL,'Cours: Time Series & Forecasting\n\nChapitre: Applications pratiques\n\nCe chapitre montre des cas pratiques et un mini-projet. Il détaille un pipeline complet, propose des exercices guidés et des pistes d\'évaluation pour mesurer la performance en condition réelle.\n\nExercice / Objectifs : Lecture et compréhension. Résumer les points clés.','Contenu: Projet & exercices','2025-11-25 22:33:26','2025-11-25 22:33:26',1,NULL,NULL),(28,33,4,_binary '',900,'Y',_binary '',NULL,'Cours: Computer Vision avancé : détection et segmentation\n\nChapitre: Fondamentaux\n\nCe chapitre présente les notions fondamentales. Nous définissons les concepts clés, le vocabulaire et le contexte technique. Vous apprendrez la terminologie, les métriques d\'évaluation et verrez des exemples concrets pour comprendre pourquoi ces méthodes sont utiles.\n\nExercice / Objectifs : Lecture et compréhension. Résumer les points clés.','Contenu: Texte introductif','2025-11-25 22:33:26','2025-11-25 22:33:26',1,NULL,NULL),(29,32,4,_binary '',900,'Y',_binary '',NULL,'Cours: Computer Vision avancé : détection et segmentation\n\nChapitre: Méthodes\n\nCe chapitre décrit les méthodes principales et leurs fondements mathématiques. Nous couvrons les algorithmes, le prétraitement des données, le choix des features et les bonnes pratiques d\'implémentation. Un petit guide pas-à-pas montre comment implémenter un modèle de base.\n\nExercice / Objectifs : Lecture et compréhension. Résumer les points clés.','Contenu: Méthode détaillée','2025-11-25 22:33:26','2025-11-25 22:33:26',1,NULL,NULL),(30,31,4,_binary '',900,'Y',_binary '',NULL,'Cours: Computer Vision avancé : détection et segmentation\n\nChapitre: Applications pratiques\n\nCe chapitre montre des cas pratiques et un mini-projet. Il détaille un pipeline complet, propose des exercices guidés et des pistes d\'évaluation pour mesurer la performance en condition réelle.\n\nExercice / Objectifs : Lecture et compréhension. Résumer les points clés.','Contenu: Projet & exercices','2025-11-25 22:33:26','2025-11-25 22:33:26',1,NULL,NULL),(31,30,4,_binary '',900,'Y',_binary '',NULL,'Cours: Feature Engineering avancé\n\nChapitre: Fondamentaux\n\nCe chapitre présente les notions fondamentales. Nous définissons les concepts clés, le vocabulaire et le contexte technique. Vous apprendrez la terminologie, les métriques d\'évaluation et verrez des exemples concrets pour comprendre pourquoi ces méthodes sont utiles.\n\nExercice / Objectifs : Lecture et compréhension. Résumer les points clés.','Contenu: Texte introductif','2025-11-25 22:33:26','2025-11-25 22:33:26',1,NULL,NULL),(32,29,4,_binary '',900,'Y',_binary '',NULL,'Cours: Feature Engineering avancé\n\nChapitre: Méthodes\n\nCe chapitre décrit les méthodes principales et leurs fondements mathématiques. Nous couvrons les algorithmes, le prétraitement des données, le choix des features et les bonnes pratiques d\'implémentation. Un petit guide pas-à-pas montre comment implémenter un modèle de base.\n\nExercice / Objectifs : Lecture et compréhension. Résumer les points clés.','Contenu: Méthode détaillée','2025-11-25 22:33:26','2025-11-25 22:33:26',1,NULL,NULL),(33,28,4,_binary '',900,'Y',_binary '',NULL,'Cours: Feature Engineering avancé\n\nChapitre: Applications pratiques\n\nCe chapitre montre des cas pratiques et un mini-projet. Il détaille un pipeline complet, propose des exercices guidés et des pistes d\'évaluation pour mesurer la performance en condition réelle.\n\nExercice / Objectifs : Lecture et compréhension. Résumer les points clés.','Contenu: Projet & exercices','2025-11-25 22:33:26','2025-11-25 22:33:26',1,NULL,NULL),(34,27,4,_binary '',900,'Y',_binary '',NULL,'Cours: Apprentissage par renforcement\n\nChapitre: Fondamentaux\n\nCe chapitre présente les notions fondamentales. Nous définissons les concepts clés, le vocabulaire et le contexte technique. Vous apprendrez la terminologie, les métriques d\'évaluation et verrez des exemples concrets pour comprendre pourquoi ces méthodes sont utiles.\n\nExercice / Objectifs : Lecture et compréhension. Résumer les points clés.','Contenu: Texte introductif','2025-11-25 22:33:26','2025-11-25 22:33:26',1,NULL,NULL),(35,26,4,_binary '',900,'Y',_binary '',NULL,'Cours: Apprentissage par renforcement\n\nChapitre: Méthodes\n\nCe chapitre décrit les méthodes principales et leurs fondements mathématiques. Nous couvrons les algorithmes, le prétraitement des données, le choix des features et les bonnes pratiques d\'implémentation. Un petit guide pas-à-pas montre comment implémenter un modèle de base.\n\nExercice / Objectifs : Lecture et compréhension. Résumer les points clés.','Contenu: Méthode détaillée','2025-11-25 22:33:26','2025-11-25 22:33:26',1,NULL,NULL),(36,25,4,_binary '',900,'Y',_binary '',NULL,'Cours: Apprentissage par renforcement\n\nChapitre: Applications pratiques\n\nCe chapitre montre des cas pratiques et un mini-projet. Il détaille un pipeline complet, propose des exercices guidés et des pistes d\'évaluation pour mesurer la performance en condition réelle.\n\nExercice / Objectifs : Lecture et compréhension. Résumer les points clés.','Contenu: Projet & exercices','2025-11-25 22:33:26','2025-11-25 22:33:26',1,NULL,NULL),(37,24,4,_binary '',900,'Y',_binary '',NULL,'Cours: Éthique et IA responsable\n\nChapitre: Fondamentaux\n\nCe chapitre présente les notions fondamentales. Nous définissons les concepts clés, le vocabulaire et le contexte technique. Vous apprendrez la terminologie, les métriques d\'évaluation et verrez des exemples concrets pour comprendre pourquoi ces méthodes sont utiles.\n\nExercice / Objectifs : Lecture et compréhension. Résumer les points clés.','Contenu: Texte introductif','2025-11-25 22:33:26','2025-11-25 22:33:26',1,NULL,NULL),(38,23,4,_binary '',900,'Y',_binary '',NULL,'Cours: Éthique et IA responsable\n\nChapitre: Méthodes\n\nCe chapitre décrit les méthodes principales et leurs fondements mathématiques. Nous couvrons les algorithmes, le prétraitement des données, le choix des features et les bonnes pratiques d\'implémentation. Un petit guide pas-à-pas montre comment implémenter un modèle de base.\n\nExercice / Objectifs : Lecture et compréhension. Résumer les points clés.','Contenu: Méthode détaillée','2025-11-25 22:33:26','2025-11-25 22:33:26',1,NULL,NULL),(39,22,4,_binary '',900,'Y',_binary '',NULL,'Cours: Éthique et IA responsable\n\nChapitre: Applications pratiques\n\nCe chapitre montre des cas pratiques et un mini-projet. Il détaille un pipeline complet, propose des exercices guidés et des pistes d\'évaluation pour mesurer la performance en condition réelle.\n\nExercice / Objectifs : Lecture et compréhension. Résumer les points clés.','Contenu: Projet & exercices','2025-11-25 22:33:26','2025-11-25 22:33:26',1,NULL,NULL),(40,21,4,_binary '',900,'Y',_binary '',NULL,'Cours: MLOps : mise en production de modèles\n\nChapitre: Fondamentaux\n\nCe chapitre présente les notions fondamentales. Nous définissons les concepts clés, le vocabulaire et le contexte technique. Vous apprendrez la terminologie, les métriques d\'évaluation et verrez des exemples concrets pour comprendre pourquoi ces méthodes sont utiles.\n\nExercice / Objectifs : Lecture et compréhension. Résumer les points clés.','Contenu: Texte introductif','2025-11-25 22:33:26','2025-11-25 22:33:26',1,NULL,NULL),(41,20,4,_binary '',900,'Y',_binary '',NULL,'Cours: MLOps : mise en production de modèles\n\nChapitre: Méthodes\n\nCe chapitre décrit les méthodes principales et leurs fondements mathématiques. Nous couvrons les algorithmes, le prétraitement des données, le choix des features et les bonnes pratiques d\'implémentation. Un petit guide pas-à-pas montre comment implémenter un modèle de base.\n\nExercice / Objectifs : Lecture et compréhension. Résumer les points clés.','Contenu: Méthode détaillée','2025-11-25 22:33:26','2025-11-25 22:33:26',1,NULL,NULL),(42,19,4,_binary '',900,'Y',_binary '',NULL,'Cours: MLOps : mise en production de modèles\n\nChapitre: Applications pratiques\n\nCe chapitre montre des cas pratiques et un mini-projet. Il détaille un pipeline complet, propose des exercices guidés et des pistes d\'évaluation pour mesurer la performance en condition réelle.\n\nExercice / Objectifs : Lecture et compréhension. Résumer les points clés.','Contenu: Projet & exercices','2025-11-25 22:33:26','2025-11-25 22:33:26',1,NULL,NULL),(43,18,4,_binary '',900,'Y',_binary '',NULL,'Cours: Modèles probabilistes et bayésiens\n\nChapitre: Fondamentaux\n\nCe chapitre présente les notions fondamentales. Nous définissons les concepts clés, le vocabulaire et le contexte technique. Vous apprendrez la terminologie, les métriques d\'évaluation et verrez des exemples concrets pour comprendre pourquoi ces méthodes sont utiles.\n\nExercice / Objectifs : Lecture et compréhension. Résumer les points clés.','Contenu: Texte introductif','2025-11-25 22:33:26','2025-11-25 22:33:26',1,NULL,NULL),(44,17,4,_binary '',900,'Y',_binary '',NULL,'Cours: Modèles probabilistes et bayésiens\n\nChapitre: Méthodes\n\nCe chapitre décrit les méthodes principales et leurs fondements mathématiques. Nous couvrons les algorithmes, le prétraitement des données, le choix des features et les bonnes pratiques d\'implémentation. Un petit guide pas-à-pas montre comment implémenter un modèle de base.\n\nExercice / Objectifs : Lecture et compréhension. Résumer les points clés.','Contenu: Méthode détaillée','2025-11-25 22:33:26','2025-11-25 22:33:26',1,NULL,NULL),(45,16,4,_binary '',900,'Y',_binary '',NULL,'Cours: Modèles probabilistes et bayésiens\n\nChapitre: Applications pratiques\n\nCe chapitre montre des cas pratiques et un mini-projet. Il détaille un pipeline complet, propose des exercices guidés et des pistes d\'évaluation pour mesurer la performance en condition réelle.\n\nExercice / Objectifs : Lecture et compréhension. Résumer les points clés.','Contenu: Projet & exercices','2025-11-25 22:33:26','2025-11-25 22:33:26',1,NULL,NULL),(46,15,4,_binary '',900,'Y',_binary '',NULL,'Cours: Apprentissage non supervisé et clustering\n\nChapitre: Fondamentaux\n\nCe chapitre présente les notions fondamentales. Nous définissons les concepts clés, le vocabulaire et le contexte technique. Vous apprendrez la terminologie, les métriques d\'évaluation et verrez des exemples concrets pour comprendre pourquoi ces méthodes sont utiles.\n\nExercice / Objectifs : Lecture et compréhension. Résumer les points clés.','Contenu: Texte introductif','2025-11-25 22:33:26','2025-11-25 22:33:26',1,NULL,NULL),(47,14,4,_binary '',900,'Y',_binary '',NULL,'Cours: Apprentissage non supervisé et clustering\n\nChapitre: Méthodes\n\nCe chapitre décrit les méthodes principales et leurs fondements mathématiques. Nous couvrons les algorithmes, le prétraitement des données, le choix des features et les bonnes pratiques d\'implémentation. Un petit guide pas-à-pas montre comment implémenter un modèle de base.\n\nExercice / Objectifs : Lecture et compréhension. Résumer les points clés.','Contenu: Méthode détaillée','2025-11-25 22:33:26','2025-11-25 22:33:26',1,NULL,NULL),(48,13,4,_binary '',900,'Y',_binary '',NULL,'Cours: Apprentissage non supervisé et clustering\n\nChapitre: Applications pratiques\n\nCe chapitre montre des cas pratiques et un mini-projet. Il détaille un pipeline complet, propose des exercices guidés et des pistes d\'évaluation pour mesurer la performance en condition réelle.\n\nExercice / Objectifs : Lecture et compréhension. Résumer les points clés.','Contenu: Projet & exercices','2025-11-25 22:33:26','2025-11-25 22:33:26',1,NULL,NULL),(49,12,4,_binary '',900,'Y',_binary '',NULL,'Cours: NLP : traitement du langage naturel\n\nChapitre: Fondamentaux\n\nCe chapitre présente les notions fondamentales. Nous définissons les concepts clés, le vocabulaire et le contexte technique. Vous apprendrez la terminologie, les métriques d\'évaluation et verrez des exemples concrets pour comprendre pourquoi ces méthodes sont utiles.\n\nExercice / Objectifs : Lecture et compréhension. Résumer les points clés.','Contenu: Texte introductif','2025-11-25 22:33:26','2025-11-25 22:33:26',1,NULL,NULL),(50,11,4,_binary '',900,'Y',_binary '',NULL,'Cours: NLP : traitement du langage naturel\n\nChapitre: Méthodes\n\nCe chapitre décrit les méthodes principales et leurs fondements mathématiques. Nous couvrons les algorithmes, le prétraitement des données, le choix des features et les bonnes pratiques d\'implémentation. Un petit guide pas-à-pas montre comment implémenter un modèle de base.\n\nExercice / Objectifs : Lecture et compréhension. Résumer les points clés.','Contenu: Méthode détaillée','2025-11-25 22:33:26','2025-11-25 22:33:26',1,NULL,NULL),(51,10,4,_binary '',900,'Y',_binary '',NULL,'Cours: NLP : traitement du langage naturel\n\nChapitre: Applications pratiques\n\nCe chapitre montre des cas pratiques et un mini-projet. Il détaille un pipeline complet, propose des exercices guidés et des pistes d\'évaluation pour mesurer la performance en condition réelle.\n\nExercice / Objectifs : Lecture et compréhension. Résumer les points clés.','Contenu: Projet & exercices','2025-11-25 22:33:26','2025-11-25 22:33:26',1,NULL,NULL),(52,9,4,_binary '',900,'Y',_binary '',NULL,'Cours: Deep Learning pour vision par ordinateur\n\nChapitre: Fondamentaux\n\nCe chapitre présente les notions fondamentales. Nous définissons les concepts clés, le vocabulaire et le contexte technique. Vous apprendrez la terminologie, les métriques d\'évaluation et verrez des exemples concrets pour comprendre pourquoi ces méthodes sont utiles.\n\nExercice / Objectifs : Lecture et compréhension. Résumer les points clés.','Contenu: Texte introductif','2025-11-25 22:33:26','2025-11-25 22:33:26',1,NULL,NULL),(53,8,4,_binary '',900,'Y',_binary '',NULL,'Cours: Deep Learning pour vision par ordinateur\n\nChapitre: Méthodes\n\nCe chapitre décrit les méthodes principales et leurs fondements mathématiques. Nous couvrons les algorithmes, le prétraitement des données, le choix des features et les bonnes pratiques d\'implémentation. Un petit guide pas-à-pas montre comment implémenter un modèle de base.\n\nExercice / Objectifs : Lecture et compréhension. Résumer les points clés.','Contenu: Méthode détaillée','2025-11-25 22:33:26','2025-11-25 22:33:26',1,NULL,NULL),(54,7,4,_binary '',900,'Y',_binary '',NULL,'Cours: Deep Learning pour vision par ordinateur\n\nChapitre: Applications pratiques\n\nCe chapitre montre des cas pratiques et un mini-projet. Il détaille un pipeline complet, propose des exercices guidés et des pistes d\'évaluation pour mesurer la performance en condition réelle.\n\nExercice / Objectifs : Lecture et compréhension. Résumer les points clés.','Contenu: Projet & exercices','2025-11-25 22:33:26','2025-11-25 22:33:26',1,NULL,NULL),(56,5,4,_binary '',900,'Y',_binary '',NULL,'Cours: Machine Learning : notions et algorithmes\n\nChapitre: Méthodes\n\nCe chapitre décrit les méthodes principales et leurs fondements mathématiques. Nous couvrons les algorithmes, le prétraitement des données, le choix des features et les bonnes pratiques d\'implémentation. Un petit guide pas-à-pas montre comment implémenter un modèle de base.\n\nExercice / Objectifs : Lecture et compréhension. Résumer les points clés.','Contenu: Méthode détaillée','2025-11-25 22:33:26','2025-11-25 22:33:26',1,NULL,NULL),(57,4,4,_binary '',900,'Y',_binary '',NULL,'Cours: Machine Learning : notions et algorithmes\n\nChapitre: Applications pratiques\n\nCe chapitre montre des cas pratiques et un mini-projet. Il détaille un pipeline complet, propose des exercices guidés et des pistes d\'évaluation pour mesurer la performance en condition réelle.\n\nExercice / Objectifs : Lecture et compréhension. Résumer les points clés.','Contenu: Projet & exercices','2025-11-25 22:33:26','2025-11-25 22:33:26',1,NULL,NULL),(58,3,4,_binary '',900,'Y',_binary '',NULL,'Cours: Introduction à l\'Intelligence Artificielle\n\nChapitre: Fondamentaux\n\nCe chapitre présente les notions fondamentales. Nous définissons les concepts clés, le vocabulaire et le contexte technique. Vous apprendrez la terminologie, les métriques d\'évaluation et verrez des exemples concrets pour comprendre pourquoi ces méthodes sont utiles.\n\nExercice / Objectifs : Lecture et compréhension. Résumer les points clés.','Contenu: Texte introductif','2025-11-25 22:33:26','2025-11-25 22:33:26',1,NULL,NULL),(59,2,4,_binary '',900,'Y',_binary '',NULL,'Cours: Introduction à l\'Intelligence Artificielle\n\nChapitre: Méthodes\n\nCe chapitre décrit les méthodes principales et leurs fondements mathématiques. Nous couvrons les algorithmes, le prétraitement des données, le choix des features et les bonnes pratiques d\'implémentation. Un petit guide pas-à-pas montre comment implémenter un modèle de base.\n\nExercice / Objectifs : Lecture et compréhension. Résumer les points clés.','Contenu: Méthode détaillée','2025-11-25 22:33:26','2025-11-25 22:33:26',1,NULL,NULL),(60,1,4,_binary '',900,'Y',_binary '',NULL,'Cours: Introduction à l\'Intelligence Artificielle\n\nChapitre: Applications pratiques\n\nCe chapitre montre des cas pratiques et un mini-projet. Il détaille un pipeline complet, propose des exercices guidés et des pistes d\'évaluation pour mesurer la performance en condition réelle.\n\nExercice / Objectifs : Lecture et compréhension. Résumer les points clés.','Contenu: Projet & exercices','2025-11-25 22:33:26','2025-11-25 22:33:26',1,NULL,NULL),(61,60,4,_binary '',600,'Y',_binary '',NULL,'Cours: Projet capstone : construire une solution IA complète\n\nChapitre: Fondamentaux\n\nCe chapitre présente les notions fondamentales. Nous définissons les concepts clés, le vocabulaire et le contexte technique. Vous apprendrez la terminologie, les métriques d\'évaluation et verrez des exemples concrets pour comprendre pourquoi ces méthodes sont utiles.\n\nExercice / Objectifs : Implémentation guidée.','Contenu: Texte introductif','2025-11-25 22:33:26','2025-11-25 22:33:26',2,NULL,NULL),(62,59,4,_binary '',600,'Y',_binary '',NULL,'Cours: Projet capstone : construire une solution IA complète\n\nChapitre: Méthodes\n\nCe chapitre décrit les méthodes principales et leurs fondements mathématiques. Nous couvrons les algorithmes, le prétraitement des données, le choix des features et les bonnes pratiques d\'implémentation. Un petit guide pas-à-pas montre comment implémenter un modèle de base.\n\nExercice / Objectifs : Implémentation guidée.','Contenu: Méthode détaillée','2025-11-25 22:33:26','2025-11-25 22:33:26',2,NULL,NULL),(63,58,4,_binary '',600,'Y',_binary '',NULL,'Cours: Projet capstone : construire une solution IA complète\n\nChapitre: Applications pratiques\n\nCe chapitre montre des cas pratiques et un mini-projet. Il détaille un pipeline complet, propose des exercices guidés et des pistes d\'évaluation pour mesurer la performance en condition réelle.\n\nExercice / Objectifs : Implémentation guidée.','Contenu: Projet & exercices','2025-11-25 22:33:26','2025-11-25 22:33:26',2,NULL,NULL),(64,57,4,_binary '',600,'Y',_binary '',NULL,'Cours: IA pour la santé\n\nChapitre: Fondamentaux\n\nCe chapitre présente les notions fondamentales. Nous définissons les concepts clés, le vocabulaire et le contexte technique. Vous apprendrez la terminologie, les métriques d\'évaluation et verrez des exemples concrets pour comprendre pourquoi ces méthodes sont utiles.\n\nExercice / Objectifs : Implémentation guidée.','Contenu: Texte introductif','2025-11-25 22:33:26','2025-11-25 22:33:26',2,NULL,NULL),(65,56,4,_binary '',600,'Y',_binary '',NULL,'Cours: IA pour la santé\n\nChapitre: Méthodes\n\nCe chapitre décrit les méthodes principales et leurs fondements mathématiques. Nous couvrons les algorithmes, le prétraitement des données, le choix des features et les bonnes pratiques d\'implémentation. Un petit guide pas-à-pas montre comment implémenter un modèle de base.\n\nExercice / Objectifs : Implémentation guidée.','Contenu: Méthode détaillée','2025-11-25 22:33:26','2025-11-25 22:33:26',2,NULL,NULL),(66,55,4,_binary '',600,'Y',_binary '',NULL,'Cours: IA pour la santé\n\nChapitre: Applications pratiques\n\nCe chapitre montre des cas pratiques et un mini-projet. Il détaille un pipeline complet, propose des exercices guidés et des pistes d\'évaluation pour mesurer la performance en condition réelle.\n\nExercice / Objectifs : Implémentation guidée.','Contenu: Projet & exercices','2025-11-25 22:33:26','2025-11-25 22:33:26',2,NULL,NULL),(67,54,4,_binary '',600,'Y',_binary '',NULL,'Cours: Pratiques avancées de data labeling\n\nChapitre: Fondamentaux\n\nCe chapitre présente les notions fondamentales. Nous définissons les concepts clés, le vocabulaire et le contexte technique. Vous apprendrez la terminologie, les métriques d\'évaluation et verrez des exemples concrets pour comprendre pourquoi ces méthodes sont utiles.\n\nExercice / Objectifs : Implémentation guidée.','Contenu: Texte introductif','2025-11-25 22:33:26','2025-11-25 22:33:26',2,NULL,NULL),(68,53,4,_binary '',600,'Y',_binary '',NULL,'Cours: Pratiques avancées de data labeling\n\nChapitre: Méthodes\n\nCe chapitre décrit les méthodes principales et leurs fondements mathématiques. Nous couvrons les algorithmes, le prétraitement des données, le choix des features et les bonnes pratiques d\'implémentation. Un petit guide pas-à-pas montre comment implémenter un modèle de base.\n\nExercice / Objectifs : Implémentation guidée.','Contenu: Méthode détaillée','2025-11-25 22:33:26','2025-11-25 22:33:26',2,NULL,NULL),(69,52,4,_binary '',600,'Y',_binary '',NULL,'Cours: Pratiques avancées de data labeling\n\nChapitre: Applications pratiques\n\nCe chapitre montre des cas pratiques et un mini-projet. Il détaille un pipeline complet, propose des exercices guidés et des pistes d\'évaluation pour mesurer la performance en condition réelle.\n\nExercice / Objectifs : Implémentation guidée.','Contenu: Projet & exercices','2025-11-25 22:33:26','2025-11-25 22:33:26',2,NULL,NULL),(70,51,4,_binary '',600,'Y',_binary '',NULL,'Cours: Sécurité des modèles ML\n\nChapitre: Fondamentaux\n\nCe chapitre présente les notions fondamentales. Nous définissons les concepts clés, le vocabulaire et le contexte technique. Vous apprendrez la terminologie, les métriques d\'évaluation et verrez des exemples concrets pour comprendre pourquoi ces méthodes sont utiles.\n\nExercice / Objectifs : Implémentation guidée.','Contenu: Texte introductif','2025-11-25 22:33:26','2025-11-25 22:33:26',2,NULL,NULL),(71,50,4,_binary '',600,'Y',_binary '',NULL,'Cours: Sécurité des modèles ML\n\nChapitre: Méthodes\n\nCe chapitre décrit les méthodes principales et leurs fondements mathématiques. Nous couvrons les algorithmes, le prétraitement des données, le choix des features et les bonnes pratiques d\'implémentation. Un petit guide pas-à-pas montre comment implémenter un modèle de base.\n\nExercice / Objectifs : Implémentation guidée.','Contenu: Méthode détaillée','2025-11-25 22:33:26','2025-11-25 22:33:26',2,NULL,NULL),(72,49,4,_binary '',600,'Y',_binary '',NULL,'Cours: Sécurité des modèles ML\n\nChapitre: Applications pratiques\n\nCe chapitre montre des cas pratiques et un mini-projet. Il détaille un pipeline complet, propose des exercices guidés et des pistes d\'évaluation pour mesurer la performance en condition réelle.\n\nExercice / Objectifs : Implémentation guidée.','Contenu: Projet & exercices','2025-11-25 22:33:26','2025-11-25 22:33:26',2,NULL,NULL),(73,48,4,_binary '',600,'Y',_binary '',NULL,'Cours: IA et robotique : perception et contrôle\n\nChapitre: Fondamentaux\n\nCe chapitre présente les notions fondamentales. Nous définissons les concepts clés, le vocabulaire et le contexte technique. Vous apprendrez la terminologie, les métriques d\'évaluation et verrez des exemples concrets pour comprendre pourquoi ces méthodes sont utiles.\n\nExercice / Objectifs : Implémentation guidée.','Contenu: Texte introductif','2025-11-25 22:33:26','2025-11-25 22:33:26',2,NULL,NULL),(74,47,4,_binary '',600,'Y',_binary '',NULL,'Cours: IA et robotique : perception et contrôle\n\nChapitre: Méthodes\n\nCe chapitre décrit les méthodes principales et leurs fondements mathématiques. Nous couvrons les algorithmes, le prétraitement des données, le choix des features et les bonnes pratiques d\'implémentation. Un petit guide pas-à-pas montre comment implémenter un modèle de base.\n\nExercice / Objectifs : Implémentation guidée.','Contenu: Méthode détaillée','2025-11-25 22:33:26','2025-11-25 22:33:26',2,NULL,NULL),(75,46,4,_binary '',600,'Y',_binary '',NULL,'Cours: IA et robotique : perception et contrôle\n\nChapitre: Applications pratiques\n\nCe chapitre montre des cas pratiques et un mini-projet. Il détaille un pipeline complet, propose des exercices guidés et des pistes d\'évaluation pour mesurer la performance en condition réelle.\n\nExercice / Objectifs : Implémentation guidée.','Contenu: Projet & exercices','2025-11-25 22:33:26','2025-11-25 22:33:26',2,NULL,NULL),(76,45,4,_binary '',600,'Y',_binary '',NULL,'Cours: Graph ML : GNN et applications\n\nChapitre: Fondamentaux\n\nCe chapitre présente les notions fondamentales. Nous définissons les concepts clés, le vocabulaire et le contexte technique. Vous apprendrez la terminologie, les métriques d\'évaluation et verrez des exemples concrets pour comprendre pourquoi ces méthodes sont utiles.\n\nExercice / Objectifs : Implémentation guidée.','Contenu: Texte introductif','2025-11-25 22:33:26','2025-11-25 22:33:26',2,NULL,NULL),(77,44,4,_binary '',600,'Y',_binary '',NULL,'Cours: Graph ML : GNN et applications\n\nChapitre: Méthodes\n\nCe chapitre décrit les méthodes principales et leurs fondements mathématiques. Nous couvrons les algorithmes, le prétraitement des données, le choix des features et les bonnes pratiques d\'implémentation. Un petit guide pas-à-pas montre comment implémenter un modèle de base.\n\nExercice / Objectifs : Implémentation guidée.','Contenu: Méthode détaillée','2025-11-25 22:33:26','2025-11-25 22:33:26',2,NULL,NULL),(78,43,4,_binary '',600,'Y',_binary '',NULL,'Cours: Graph ML : GNN et applications\n\nChapitre: Applications pratiques\n\nCe chapitre montre des cas pratiques et un mini-projet. Il détaille un pipeline complet, propose des exercices guidés et des pistes d\'évaluation pour mesurer la performance en condition réelle.\n\nExercice / Objectifs : Implémentation guidée.','Contenu: Projet & exercices','2025-11-25 22:33:26','2025-11-25 22:33:26',2,NULL,NULL),(79,42,4,_binary '',600,'Y',_binary '',NULL,'Cours: Représentations et embeddings\n\nChapitre: Fondamentaux\n\nCe chapitre présente les notions fondamentales. Nous définissons les concepts clés, le vocabulaire et le contexte technique. Vous apprendrez la terminologie, les métriques d\'évaluation et verrez des exemples concrets pour comprendre pourquoi ces méthodes sont utiles.\n\nExercice / Objectifs : Implémentation guidée.','Contenu: Texte introductif','2025-11-25 22:33:26','2025-11-25 22:33:26',2,NULL,NULL),(80,41,4,_binary '',600,'Y',_binary '',NULL,'Cours: Représentations et embeddings\n\nChapitre: Méthodes\n\nCe chapitre décrit les méthodes principales et leurs fondements mathématiques. Nous couvrons les algorithmes, le prétraitement des données, le choix des features et les bonnes pratiques d\'implémentation. Un petit guide pas-à-pas montre comment implémenter un modèle de base.\n\nExercice / Objectifs : Implémentation guidée.','Contenu: Méthode détaillée','2025-11-25 22:33:26','2025-11-25 22:33:26',2,NULL,NULL),(81,40,4,_binary '',600,'Y',_binary '',NULL,'Cours: Représentations et embeddings\n\nChapitre: Applications pratiques\n\nCe chapitre montre des cas pratiques et un mini-projet. Il détaille un pipeline complet, propose des exercices guidés et des pistes d\'évaluation pour mesurer la performance en condition réelle.\n\nExercice / Objectifs : Implémentation guidée.','Contenu: Projet & exercices','2025-11-25 22:33:26','2025-11-25 22:33:26',2,NULL,NULL),(82,39,4,_binary '',600,'Y',_binary '',NULL,'Cours: AutoML et optimisation d\'hyperparamètres\n\nChapitre: Fondamentaux\n\nCe chapitre présente les notions fondamentales. Nous définissons les concepts clés, le vocabulaire et le contexte technique. Vous apprendrez la terminologie, les métriques d\'évaluation et verrez des exemples concrets pour comprendre pourquoi ces méthodes sont utiles.\n\nExercice / Objectifs : Implémentation guidée.','Contenu: Texte introductif','2025-11-25 22:33:26','2025-11-25 22:33:26',2,NULL,NULL),(83,38,4,_binary '',600,'Y',_binary '',NULL,'Cours: AutoML et optimisation d\'hyperparamètres\n\nChapitre: Méthodes\n\nCe chapitre décrit les méthodes principales et leurs fondements mathématiques. Nous couvrons les algorithmes, le prétraitement des données, le choix des features et les bonnes pratiques d\'implémentation. Un petit guide pas-à-pas montre comment implémenter un modèle de base.\n\nExercice / Objectifs : Implémentation guidée.','Contenu: Méthode détaillée','2025-11-25 22:33:26','2025-11-25 22:33:26',2,NULL,NULL),(84,37,4,_binary '',600,'Y',_binary '',NULL,'Cours: AutoML et optimisation d\'hyperparamètres\n\nChapitre: Applications pratiques\n\nCe chapitre montre des cas pratiques et un mini-projet. Il détaille un pipeline complet, propose des exercices guidés et des pistes d\'évaluation pour mesurer la performance en condition réelle.\n\nExercice / Objectifs : Implémentation guidée.','Contenu: Projet & exercices','2025-11-25 22:33:26','2025-11-25 22:33:26',2,NULL,NULL),(85,36,4,_binary '',600,'Y',_binary '',NULL,'Cours: Time Series & Forecasting\n\nChapitre: Fondamentaux\n\nCe chapitre présente les notions fondamentales. Nous définissons les concepts clés, le vocabulaire et le contexte technique. Vous apprendrez la terminologie, les métriques d\'évaluation et verrez des exemples concrets pour comprendre pourquoi ces méthodes sont utiles.\n\nExercice / Objectifs : Implémentation guidée.','Contenu: Texte introductif','2025-11-25 22:33:26','2025-11-25 22:33:26',2,NULL,NULL),(86,35,4,_binary '',600,'Y',_binary '',NULL,'Cours: Time Series & Forecasting\n\nChapitre: Méthodes\n\nCe chapitre décrit les méthodes principales et leurs fondements mathématiques. Nous couvrons les algorithmes, le prétraitement des données, le choix des features et les bonnes pratiques d\'implémentation. Un petit guide pas-à-pas montre comment implémenter un modèle de base.\n\nExercice / Objectifs : Implémentation guidée.','Contenu: Méthode détaillée','2025-11-25 22:33:26','2025-11-25 22:33:26',2,NULL,NULL),(87,34,4,_binary '',600,'Y',_binary '',NULL,'Cours: Time Series & Forecasting\n\nChapitre: Applications pratiques\n\nCe chapitre montre des cas pratiques et un mini-projet. Il détaille un pipeline complet, propose des exercices guidés et des pistes d\'évaluation pour mesurer la performance en condition réelle.\n\nExercice / Objectifs : Implémentation guidée.','Contenu: Projet & exercices','2025-11-25 22:33:26','2025-11-25 22:33:26',2,NULL,NULL),(88,33,4,_binary '',600,'Y',_binary '',NULL,'Cours: Computer Vision avancé : détection et segmentation\n\nChapitre: Fondamentaux\n\nCe chapitre présente les notions fondamentales. Nous définissons les concepts clés, le vocabulaire et le contexte technique. Vous apprendrez la terminologie, les métriques d\'évaluation et verrez des exemples concrets pour comprendre pourquoi ces méthodes sont utiles.\n\nExercice / Objectifs : Implémentation guidée.','Contenu: Texte introductif','2025-11-25 22:33:26','2025-11-25 22:33:26',2,NULL,NULL),(89,32,4,_binary '',600,'Y',_binary '',NULL,'Cours: Computer Vision avancé : détection et segmentation\n\nChapitre: Méthodes\n\nCe chapitre décrit les méthodes principales et leurs fondements mathématiques. Nous couvrons les algorithmes, le prétraitement des données, le choix des features et les bonnes pratiques d\'implémentation. Un petit guide pas-à-pas montre comment implémenter un modèle de base.\n\nExercice / Objectifs : Implémentation guidée.','Contenu: Méthode détaillée','2025-11-25 22:33:26','2025-11-25 22:33:26',2,NULL,NULL),(90,31,4,_binary '',600,'Y',_binary '',NULL,'Cours: Computer Vision avancé : détection et segmentation\n\nChapitre: Applications pratiques\n\nCe chapitre montre des cas pratiques et un mini-projet. Il détaille un pipeline complet, propose des exercices guidés et des pistes d\'évaluation pour mesurer la performance en condition réelle.\n\nExercice / Objectifs : Implémentation guidée.','Contenu: Projet & exercices','2025-11-25 22:33:26','2025-11-25 22:33:26',2,NULL,NULL),(91,30,4,_binary '',600,'Y',_binary '',NULL,'Cours: Feature Engineering avancé\n\nChapitre: Fondamentaux\n\nCe chapitre présente les notions fondamentales. Nous définissons les concepts clés, le vocabulaire et le contexte technique. Vous apprendrez la terminologie, les métriques d\'évaluation et verrez des exemples concrets pour comprendre pourquoi ces méthodes sont utiles.\n\nExercice / Objectifs : Implémentation guidée.','Contenu: Texte introductif','2025-11-25 22:33:26','2025-11-25 22:33:26',2,NULL,NULL),(92,29,4,_binary '',600,'Y',_binary '',NULL,'Cours: Feature Engineering avancé\n\nChapitre: Méthodes\n\nCe chapitre décrit les méthodes principales et leurs fondements mathématiques. Nous couvrons les algorithmes, le prétraitement des données, le choix des features et les bonnes pratiques d\'implémentation. Un petit guide pas-à-pas montre comment implémenter un modèle de base.\n\nExercice / Objectifs : Implémentation guidée.','Contenu: Méthode détaillée','2025-11-25 22:33:26','2025-11-25 22:33:26',2,NULL,NULL),(93,28,4,_binary '',600,'Y',_binary '',NULL,'Cours: Feature Engineering avancé\n\nChapitre: Applications pratiques\n\nCe chapitre montre des cas pratiques et un mini-projet. Il détaille un pipeline complet, propose des exercices guidés et des pistes d\'évaluation pour mesurer la performance en condition réelle.\n\nExercice / Objectifs : Implémentation guidée.','Contenu: Projet & exercices','2025-11-25 22:33:26','2025-11-25 22:33:26',2,NULL,NULL),(94,27,4,_binary '',600,'Y',_binary '',NULL,'Cours: Apprentissage par renforcement\n\nChapitre: Fondamentaux\n\nCe chapitre présente les notions fondamentales. Nous définissons les concepts clés, le vocabulaire et le contexte technique. Vous apprendrez la terminologie, les métriques d\'évaluation et verrez des exemples concrets pour comprendre pourquoi ces méthodes sont utiles.\n\nExercice / Objectifs : Implémentation guidée.','Contenu: Texte introductif','2025-11-25 22:33:26','2025-11-25 22:33:26',2,NULL,NULL),(95,26,4,_binary '',600,'Y',_binary '',NULL,'Cours: Apprentissage par renforcement\n\nChapitre: Méthodes\n\nCe chapitre décrit les méthodes principales et leurs fondements mathématiques. Nous couvrons les algorithmes, le prétraitement des données, le choix des features et les bonnes pratiques d\'implémentation. Un petit guide pas-à-pas montre comment implémenter un modèle de base.\n\nExercice / Objectifs : Implémentation guidée.','Contenu: Méthode détaillée','2025-11-25 22:33:26','2025-11-25 22:33:26',2,NULL,NULL),(96,25,4,_binary '',600,'Y',_binary '',NULL,'Cours: Apprentissage par renforcement\n\nChapitre: Applications pratiques\n\nCe chapitre montre des cas pratiques et un mini-projet. Il détaille un pipeline complet, propose des exercices guidés et des pistes d\'évaluation pour mesurer la performance en condition réelle.\n\nExercice / Objectifs : Implémentation guidée.','Contenu: Projet & exercices','2025-11-25 22:33:26','2025-11-25 22:33:26',2,NULL,NULL),(97,24,4,_binary '',600,'Y',_binary '',NULL,'Cours: Éthique et IA responsable\n\nChapitre: Fondamentaux\n\nCe chapitre présente les notions fondamentales. Nous définissons les concepts clés, le vocabulaire et le contexte technique. Vous apprendrez la terminologie, les métriques d\'évaluation et verrez des exemples concrets pour comprendre pourquoi ces méthodes sont utiles.\n\nExercice / Objectifs : Implémentation guidée.','Contenu: Texte introductif','2025-11-25 22:33:26','2025-11-25 22:33:26',2,NULL,NULL),(98,23,4,_binary '',600,'Y',_binary '',NULL,'Cours: Éthique et IA responsable\n\nChapitre: Méthodes\n\nCe chapitre décrit les méthodes principales et leurs fondements mathématiques. Nous couvrons les algorithmes, le prétraitement des données, le choix des features et les bonnes pratiques d\'implémentation. Un petit guide pas-à-pas montre comment implémenter un modèle de base.\n\nExercice / Objectifs : Implémentation guidée.','Contenu: Méthode détaillée','2025-11-25 22:33:26','2025-11-25 22:33:26',2,NULL,NULL),(99,22,4,_binary '',600,'Y',_binary '',NULL,'Cours: Éthique et IA responsable\n\nChapitre: Applications pratiques\n\nCe chapitre montre des cas pratiques et un mini-projet. Il détaille un pipeline complet, propose des exercices guidés et des pistes d\'évaluation pour mesurer la performance en condition réelle.\n\nExercice / Objectifs : Implémentation guidée.','Contenu: Projet & exercices','2025-11-25 22:33:26','2025-11-25 22:33:26',2,NULL,NULL),(100,21,4,_binary '',600,'Y',_binary '',NULL,'Cours: MLOps : mise en production de modèles\n\nChapitre: Fondamentaux\n\nCe chapitre présente les notions fondamentales. Nous définissons les concepts clés, le vocabulaire et le contexte technique. Vous apprendrez la terminologie, les métriques d\'évaluation et verrez des exemples concrets pour comprendre pourquoi ces méthodes sont utiles.\n\nExercice / Objectifs : Implémentation guidée.','Contenu: Texte introductif','2025-11-25 22:33:26','2025-11-25 22:33:26',2,NULL,NULL),(101,20,4,_binary '',600,'Y',_binary '',NULL,'Cours: MLOps : mise en production de modèles\n\nChapitre: Méthodes\n\nCe chapitre décrit les méthodes principales et leurs fondements mathématiques. Nous couvrons les algorithmes, le prétraitement des données, le choix des features et les bonnes pratiques d\'implémentation. Un petit guide pas-à-pas montre comment implémenter un modèle de base.\n\nExercice / Objectifs : Implémentation guidée.','Contenu: Méthode détaillée','2025-11-25 22:33:26','2025-11-25 22:33:26',2,NULL,NULL),(102,19,4,_binary '',600,'Y',_binary '',NULL,'Cours: MLOps : mise en production de modèles\n\nChapitre: Applications pratiques\n\nCe chapitre montre des cas pratiques et un mini-projet. Il détaille un pipeline complet, propose des exercices guidés et des pistes d\'évaluation pour mesurer la performance en condition réelle.\n\nExercice / Objectifs : Implémentation guidée.','Contenu: Projet & exercices','2025-11-25 22:33:26','2025-11-25 22:33:26',2,NULL,NULL),(103,18,4,_binary '',600,'Y',_binary '',NULL,'Cours: Modèles probabilistes et bayésiens\n\nChapitre: Fondamentaux\n\nCe chapitre présente les notions fondamentales. Nous définissons les concepts clés, le vocabulaire et le contexte technique. Vous apprendrez la terminologie, les métriques d\'évaluation et verrez des exemples concrets pour comprendre pourquoi ces méthodes sont utiles.\n\nExercice / Objectifs : Implémentation guidée.','Contenu: Texte introductif','2025-11-25 22:33:26','2025-11-25 22:33:26',2,NULL,NULL),(104,17,4,_binary '',600,'Y',_binary '',NULL,'Cours: Modèles probabilistes et bayésiens\n\nChapitre: Méthodes\n\nCe chapitre décrit les méthodes principales et leurs fondements mathématiques. Nous couvrons les algorithmes, le prétraitement des données, le choix des features et les bonnes pratiques d\'implémentation. Un petit guide pas-à-pas montre comment implémenter un modèle de base.\n\nExercice / Objectifs : Implémentation guidée.','Contenu: Méthode détaillée','2025-11-25 22:33:26','2025-11-25 22:33:26',2,NULL,NULL),(105,16,4,_binary '',600,'Y',_binary '',NULL,'Cours: Modèles probabilistes et bayésiens\n\nChapitre: Applications pratiques\n\nCe chapitre montre des cas pratiques et un mini-projet. Il détaille un pipeline complet, propose des exercices guidés et des pistes d\'évaluation pour mesurer la performance en condition réelle.\n\nExercice / Objectifs : Implémentation guidée.','Contenu: Projet & exercices','2025-11-25 22:33:26','2025-11-25 22:33:26',2,NULL,NULL),(106,15,4,_binary '',600,'Y',_binary '',NULL,'Cours: Apprentissage non supervisé et clustering\n\nChapitre: Fondamentaux\n\nCe chapitre présente les notions fondamentales. Nous définissons les concepts clés, le vocabulaire et le contexte technique. Vous apprendrez la terminologie, les métriques d\'évaluation et verrez des exemples concrets pour comprendre pourquoi ces méthodes sont utiles.\n\nExercice / Objectifs : Implémentation guidée.','Contenu: Texte introductif','2025-11-25 22:33:26','2025-11-25 22:33:26',2,NULL,NULL),(107,14,4,_binary '',600,'Y',_binary '',NULL,'Cours: Apprentissage non supervisé et clustering\n\nChapitre: Méthodes\n\nCe chapitre décrit les méthodes principales et leurs fondements mathématiques. Nous couvrons les algorithmes, le prétraitement des données, le choix des features et les bonnes pratiques d\'implémentation. Un petit guide pas-à-pas montre comment implémenter un modèle de base.\n\nExercice / Objectifs : Implémentation guidée.','Contenu: Méthode détaillée','2025-11-25 22:33:26','2025-11-25 22:33:26',2,NULL,NULL),(108,13,4,_binary '',600,'Y',_binary '',NULL,'Cours: Apprentissage non supervisé et clustering\n\nChapitre: Applications pratiques\n\nCe chapitre montre des cas pratiques et un mini-projet. Il détaille un pipeline complet, propose des exercices guidés et des pistes d\'évaluation pour mesurer la performance en condition réelle.\n\nExercice / Objectifs : Implémentation guidée.','Contenu: Projet & exercices','2025-11-25 22:33:26','2025-11-25 22:33:26',2,NULL,NULL),(109,12,4,_binary '',600,'Y',_binary '',NULL,'Cours: NLP : traitement du langage naturel\n\nChapitre: Fondamentaux\n\nCe chapitre présente les notions fondamentales. Nous définissons les concepts clés, le vocabulaire et le contexte technique. Vous apprendrez la terminologie, les métriques d\'évaluation et verrez des exemples concrets pour comprendre pourquoi ces méthodes sont utiles.\n\nExercice / Objectifs : Implémentation guidée.','Contenu: Texte introductif','2025-11-25 22:33:26','2025-11-25 22:33:26',2,NULL,NULL),(110,11,4,_binary '',600,'Y',_binary '',NULL,'Cours: NLP : traitement du langage naturel\n\nChapitre: Méthodes\n\nCe chapitre décrit les méthodes principales et leurs fondements mathématiques. Nous couvrons les algorithmes, le prétraitement des données, le choix des features et les bonnes pratiques d\'implémentation. Un petit guide pas-à-pas montre comment implémenter un modèle de base.\n\nExercice / Objectifs : Implémentation guidée.','Contenu: Méthode détaillée','2025-11-25 22:33:26','2025-11-25 22:33:26',2,NULL,NULL),(111,10,4,_binary '',600,'Y',_binary '',NULL,'Cours: NLP : traitement du langage naturel\n\nChapitre: Applications pratiques\n\nCe chapitre montre des cas pratiques et un mini-projet. Il détaille un pipeline complet, propose des exercices guidés et des pistes d\'évaluation pour mesurer la performance en condition réelle.\n\nExercice / Objectifs : Implémentation guidée.','Contenu: Projet & exercices','2025-11-25 22:33:26','2025-11-25 22:33:26',2,NULL,NULL),(112,9,4,_binary '',600,'Y',_binary '',NULL,'Cours: Deep Learning pour vision par ordinateur\n\nChapitre: Fondamentaux\n\nCe chapitre présente les notions fondamentales. Nous définissons les concepts clés, le vocabulaire et le contexte technique. Vous apprendrez la terminologie, les métriques d\'évaluation et verrez des exemples concrets pour comprendre pourquoi ces méthodes sont utiles.\n\nExercice / Objectifs : Implémentation guidée.','Contenu: Texte introductif','2025-11-25 22:33:26','2025-11-25 22:33:26',2,NULL,NULL),(113,8,4,_binary '',600,'Y',_binary '',NULL,'Cours: Deep Learning pour vision par ordinateur\n\nChapitre: Méthodes\n\nCe chapitre décrit les méthodes principales et leurs fondements mathématiques. Nous couvrons les algorithmes, le prétraitement des données, le choix des features et les bonnes pratiques d\'implémentation. Un petit guide pas-à-pas montre comment implémenter un modèle de base.\n\nExercice / Objectifs : Implémentation guidée.','Contenu: Méthode détaillée','2025-11-25 22:33:26','2025-11-25 22:33:26',2,NULL,NULL),(114,7,4,_binary '',600,'Y',_binary '',NULL,'Cours: Deep Learning pour vision par ordinateur\n\nChapitre: Applications pratiques\n\nCe chapitre montre des cas pratiques et un mini-projet. Il détaille un pipeline complet, propose des exercices guidés et des pistes d\'évaluation pour mesurer la performance en condition réelle.\n\nExercice / Objectifs : Implémentation guidée.','Contenu: Projet & exercices','2025-11-25 22:33:26','2025-11-25 22:33:26',2,NULL,NULL),(116,5,4,_binary '',600,'Y',_binary '',NULL,'Cours: Machine Learning : notions et algorithmes\n\nChapitre: Méthodes\n\nCe chapitre décrit les méthodes principales et leurs fondements mathématiques. Nous couvrons les algorithmes, le prétraitement des données, le choix des features et les bonnes pratiques d\'implémentation. Un petit guide pas-à-pas montre comment implémenter un modèle de base.\n\nExercice / Objectifs : Implémentation guidée.','Contenu: Méthode détaillée','2025-11-25 22:33:26','2025-11-25 22:33:26',2,NULL,NULL),(117,4,4,_binary '',600,'Y',_binary '',NULL,'Cours: Machine Learning : notions et algorithmes\n\nChapitre: Applications pratiques\n\nCe chapitre montre des cas pratiques et un mini-projet. Il détaille un pipeline complet, propose des exercices guidés et des pistes d\'évaluation pour mesurer la performance en condition réelle.\n\nExercice / Objectifs : Implémentation guidée.','Contenu: Projet & exercices','2025-11-25 22:33:26','2025-11-25 22:33:26',2,NULL,NULL),(118,3,4,_binary '',600,'Y',_binary '',NULL,'Cours: Introduction à l\'Intelligence Artificielle\n\nChapitre: Fondamentaux\n\nCe chapitre présente les notions fondamentales. Nous définissons les concepts clés, le vocabulaire et le contexte technique. Vous apprendrez la terminologie, les métriques d\'évaluation et verrez des exemples concrets pour comprendre pourquoi ces méthodes sont utiles.\n\nExercice / Objectifs : Implémentation guidée.','Contenu: Texte introductif','2025-11-25 22:33:26','2025-11-25 22:33:26',2,NULL,NULL),(119,2,4,_binary '',600,'Y',_binary '',NULL,'Cours: Introduction à l\'Intelligence Artificielle\n\nChapitre: Méthodes\n\nCe chapitre décrit les méthodes principales et leurs fondements mathématiques. Nous couvrons les algorithmes, le prétraitement des données, le choix des features et les bonnes pratiques d\'implémentation. Un petit guide pas-à-pas montre comment implémenter un modèle de base.\n\nExercice / Objectifs : Implémentation guidée.','Contenu: Méthode détaillée','2025-11-25 22:33:26','2025-11-25 22:33:26',2,NULL,NULL),(120,1,4,_binary '',600,'Y',_binary '',NULL,'Cours: Introduction à l\'Intelligence Artificielle\n\nChapitre: Applications pratiques\n\nCe chapitre montre des cas pratiques et un mini-projet. Il détaille un pipeline complet, propose des exercices guidés et des pistes d\'évaluation pour mesurer la performance en condition réelle.\n\nExercice / Objectifs : Implémentation guidée.','Contenu: Projet & exercices','2025-11-25 22:33:26','2025-11-25 22:33:26',2,NULL,NULL),(125,6,4,_binary '\0',0,'1',_binary '','','mmmmmmmmmmmmmmm','mmm','2025-12-04 21:31:59','2025-12-04 21:31:59',1,'',0),(126,6,4,_binary '\0',0,'1',_binary '','','huhiuhiuhiuhi','hiuhiuhiuhiu','2025-12-04 21:37:33','2025-12-04 21:37:33',2,'',0),(127,63,1,_binary '\0',0,'1',_binary '',NULL,'Le spectre d\'un opérateur T sur un espace de Banach X est l\'ensemble des scalaires λ pour lesquels T - λI n\'est pas inversible. Le spectre ponctuel correspond aux valeurs propres, tandis que le spectre continu caractérise les λ où T - λI est injectif mais non surjectif. Le spectre résiduel survient lorsque l\'image n\'est pas dense. Des opérateurs de multiplication sur L²([0,1]) et des opérateurs de shift fournissent des illustrations significatives de ces concepts.','Définition du spectre d\'un opérateur linéaire borné : distinctions entre spectre ponctuel, continu et résiduel avec exemples','2025-12-11 16:27:18','2025-12-11 16:27:18',1,NULL,NULL),(128,63,1,_binary '\0',0,'1',_binary '',NULL,'Le spectre d\'un opérateur borné est toujours un compact non vide dans le plan complexe, contenu dans le disque de rayon égal à la norme de l\'opérateur. La théorie des perturbations montre que le spectre essentiel est stable sous l\'addition d\'opérateurs compacts. Ces résultats sont fondamentaux pour l\'analyse asymptotique et la stabilité spectrale dans les équations aux dérivées partielles. La démonstration de la compacité utilise la continuité de la résolvante hors du spectre.','Propriétés topologiques du spectre : compacité, bornitude et invariance sous perturbations compactes des opérateurs','2025-12-11 16:27:18','2025-12-11 16:27:18',2,NULL,NULL),(129,63,1,_binary '\0',0,'1',_binary '',NULL,'La fonction résolvante R(λ,T) = (T - λI)⁻¹ est définie et holomorphe sur le complémentaire du spectre. Son développement en série de Neumann converge pour |λ| > ||T||. Cette analyticité permet de définir un calcul fonctionnel pour les fonctions holomorphes sur un voisinage du spectre, en intégrant la résolvante le long de contours appropriés. Le théorème de représentation spectrale en découle naturellement pour les opérateurs normaux.','Fonction résolvante et son développement en série : analyticité et applications au calcul fonctionnel holomorphe','2025-12-11 16:27:18','2025-12-11 16:27:18',3,NULL,NULL),(130,64,1,_binary '\0',0,'1',_binary '',NULL,'Pour tout opérateur auto-adjoint borné T sur un espace de Hilbert, il existe une mesure spectrale E sur les boréliens de ℝ telle que T = ∫ λ dE(λ). Cette intégrale définit un isomorphisme entre l\'algèbre des fonctions boréliennes bornées et une algèbre d\'opérateurs. La mesure E projecte l\'espace sur les sous-espaces propres généralisés. La démonstration utilise la transformée de Cayley et le théorème de Riesz-Markov.','Théorème spectral pour les opérateurs auto-adjoints bornés : construction de la mesure spectrale et diagonalisation','2025-12-11 16:27:18','2025-12-11 16:27:18',1,NULL,NULL),(131,64,1,_binary '\0',0,'1',_binary '',NULL,'Le calcul fonctionnel s\'étend aux opérateurs normaux (TT* = T*T) en utilisant le spectre dans ℂ. Pour toute fonction borélienne bornée f, l\'opérateur f(T) est défini par intégration spectrale. Ce cadre permet de traiter simultanément les opérateurs auto-adjoints et unitaires. Des applications incluent la définition de l\'exponentielle d\'opérateurs pour les équations d\'évolution et la racine carrée d\'opérateurs positifs.','Calcul fonctionnel pour les opérateurs normaux : extension aux fonctions continues et boréliennes avec applications','2025-12-11 16:27:18','2025-12-11 16:27:18',2,NULL,NULL),(132,64,1,_binary '\0',0,'1',_binary '',NULL,'Les opérateurs compacts auto-adjoints possèdent un spectre purement ponctuel, avec des valeurs propres réelles tendant vers zéro. Le théorème spectral assure une décomposition en série T = ∑ λₙ ⟨·,φₙ⟩ φₙ, où {φₙ} est une base hilbertienne de vecteurs propres. Le théorème de Hilbert-Schmidt caractérise ces opérateurs comme limites d\'opérateurs de rang fini. Cette décomposition est cruciale pour les problèmes variationnels.','Opérateurs compacts auto-adjoints : décomposition discrète en série de valeurs propres et théorème de Hilbert-Schmidt','2025-12-11 16:27:18','2025-12-11 16:27:18',3,NULL,NULL),(133,65,1,_binary '\0',0,'1',_binary '',NULL,'Un opérateur non borné T est dit auto-adjoint si T = T* et dom(T) = dom(T*). Le théorème de Stone garantit que iT génère un groupe unitaire. Les conditions de symétrie essentielle et de défaut nulle caractérisent l\'existence d\'extensions auto-adjointes. Des exemples incluent l\'opérateur de Laplace avec conditions aux limites et les opérateurs de multiplication par des fonctions non bornées.','Opérateurs non bornés et leurs extensions auto-adjointes : critères de Stone-von Neumann et domaines essentiels','2025-12-11 16:27:18','2025-12-11 16:27:18',1,NULL,NULL),(134,65,1,_binary '\0',0,'1',_binary '',NULL,'Le calcul fonctionnel pour un opérateur auto-adjoint non borné T se construit via la mesure spectrale associée, définie sur ℝ. La transformée de Cayley κ(T) = (T - i)(T + i)⁻¹ permet de ramener le problème à un opérateur unitaire borné. Ce formalisme est essentiel pour définir des fonctions comme exp(itT) dans les équations d\'évolution ou les résolvantes de problèmes spectraux.','Calcul fonctionnel pour opérateurs non bornés : définition via la transformée de Cayley et applications spectrales','2025-12-11 16:27:18','2025-12-11 16:27:18',2,NULL,NULL),(135,65,1,_binary '\0',0,'1',_binary '',NULL,'L\'analyse spectrale des Hamiltoniens -Δ + V sur L²(ℝⁿ) révèle une structure riche : spectre discret (états liés) et continu (états de diffusion). La théorie des perturbations permet d\'étudier la stabilité des valeurs propres sous des potentiels décroissants. Les opérateurs de Schatten-von Neumann classifient la compacité des résolvantes. Ces outils sont centraux en théorie quantique des champs et en chimie computationnelle.','Applications en mécanique quantique : spectre des Hamiltoniens, états liés et diffusion dans les potentiels locaux','2025-12-11 16:27:18','2025-12-11 16:27:18',3,NULL,NULL),(136,66,4,_binary '\0',0,'1',_binary '',NULL,'Le spectre d\'un opérateur T sur un espace de Banach X est l\'ensemble des scalaires λ pour lesquels T - λI n\'est pas inversible. Le spectre ponctuel correspond aux valeurs propres, tandis que le spectre continu caractérise les λ où T - λI est injectif mais non surjectif. Le spectre résiduel survient lorsque l\'image n\'est pas dense. Des opérateurs de multiplication sur L²([0,1]) et des opérateurs de shift fournissent des illustrations significatives de ces concepts.','Définition du spectre d\'un opérateur linéaire borné : distinctions entre spectre ponctuel, continu et résiduel avec exemples','2025-12-11 17:07:30','2025-12-11 17:07:30',1,NULL,NULL),(137,66,4,_binary '\0',0,'1',_binary '',NULL,'Le spectre d\'un opérateur borné est toujours un compact non vide dans le plan complexe, contenu dans le disque de rayon égal à la norme de l\'opérateur. La théorie des perturbations montre que le spectre essentiel est stable sous l\'addition d\'opérateurs compacts. Ces résultats sont fondamentaux pour l\'analyse asymptotique et la stabilité spectrale dans les équations aux dérivées partielles. La démonstration de la compacité utilise la continuité de la résolvante hors du spectre.','Propriétés topologiques du spectre : compacité, bornitude et invariance sous perturbations compactes des opérateurs','2025-12-11 17:07:30','2025-12-11 17:07:30',2,NULL,NULL),(138,66,4,_binary '\0',0,'1',_binary '',NULL,'La fonction résolvante R(λ,T) = (T - λI)⁻¹ est définie et holomorphe sur le complémentaire du spectre. Son développement en série de Neumann converge pour |λ| > ||T||. Cette analyticité permet de définir un calcul fonctionnel pour les fonctions holomorphes sur un voisinage du spectre, en intégrant la résolvante le long de contours appropriés. Le théorème de représentation spectrale en découle naturellement pour les opérateurs normaux.','Fonction résolvante et son développement en série : analyticité et applications au calcul fonctionnel holomorphe','2025-12-11 17:07:30','2025-12-11 17:07:30',3,NULL,NULL),(139,67,4,_binary '\0',0,'1',_binary '',NULL,'Pour tout opérateur auto-adjoint borné T sur un espace de Hilbert, il existe une mesure spectrale E sur les boréliens de ℝ telle que T = ∫ λ dE(λ). Cette intégrale définit un isomorphisme entre l\'algèbre des fonctions boréliennes bornées et une algèbre d\'opérateurs. La mesure E projecte l\'espace sur les sous-espaces propres généralisés. La démonstration utilise la transformée de Cayley et le théorème de Riesz-Markov.','Théorème spectral pour les opérateurs auto-adjoints bornés : construction de la mesure spectrale et diagonalisation','2025-12-11 17:07:30','2025-12-11 17:07:30',1,NULL,NULL),(140,67,4,_binary '\0',0,'1',_binary '',NULL,'Le calcul fonctionnel s\'étend aux opérateurs normaux (TT* = T*T) en utilisant le spectre dans ℂ. Pour toute fonction borélienne bornée f, l\'opérateur f(T) est défini par intégration spectrale. Ce cadre permet de traiter simultanément les opérateurs auto-adjoints et unitaires. Des applications incluent la définition de l\'exponentielle d\'opérateurs pour les équations d\'évolution et la racine carrée d\'opérateurs positifs.','Calcul fonctionnel pour les opérateurs normaux : extension aux fonctions continues et boréliennes avec applications','2025-12-11 17:07:30','2025-12-11 17:07:30',2,NULL,NULL),(141,67,4,_binary '\0',0,'1',_binary '',NULL,'Les opérateurs compacts auto-adjoints possèdent un spectre purement ponctuel, avec des valeurs propres réelles tendant vers zéro. Le théorème spectral assure une décomposition en série T = ∑ λₙ ⟨·,φₙ⟩ φₙ, où {φₙ} est une base hilbertienne de vecteurs propres. Le théorème de Hilbert-Schmidt caractérise ces opérateurs comme limites d\'opérateurs de rang fini. Cette décomposition est cruciale pour les problèmes variationnels.','Opérateurs compacts auto-adjoints : décomposition discrète en série de valeurs propres et théorème de Hilbert-Schmidt','2025-12-11 17:07:30','2025-12-11 17:07:30',3,NULL,NULL),(142,68,4,_binary '\0',0,'1',_binary '',NULL,'Un opérateur non borné T est dit auto-adjoint si T = T* et dom(T) = dom(T*). Le théorème de Stone garantit que iT génère un groupe unitaire. Les conditions de symétrie essentielle et de défaut nulle caractérisent l\'existence d\'extensions auto-adjointes. Des exemples incluent l\'opérateur de Laplace avec conditions aux limites et les opérateurs de multiplication par des fonctions non bornées.','Opérateurs non bornés et leurs extensions auto-adjointes : critères de Stone-von Neumann et domaines essentiels','2025-12-11 17:07:30','2025-12-11 17:07:30',1,NULL,NULL),(143,68,4,_binary '\0',0,'1',_binary '',NULL,'Le calcul fonctionnel pour un opérateur auto-adjoint non borné T se construit via la mesure spectrale associée, définie sur ℝ. La transformée de Cayley κ(T) = (T - i)(T + i)⁻¹ permet de ramener le problème à un opérateur unitaire borné. Ce formalisme est essentiel pour définir des fonctions comme exp(itT) dans les équations d\'évolution ou les résolvantes de problèmes spectraux.','Calcul fonctionnel pour opérateurs non bornés : définition via la transformée de Cayley et applications spectrales','2025-12-11 17:07:30','2025-12-11 17:07:30',2,NULL,NULL),(144,68,4,_binary '\0',0,'1',_binary '',NULL,'L\'analyse spectrale des Hamiltoniens -Δ + V sur L²(ℝⁿ) révèle une structure riche : spectre discret (états liés) et continu (états de diffusion). La théorie des perturbations permet d\'étudier la stabilité des valeurs propres sous des potentiels décroissants. Les opérateurs de Schatten-von Neumann classifient la compacité des résolvantes. Ces outils sont centraux en théorie quantique des champs et en chimie computationnelle.','Applications en mécanique quantique : spectre des Hamiltoniens, états liés et diffusion dans les potentiels locaux','2025-12-11 17:07:30','2025-12-11 17:07:30',3,NULL,NULL),(145,69,4,_binary '\0',0,'1',_binary '',NULL,'Pierre Larousse, avec son Nouveau Dictionnaire de la Langue Française en1856, a instauré une philosophie novatrice combinant définitions précises et illustrations encyclopédiques. Au fil des décennies, les éditions se sont enrichies, intégrant des néologismes, des régionalismes et adaptant leur contenu aux avancées scientifiques et sociales. La transition vers le numérique a introduit de nouvelles fonctionnalités interactives, tout en conservant la rigueur lexicographique qui fait son autorité.','Histoire et évolution du Dictionnaire Larousse depuis Pierre Larousse, mettant en lumière ses principes fondateurs et ses transformations majeures jusqu\'à l\'ère numérique','2025-12-11 17:13:48','2025-12-11 17:13:48',1,NULL,NULL),(146,69,4,_binary '\0',0,'1',_binary '',NULL,'Un article typique commence par le mot en gras, suivi de sa transcription phonétique entre crochets. Vient ensuite la nature grammaticale abrégée (n.m., v.tr., etc.), puis l\'origine étymologique succincte. Les différentes acceptions sont numérotées et souvent classées par ordre de fréquence ou historique, chacune étant illustrée par des exemples phrases ou des citations littéraires qui contextualisent l\'emploi. Des renvois vers des synonymes, des antonymes ou des homophones complètent l\'information.','Décryptage de la structure interne d\'un article complexe : entrée, catégorie grammaticale, prononciation, étymologie, définitions hiérarchisées et exemples d\'usage','2025-12-11 17:13:48','2025-12-11 17:13:48',2,NULL,NULL),(147,69,4,_binary '\0',0,'1',_binary '',NULL,'Au-delà de la simple recherche alphabétique, le Larousse offre des outils puissants. Les index thématiques permettent d\'explorer un champ lexical complet. Les planches illustrées, particulièrement utiles pour la botanique ou l\'anatomie, associent visuellement les termes techniques. Les suppléments en ligne ou en fin de volume, avec des chronologies, des biographies ou des données géopolitiques, transforment le dictionnaire en une véritable base de connaissances interconnectée, nécessitant une méthodologie de croisement des informations.','Techniques de recherche avancée et utilisation des index thématiques, des planches illustrées et des suppléments encyclopédiques pour une consultation optimale','2025-12-11 17:13:48','2025-12-11 17:13:48',3,NULL,NULL),(148,70,4,_binary '\0',0,'1',_binary '',NULL,'La polysémie, où un même mot possède plusieurs sens, est centrale. Le Larousse permet de distinguer ces acceptions, par exemple pour le mot \'œuvre\' (production artistique, action de faire, ensemble des productions). La synonymie n\'est jamais parfaite ; consulter les synonymes proposés révèle des différences de registre ou de connotation. Les relations d\'inclusion (hyperonymie/hyponymie), comme \'fleur\' et \'rose\', sont également explicites, aidant à structurer le vocabulaire de manière logique et hiérarchique.','Analyse fine des nuances sémantiques et des réseaux lexicaux : polysémie, synonymie imparfaite, hyperonymie et hyponymie à travers les définitions','2025-12-11 17:13:48','2025-12-11 17:13:48',1,NULL,NULL),(149,70,4,_binary '\0',0,'1',_binary '',NULL,'Les marques telles que \'(vieilli)\', \'(littéraire)\', \'(familier)\', \'(argotique)\' ou \'(technique)\' sont cruciales pour éviter les maladresses de style. Comprendre que \'bagnole\' est familier tandis que \'automobile\' est standard influence le choix des mots dans un discours formel. De même, identifier un terme comme appartenant au vocabulaire juridique ou médical permet de l\'utiliser à bon escient. Cette leçon enseigne à lire ces indications comme des guides pour une expression précise et adaptée à chaque situation de communication.','Interprétation des marques d\'usage et des registres de langue pour un emploi contextuellement approprié des termes dans la communication écrite et orale','2025-12-11 17:13:48','2025-12-11 17:13:48',2,NULL,NULL),(150,70,4,_binary '\0',0,'1',_binary '',NULL,'L\'ultime étape est l\'application concrète. face à un texte à améliorer, le dictionnaire sert à trouver des synonymes variés pour éliminer les redites. Il permet de vérifier la construction correcte des verbes (transitif, intransitif, préposition requise) et l\'emploi des locutions figées. En croisant les informations d\'un article (définition, exemples, synonymes), l\'étudiant apprend à justifier ses choix lexicaux, à corriger des impropriétés sémantiques et à produire une prose plus nuancée, précise et stylistiquement maîtrisée, essentielle pour les travaux universitaires.','Application pratique à la rédaction : utiliser le Larousse pour enrichir un texte, éviter les répétitions, corriger des impropriétés et vérifier l\'emploi des locutions','2025-12-11 17:13:48','2025-12-11 17:13:48',3,NULL,NULL),(151,71,4,_binary '\0',0,'1',_binary '',NULL,'La leçon commence par distinguer les différentes parties du spectre d\'un opérateur linéaire. Elle examine les conditions d\'existence de valeurs propres et de vecteurs propres, puis s\'intéresse au spectre continu lié à l\'approximabilité et au spectre résiduel. Des exemples concrets sur des espaces de Hilbert illustrent ces concepts, mettant en lumière les différences entre opérateurs compacts et non bornés. Des exercices guidés permettent de calculer explicitement le spectre d\'opérateurs simples.','Définitions précises du spectre ponctuel, continu et résiduel et étude de leurs propriétés fondamentales dans divers espaces fonctionnels','2025-12-11 17:22:27','2025-12-11 17:22:27',1,NULL,NULL),(152,71,4,_binary '\0',0,'1',_binary '',NULL,'L\'analyse de la fonction résolvante, définie sur l\'ensemble résolvant, constitue le cœur de cette leçon. On y démontre son analyticité et on explore les liens entre la norme de la résolvante et la distance au spectre. La leçon aborde également le théorème de l\'application spectrale et son utilisation pour étudier les fonctions d\'opérateurs. Des applications à la stabilité des opérateurs sous perturbations faibles sont présentées, avec des exercices sur le calcul de développements en série de la résolvante.','Propriétés analytiques de la résolvante et son rôle dans l\'étude de la régularité et de la continuité des opérateurs','2025-12-11 17:22:27','2025-12-11 17:22:27',2,NULL,NULL),(153,71,4,_binary '\0',0,'1',_binary '',NULL,'Cette leçon se concentre sur les opérateurs présentant des symétries particulières, comme l\'auto-adjonction et la normalité. Elle établit les propriétés spectrales spécifiques à ces classes : réalité du spectre pour les auto-adjoints, et décomposition spectrale pour les normaux. Les prémisses du calcul fonctionnel sont introduites, permettant de définir f(T) pour des fonctions continues. Des exemples sur L²(R) illustrent la puissance de ces outils pour diagonaliser des opérateurs différentiels.','Introduction aux opérateurs auto-adjoints et normaux, et premières implications pour le calcul fonctionnel continu','2025-12-11 17:22:27','2025-12-11 17:22:27',3,NULL,NULL),(154,72,4,_binary '\0',0,'1',_binary '',NULL,'La leçon détaille la structure spectrale des opérateurs compacts auto-adjoints sur un espace de Hilbert. Elle démontre que le spectre est réel, discret à l\'exception possible de zéro, et que les vecteurs propres forment une base hilbertienne. La décomposition canonique de l\'opérateur en une série convergente de projections de rang fini est établie rigoureusement. Des exercices pratiques consistent à diagonaliser des opérateurs intégraux compacts sur L².','Théorème spectral pour les opérateurs compacts auto-adjoints : décomposition en série de projections sur les sous-espaces propres','2025-12-11 17:22:27','2025-12-11 17:22:27',1,NULL,NULL),(155,72,4,_binary '\0',0,'1',_binary '',NULL,'On étend ici les résultats au cas des opérateurs compacts normaux, où le spectre peut être complexe. La leçon explique la décomposition selon les parties réelle et imaginaire de l\'opérateur. La convergence de la série spectrale en norme d\'opérateur est analysée, et l\'on étudie l\'approximation d\'opérateurs par des opérateurs de rang fini. Des contre-exemples montrent les limitations de ces décompositions en dehors de la compacité.','Généralisation aux opérateurs compacts normaux et étude de la convergence des séries spectrales dans la topologie opératorielle','2025-12-11 17:22:27','2025-12-11 17:22:27',2,NULL,NULL),(156,72,4,_binary '\0',0,'1',_binary '',NULL,'Cette leçon construit systématiquement le calcul fonctionnel pour un opérateur borné dont le spectre est une suite discrète. On définit f(T) pour une fonction f continue en utilisant une intégrale spectrale qui se réduit à une somme sur les valeurs propres. Les propriétés algébriques et analytiques de ce calcul sont vérifiées. Des applications à l\'exponentielle d\'opérateur et à la résolution d\'équations d\'évolution sont proposées en exercice.','Construction du calcul fonctionnel pour les opérateurs bornés à spectre discret à l\'aide de l\'intégrale spectrale de Riemann','2025-12-11 17:22:27','2025-12-11 17:22:27',3,NULL,NULL),(157,73,4,_binary '\0',0,'1',_binary '',NULL,'Cette leçon introduit la notion centrale de mesure à valeurs projectrices, ou résolution de l\'identité. Elle montre comment associer à tout opérateur auto-adjoint borné une telle mesure sur son spectre. Le théorème spectral est alors reformulé en affirmant que l\'opérateur est l\'intégrale de la fonction identité par rapport à sa mesure spectrale. La construction de la mesure pour l\'opérateur de multiplication sur L² est détaillée comme exemple fondamental.','Introduction aux mesures spectrales projectrices et formulation du théorème spectral en termes d\'intégrale de projection','2025-12-11 17:22:27','2025-12-11 17:22:27',1,NULL,NULL),(158,73,4,_binary '\0',0,'1',_binary '',NULL,'On généralise la théorie aux opérateurs non bornés, qui sont essentiels en mécanique quantique. La leçon définit rigoureusement ce qu\'est un opérateur auto-adjoint non borné via son graphe. Le théorème spectral est étendu à cette classe, utilisant toujours une mesure spectrale, mais maintenant sur R tout entier. Le lien avec le calcul fonctionnel de Fourier est établi, permettant de définir l\'opérateur e^{itT}. Des exemples comme l\'opérateur de Laplace sont analysés.','Extension de la théorie aux opérateurs auto-adjoints non bornés et étude de leurs propriétés spectrales dans des espaces de Hilbert','2025-12-11 17:22:27','2025-12-11 17:22:27',2,NULL,NULL),(159,73,4,_binary '\0',0,'1',_binary '',NULL,'La leçon finale illustre la puissance de l\'analyse spectrale en l\'appliquant à la résolution d\'EDP. On montre comment la diagonalisation d\'opérateurs différentiels auto-adjoints (comme le Laplacien avec conditions aux limites) permet de résoudre l\'équation de la chaleur ou l\'équation des ondes par décomposition en modes propres. Des exercices portent sur le calcul explicite des solutions pour des domaines simples, reliant ainsi la théorie abstraite à des problèmes concrets de physique mathématique.','Applications de la décomposition spectrale à la résolution d\'équations aux dérivées partielles linéaires et à la modélisation en physique','2025-12-11 17:22:27','2025-12-11 17:22:27',3,NULL,NULL),(160,74,4,_binary '\0',300,'1',_binary '',NULL,'DeepSeek s\'est imposé comme une solution open-source polyvalente pour la recherche en intelligence artificielle. Son architecture modulaire permet une intégration aisée avec les bibliothèques populaires comme PyTorch et TensorFlow. Les avantages incluent une documentation exhaustive, une communauté active et des performances optimisées pour le calcul distribué. Des études de cas montrent son efficacité dans des domaines variés allant du traitement du langage naturel à la vision par ordinateur.','Présentation détaillée de l\'écosystème DeepSeek : historique, cas d\'usage typiques et comparaison avec alternatives similaires','2025-12-11 17:29:43','2025-12-24 23:46:35',1,NULL,0),(161,74,4,_binary '\0',0,'1',_binary '',NULL,'Une configuration appropriée est cruciale pour exploiter pleinement le potentiel de la plateforme. Cette leçon aborde la création d\'environnements virtuels isolés, l\'installation sélective des packages requis et le paramétrage des drivers GPU. Des techniques de profiling aident à identifier les goulots d\'étranglement potentiels. Les bonnes pratiques couvrent également la gestion versionnée des configurations via des outils comme Docker ou Conda pour assurer la reproductibilité des expériences.','Configuration environnementale avancée : gestion des dépendances, virtualisation et optimisation des paramètres système','2025-12-11 17:29:43','2025-12-11 17:29:43',2,NULL,NULL),(162,74,4,_binary '\0',0,'1',_binary '',NULL,'L\'organisation systématique des projets accélère le développement et facilite la maintenance. Cette section détaille des conventions de nommage cohérentes, l\'arborescence recommandée pour séparer données, code et résultats. L\'intégration avec Git permet de tracker les modifications tandis que des outils comme DVC gèrent efficacement les jeux de données volumineux. Des workflows collaboratifs sont présentés pour coordonner les contributions multiples sans conflits.','Methodologies de gestion de projet : structuration des répertoires, versioning et collaboration en équipe','2025-12-11 17:29:43','2025-12-11 17:29:43',3,NULL,NULL),(163,75,4,_binary '\0',0,'1',_binary '',NULL,'La construction from scratch d\'un perceptron multicouche permet de saisir les mécanismes fondamentaux du deep learning. Cette approche pédagogique couvre le calcul manuel des dérivées partielles, la chain rule et l\'implémentation d\'algorithmes d\'optimisation comme la descente de gradient stochastique. Des visualisations aident à comprendre la propagation des erreurs et l\'impact des fonctions d\'activation. L\'exercice final consiste à entraîner un classifieur sur un dataset synthétique.','Implémentation manuelle de réseaux neuronaux élémentaires : calculs forward/backward et gestion des gradients','2025-12-11 17:29:43','2025-12-11 17:29:43',1,NULL,NULL),(164,75,4,_binary '\0',0,'1',_binary '',NULL,'DeepSeek offre des abstractions permettant de construire des modèles complexes avec peu de code. Cette leçon présente les modules préconstruits pour les couches convolutionnelles, récurrentes et attentionnelles. Les optimiseurs intégrés (Adam, RMSProp) sont comparés empiriquement sur des benchmarks standards. Les callbacks automatisent des tâches comme l\'early stopping, le checkpointing ou l\'ajustement dynamique du learning rate. Un TP pratique montre comment construire un CNN en moins de vingt lignes de code.','Exploitation des APIs haut niveau : couches préfabriquées, optimiseurs et callbacks pour prototyping rapide','2025-12-11 17:29:43','2025-12-11 17:29:43',2,NULL,NULL),(165,75,4,_binary '\0',0,'1',_binary '',NULL,'Le débogage méthodique est essentiel pour améliorer les performances des modèles. Cette section enseigne l\'interprétation des courbes de loss et d\'accuracy pour identifier underfitting/overfitting. Des techniques comme la validation croisée, la dropout et la batch normalization sont expliquées théoriquement et implémentées pratiquement. Des outils de visualisation des activations et gradients aident à diagnostiquer les problèmes de vanishing gradient. Un cas concret montre comment corriger un modèle souffrant de surapprentissage.','Techniques avancées de débogage : analyse des courbes d\'apprentissage, détection overfitting et méthodes regularization','2025-12-11 17:29:43','2025-12-11 17:29:43',3,NULL,NULL),(166,76,4,_binary '\0',0,'1',_binary '',NULL,'La réduction de la taille et de la complexité des modèles est cruciale pour les déploiements edge. Cette leçon compare les algorithmes de pruning structuré et non structuré, avec des métriques d\'évaluation du tradeoff performance/taille. La quantification en précision mixte (FP16/INT8) permet des gains significatifs sur GPU modernes. La distillation de connaissances transfère l\'expertise d\'un modèle large à un modèle compact. Des benchmarks quantifient l\'impact de chaque technique sur des architectures standards.','Techniques de compression et accélération : pruning, quantification et distillation pour déploiement contraint','2025-12-11 17:29:43','2025-12-11 17:29:43',1,NULL,NULL),(167,76,4,_binary '\0',0,'1',_binary '',NULL,'Le déploiement production nécessite une infrastructure robuste et élastique. Cette section présente des patterns comme les API REST/gRPC, la conteneurisation avec Docker/Kubernetes et l\'orchestration des ressources. Le load balancing distribue intelligemment la charge entre plusieurs instances tandis que des files d\'attente gèrent les pics de demandes. Des considérations security comme l\'authentification et le chiffrement sont intégrées dans un exemple complet de service scalable.','Architectures de servir scalable : microservices, load balancing et gestion asynchrone des requêtes inference','2025-12-11 17:29:43','2025-12-11 17:29:43',2,NULL,NULL),(168,76,4,_binary '\0',0,'1',_binary '',NULL,'Un système en production nécessite une supervision constante pour détecter drifts et anomalies. Cette leçon couvre l\'instrumentation des pipelines avec des métriques business et techniques. Des dashboards visualisent la latence, le throughput et la qualité des prédictions over time. Des mécanismes d\'alerting proactive notifient les équipes en cas de dégradation. Le versioning des modèles et des données permet des rollbacks safe et des A/B testing contrôlés. Un exercice simule la détection d\'un concept drift sur un dataset évolutif.','Monitoring continu et maintenance évolutive : métriques custom, alerting proactive et versioning modèles','2025-12-11 17:29:43','2025-12-11 17:29:43',3,NULL,NULL),(169,30,1,_binary '\0',10,'1',_binary '','1/1/10/30/1-1-10-30.25.12.2025.12.25.14.mp4','','mmmmmmmm','2025-12-25 12:25:15','2025-12-25 12:25:15',3,'1/1/10/30/1-1-10-30.25.12.2025.12.25.14.jpeg',7737751),(170,79,4,_binary '\0',0,'1',_binary '',NULL,'Les espaces de Banach, caractérisés par leur complétude sous une norme donnée, constituent le cadre naturel pour l\'étude des opérateurs linéaires continus. Les espaces de Hilbert, un cas particulier muni d\'un produit scalaire, offrent des propriétés géométriques supplémentaires. Cette leçon revient sur les définitions des normes, des suites de Cauchy et de la convergence. Elle présente des exemples fondamentaux comme les espaces L^p et l^2. La complétude assure que les techniques limites, cruciales pour la définition du spectre, sont bien définies.','Espaces de Banach et de Hilbert, rappels sur les normes et propriétés de complétude essentielles pour l\'étude des opérateurs','2025-12-27 20:43:08','2025-12-27 20:43:08',1,NULL,NULL),(171,79,4,_binary '\0',0,'1',_binary '',NULL,'Un opérateur linéaire T entre deux espaces de Banach est dit borné si son image de la boule unité est bornée. La norme opérateur, définie comme le supremum de ||T(x)|| pour ||x||=1, quantifie cette propriété. Cette leçon explore cette définition à travers des exemples variés : opérateurs de multiplication sur L^2, opérateurs intégraux, et dérivées dans des espaces de fonctions différentiables. La continuité et la bornitude sont équivalentes pour les opérateurs linéaires, un résultat fondamental pour l\'analyse.','Opérateurs linéaires bornés, définition de la norme opérateur et exemples concrets dans différents espaces fonctionnels','2025-12-27 20:43:08','2025-12-27 20:43:08',2,NULL,NULL),(172,79,4,_binary '\0',0,'1',_binary '',NULL,'Le spectre σ(T) d\'un opérateur borné T sur un espace de Banach X est l\'ensemble des scalaires complexes λ pour lesquels l\'opérateur (T - λI) n\'est pas inversible. On distingue le spectre ponctuel (valeurs propres), le spectre continu (où l\'opérateur est injectif et d\'image dense mais non surjectif) et le spectre résiduel. Cette leçon détaille ces concepts et propose des exercices de calcul du spectre pour des opérateurs simples, comme les opérateurs de shift ou de multiplication, en illustrant les différents types spectraux.','Introduction au spectre d\'un opérateur, distinction entre spectre ponctuel, continu et résiduel avec calculs pratiques','2025-12-27 20:43:08','2025-12-27 20:43:08',3,NULL,NULL),(173,80,4,_binary '\0',0,'1',_binary '',NULL,'Un opérateur linéaire est compact s\'il transforme toute suite bornée en une suite admettant une sous-suite convergente. Cette propriété, plus forte que la simple continuité, est cruciale pour une analyse spectrale fine. Les opérateurs intégraux à noyau de Hilbert-Schmidt ou les opérateurs de rang fini en sont des exemples typiques. Cette leçon présente plusieurs caractérisations de la compacité et explore des théorèmes importants, comme le fait que la limite en norme d\'opérateurs de rang fini est compacte.','Définition et propriétés fondamentales des opérateurs compacts, exemples classiques et critères de compacité','2025-12-27 20:43:08','2025-12-27 20:43:08',1,NULL,NULL),(174,80,4,_binary '\0',0,'1',_binary '',NULL,'Pour un opérateur compact T sur un espace de Banach de dimension infinie, le spectre σ(T) a une structure particulière. Tout λ ≠0 dans le spectre est une valeur propre isolée, et l\'espace propre correspondant est de dimension finie. Cette leçon démontre ces résultats clés et examine le comportement des valeurs propres, qui peuvent s\'accumuler uniquement en zéro. Des exemples, comme l\'opérateur intégral de Volterra, illustrent cette structure et montrent que zéro peut appartenir ou non au spectre.','Structure du spectre des opérateurs compacts, étude des valeurs propres non nulles et de leur multiplicité','2025-12-27 20:43:08','2025-12-27 20:43:08',2,NULL,NULL),(175,80,4,_binary '\0',0,'1',_binary '',NULL,'La théorie de Riesz-Schauder fournit un cadre pour décomposer un espace de Banach relativement à un opérateur compact T. Pour chaque valeur propre non nulle λ, on peut définir un projecteur spectral sur l\'espace propre généralisé. La somme directe de ces espaces est dense dans un sous-espace invariant approprié. Cette leçon détaille la construction de ces projecteurs et explique comment ils permettent une décomposition partielle de l\'opérateur, forme infinie de la réduction des endomorphismes en dimension finie.','Théorie de Riesz-Schauder et décomposition spectrale des opérateurs compacts, projecteurs spectraux associés','2025-12-27 20:43:08','2025-12-27 20:43:08',3,NULL,NULL),(176,81,4,_binary '\0',0,'1',_binary '',NULL,'Sur un espace de Hilbert, un opérateur T est auto-adjoint s\'il est égal à son adjoint T*. Cette propriété entraîne que son spectre est toujours un sous-ensemble de l\'axe réel. Les opérateurs auto-adjoints compacts possèdent une base hilbertienne de vecteurs propres. Pour les opérateurs non compacts, le spectre peut être continu. Cette leçon établit ces propriétés fondamentales et prépare le terrain pour le théorème spectral en étudiant des exemples comme l\'opérateur de multiplication par x sur L^2(R).','Opérateurs auto-adjoints et leurs propriétés spectrales de base, symétrie du spectre et existence de valeurs propres','2025-12-27 20:43:08','2025-12-27 20:43:08',1,NULL,NULL),(177,81,4,_binary '\0',0,'1',_binary '',NULL,'Le théorème spectral affirme que tout opérateur auto-adjoint borné T sur un espace de Hilbert H est unitairement équivalent à un opérateur de multiplication sur un espace L^2. Plus précisément, il existe une mesure spectrale E, une famille de projecteurs orthogonaux, telle que T peut s\'écrire comme l\'intégrale de λ par rapport à dE(λ). Cette leçon explique la construction de cette mesure spectrale et comment elle représente une généralisation puissante de la diagonalisation pour les opérateurs de dimension infinie.','Énoncé et interprétation du théorème spectral pour opérateurs auto-adjoints bornés, mesure spectrale associée','2025-12-27 20:43:08','2025-12-27 20:43:08',2,NULL,NULL),(178,81,4,_binary '\0',0,'1',_binary '',NULL,'Le calcul fonctionnel permet de donner un sens à l\'expression f(T) où T est un opérateur auto-adjoint et f une fonction. Pour f continue et bornée sur le spectre de T, on définit f(T) via l\'intégrale de f(λ) par rapport à la mesure spectrale dE(λ). Cette construction préserve les propriétés algébriques : (f+g)(T)=f(T)+g(T), (fg)(T)=f(T)g(T). Cette leçon illustre ce calcul avec des exemples comme l\'exponentielle e^{iT} ou les fonctions caractéristiques qui donnent les projecteurs spectraux E(Ω).','Calcul fonctionnel continu et borné pour opérateurs auto-adjoints, définition de f(T) et exemples d\'applications','2025-12-27 20:43:08','2025-12-27 20:43:08',3,NULL,NULL),(179,81,4,_binary '\0',0,'1',_binary '',NULL,'La décomposition spectrale est un outil central pour résoudre des équations différentielles impliquant des opérateurs. Par exemple, pour résoudre l\'équation d\'évolution du type i dψ/dt = Hψ (équation de Schrödinger), où H est un hamiltonien auto-adjoint, le calcul fonctionnel permet d\'écrire la solution comme ψ(t) = e^{-iHt}ψ(0). Cette solution est construite en décomposant l\'état initial sur la base spectrale de H. Cette leçon présente cette application emblématique et d\'autres problèmes similaires en physique mathématique.','Applications de la décomposition spectrale à la résolution de problèmes, en particulier aux équations d\'évolution linéaires','2025-12-27 20:43:08','2025-12-27 20:43:08',4,NULL,NULL),(183,83,4,_binary '\0',0,'1',_binary '',NULL,'Un opérateur linéaire est compact s\'il transforme toute suite bornée en une suite admettant une sous-suite convergente. Cette propriété, plus forte que la simple continuité, est cruciale pour une analyse spectrale fine. Les opérateurs intégraux à noyau de Hilbert-Schmidt ou les opérateurs de rang fini en sont des exemples typiques. Cette leçon présente plusieurs caractérisations de la compacité et explore des théorèmes importants, comme le fait que la limite en norme d\'opérateurs de rang fini est compacte.','Définition et propriétés fondamentales des opérateurs compacts, exemples classiques et critères de compacité','2025-12-27 20:43:37','2025-12-27 20:43:37',1,NULL,NULL),(184,83,4,_binary '\0',0,'1',_binary '',NULL,'Pour un opérateur compact T sur un espace de Banach de dimension infinie, le spectre σ(T) a une structure particulière. Tout λ ≠0 dans le spectre est une valeur propre isolée, et l\'espace propre correspondant est de dimension finie. Cette leçon démontre ces résultats clés et examine le comportement des valeurs propres, qui peuvent s\'accumuler uniquement en zéro. Des exemples, comme l\'opérateur intégral de Volterra, illustrent cette structure et montrent que zéro peut appartenir ou non au spectre.','Structure du spectre des opérateurs compacts, étude des valeurs propres non nulles et de leur multiplicité','2025-12-27 20:43:37','2025-12-27 20:43:37',2,NULL,NULL),(185,83,4,_binary '\0',0,'1',_binary '',NULL,'La théorie de Riesz-Schauder fournit un cadre pour décomposer un espace de Banach relativement à un opérateur compact T. Pour chaque valeur propre non nulle λ, on peut définir un projecteur spectral sur l\'espace propre généralisé. La somme directe de ces espaces est dense dans un sous-espace invariant approprié. Cette leçon détaille la construction de ces projecteurs et explique comment ils permettent une décomposition partielle de l\'opérateur, forme infinie de la réduction des endomorphismes en dimension finie.','Théorie de Riesz-Schauder et décomposition spectrale des opérateurs compacts, projecteurs spectraux associés','2025-12-27 20:43:37','2025-12-27 20:43:37',3,NULL,NULL),(186,84,4,_binary '\0',0,'1',_binary '',NULL,'Sur un espace de Hilbert, un opérateur T est auto-adjoint s\'il est égal à son adjoint T*. Cette propriété entraîne que son spectre est toujours un sous-ensemble de l\'axe réel. Les opérateurs auto-adjoints compacts possèdent une base hilbertienne de vecteurs propres. Pour les opérateurs non compacts, le spectre peut être continu. Cette leçon établit ces propriétés fondamentales et prépare le terrain pour le théorème spectral en étudiant des exemples comme l\'opérateur de multiplication par x sur L^2(R).','Opérateurs auto-adjoints et leurs propriétés spectrales de base, symétrie du spectre et existence de valeurs propres','2025-12-27 20:43:37','2025-12-27 20:43:37',1,NULL,NULL),(187,84,4,_binary '\0',0,'1',_binary '',NULL,'Le théorème spectral affirme que tout opérateur auto-adjoint borné T sur un espace de Hilbert H est unitairement équivalent à un opérateur de multiplication sur un espace L^2. Plus précisément, il existe une mesure spectrale E, une famille de projecteurs orthogonaux, telle que T peut s\'écrire comme l\'intégrale de λ par rapport à dE(λ). Cette leçon explique la construction de cette mesure spectrale et comment elle représente une généralisation puissante de la diagonalisation pour les opérateurs de dimension infinie.','Énoncé et interprétation du théorème spectral pour opérateurs auto-adjoints bornés, mesure spectrale associée','2025-12-27 20:43:37','2025-12-27 20:43:37',2,NULL,NULL),(188,84,4,_binary '\0',0,'1',_binary '',NULL,'Le calcul fonctionnel permet de donner un sens à l\'expression f(T) où T est un opérateur auto-adjoint et f une fonction. Pour f continue et bornée sur le spectre de T, on définit f(T) via l\'intégrale de f(λ) par rapport à la mesure spectrale dE(λ). Cette construction préserve les propriétés algébriques : (f+g)(T)=f(T)+g(T), (fg)(T)=f(T)g(T). Cette leçon illustre ce calcul avec des exemples comme l\'exponentielle e^{iT} ou les fonctions caractéristiques qui donnent les projecteurs spectraux E(Ω).','Calcul fonctionnel continu et borné pour opérateurs auto-adjoints, définition de f(T) et exemples d\'applications','2025-12-27 20:43:37','2025-12-27 20:43:37',3,NULL,NULL),(189,84,4,_binary '\0',0,'1',_binary '',NULL,'La décomposition spectrale est un outil central pour résoudre des équations différentielles impliquant des opérateurs. Par exemple, pour résoudre l\'équation d\'évolution du type i dψ/dt = Hψ (équation de Schrödinger), où H est un hamiltonien auto-adjoint, le calcul fonctionnel permet d\'écrire la solution comme ψ(t) = e^{-iHt}ψ(0). Cette solution est construite en décomposant l\'état initial sur la base spectrale de H. Cette leçon présente cette application emblématique et d\'autres problèmes similaires en physique mathématique.','Applications de la décomposition spectrale à la résolution de problèmes, en particulier aux équations d\'évolution linéaires','2025-12-27 20:43:37','2025-12-27 20:43:37',4,NULL,NULL),(215,88,4,_binary '\0',0,'1',_binary '',NULL,'A bounded linear operator is characterized by its finite operator norm, which provides a measure of its maximum amplification of vector lengths. Continuity is equivalent to boundedness for linear maps between normed spaces, a fundamental result linking analytical and algebraic properties. This lesson explores the calculation of the operator norm for various examples, including multiplication and integral operators. The importance of boundedness for ensuring stable and predictable behavior in infinite dimensions is emphasized, forming the bedrock for spectral analysis.','Defining bounded linear operators, operator norms, and continuity properties within the context of normed vector spaces','2025-12-27 23:11:43','2025-12-27 23:11:43',1,NULL,NULL),(216,88,4,_binary '\0',0,'1',_binary '',NULL,'Hilbert spaces extend the geometric intuition of Euclidean space to infinite dimensions through the structure of an inner product. This inner product induces a norm and a concept of orthogonality, which is crucial for decompositions like the projection theorem. The lesson details how the geometry of Hilbert spaces simplifies the analysis of operators, particularly those that are self-adjoint or normal. Key examples such as L^2 spaces are examined to illustrate how these abstract concepts manifest in practical settings like signal processing or quantum states.','Introduction to Hilbert spaces, inner product structures, and the pivotal role of orthogonality in operator theory','2025-12-27 23:11:43','2025-12-27 23:11:43',2,NULL,NULL),(217,88,4,_binary '\0',0,'1',_binary '',NULL,'Compact operators are those that map bounded sets to relatively compact sets, generalizing the concept of finite-dimensional linear maps. Their spectrum, except possibly for zero, consists entirely of eigenvalues, making them more tractable than general bounded operators. This lesson investigates the approximation of compact operators by sequences of finite-rank operators, a property with significant implications for numerical methods. Applications in integral equations and the analysis of differential operators are discussed, highlighting the practical utility of this important operator class.','Exploring compact operators, their spectral properties, and approximation by finite-rank operators in practical applications','2025-12-27 23:11:43','2025-12-27 23:11:43',3,NULL,NULL),(218,89,4,_binary '\0',0,'1',_binary '',NULL,'The spectrum of an operator T is the set of complex numbers λ for which (T - λI) is not invertible, while the resolvent set is its complement. The resolvent function, R(λ, T) = (T - λI)^-1, is analytic on the resolvent set, allowing the use of complex analysis techniques. This lesson covers the fundamental properties of the spectrum, including its non-emptiness for bounded operators on complex Banach spaces. The maximum modulus principle and the spectral radius formula are derived, providing powerful tools for estimating the size of the spectrum.','Defining the spectrum and resolvent set of an operator, analyzing the analytic properties of the resolvent function','2025-12-27 23:11:43','2025-12-27 23:11:43',1,NULL,NULL),(219,89,4,_binary '\0',0,'1',_binary '',NULL,'The spectrum is partitioned into three disjoint parts: the point spectrum (eigenvalues), continuous spectrum (where the operator is injective with dense but non-closed range), and residual spectrum (where the operator is injective but without dense range). This lesson provides clear definitions and explores canonical examples for each type, such as multiplication operators on L^p spaces. Understanding this decomposition is crucial for diagnosing the invertibility and spectral properties of an operator, influencing the choice of analytical methods for solving associated equations.','Decomposing the spectrum into point, continuous, and residual components with illustrative examples for each case','2025-12-27 23:11:43','2025-12-27 23:11:43',2,NULL,NULL),(220,89,4,_binary '\0',0,'1',_binary '',NULL,'The spectral mapping theorem for polynomials states that the spectrum of p(T) is precisely the image under p of the spectrum of T. This result forms the basis for the holomorphic functional calculus, which allows one to define f(T) for functions f analytic on a neighborhood of the spectrum. This lesson explains how to construct this calculus, starting with polynomials and rational functions, and demonstrates its use in solving operator equations. The functional calculus is a precursor to the more powerful continuous functional calculus for normal operators.','Spectral mapping theorem and functional calculus for polynomials and rational functions applied to bounded operators','2025-12-27 23:11:43','2025-12-27 23:11:43',3,NULL,NULL),(221,90,4,_binary '\0',0,'1',_binary '',NULL,'An operator T on a Hilbert space is self-adjoint if it equals its adjoint, T = T*, and normal if it commutes with its adjoint, TT* = T*T. Self-adjoint operators have a real spectrum and a complete set of eigenvectors (in the generalized sense of spectral measures). This lesson establishes the fundamental properties of these operator classes, including the fact that normality is necessary and sufficient for a valid spectral theorem. Examples include multiplication operators and certain differential operators, illustrating their prevalence in applied mathematics.','Criteria for self-adjointness and normality, their spectral properties, and the significance of real spectra','2025-12-27 23:11:43','2025-12-27 23:11:43',1,NULL,NULL),(222,90,4,_binary '\0',0,'1',_binary '',NULL,'The spectral theorem for a bounded self-adjoint operator A states that it is unitarily equivalent to a multiplication operator on an L^2 space. This means there exists a measure space and a real-valued function such that A acts as multiplication by that function. Equivalently, the theorem can be expressed using a projection-valued measure E, allowing the representation A = ∫ λ dE(λ). This lesson explains both formulations and their equivalence, providing a powerful tool for analyzing the operator\'s structure and defining a functional calculus for continuous functions.','The spectral theorem for bounded self-adjoint operators presented via multiplication operator form and projection-valued measures','2025-12-27 23:11:43','2025-12-27 23:11:43',2,NULL,NULL),(223,90,4,_binary '\0',0,'1',_binary '',NULL,'The spectral theorem enables a robust functional calculus. For a normal operator N with spectral measure E, one can define f(N) for any bounded Borel function f by f(N) = ∫ f(λ) dE(λ). This calculus preserves algebraic operations and respects continuous functional relationships. This lesson details the construction and properties of this calculus, including the continuous functional calculus for continuous functions on the spectrum. Its power is demonstrated by applications such as defining operators like |N| or the exponential e^(itN), which are essential for evolution equations.','Functional calculus for continuous and bounded Borel functions derived from the spectral theorem for normal operators','2025-12-27 23:11:43','2025-12-27 23:11:43',3,NULL,NULL),(224,91,4,_binary '\0',0,'1',_binary '',NULL,'Unbounded operators are defined not on the whole Hilbert space but on a dense subspace called the domain. The graph of the operator and the associated graph norm are essential tools for analyzing them. An operator is closed if its graph is closed, a property necessary for a well-defined adjoint and a meaningful spectral theory. This lesson explores these foundational definitions, using differential operators like -d²/dx² as primary examples. The distinction between symmetric and self-adjoint operators is introduced, with self-adjointness being crucial for the spectral theorem.','Defining unbounded operators, their domains, graph norms, and the critical concept of closedness for spectral analysis','2025-12-27 23:11:43','2025-12-27 23:11:43',1,NULL,NULL),(225,91,4,_binary '\0',0,'1',_binary '',NULL,'The definitions of resolvent set and spectrum are adapted for unbounded operators, noting that the resolvent R(λ, T) is a bounded operator when it exists. The spectrum can be unbounded and may include points where the operator is not defined. This lesson carefully examines the spectral properties of unbounded operators, highlighting differences from the bounded case. The concept of essential self-adjointness is introduced, which ensures a unique self-adjoint extension and simplifies the analysis of operators defined on a core domain.','Spectral theory for unbounded operators, resolving technical issues with the resolvent and spectrum definitions','2025-12-27 23:11:43','2025-12-27 23:11:43',2,NULL,NULL),(226,91,4,_binary '\0',0,'1',_binary '',NULL,'The spectral theorem extends to unbounded self-adjoint operators, representing them as multiplication operators on L^2 spaces via a projection-valued measure. One common proof strategy uses the Cayley transform to map the unbounded self-adjoint operator to a unitary operator, to which the bounded spectral theorem applies. This lesson outlines this construction and its resulting functional calculus, which allows defining functions of an unbounded operator. This powerful tool is fundamental in quantum mechanics, where the Hamiltonian is typically an unbounded self-adjoint operator.','Spectral theorem and functional calculus for unbounded self-adjoint operators via Cayley transform and resolution of the identity','2025-12-27 23:11:43','2025-12-27 23:11:43',3,NULL,NULL),(227,92,4,_binary '\0',0,'1',_binary '',NULL,'The polar decomposition theorem states that any bounded operator T on a Hilbert space can be written as T = U|T|, where |T| = (T*T)^(1/2) is a positive operator and U is a partial isometry. This decomposition generalizes the polar form of a complex number and reveals important geometric information about T. This lesson proves the theorem and examines its properties, including the uniqueness of the decomposition when the initial space of U is chosen appropriately. Applications include analyzing the range and kernel of the operator.','Polar decomposition theorem for bounded operators on Hilbert spaces, relating modulus and partial isometries','2025-12-27 23:11:43','2025-12-27 23:11:43',1,NULL,NULL),(228,92,4,_binary '\0',0,'1',_binary '',NULL,'For a compact operator T on a Hilbert space, the singular value decomposition provides a canonical series expansion T = Σ σ_n (·, u_n) v_n, where {σ_n} are the singular values and {u_n}, {v_n} are orthonormal sequences. The singular values are the eigenvalues of |T| and tend to zero. This lesson details this decomposition, highlighting its optimal approximation properties; truncating the series gives the best finite-rank approximation. This result is the theoretical foundation for many numerical methods, including the finite element method and data compression techniques like PCA.','Singular value decomposition for compact operators and its implications for approximation theory and numerical analysis','2025-12-27 23:11:43','2025-12-27 23:11:43',2,NULL,NULL),(229,92,4,_binary '\0',0,'1',_binary '',NULL,'Operator algebras, such as C*-algebras and von Neumann algebras, provide a unifying framework for spectral theory. The algebra generated by a normal operator and its adjoint is a commutative C*-algebra. Within this algebra, the spectral theorem corresponds to a representation of the algebra as continuous functions on the spectrum. This lesson introduces these concepts, showing how the decomposition of an operator is related to the structure of the algebra it generates. This perspective connects functional analysis with other areas of mathematics and theoretical physics.','Introduction to operator algebras, C*-algebras, and decompositions within algebras generated by normal operators','2025-12-27 23:11:43','2025-12-27 23:11:43',3,NULL,NULL);
/*!40000 ALTER TABLE `course_chapter_content` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `course_chapter_content_view`
--

DROP TABLE IF EXISTS `course_chapter_content_view`;
/*!50001 DROP VIEW IF EXISTS `course_chapter_content_view`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `course_chapter_content_view` AS SELECT 
 1 AS `chapter_id`,
 1 AS `course_id`,
 1 AS `chapter_title`,
 1 AS `chapter_description`,
 1 AS `num_of_reading`,
 1 AS `num_of_contents`,
 1 AS `chapter_is_visible`,
 1 AS `chapter_sequence`,
 1 AS `content_id`,
 1 AS `content_type_id`,
 1 AS `is_important`,
 1 AS `time_required_in_sec`,
 1 AS `is_open_for_free`,
 1 AS `content_is_visible`,
 1 AS `content_url`,
 1 AS `content_text`,
 1 AS `content_brief`,
 1 AS `date_creation`,
 1 AS `date_update`,
 1 AS `content_sequence`,
 1 AS `content_type`,
 1 AS `content_cover_url`,
 1 AS `file_size_in_bytes`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `course_chapter_progress_view`
--

DROP TABLE IF EXISTS `course_chapter_progress_view`;
/*!50001 DROP VIEW IF EXISTS `course_chapter_progress_view`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `course_chapter_progress_view` AS SELECT 
 1 AS `enrollment_id`,
 1 AS `student_id`,
 1 AS `course_id`,
 1 AS `course_chapter_id`,
 1 AS `total_chapter`,
 1 AS `chapter_completion_percentage`,
 1 AS `course_completion_percentage`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `course_chapter_view`
--

DROP TABLE IF EXISTS `course_chapter_view`;
/*!50001 DROP VIEW IF EXISTS `course_chapter_view`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `course_chapter_view` AS SELECT 
 1 AS `course_title`,
 1 AS `course_brief`,
 1 AS `instructor_id`,
 1 AS `num_of_chapters`,
 1 AS `course_fee`,
 1 AS `language_id`,
 1 AS `school_subject_id`,
 1 AS `is_course_visible`,
 1 AS `date_creation`,
 1 AS `date_update`,
 1 AS `date_start_course`,
 1 AS `date_end_course`,
 1 AS `language_name`,
 1 AS `language_code`,
 1 AS `school_id`,
 1 AS `label_subject`,
 1 AS `code_qualification`,
 1 AS `education`,
 1 AS `level`,
 1 AS `label_qualification`,
 1 AS `id`,
 1 AS `course_id`,
 1 AS `chapter_title`,
 1 AS `chapter_description`,
 1 AS `num_of_reading`,
 1 AS `num_of_contents`,
 1 AS `is_visible`,
 1 AS `sequence`,
 1 AS `date_chapter_creation`,
 1 AS `date_chapter_update`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `course_favorite`
--

DROP TABLE IF EXISTS `course_favorite`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `course_favorite` (
  `id` int NOT NULL AUTO_INCREMENT,
  `course_id` int DEFAULT NULL,
  `student_id` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_favorite`
--

LOCK TABLES `course_favorite` WRITE;
/*!40000 ALTER TABLE `course_favorite` DISABLE KEYS */;
/*!40000 ALTER TABLE `course_favorite` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `course_instructor_enrollment_view`
--

DROP TABLE IF EXISTS `course_instructor_enrollment_view`;
/*!50001 DROP VIEW IF EXISTS `course_instructor_enrollment_view`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `course_instructor_enrollment_view` AS SELECT 
 1 AS `id`,
 1 AS `course_title`,
 1 AS `course_brief`,
 1 AS `instructor_id`,
 1 AS `num_of_chapters`,
 1 AS `course_fee`,
 1 AS `language_id`,
 1 AS `school_subject_id`,
 1 AS `is_visible`,
 1 AS `date_creation`,
 1 AS `date_update`,
 1 AS `date_start_course`,
 1 AS `date_end_course`,
 1 AS `language_name`,
 1 AS `school_id`,
 1 AS `label_subject`,
 1 AS `code_qualification`,
 1 AS `education`,
 1 AS `level`,
 1 AS `label_qualification`,
 1 AS `first_name`,
 1 AS `last_name`,
 1 AS `active_account`,
 1 AS `email`,
 1 AS `num_of_published_courses`,
 1 AS `enrollment_id`,
 1 AS `student_id`,
 1 AS `enrollment_date`,
 1 AS `last_activity`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `course_instructor_view`
--

DROP TABLE IF EXISTS `course_instructor_view`;
/*!50001 DROP VIEW IF EXISTS `course_instructor_view`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `course_instructor_view` AS SELECT 
 1 AS `id`,
 1 AS `course_title`,
 1 AS `course_brief`,
 1 AS `instructor_id`,
 1 AS `num_of_chapters`,
 1 AS `course_fee`,
 1 AS `language_id`,
 1 AS `school_subject_id`,
 1 AS `is_visible`,
 1 AS `date_creation`,
 1 AS `date_update`,
 1 AS `date_start_course`,
 1 AS `date_end_course`,
 1 AS `language_name`,
 1 AS `language_code`,
 1 AS `school_id`,
 1 AS `label_subject`,
 1 AS `code_qualification`,
 1 AS `education`,
 1 AS `level`,
 1 AS `label_qualification`,
 1 AS `first_name`,
 1 AS `last_name`,
 1 AS `active_account`,
 1 AS `email`,
 1 AS `num_of_published_courses`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `course_progress_view`
--

DROP TABLE IF EXISTS `course_progress_view`;
/*!50001 DROP VIEW IF EXISTS `course_progress_view`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `course_progress_view` AS SELECT 
 1 AS `enrollment_id`,
 1 AS `student_id`,
 1 AS `course_id`,
 1 AS `course_completion_percentage`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `course_view`
--

DROP TABLE IF EXISTS `course_view`;
/*!50001 DROP VIEW IF EXISTS `course_view`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `course_view` AS SELECT 
 1 AS `id`,
 1 AS `course_title`,
 1 AS `course_brief`,
 1 AS `instructor_id`,
 1 AS `num_of_chapters`,
 1 AS `course_fee`,
 1 AS `language_id`,
 1 AS `school_subject_id`,
 1 AS `is_visible`,
 1 AS `date_creation`,
 1 AS `date_update`,
 1 AS `date_start_course`,
 1 AS `date_end_course`,
 1 AS `language_name`,
 1 AS `language_code`,
 1 AS `school_id`,
 1 AS `label_subject`,
 1 AS `code_qualification`,
 1 AS `education`,
 1 AS `level`,
 1 AS `label_qualification`,
 1 AS `num_of_quizzes`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `dashboard_instructor_calendar_assistance_view`
--

DROP TABLE IF EXISTS `dashboard_instructor_calendar_assistance_view`;
/*!50001 DROP VIEW IF EXISTS `dashboard_instructor_calendar_assistance_view`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `dashboard_instructor_calendar_assistance_view` AS SELECT 
 1 AS `row_id`,
 1 AS `instructor_id`,
 1 AS `count`,
 1 AS `min_date_demand`,
 1 AS `max_date_demand`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `dashboard_instructor_course_view`
--

DROP TABLE IF EXISTS `dashboard_instructor_course_view`;
/*!50001 DROP VIEW IF EXISTS `dashboard_instructor_course_view`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `dashboard_instructor_course_view` AS SELECT 
 1 AS `row_id`,
 1 AS `instructor_id`,
 1 AS `is_visible`,
 1 AS `count`,
 1 AS `max_date_creation`,
 1 AS `max_date_update`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `dashboard_instructor_enrollment_course_view`
--

DROP TABLE IF EXISTS `dashboard_instructor_enrollment_course_view`;
/*!50001 DROP VIEW IF EXISTS `dashboard_instructor_enrollment_course_view`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `dashboard_instructor_enrollment_course_view` AS SELECT 
 1 AS `row_id`,
 1 AS `instructor_id`,
 1 AS `count_courses`,
 1 AS `count`,
 1 AS `min_enrollment_date`,
 1 AS `max_enrollment_date`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `dashboard_school_calendar_assistance_view`
--

DROP TABLE IF EXISTS `dashboard_school_calendar_assistance_view`;
/*!50001 DROP VIEW IF EXISTS `dashboard_school_calendar_assistance_view`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `dashboard_school_calendar_assistance_view` AS SELECT 
 1 AS `row_id`,
 1 AS `school_id`,
 1 AS `count`,
 1 AS `min_date_demand`,
 1 AS `max_date_demand`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `dashboard_school_course_view`
--

DROP TABLE IF EXISTS `dashboard_school_course_view`;
/*!50001 DROP VIEW IF EXISTS `dashboard_school_course_view`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `dashboard_school_course_view` AS SELECT 
 1 AS `row_id`,
 1 AS `school_id`,
 1 AS `is_visible`,
 1 AS `count`,
 1 AS `max_date_creation`,
 1 AS `max_date_update`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `dashboard_school_enrollment_course_view`
--

DROP TABLE IF EXISTS `dashboard_school_enrollment_course_view`;
/*!50001 DROP VIEW IF EXISTS `dashboard_school_enrollment_course_view`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `dashboard_school_enrollment_course_view` AS SELECT 
 1 AS `row_id`,
 1 AS `school_id`,
 1 AS `count_courses`,
 1 AS `count`,
 1 AS `min_enrollment_date`,
 1 AS `max_enrollment_date`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `dashboard_student_calendar_assistance_view`
--

DROP TABLE IF EXISTS `dashboard_student_calendar_assistance_view`;
/*!50001 DROP VIEW IF EXISTS `dashboard_student_calendar_assistance_view`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `dashboard_student_calendar_assistance_view` AS SELECT 
 1 AS `row_id`,
 1 AS `student_id`,
 1 AS `count`,
 1 AS `min_date_demand`,
 1 AS `max_date_demand`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `dashboard_student_course_view`
--

DROP TABLE IF EXISTS `dashboard_student_course_view`;
/*!50001 DROP VIEW IF EXISTS `dashboard_student_course_view`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `dashboard_student_course_view` AS SELECT 
 1 AS `row_id`,
 1 AS `student_id`,
 1 AS `nbr_course`,
 1 AS `max_course_date_update`,
 1 AS `nbr_instructor`,
 1 AS `nbr_subject`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `dashboard_student_enrollment_course_view`
--

DROP TABLE IF EXISTS `dashboard_student_enrollment_course_view`;
/*!50001 DROP VIEW IF EXISTS `dashboard_student_enrollment_course_view`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `dashboard_student_enrollment_course_view` AS SELECT 
 1 AS `row_id`,
 1 AS `student_id`,
 1 AS `count_courses`,
 1 AS `count`,
 1 AS `min_enrollment_date`,
 1 AS `max_enrollment_date`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `enrollment`
--

DROP TABLE IF EXISTS `enrollment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `enrollment` (
  `id` int NOT NULL AUTO_INCREMENT,
  `student_id` int NOT NULL,
  `course_id` int NOT NULL,
  `enrollment_date` date NOT NULL,
  `is_paid_subscription` char(1) NOT NULL,
  `last_activity` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `enrollment_student` (`student_id`),
  KEY `enrollment_course` (`course_id`),
  CONSTRAINT `enrollment_course` FOREIGN KEY (`course_id`) REFERENCES `course` (`id`) ON DELETE CASCADE,
  CONSTRAINT `enrollment_student` FOREIGN KEY (`student_id`) REFERENCES `student` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enrollment`
--

LOCK TABLES `enrollment` WRITE;
/*!40000 ALTER TABLE `enrollment` DISABLE KEYS */;
INSERT INTO `enrollment` VALUES (1,1,1,'2025-11-26','0','2025-12-26 13:12:18'),(2,1,27,'2025-12-20','0','2025-12-27 20:57:26');
/*!40000 ALTER TABLE `enrollment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `enrollment_course_view`
--

DROP TABLE IF EXISTS `enrollment_course_view`;
/*!50001 DROP VIEW IF EXISTS `enrollment_course_view`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `enrollment_course_view` AS SELECT 
 1 AS `id`,
 1 AS `course_id`,
 1 AS `course_title`,
 1 AS `course_brief`,
 1 AS `instructor_id`,
 1 AS `num_of_chapters`,
 1 AS `course_fee`,
 1 AS `language_id`,
 1 AS `school_subject_id`,
 1 AS `is_visible`,
 1 AS `date_creation`,
 1 AS `date_update`,
 1 AS `language_name`,
 1 AS `school_id`,
 1 AS `label_subject`,
 1 AS `code_qualification`,
 1 AS `education`,
 1 AS `level`,
 1 AS `label_qualification`,
 1 AS `enrollment_id`,
 1 AS `enrollment_date`,
 1 AS `last_activity`,
 1 AS `student_id`,
 1 AS `student_first_name`,
 1 AS `student_last_name`,
 1 AS `classroom`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `event_calendar`
--

DROP TABLE IF EXISTS `event_calendar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `event_calendar` (
  `id` int NOT NULL,
  `event_calendar_fr` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `event_calendar_en` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `event_calendar_es` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event_calendar`
--

LOCK TABLES `event_calendar` WRITE;
/*!40000 ALTER TABLE `event_calendar` DISABLE KEYS */;
INSERT INTO `event_calendar` VALUES (1,'Chat en ligne','Online chat','Chat en línea'),(2,'Visioconférence','Videoconference','Videoconferencia'),(3,'Présentiel en salle','In-person classroom','Presencial en aula');
/*!40000 ALTER TABLE `event_calendar` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `feedback`
--

DROP TABLE IF EXISTS `feedback`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `feedback` (
  `id` int NOT NULL AUTO_INCREMENT,
  `enrollment_id` int NOT NULL,
  `rating_score` int NOT NULL,
  `feedback_text` varchar(4000) DEFAULT NULL,
  `submission_date` date NOT NULL,
  PRIMARY KEY (`id`),
  KEY `feedback_enrollment` (`enrollment_id`),
  CONSTRAINT `feedback_enrollment` FOREIGN KEY (`enrollment_id`) REFERENCES `enrollment` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `feedback`
--

LOCK TABLES `feedback` WRITE;
/*!40000 ALTER TABLE `feedback` DISABLE KEYS */;
/*!40000 ALTER TABLE `feedback` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `feedback_course_view`
--

DROP TABLE IF EXISTS `feedback_course_view`;
/*!50001 DROP VIEW IF EXISTS `feedback_course_view`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `feedback_course_view` AS SELECT 
 1 AS `id`,
 1 AS `course_title`,
 1 AS `course_brief`,
 1 AS `instructor_id`,
 1 AS `num_of_chapters`,
 1 AS `course_fee`,
 1 AS `language_id`,
 1 AS `school_subject_id`,
 1 AS `is_visible`,
 1 AS `date_creation`,
 1 AS `date_update`,
 1 AS `language_name`,
 1 AS `school_id`,
 1 AS `label_subject`,
 1 AS `code_qualification`,
 1 AS `education`,
 1 AS `level`,
 1 AS `label_qualification`,
 1 AS `enrollment_id`,
 1 AS `enrollment_date`,
 1 AS `student_id`,
 1 AS `student_first_name`,
 1 AS `student_last_name`,
 1 AS `classroom`,
 1 AS `feedback_id`,
 1 AS `rating_score`,
 1 AS `feedback_text`,
 1 AS `submission_date`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `instructor`
--

DROP TABLE IF EXISTS `instructor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `instructor` (
  `id` int NOT NULL AUTO_INCREMENT,
  `school_id` int NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `date_birth` date DEFAULT '1900-01-01',
  `address` varchar(1000) DEFAULT NULL,
  `phone_primary` varchar(45) NOT NULL,
  `phone_secondary` varchar(45) DEFAULT NULL,
  `registration_date` date NOT NULL,
  `introduction_brief` varchar(1000) DEFAULT NULL,
  `image` varchar(2000) DEFAULT NULL,
  `num_of_published_courses` int DEFAULT NULL,
  `num_of_enrolled_students` int DEFAULT NULL,
  `average_review_rating` int DEFAULT NULL,
  `num_of_reviews` int DEFAULT NULL,
  `active_account` bit(1) DEFAULT b'1',
  `country_city_id` int DEFAULT NULL,
  `country_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `instructor_school_idx` (`school_id`),
  CONSTRAINT `instructor_school` FOREIGN KEY (`school_id`) REFERENCES `school` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `instructor`
--

LOCK TABLES `instructor` WRITE;
/*!40000 ALTER TABLE `instructor` DISABLE KEYS */;
INSERT INTO `instructor` VALUES (1,1,'IA','Prof','prof@smart.edu','12345678','2023-11-25','localhost intern','+212662373737','','2025-11-25','Agent IA',NULL,24,NULL,NULL,NULL,_binary '',346,116);
/*!40000 ALTER TABLE `instructor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `instructor_calendar`
--

DROP TABLE IF EXISTS `instructor_calendar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `instructor_calendar` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `instructor_id` int NOT NULL,
  `event_calendar_id` int NOT NULL,
  `title` varchar(100) NOT NULL,
  `start` datetime NOT NULL,
  `end` datetime DEFAULT NULL,
  `allDay` bit(1) NOT NULL DEFAULT b'0',
  `backgroundColor` varchar(10) DEFAULT NULL,
  `event_description` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `instructor_calendar_fk_idx` (`instructor_id`),
  KEY `event_calendar_fk_idx` (`event_calendar_id`),
  CONSTRAINT `event_calendar_fk` FOREIGN KEY (`event_calendar_id`) REFERENCES `event_calendar` (`id`),
  CONSTRAINT `instructor_calendar_fk` FOREIGN KEY (`instructor_id`) REFERENCES `instructor` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `instructor_calendar`
--

LOCK TABLES `instructor_calendar` WRITE;
/*!40000 ALTER TABLE `instructor_calendar` DISABLE KEYS */;
INSERT INTO `instructor_calendar` VALUES (1,1,2,'Visioconférence','2025-12-18 00:00:00','2025-12-19 00:00:00',_binary '','#283479','okokoko'),(2,1,1,'Chat en ligne','2025-12-24 10:00:00','2025-12-24 12:00:00',_binary '\0','#000000','ceci est un planning');
/*!40000 ALTER TABLE `instructor_calendar` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `instructor_calendar_assistance`
--

DROP TABLE IF EXISTS `instructor_calendar_assistance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `instructor_calendar_assistance` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `instructor_calendar_id` bigint DEFAULT NULL,
  `student_id` int NOT NULL,
  `course_id` int NOT NULL,
  `course_chapter_id` int NOT NULL,
  `course_chapter_content_id` int NOT NULL,
  `date_demand` datetime NOT NULL,
  `description_demand` varchar(1000) DEFAULT NULL,
  `accepted` bit(1) DEFAULT NULL,
  `acceptance_date` datetime DEFAULT NULL,
  `response_demand` mediumtext,
  `attachment_url` varchar(2000) DEFAULT NULL,
  `response_demand_link` varchar(2000) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `instructor_calendar_instructor_calendar_assistance_idx` (`instructor_calendar_id`),
  CONSTRAINT `instructor_calendar_instructor_calendar_assistance` FOREIGN KEY (`instructor_calendar_id`) REFERENCES `instructor_calendar` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `instructor_calendar_assistance`
--

LOCK TABLES `instructor_calendar_assistance` WRITE;
/*!40000 ALTER TABLE `instructor_calendar_assistance` DISABLE KEYS */;
INSERT INTO `instructor_calendar_assistance` VALUES (1,NULL,1,27,74,160,'2025-12-20 22:41:17','comment faire',_binary '\0','2025-12-20 23:31:16','Demande étudiant:Annuler',NULL,''),(4,NULL,1,1,1,60,'2025-12-20 23:52:10','mmmmmm  bnin',_binary '','2025-12-21 00:00:21','ok pour ceci',NULL,''),(5,NULL,1,1,3,118,'2025-12-20 23:54:01','kmkm mkmklmk',_binary '','2025-12-21 00:00:35','mmmmmmmm jjj',NULL,''),(6,2,1,1,3,118,'2025-12-21 00:30:27','kklkl',_binary '','2025-12-23 20:36:17','ceci est un planning',NULL,'');
/*!40000 ALTER TABLE `instructor_calendar_assistance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `instructor_calendar_assistance_count_view`
--

DROP TABLE IF EXISTS `instructor_calendar_assistance_count_view`;
/*!50001 DROP VIEW IF EXISTS `instructor_calendar_assistance_count_view`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `instructor_calendar_assistance_count_view` AS SELECT 
 1 AS `id`,
 1 AS `instructor_id`,
 1 AS `event_calendar_id`,
 1 AS `title`,
 1 AS `start`,
 1 AS `end`,
 1 AS `allDay`,
 1 AS `backgroundColor`,
 1 AS `event_description`,
 1 AS `count_assistance`,
 1 AS `list_instructor_calendar_assistance_ids`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `instructor_calendar_assistance_view`
--

DROP TABLE IF EXISTS `instructor_calendar_assistance_view`;
/*!50001 DROP VIEW IF EXISTS `instructor_calendar_assistance_view`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `instructor_calendar_assistance_view` AS SELECT 
 1 AS `id`,
 1 AS `instructor_calendar_id`,
 1 AS `student_id`,
 1 AS `course_id`,
 1 AS `course_chapter_id`,
 1 AS `course_chapter_content_id`,
 1 AS `date_demand`,
 1 AS `description_demand`,
 1 AS `accepted`,
 1 AS `acceptance_date`,
 1 AS `response_demand`,
 1 AS `response_demand_link`,
 1 AS `course_title`,
 1 AS `instructor_id`,
 1 AS `chapter_title`,
 1 AS `content_brief`,
 1 AS `student_last_name`,
 1 AS `student_first_name`,
 1 AS `instructor_last_name`,
 1 AS `instructor_first_name`,
 1 AS `school_id`,
 1 AS `school_subject_id`,
 1 AS `label_subject`,
 1 AS `education`,
 1 AS `level`,
 1 AS `label_qualification`,
 1 AS `classroom`,
 1 AS `attachment_url`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `instructor_calendar_view`
--

DROP TABLE IF EXISTS `instructor_calendar_view`;
/*!50001 DROP VIEW IF EXISTS `instructor_calendar_view`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `instructor_calendar_view` AS SELECT 
 1 AS `id`,
 1 AS `instructor_id`,
 1 AS `event_calendar_id`,
 1 AS `title`,
 1 AS `start`,
 1 AS `end`,
 1 AS `allDay`,
 1 AS `event_description`,
 1 AS `backgroundColor`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `instructor_profile`
--

DROP TABLE IF EXISTS `instructor_profile`;
/*!50001 DROP VIEW IF EXISTS `instructor_profile`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `instructor_profile` AS SELECT 
 1 AS `id`,
 1 AS `school_id`,
 1 AS `first_name`,
 1 AS `last_name`,
 1 AS `email`,
 1 AS `password`,
 1 AS `address`,
 1 AS `phone_primary`,
 1 AS `phone_secondary`,
 1 AS `registration_date`,
 1 AS `active_account`,
 1 AS `image`,
 1 AS `introduction_brief`,
 1 AS `country_city_id`,
 1 AS `country_id`,
 1 AS `date_birth`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `instructor_student_subject_qualification_view`
--

DROP TABLE IF EXISTS `instructor_student_subject_qualification_view`;
/*!50001 DROP VIEW IF EXISTS `instructor_student_subject_qualification_view`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `instructor_student_subject_qualification_view` AS SELECT 
 1 AS `view_id`,
 1 AS `student_id`,
 1 AS `school_id`,
 1 AS `school_qualification_id`,
 1 AS `classroom`,
 1 AS `first_name`,
 1 AS `last_name`,
 1 AS `email`,
 1 AS `password`,
 1 AS `address`,
 1 AS `phone_primary`,
 1 AS `phone_secondary`,
 1 AS `registration_date`,
 1 AS `image`,
 1 AS `num_of_courses_enrolled`,
 1 AS `num_of_courses_completed`,
 1 AS `active_account`,
 1 AS `country_city_id`,
 1 AS `country_id`,
 1 AS `school_subject_id`,
 1 AS `instructor_id`,
 1 AS `subject_id`,
 1 AS `qualification_id`,
 1 AS `label_subject`,
 1 AS `code`,
 1 AS `label_qualification`,
 1 AS `level`,
 1 AS `education`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `instructor_subject`
--

DROP TABLE IF EXISTS `instructor_subject`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `instructor_subject` (
  `id` int NOT NULL AUTO_INCREMENT,
  `instructor_id` int NOT NULL,
  `school_subject_id` int NOT NULL,
  `subject_price` int NOT NULL DEFAULT '0',
  `classrooms_teaching` varchar(500) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uc_instructor_subject_qualification` (`instructor_id`,`school_subject_id`),
  KEY `instructor_subject_school_cn_idx` (`school_subject_id`),
  KEY `instructor_subject_cn_idx` (`instructor_id`),
  CONSTRAINT `instructor_subject_qualification_instructor` FOREIGN KEY (`instructor_id`) REFERENCES `instructor` (`id`),
  CONSTRAINT `instructor_subject_school_subject` FOREIGN KEY (`school_subject_id`) REFERENCES `school_subject` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `instructor_subject`
--

LOCK TABLES `instructor_subject` WRITE;
/*!40000 ALTER TABLE `instructor_subject` DISABLE KEYS */;
INSERT INTO `instructor_subject` VALUES (1,1,1,0,'G1');
/*!40000 ALTER TABLE `instructor_subject` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `instructor_subject_classroom_view`
--

DROP TABLE IF EXISTS `instructor_subject_classroom_view`;
/*!50001 DROP VIEW IF EXISTS `instructor_subject_classroom_view`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `instructor_subject_classroom_view` AS SELECT 
 1 AS `id`,
 1 AS `instructor_id`,
 1 AS `school_subject_id`,
 1 AS `school_qualification_id`,
 1 AS `subject_price`,
 1 AS `subject_id`,
 1 AS `qualification_id`,
 1 AS `school_id`,
 1 AS `label_subject`,
 1 AS `code`,
 1 AS `label_qualification`,
 1 AS `level`,
 1 AS `education`,
 1 AS `classroom`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `instructor_subject_view`
--

DROP TABLE IF EXISTS `instructor_subject_view`;
/*!50001 DROP VIEW IF EXISTS `instructor_subject_view`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `instructor_subject_view` AS SELECT 
 1 AS `id`,
 1 AS `school_subject_id`,
 1 AS `school_qualification_id`,
 1 AS `instructor_id`,
 1 AS `subject_id`,
 1 AS `qualification_id`,
 1 AS `school_id`,
 1 AS `label_subject`,
 1 AS `code`,
 1 AS `label_qualification`,
 1 AS `level`,
 1 AS `education`,
 1 AS `classrooms_teaching`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `language`
--

DROP TABLE IF EXISTS `language`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `language` (
  `id` int NOT NULL,
  `language_name` varchar(50) NOT NULL,
  `language_code` varchar(2) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `language`
--

LOCK TABLES `language` WRITE;
/*!40000 ALTER TABLE `language` DISABLE KEYS */;
INSERT INTO `language` VALUES (1,'العربية','ar'),(2,'Français','fr'),(3,'English ','en'),(4,'Español','es');
/*!40000 ALTER TABLE `language` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `learning_progress`
--

DROP TABLE IF EXISTS `learning_progress`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `learning_progress` (
  `id` int NOT NULL AUTO_INCREMENT,
  `enrollment_id` int NOT NULL,
  `course_chapter_content_id` int NOT NULL,
  `begin_timestamp` timestamp NOT NULL,
  `completion_timestamp` timestamp NULL DEFAULT NULL,
  `status` char(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `learning_prgs_crs_chapter_cnt` (`course_chapter_content_id`),
  KEY `learning_progress_enrollment` (`enrollment_id`),
  CONSTRAINT `learning_prgs_crs_chapter_cnt` FOREIGN KEY (`course_chapter_content_id`) REFERENCES `course_chapter_content` (`id`),
  CONSTRAINT `learning_progress_enrollment` FOREIGN KEY (`enrollment_id`) REFERENCES `enrollment` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `learning_progress`
--

LOCK TABLES `learning_progress` WRITE;
/*!40000 ALTER TABLE `learning_progress` DISABLE KEYS */;
INSERT INTO `learning_progress` VALUES (1,1,58,'2025-12-20 10:49:00',NULL,'B');
/*!40000 ALTER TABLE `learning_progress` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `learning_progress_view`
--

DROP TABLE IF EXISTS `learning_progress_view`;
/*!50001 DROP VIEW IF EXISTS `learning_progress_view`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `learning_progress_view` AS SELECT 
 1 AS `row_id`,
 1 AS `id`,
 1 AS `enrollment_id`,
 1 AS `student_id`,
 1 AS `course_id`,
 1 AS `school_subject_id`,
 1 AS `course_chapter_id`,
 1 AS `course_chapter_content_id`,
 1 AS `begin_timestamp`,
 1 AS `completion_timestamp`,
 1 AS `status`,
 1 AS `enrollment_date`,
 1 AS `last_activity`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `messages_box`
--

DROP TABLE IF EXISTS `messages_box`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `messages_box` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_sender_id` int NOT NULL,
  `user_sender_role` varchar(10) NOT NULL,
  `subject` varchar(255) NOT NULL,
  `body` mediumtext NOT NULL,
  `date_update` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `to_trash` bit(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `messages_box`
--

LOCK TABLES `messages_box` WRITE;
/*!40000 ALTER TABLE `messages_box` DISABLE KEYS */;
INSERT INTO `messages_box` VALUES (1,1,'Student','lll','lllll','2025-12-20 22:41:39',_binary '\0');
/*!40000 ALTER TABLE `messages_box` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `messages_box_inbox_view`
--

DROP TABLE IF EXISTS `messages_box_inbox_view`;
/*!50001 DROP VIEW IF EXISTS `messages_box_inbox_view`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `messages_box_inbox_view` AS SELECT 
 1 AS `id`,
 1 AS `user_sender_id`,
 1 AS `user_sender_role`,
 1 AS `subject`,
 1 AS `date_update`,
 1 AS `to_trash`,
 1 AS `message_box_recipient_id`,
 1 AS `user_recipient_id`,
 1 AS `user_recipient_role`,
 1 AS `is_read`,
 1 AS `user_sender_full_name`,
 1 AS `user_sender_email`,
 1 AS `user_recipient_full_name`,
 1 AS `user_recipient_email`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `messages_box_recipients`
--

DROP TABLE IF EXISTS `messages_box_recipients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `messages_box_recipients` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_recipient_id` int NOT NULL,
  `user_recipient_role` varchar(10) NOT NULL,
  `message_box_id` bigint NOT NULL,
  `is_read` bit(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_recipient_id` (`user_recipient_id`,`user_recipient_role`,`message_box_id`),
  KEY `message_box_id` (`message_box_id`),
  CONSTRAINT `messages_box_recipients_ibfk_1` FOREIGN KEY (`message_box_id`) REFERENCES `messages_box` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `messages_box_recipients`
--

LOCK TABLES `messages_box_recipients` WRITE;
/*!40000 ALTER TABLE `messages_box_recipients` DISABLE KEYS */;
INSERT INTO `messages_box_recipients` VALUES (1,1,'Instructor',1,_binary '');
/*!40000 ALTER TABLE `messages_box_recipients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `messages_box_view`
--

DROP TABLE IF EXISTS `messages_box_view`;
/*!50001 DROP VIEW IF EXISTS `messages_box_view`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `messages_box_view` AS SELECT 
 1 AS `id`,
 1 AS `user_sender_id`,
 1 AS `user_sender_role`,
 1 AS `subject`,
 1 AS `body`,
 1 AS `date_update`,
 1 AS `to_trash`,
 1 AS `message_box_recipient_id`,
 1 AS `user_recipient_id`,
 1 AS `user_recipient_role`,
 1 AS `is_read`,
 1 AS `user_sender_full_name`,
 1 AS `user_sender_email`,
 1 AS `user_recipient_full_name`,
 1 AS `user_recipient_email`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `package`
--

DROP TABLE IF EXISTS `package`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `package` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `price_per_student` decimal(10,2) NOT NULL,
  `min_students` int DEFAULT '1',
  `max_students` int DEFAULT NULL,
  `max_teachers` int DEFAULT NULL,
  `max_courses_per_prof` int DEFAULT NULL,
  `duration_days` int DEFAULT NULL,
  `discount_percentage` decimal(5,2) DEFAULT '0.00',
  `discount_start_month` int DEFAULT '0',
  `featured` bit(1) DEFAULT NULL,
  `support` bit(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `package`
--

LOCK TABLES `package` WRITE;
/*!40000 ALTER TABLE `package` DISABLE KEYS */;
INSERT INTO `package` VALUES (1,'DEMO',0.00,1,10,3,3,14,0.00,0,_binary '\0',_binary '\0'),(2,'START',89.00,1,20,3,20,0,5.00,11,_binary '\0',_binary '\0'),(3,'BASIC',59.00,21,100,10,50,0,5.00,9,_binary '',_binary '\0'),(4,'SILVER',29.00,101,500,100,200,0,5.00,6,_binary '\0',_binary ''),(5,'GOLD',21.00,501,1000,500,1000,0,10.00,3,_binary '\0',_binary '');
/*!40000 ALTER TABLE `package` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment`
--

DROP TABLE IF EXISTS `payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment` (
  `id` int NOT NULL AUTO_INCREMENT,
  `school_id` int NOT NULL,
  `package_id` int NOT NULL,
  `number_of_students` int NOT NULL,
  `number_of_months` int NOT NULL,
  `amount_paid_reel` decimal(10,2) NOT NULL DEFAULT '0.00',
  `amount_paid_global` decimal(10,2) NOT NULL DEFAULT '0.00',
  `payment_method` varchar(20) NOT NULL,
  `discount_percentage` int DEFAULT NULL,
  `payment_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `renewal_date` datetime DEFAULT NULL,
  `payment_status` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `transaction_reference` varchar(255) DEFAULT NULL,
  `date_insert` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `payment_school_FK` (`school_id`),
  KEY `payment_package_FK` (`package_id`),
  CONSTRAINT `payment_package_FK` FOREIGN KEY (`package_id`) REFERENCES `package` (`id`) ON DELETE CASCADE,
  CONSTRAINT `payment_school_FK` FOREIGN KEY (`school_id`) REFERENCES `school` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment`
--

LOCK TABLES `payment` WRITE;
/*!40000 ALTER TABLE `payment` DISABLE KEYS */;
INSERT INTO `payment` VALUES (2,1,5,501,12,113627.00,113627.00,'contact_sales',0,'2025-11-26 00:00:00','2026-11-27 00:00:00','1','7a3afd73-87fb-450a-b074-f35067ae1c12','2025-11-26 21:39:53');
/*!40000 ALTER TABLE `payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment_status`
--

DROP TABLE IF EXISTS `payment_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment_status` (
  `code` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `label` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment_status`
--

LOCK TABLES `payment_status` WRITE;
/*!40000 ALTER TABLE `payment_status` DISABLE KEYS */;
INSERT INTO `payment_status` VALUES ('1','finished'),('2','pending'),('3','failed'),('4','canceled'),('5','to_validate');
/*!40000 ALTER TABLE `payment_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qualification`
--

DROP TABLE IF EXISTS `qualification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `qualification` (
  `id` int NOT NULL AUTO_INCREMENT,
  `code` varchar(45) NOT NULL,
  `label` varchar(200) NOT NULL,
  `level` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `education` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `school_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `qualification_school_FK` (`school_id`),
  CONSTRAINT `qualification_school_FK` FOREIGN KEY (`school_id`) REFERENCES `school` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qualification`
--

LOCK TABLES `qualification` WRITE;
/*!40000 ALTER TABLE `qualification` DISABLE KEYS */;
INSERT INTO `qualification` VALUES (1,'23','École d\'ingénieurs','Enseignement Supérieur','Établissements d\'enseignement supérieur',1),(2,'000','nnnn','Enseignement Supérieur','Établissements d\'enseignement supérieur',1);
/*!40000 ALTER TABLE `qualification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `questions`
--

DROP TABLE IF EXISTS `questions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `questions` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `idx` int DEFAULT NULL,
  `question_text` varchar(8000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `choices` text NOT NULL,
  `correct_answer` int unsigned NOT NULL,
  `quiz_id` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_questions_quiz` (`quiz_id`),
  CONSTRAINT `fk_questions_quiz` FOREIGN KEY (`quiz_id`) REFERENCES `quizzes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=688 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `questions`
--

LOCK TABLES `questions` WRITE;
/*!40000 ALTER TABLE `questions` DISABLE KEYS */;
INSERT INTO `questions` VALUES (1,1,'Quel est l\'objectif principal du cours \"Introduction à l\'Intelligence Artificielle\" ?','[\"Comprendre les concepts\",\"Suivre l\'installation du logiciel\",\"Acheter une licence\",\"Rédiger un CV\"]',0,1),(2,1,'Quel est l\'objectif principal du cours \"Machine Learning : notions et algorithmes\" ?','[\"Comprendre les concepts\",\"Suivre l\'installation du logiciel\",\"Acheter une licence\",\"Rédiger un CV\"]',0,2),(3,1,'Quel est l\'objectif principal du cours \"Deep Learning pour vision par ordinateur\" ?','[\"Comprendre les concepts\",\"Suivre l\'installation du logiciel\",\"Acheter une licence\",\"Rédiger un CV\"]',0,3),(4,1,'Quel est l\'objectif principal du cours \"NLP : traitement du langage naturel\" ?','[\"Comprendre les concepts\",\"Suivre l\'installation du logiciel\",\"Acheter une licence\",\"Rédiger un CV\"]',0,4),(5,1,'Quel est l\'objectif principal du cours \"Apprentissage non supervisé et clustering\" ?','[\"Comprendre les concepts\",\"Suivre l\'installation du logiciel\",\"Acheter une licence\",\"Rédiger un CV\"]',0,5),(6,1,'Quel est l\'objectif principal du cours \"Modèles probabilistes et bayésiens\" ?','[\"Comprendre les concepts\",\"Suivre l\'installation du logiciel\",\"Acheter une licence\",\"Rédiger un CV\"]',0,6),(7,1,'Quel est l\'objectif principal du cours \"MLOps : mise en production de modèles\" ?','[\"Comprendre les concepts\",\"Suivre l\'installation du logiciel\",\"Acheter une licence\",\"Rédiger un CV\"]',0,7),(8,1,'Quel est l\'objectif principal du cours \"Éthique et IA responsable\" ?','[\"Comprendre les concepts\",\"Suivre l\'installation du logiciel\",\"Acheter une licence\",\"Rédiger un CV\"]',0,8),(9,1,'Quel est l\'objectif principal du cours \"Apprentissage par renforcement\" ?','[\"Comprendre les concepts\",\"Suivre l\'installation du logiciel\",\"Acheter une licence\",\"Rédiger un CV\"]',0,9),(10,1,'Quel est l\'objectif principal du cours \"Feature Engineering avancé\" ?','[\"Comprendre les concepts\",\"Suivre l\'installation du logiciel\",\"Acheter une licence\",\"Rédiger un CV\"]',0,10),(11,1,'Quel est l\'objectif principal du cours \"Computer Vision avancé : détection et segmentation\" ?','[\"Comprendre les concepts\",\"Suivre l\'installation du logiciel\",\"Acheter une licence\",\"Rédiger un CV\"]',0,11),(12,1,'Quel est l\'objectif principal du cours \"Time Series & Forecasting\" ?','[\"Comprendre les concepts\",\"Suivre l\'installation du logiciel\",\"Acheter une licence\",\"Rédiger un CV\"]',0,12),(13,1,'Quel est l\'objectif principal du cours \"AutoML et optimisation d\'hyperparamètres\" ?','[\"Comprendre les concepts\",\"Suivre l\'installation du logiciel\",\"Acheter une licence\",\"Rédiger un CV\"]',0,13),(14,1,'Quel est l\'objectif principal du cours \"Représentations et embeddings\" ?','[\"Comprendre les concepts\",\"Suivre l\'installation du logiciel\",\"Acheter une licence\",\"Rédiger un CV\"]',0,14),(15,1,'Quel est l\'objectif principal du cours \"Graph ML : GNN et applications\" ?','[\"Comprendre les concepts\",\"Suivre l\'installation du logiciel\",\"Acheter une licence\",\"Rédiger un CV\"]',0,15),(16,1,'Quel est l\'objectif principal du cours \"IA et robotique : perception et contrôle\" ?','[\"Comprendre les concepts\",\"Suivre l\'installation du logiciel\",\"Acheter une licence\",\"Rédiger un CV\"]',0,16),(17,1,'Quel est l\'objectif principal du cours \"Sécurité des modèles ML\" ?','[\"Comprendre les concepts\",\"Suivre l\'installation du logiciel\",\"Acheter une licence\",\"Rédiger un CV\"]',0,17),(18,1,'Quel est l\'objectif principal du cours \"Pratiques avancées de data labeling\" ?','[\"Comprendre les concepts\",\"Suivre l\'installation du logiciel\",\"Acheter une licence\",\"Rédiger un CV\"]',0,18),(19,1,'Quel est l\'objectif principal du cours \"IA pour la santé\" ?','[\"Comprendre les concepts\",\"Suivre l\'installation du logiciel\",\"Acheter une licence\",\"Rédiger un CV\"]',0,19),(20,1,'Quel est l\'objectif principal du cours \"Projet capstone : construire une solution IA complète\" ?','[\"Comprendre les concepts\",\"Suivre l\'installation du logiciel\",\"Acheter une licence\",\"Rédiger un CV\"]',0,20),(32,2,'Quel outil est typiquement utilisé dans les travaux pratiques du cours \"Introduction à l\'Intelligence Artificielle\" ?','[\"Python\",\"Microsoft Excel\",\"Adobe Photoshop\",\"Microsoft Word\"]',0,1),(33,2,'Quel outil est typiquement utilisé dans les travaux pratiques du cours \"Machine Learning : notions et algorithmes\" ?','[\"Python\",\"Microsoft Excel\",\"Adobe Photoshop\",\"Microsoft Word\"]',0,2),(34,2,'Quel outil est typiquement utilisé dans les travaux pratiques du cours \"Deep Learning pour vision par ordinateur\" ?','[\"Python\",\"Microsoft Excel\",\"Adobe Photoshop\",\"Microsoft Word\"]',0,3),(35,2,'Quel outil est typiquement utilisé dans les travaux pratiques du cours \"NLP : traitement du langage naturel\" ?','[\"Python\",\"Microsoft Excel\",\"Adobe Photoshop\",\"Microsoft Word\"]',0,4),(36,2,'Quel outil est typiquement utilisé dans les travaux pratiques du cours \"Apprentissage non supervisé et clustering\" ?','[\"Python\",\"Microsoft Excel\",\"Adobe Photoshop\",\"Microsoft Word\"]',0,5),(37,2,'Quel outil est typiquement utilisé dans les travaux pratiques du cours \"Modèles probabilistes et bayésiens\" ?','[\"Python\",\"Microsoft Excel\",\"Adobe Photoshop\",\"Microsoft Word\"]',0,6),(38,2,'Quel outil est typiquement utilisé dans les travaux pratiques du cours \"MLOps : mise en production de modèles\" ?','[\"Python\",\"Microsoft Excel\",\"Adobe Photoshop\",\"Microsoft Word\"]',0,7),(39,2,'Quel outil est typiquement utilisé dans les travaux pratiques du cours \"Éthique et IA responsable\" ?','[\"Python\",\"Microsoft Excel\",\"Adobe Photoshop\",\"Microsoft Word\"]',0,8),(40,2,'Quel outil est typiquement utilisé dans les travaux pratiques du cours \"Apprentissage par renforcement\" ?','[\"Python\",\"Microsoft Excel\",\"Adobe Photoshop\",\"Microsoft Word\"]',0,9),(41,2,'Quel outil est typiquement utilisé dans les travaux pratiques du cours \"Feature Engineering avancé\" ?','[\"Python\",\"Microsoft Excel\",\"Adobe Photoshop\",\"Microsoft Word\"]',0,10),(42,2,'Quel outil est typiquement utilisé dans les travaux pratiques du cours \"Computer Vision avancé : détection et segmentation\" ?','[\"Python\",\"Microsoft Excel\",\"Adobe Photoshop\",\"Microsoft Word\"]',0,11),(43,2,'Quel outil est typiquement utilisé dans les travaux pratiques du cours \"Time Series & Forecasting\" ?','[\"Python\",\"Microsoft Excel\",\"Adobe Photoshop\",\"Microsoft Word\"]',0,12),(44,2,'Quel outil est typiquement utilisé dans les travaux pratiques du cours \"AutoML et optimisation d\'hyperparamètres\" ?','[\"Python\",\"Microsoft Excel\",\"Adobe Photoshop\",\"Microsoft Word\"]',0,13),(45,2,'Quel outil est typiquement utilisé dans les travaux pratiques du cours \"Représentations et embeddings\" ?','[\"Python\",\"Microsoft Excel\",\"Adobe Photoshop\",\"Microsoft Word\"]',0,14),(46,2,'Quel outil est typiquement utilisé dans les travaux pratiques du cours \"Graph ML : GNN et applications\" ?','[\"Python\",\"Microsoft Excel\",\"Adobe Photoshop\",\"Microsoft Word\"]',0,15),(47,2,'Quel outil est typiquement utilisé dans les travaux pratiques du cours \"IA et robotique : perception et contrôle\" ?','[\"Python\",\"Microsoft Excel\",\"Adobe Photoshop\",\"Microsoft Word\"]',0,16),(48,2,'Quel outil est typiquement utilisé dans les travaux pratiques du cours \"Sécurité des modèles ML\" ?','[\"Python\",\"Microsoft Excel\",\"Adobe Photoshop\",\"Microsoft Word\"]',0,17),(49,2,'Quel outil est typiquement utilisé dans les travaux pratiques du cours \"Pratiques avancées de data labeling\" ?','[\"Python\",\"Microsoft Excel\",\"Adobe Photoshop\",\"Microsoft Word\"]',0,18),(50,2,'Quel outil est typiquement utilisé dans les travaux pratiques du cours \"IA pour la santé\" ?','[\"Python\",\"Microsoft Excel\",\"Adobe Photoshop\",\"Microsoft Word\"]',0,19),(51,2,'Quel outil est typiquement utilisé dans les travaux pratiques du cours \"Projet capstone : construire une solution IA complète\" ?','[\"Python\",\"Microsoft Excel\",\"Adobe Photoshop\",\"Microsoft Word\"]',0,20),(63,3,'Le cours \"Introduction à l\'Intelligence Artificielle\" relève principalement de quel domaine ?','[\"Informatique / IA\",\"Cuisine\",\"Musique\",\"Sport\"]',0,1),(64,3,'Le cours \"Machine Learning : notions et algorithmes\" relève principalement de quel domaine ?','[\"Informatique / IA\",\"Cuisine\",\"Musique\",\"Sport\"]',0,2),(65,3,'Le cours \"Deep Learning pour vision par ordinateur\" relève principalement de quel domaine ?','[\"Informatique / IA\",\"Cuisine\",\"Musique\",\"Sport\"]',0,3),(66,3,'Le cours \"NLP : traitement du langage naturel\" relève principalement de quel domaine ?','[\"Informatique / IA\",\"Cuisine\",\"Musique\",\"Sport\"]',0,4),(67,3,'Le cours \"Apprentissage non supervisé et clustering\" relève principalement de quel domaine ?','[\"Informatique / IA\",\"Cuisine\",\"Musique\",\"Sport\"]',0,5),(68,3,'Le cours \"Modèles probabilistes et bayésiens\" relève principalement de quel domaine ?','[\"Informatique / IA\",\"Cuisine\",\"Musique\",\"Sport\"]',0,6),(69,3,'Le cours \"MLOps : mise en production de modèles\" relève principalement de quel domaine ?','[\"Informatique / IA\",\"Cuisine\",\"Musique\",\"Sport\"]',0,7),(70,3,'Le cours \"Éthique et IA responsable\" relève principalement de quel domaine ?','[\"Informatique / IA\",\"Cuisine\",\"Musique\",\"Sport\"]',0,8),(71,3,'Le cours \"Apprentissage par renforcement\" relève principalement de quel domaine ?','[\"Informatique / IA\",\"Cuisine\",\"Musique\",\"Sport\"]',0,9),(72,3,'Le cours \"Feature Engineering avancé\" relève principalement de quel domaine ?','[\"Informatique / IA\",\"Cuisine\",\"Musique\",\"Sport\"]',0,10),(73,3,'Le cours \"Computer Vision avancé : détection et segmentation\" relève principalement de quel domaine ?','[\"Informatique / IA\",\"Cuisine\",\"Musique\",\"Sport\"]',0,11),(74,3,'Le cours \"Time Series & Forecasting\" relève principalement de quel domaine ?','[\"Informatique / IA\",\"Cuisine\",\"Musique\",\"Sport\"]',0,12),(75,3,'Le cours \"AutoML et optimisation d\'hyperparamètres\" relève principalement de quel domaine ?','[\"Informatique / IA\",\"Cuisine\",\"Musique\",\"Sport\"]',0,13),(76,3,'Le cours \"Représentations et embeddings\" relève principalement de quel domaine ?','[\"Informatique / IA\",\"Cuisine\",\"Musique\",\"Sport\"]',0,14),(77,3,'Le cours \"Graph ML : GNN et applications\" relève principalement de quel domaine ?','[\"Informatique / IA\",\"Cuisine\",\"Musique\",\"Sport\"]',0,15),(78,3,'Le cours \"IA et robotique : perception et contrôle\" relève principalement de quel domaine ?','[\"Informatique / IA\",\"Cuisine\",\"Musique\",\"Sport\"]',0,16),(79,3,'Le cours \"Sécurité des modèles ML\" relève principalement de quel domaine ?','[\"Informatique / IA\",\"Cuisine\",\"Musique\",\"Sport\"]',0,17),(80,3,'Le cours \"Pratiques avancées de data labeling\" relève principalement de quel domaine ?','[\"Informatique / IA\",\"Cuisine\",\"Musique\",\"Sport\"]',0,18),(81,3,'Le cours \"IA pour la santé\" relève principalement de quel domaine ?','[\"Informatique / IA\",\"Cuisine\",\"Musique\",\"Sport\"]',0,19),(82,3,'Le cours \"Projet capstone : construire une solution IA complète\" relève principalement de quel domaine ?','[\"Informatique / IA\",\"Cuisine\",\"Musique\",\"Sport\"]',0,20),(94,4,'Quel type principal de ressource est fourni dans \"Introduction à l\'Intelligence Artificielle\" ?','[\"Vidéos pédagogiques\",\"Fichiers audio\",\"Images haute résolution\",\"Documents imprimés uniquement\"]',0,1),(95,4,'Quel type principal de ressource est fourni dans \"Machine Learning : notions et algorithmes\" ?','[\"Vidéos pédagogiques\",\"Fichiers audio\",\"Images haute résolution\",\"Documents imprimés uniquement\"]',0,2),(96,4,'Quel type principal de ressource est fourni dans \"Deep Learning pour vision par ordinateur\" ?','[\"Vidéos pédagogiques\",\"Fichiers audio\",\"Images haute résolution\",\"Documents imprimés uniquement\"]',0,3),(97,4,'Quel type principal de ressource est fourni dans \"NLP : traitement du langage naturel\" ?','[\"Vidéos pédagogiques\",\"Fichiers audio\",\"Images haute résolution\",\"Documents imprimés uniquement\"]',0,4),(98,4,'Quel type principal de ressource est fourni dans \"Apprentissage non supervisé et clustering\" ?','[\"Vidéos pédagogiques\",\"Fichiers audio\",\"Images haute résolution\",\"Documents imprimés uniquement\"]',0,5),(99,4,'Quel type principal de ressource est fourni dans \"Modèles probabilistes et bayésiens\" ?','[\"Vidéos pédagogiques\",\"Fichiers audio\",\"Images haute résolution\",\"Documents imprimés uniquement\"]',0,6),(100,4,'Quel type principal de ressource est fourni dans \"MLOps : mise en production de modèles\" ?','[\"Vidéos pédagogiques\",\"Fichiers audio\",\"Images haute résolution\",\"Documents imprimés uniquement\"]',0,7),(101,4,'Quel type principal de ressource est fourni dans \"Éthique et IA responsable\" ?','[\"Vidéos pédagogiques\",\"Fichiers audio\",\"Images haute résolution\",\"Documents imprimés uniquement\"]',0,8),(102,4,'Quel type principal de ressource est fourni dans \"Apprentissage par renforcement\" ?','[\"Vidéos pédagogiques\",\"Fichiers audio\",\"Images haute résolution\",\"Documents imprimés uniquement\"]',0,9),(103,4,'Quel type principal de ressource est fourni dans \"Feature Engineering avancé\" ?','[\"Vidéos pédagogiques\",\"Fichiers audio\",\"Images haute résolution\",\"Documents imprimés uniquement\"]',0,10),(104,4,'Quel type principal de ressource est fourni dans \"Computer Vision avancé : détection et segmentation\" ?','[\"Vidéos pédagogiques\",\"Fichiers audio\",\"Images haute résolution\",\"Documents imprimés uniquement\"]',0,11),(105,4,'Quel type principal de ressource est fourni dans \"Time Series & Forecasting\" ?','[\"Vidéos pédagogiques\",\"Fichiers audio\",\"Images haute résolution\",\"Documents imprimés uniquement\"]',0,12),(106,4,'Quel type principal de ressource est fourni dans \"AutoML et optimisation d\'hyperparamètres\" ?','[\"Vidéos pédagogiques\",\"Fichiers audio\",\"Images haute résolution\",\"Documents imprimés uniquement\"]',0,13),(107,4,'Quel type principal de ressource est fourni dans \"Représentations et embeddings\" ?','[\"Vidéos pédagogiques\",\"Fichiers audio\",\"Images haute résolution\",\"Documents imprimés uniquement\"]',0,14),(108,4,'Quel type principal de ressource est fourni dans \"Graph ML : GNN et applications\" ?','[\"Vidéos pédagogiques\",\"Fichiers audio\",\"Images haute résolution\",\"Documents imprimés uniquement\"]',0,15),(109,4,'Quel type principal de ressource est fourni dans \"IA et robotique : perception et contrôle\" ?','[\"Vidéos pédagogiques\",\"Fichiers audio\",\"Images haute résolution\",\"Documents imprimés uniquement\"]',0,16),(110,4,'Quel type principal de ressource est fourni dans \"Sécurité des modèles ML\" ?','[\"Vidéos pédagogiques\",\"Fichiers audio\",\"Images haute résolution\",\"Documents imprimés uniquement\"]',0,17),(111,4,'Quel type principal de ressource est fourni dans \"Pratiques avancées de data labeling\" ?','[\"Vidéos pédagogiques\",\"Fichiers audio\",\"Images haute résolution\",\"Documents imprimés uniquement\"]',0,18),(112,4,'Quel type principal de ressource est fourni dans \"IA pour la santé\" ?','[\"Vidéos pédagogiques\",\"Fichiers audio\",\"Images haute résolution\",\"Documents imprimés uniquement\"]',0,19),(113,4,'Quel type principal de ressource est fourni dans \"Projet capstone : construire une solution IA complète\" ?','[\"Vidéos pédagogiques\",\"Fichiers audio\",\"Images haute résolution\",\"Documents imprimés uniquement\"]',0,20),(125,5,'Combien de chapitres contient le cours \"Introduction à l\'Intelligence Artificielle\" ?','[\"3\",\"4\",\"5\"]',0,1),(126,5,'Combien de chapitres contient le cours \"Machine Learning : notions et algorithmes\" ?','[\"3\",\"4\",\"5\"]',0,2),(127,5,'Combien de chapitres contient le cours \"Deep Learning pour vision par ordinateur\" ?','[\"3\",\"4\",\"5\"]',0,3),(128,5,'Combien de chapitres contient le cours \"NLP : traitement du langage naturel\" ?','[\"3\",\"4\",\"5\"]',0,4),(129,5,'Combien de chapitres contient le cours \"Apprentissage non supervisé et clustering\" ?','[\"3\",\"4\",\"5\"]',0,5),(130,5,'Combien de chapitres contient le cours \"Modèles probabilistes et bayésiens\" ?','[\"3\",\"4\",\"5\"]',0,6),(131,5,'Combien de chapitres contient le cours \"MLOps : mise en production de modèles\" ?','[\"3\",\"4\",\"5\"]',0,7),(132,5,'Combien de chapitres contient le cours \"Éthique et IA responsable\" ?','[\"3\",\"4\",\"5\"]',0,8),(133,5,'Combien de chapitres contient le cours \"Apprentissage par renforcement\" ?','[\"3\",\"4\",\"5\"]',0,9),(134,5,'Combien de chapitres contient le cours \"Feature Engineering avancé\" ?','[\"3\",\"4\",\"5\"]',0,10),(135,5,'Combien de chapitres contient le cours \"Computer Vision avancé : détection et segmentation\" ?','[\"3\",\"4\",\"5\"]',0,11),(136,5,'Combien de chapitres contient le cours \"Time Series & Forecasting\" ?','[\"3\",\"4\",\"5\"]',0,12),(137,5,'Combien de chapitres contient le cours \"AutoML et optimisation d\'hyperparamètres\" ?','[\"3\",\"4\",\"5\"]',0,13),(138,5,'Combien de chapitres contient le cours \"Représentations et embeddings\" ?','[\"3\",\"4\",\"5\"]',0,14),(139,5,'Combien de chapitres contient le cours \"Graph ML : GNN et applications\" ?','[\"3\",\"4\",\"5\"]',0,15),(140,5,'Combien de chapitres contient le cours \"IA et robotique : perception et contrôle\" ?','[\"3\",\"4\",\"5\"]',0,16),(141,5,'Combien de chapitres contient le cours \"Sécurité des modèles ML\" ?','[\"3\",\"4\",\"5\"]',0,17),(142,5,'Combien de chapitres contient le cours \"Pratiques avancées de data labeling\" ?','[\"3\",\"4\",\"5\"]',0,18),(143,5,'Combien de chapitres contient le cours \"IA pour la santé\" ?','[\"3\",\"4\",\"5\"]',0,19),(144,5,'Combien de chapitres contient le cours \"Projet capstone : construire une solution IA complète\" ?','[\"3\",\"4\",\"5\"]',0,20),(156,1,'Quel est le thème principal du cours \"Introduction à l\'Intelligence Artificielle\" ?','[\"Intelligence artificielle\",\"Biologie\",\"Arts visuels\",\"Gestion hôtelière\"]',0,32),(157,1,'Quel est le thème principal du cours \"Introduction à l\'Intelligence Artificielle\" ?','[\"Intelligence artificielle\",\"Biologie\",\"Arts visuels\",\"Gestion hôtelière\"]',0,33),(158,1,'Quel est le thème principal du cours \"Introduction à l\'Intelligence Artificielle\" ?','[\"Intelligence artificielle\",\"Biologie\",\"Arts visuels\",\"Gestion hôtelière\"]',0,34),(159,1,'Quel est le thème principal du cours \"Machine Learning : notions et algorithmes\" ?','[\"Intelligence artificielle\",\"Biologie\",\"Arts visuels\",\"Gestion hôtelière\"]',0,35),(162,1,'Quel est le thème principal du cours \"Deep Learning pour vision par ordinateur\" ?','[\"Intelligence artificielle\",\"Biologie\",\"Arts visuels\",\"Gestion hôtelière\"]',0,38),(163,1,'Quel est le thème principal du cours \"Deep Learning pour vision par ordinateur\" ?','[\"Intelligence artificielle\",\"Biologie\",\"Arts visuels\",\"Gestion hôtelière\"]',0,39),(164,1,'Quel est le thème principal du cours \"Deep Learning pour vision par ordinateur\" ?','[\"Intelligence artificielle\",\"Biologie\",\"Arts visuels\",\"Gestion hôtelière\"]',0,40),(165,1,'Quel est le thème principal du cours \"NLP : traitement du langage naturel\" ?','[\"Intelligence artificielle\",\"Biologie\",\"Arts visuels\",\"Gestion hôtelière\"]',0,41),(166,1,'Quel est le thème principal du cours \"NLP : traitement du langage naturel\" ?','[\"Intelligence artificielle\",\"Biologie\",\"Arts visuels\",\"Gestion hôtelière\"]',0,42),(167,1,'Quel est le thème principal du cours \"NLP : traitement du langage naturel\" ?','[\"Intelligence artificielle\",\"Biologie\",\"Arts visuels\",\"Gestion hôtelière\"]',0,43),(168,1,'Quel est le thème principal du cours \"Apprentissage non supervisé et clustering\" ?','[\"Intelligence artificielle\",\"Biologie\",\"Arts visuels\",\"Gestion hôtelière\"]',0,44),(169,1,'Quel est le thème principal du cours \"Apprentissage non supervisé et clustering\" ?','[\"Intelligence artificielle\",\"Biologie\",\"Arts visuels\",\"Gestion hôtelière\"]',0,45),(170,1,'Quel est le thème principal du cours \"Apprentissage non supervisé et clustering\" ?','[\"Intelligence artificielle\",\"Biologie\",\"Arts visuels\",\"Gestion hôtelière\"]',0,46),(171,1,'Quel est le thème principal du cours \"Modèles probabilistes et bayésiens\" ?','[\"Intelligence artificielle\",\"Biologie\",\"Arts visuels\",\"Gestion hôtelière\"]',0,47),(172,1,'Quel est le thème principal du cours \"Modèles probabilistes et bayésiens\" ?','[\"Intelligence artificielle\",\"Biologie\",\"Arts visuels\",\"Gestion hôtelière\"]',0,48),(173,1,'Quel est le thème principal du cours \"Modèles probabilistes et bayésiens\" ?','[\"Intelligence artificielle\",\"Biologie\",\"Arts visuels\",\"Gestion hôtelière\"]',0,49),(174,1,'Quel est le thème principal du cours \"MLOps : mise en production de modèles\" ?','[\"Intelligence artificielle\",\"Biologie\",\"Arts visuels\",\"Gestion hôtelière\"]',0,50),(175,1,'Quel est le thème principal du cours \"MLOps : mise en production de modèles\" ?','[\"Intelligence artificielle\",\"Biologie\",\"Arts visuels\",\"Gestion hôtelière\"]',0,51),(176,1,'Quel est le thème principal du cours \"MLOps : mise en production de modèles\" ?','[\"Intelligence artificielle\",\"Biologie\",\"Arts visuels\",\"Gestion hôtelière\"]',0,52),(177,1,'Quel est le thème principal du cours \"Éthique et IA responsable\" ?','[\"Intelligence artificielle\",\"Biologie\",\"Arts visuels\",\"Gestion hôtelière\"]',0,53),(178,1,'Quel est le thème principal du cours \"Éthique et IA responsable\" ?','[\"Intelligence artificielle\",\"Biologie\",\"Arts visuels\",\"Gestion hôtelière\"]',0,54),(179,1,'Quel est le thème principal du cours \"Éthique et IA responsable\" ?','[\"Intelligence artificielle\",\"Biologie\",\"Arts visuels\",\"Gestion hôtelière\"]',0,55),(180,1,'Quel est le thème principal du cours \"Apprentissage par renforcement\" ?','[\"Intelligence artificielle\",\"Biologie\",\"Arts visuels\",\"Gestion hôtelière\"]',0,56),(181,1,'Quel est le thème principal du cours \"Apprentissage par renforcement\" ?','[\"Intelligence artificielle\",\"Biologie\",\"Arts visuels\",\"Gestion hôtelière\"]',0,57),(182,1,'Quel est le thème principal du cours \"Apprentissage par renforcement\" ?','[\"Intelligence artificielle\",\"Biologie\",\"Arts visuels\",\"Gestion hôtelière\"]',0,58),(183,1,'Quel est le thème principal du cours \"Feature Engineering avancé\" ?','[\"Intelligence artificielle\",\"Biologie\",\"Arts visuels\",\"Gestion hôtelière\"]',0,59),(184,1,'Quel est le thème principal du cours \"Feature Engineering avancé\" ?','[\"Intelligence artificielle\",\"Biologie\",\"Arts visuels\",\"Gestion hôtelière\"]',0,60),(185,1,'Quel est le thème principal du cours \"Feature Engineering avancé\" ?','[\"Intelligence artificielle\",\"Biologie\",\"Arts visuels\",\"Gestion hôtelière\"]',0,61),(186,1,'Quel est le thème principal du cours \"Computer Vision avancé : détection et segmentation\" ?','[\"Intelligence artificielle\",\"Biologie\",\"Arts visuels\",\"Gestion hôtelière\"]',0,62),(187,1,'Quel est le thème principal du cours \"Computer Vision avancé : détection et segmentation\" ?','[\"Intelligence artificielle\",\"Biologie\",\"Arts visuels\",\"Gestion hôtelière\"]',0,63),(188,1,'Quel est le thème principal du cours \"Computer Vision avancé : détection et segmentation\" ?','[\"Intelligence artificielle\",\"Biologie\",\"Arts visuels\",\"Gestion hôtelière\"]',0,64),(189,1,'Quel est le thème principal du cours \"Time Series & Forecasting\" ?','[\"Intelligence artificielle\",\"Biologie\",\"Arts visuels\",\"Gestion hôtelière\"]',0,65),(190,1,'Quel est le thème principal du cours \"Time Series & Forecasting\" ?','[\"Intelligence artificielle\",\"Biologie\",\"Arts visuels\",\"Gestion hôtelière\"]',0,66),(191,1,'Quel est le thème principal du cours \"Time Series & Forecasting\" ?','[\"Intelligence artificielle\",\"Biologie\",\"Arts visuels\",\"Gestion hôtelière\"]',0,67),(192,1,'Quel est le thème principal du cours \"AutoML et optimisation d\'hyperparamètres\" ?','[\"Intelligence artificielle\",\"Biologie\",\"Arts visuels\",\"Gestion hôtelière\"]',0,68),(193,1,'Quel est le thème principal du cours \"AutoML et optimisation d\'hyperparamètres\" ?','[\"Intelligence artificielle\",\"Biologie\",\"Arts visuels\",\"Gestion hôtelière\"]',0,69),(194,1,'Quel est le thème principal du cours \"AutoML et optimisation d\'hyperparamètres\" ?','[\"Intelligence artificielle\",\"Biologie\",\"Arts visuels\",\"Gestion hôtelière\"]',0,70),(195,1,'Quel est le thème principal du cours \"Représentations et embeddings\" ?','[\"Intelligence artificielle\",\"Biologie\",\"Arts visuels\",\"Gestion hôtelière\"]',0,71),(196,1,'Quel est le thème principal du cours \"Représentations et embeddings\" ?','[\"Intelligence artificielle\",\"Biologie\",\"Arts visuels\",\"Gestion hôtelière\"]',0,72),(197,1,'Quel est le thème principal du cours \"Représentations et embeddings\" ?','[\"Intelligence artificielle\",\"Biologie\",\"Arts visuels\",\"Gestion hôtelière\"]',0,73),(198,1,'Quel est le thème principal du cours \"Graph ML : GNN et applications\" ?','[\"Intelligence artificielle\",\"Biologie\",\"Arts visuels\",\"Gestion hôtelière\"]',0,74),(199,1,'Quel est le thème principal du cours \"Graph ML : GNN et applications\" ?','[\"Intelligence artificielle\",\"Biologie\",\"Arts visuels\",\"Gestion hôtelière\"]',0,75),(200,1,'Quel est le thème principal du cours \"Graph ML : GNN et applications\" ?','[\"Intelligence artificielle\",\"Biologie\",\"Arts visuels\",\"Gestion hôtelière\"]',0,76),(201,1,'Quel est le thème principal du cours \"IA et robotique : perception et contrôle\" ?','[\"Intelligence artificielle\",\"Biologie\",\"Arts visuels\",\"Gestion hôtelière\"]',0,77),(202,1,'Quel est le thème principal du cours \"IA et robotique : perception et contrôle\" ?','[\"Intelligence artificielle\",\"Biologie\",\"Arts visuels\",\"Gestion hôtelière\"]',0,78),(203,1,'Quel est le thème principal du cours \"IA et robotique : perception et contrôle\" ?','[\"Intelligence artificielle\",\"Biologie\",\"Arts visuels\",\"Gestion hôtelière\"]',0,79),(204,1,'Quel est le thème principal du cours \"Sécurité des modèles ML\" ?','[\"Intelligence artificielle\",\"Biologie\",\"Arts visuels\",\"Gestion hôtelière\"]',0,80),(205,1,'Quel est le thème principal du cours \"Sécurité des modèles ML\" ?','[\"Intelligence artificielle\",\"Biologie\",\"Arts visuels\",\"Gestion hôtelière\"]',0,81),(206,1,'Quel est le thème principal du cours \"Sécurité des modèles ML\" ?','[\"Intelligence artificielle\",\"Biologie\",\"Arts visuels\",\"Gestion hôtelière\"]',0,82),(207,1,'Quel est le thème principal du cours \"Pratiques avancées de data labeling\" ?','[\"Intelligence artificielle\",\"Biologie\",\"Arts visuels\",\"Gestion hôtelière\"]',0,83),(208,1,'Quel est le thème principal du cours \"Pratiques avancées de data labeling\" ?','[\"Intelligence artificielle\",\"Biologie\",\"Arts visuels\",\"Gestion hôtelière\"]',0,84),(209,1,'Quel est le thème principal du cours \"Pratiques avancées de data labeling\" ?','[\"Intelligence artificielle\",\"Biologie\",\"Arts visuels\",\"Gestion hôtelière\"]',0,85),(210,1,'Quel est le thème principal du cours \"IA pour la santé\" ?','[\"Intelligence artificielle\",\"Biologie\",\"Arts visuels\",\"Gestion hôtelière\"]',0,86),(211,1,'Quel est le thème principal du cours \"IA pour la santé\" ?','[\"Intelligence artificielle\",\"Biologie\",\"Arts visuels\",\"Gestion hôtelière\"]',0,87),(212,1,'Quel est le thème principal du cours \"IA pour la santé\" ?','[\"Intelligence artificielle\",\"Biologie\",\"Arts visuels\",\"Gestion hôtelière\"]',0,88),(213,1,'Quel est le thème principal du cours \"Projet capstone : construire une solution IA complète\" ?','[\"Intelligence artificielle\",\"Biologie\",\"Arts visuels\",\"Gestion hôtelière\"]',0,89),(214,1,'Quel est le thème principal du cours \"Projet capstone : construire une solution IA complète\" ?','[\"Intelligence artificielle\",\"Biologie\",\"Arts visuels\",\"Gestion hôtelière\"]',0,90),(215,1,'Quel est le thème principal du cours \"Projet capstone : construire une solution IA complète\" ?','[\"Intelligence artificielle\",\"Biologie\",\"Arts visuels\",\"Gestion hôtelière\"]',0,91),(219,2,'Quel outil est recommandé dans le cours \"Introduction à l\'Intelligence Artificielle\" ?','[\"Python\",\"Bloc-notes\",\"Photoshop\",\"PowerPoint\"]',0,32),(220,2,'Quel outil est recommandé dans le cours \"Introduction à l\'Intelligence Artificielle\" ?','[\"Python\",\"Bloc-notes\",\"Photoshop\",\"PowerPoint\"]',0,33),(221,2,'Quel outil est recommandé dans le cours \"Introduction à l\'Intelligence Artificielle\" ?','[\"Python\",\"Bloc-notes\",\"Photoshop\",\"PowerPoint\"]',0,34),(222,2,'Quel outil est recommandé dans le cours \"Machine Learning : notions et algorithmes\" ?','[\"Python\",\"Bloc-notes\",\"Photoshop\",\"PowerPoint\"]',0,35),(225,2,'Quel outil est recommandé dans le cours \"Deep Learning pour vision par ordinateur\" ?','[\"Python\",\"Bloc-notes\",\"Photoshop\",\"PowerPoint\"]',0,38),(226,2,'Quel outil est recommandé dans le cours \"Deep Learning pour vision par ordinateur\" ?','[\"Python\",\"Bloc-notes\",\"Photoshop\",\"PowerPoint\"]',0,39),(227,2,'Quel outil est recommandé dans le cours \"Deep Learning pour vision par ordinateur\" ?','[\"Python\",\"Bloc-notes\",\"Photoshop\",\"PowerPoint\"]',0,40),(228,2,'Quel outil est recommandé dans le cours \"NLP : traitement du langage naturel\" ?','[\"Python\",\"Bloc-notes\",\"Photoshop\",\"PowerPoint\"]',0,41),(229,2,'Quel outil est recommandé dans le cours \"NLP : traitement du langage naturel\" ?','[\"Python\",\"Bloc-notes\",\"Photoshop\",\"PowerPoint\"]',0,42),(230,2,'Quel outil est recommandé dans le cours \"NLP : traitement du langage naturel\" ?','[\"Python\",\"Bloc-notes\",\"Photoshop\",\"PowerPoint\"]',0,43),(231,2,'Quel outil est recommandé dans le cours \"Apprentissage non supervisé et clustering\" ?','[\"Python\",\"Bloc-notes\",\"Photoshop\",\"PowerPoint\"]',0,44),(232,2,'Quel outil est recommandé dans le cours \"Apprentissage non supervisé et clustering\" ?','[\"Python\",\"Bloc-notes\",\"Photoshop\",\"PowerPoint\"]',0,45),(233,2,'Quel outil est recommandé dans le cours \"Apprentissage non supervisé et clustering\" ?','[\"Python\",\"Bloc-notes\",\"Photoshop\",\"PowerPoint\"]',0,46),(234,2,'Quel outil est recommandé dans le cours \"Modèles probabilistes et bayésiens\" ?','[\"Python\",\"Bloc-notes\",\"Photoshop\",\"PowerPoint\"]',0,47),(235,2,'Quel outil est recommandé dans le cours \"Modèles probabilistes et bayésiens\" ?','[\"Python\",\"Bloc-notes\",\"Photoshop\",\"PowerPoint\"]',0,48),(236,2,'Quel outil est recommandé dans le cours \"Modèles probabilistes et bayésiens\" ?','[\"Python\",\"Bloc-notes\",\"Photoshop\",\"PowerPoint\"]',0,49),(237,2,'Quel outil est recommandé dans le cours \"MLOps : mise en production de modèles\" ?','[\"Python\",\"Bloc-notes\",\"Photoshop\",\"PowerPoint\"]',0,50),(238,2,'Quel outil est recommandé dans le cours \"MLOps : mise en production de modèles\" ?','[\"Python\",\"Bloc-notes\",\"Photoshop\",\"PowerPoint\"]',0,51),(239,2,'Quel outil est recommandé dans le cours \"MLOps : mise en production de modèles\" ?','[\"Python\",\"Bloc-notes\",\"Photoshop\",\"PowerPoint\"]',0,52),(240,2,'Quel outil est recommandé dans le cours \"Éthique et IA responsable\" ?','[\"Python\",\"Bloc-notes\",\"Photoshop\",\"PowerPoint\"]',0,53),(241,2,'Quel outil est recommandé dans le cours \"Éthique et IA responsable\" ?','[\"Python\",\"Bloc-notes\",\"Photoshop\",\"PowerPoint\"]',0,54),(242,2,'Quel outil est recommandé dans le cours \"Éthique et IA responsable\" ?','[\"Python\",\"Bloc-notes\",\"Photoshop\",\"PowerPoint\"]',0,55),(243,2,'Quel outil est recommandé dans le cours \"Apprentissage par renforcement\" ?','[\"Python\",\"Bloc-notes\",\"Photoshop\",\"PowerPoint\"]',0,56),(244,2,'Quel outil est recommandé dans le cours \"Apprentissage par renforcement\" ?','[\"Python\",\"Bloc-notes\",\"Photoshop\",\"PowerPoint\"]',0,57),(245,2,'Quel outil est recommandé dans le cours \"Apprentissage par renforcement\" ?','[\"Python\",\"Bloc-notes\",\"Photoshop\",\"PowerPoint\"]',0,58),(246,2,'Quel outil est recommandé dans le cours \"Feature Engineering avancé\" ?','[\"Python\",\"Bloc-notes\",\"Photoshop\",\"PowerPoint\"]',0,59),(247,2,'Quel outil est recommandé dans le cours \"Feature Engineering avancé\" ?','[\"Python\",\"Bloc-notes\",\"Photoshop\",\"PowerPoint\"]',0,60),(248,2,'Quel outil est recommandé dans le cours \"Feature Engineering avancé\" ?','[\"Python\",\"Bloc-notes\",\"Photoshop\",\"PowerPoint\"]',0,61),(249,2,'Quel outil est recommandé dans le cours \"Computer Vision avancé : détection et segmentation\" ?','[\"Python\",\"Bloc-notes\",\"Photoshop\",\"PowerPoint\"]',0,62),(250,2,'Quel outil est recommandé dans le cours \"Computer Vision avancé : détection et segmentation\" ?','[\"Python\",\"Bloc-notes\",\"Photoshop\",\"PowerPoint\"]',0,63),(251,2,'Quel outil est recommandé dans le cours \"Computer Vision avancé : détection et segmentation\" ?','[\"Python\",\"Bloc-notes\",\"Photoshop\",\"PowerPoint\"]',0,64),(252,2,'Quel outil est recommandé dans le cours \"Time Series & Forecasting\" ?','[\"Python\",\"Bloc-notes\",\"Photoshop\",\"PowerPoint\"]',0,65),(253,2,'Quel outil est recommandé dans le cours \"Time Series & Forecasting\" ?','[\"Python\",\"Bloc-notes\",\"Photoshop\",\"PowerPoint\"]',0,66),(254,2,'Quel outil est recommandé dans le cours \"Time Series & Forecasting\" ?','[\"Python\",\"Bloc-notes\",\"Photoshop\",\"PowerPoint\"]',0,67),(255,2,'Quel outil est recommandé dans le cours \"AutoML et optimisation d\'hyperparamètres\" ?','[\"Python\",\"Bloc-notes\",\"Photoshop\",\"PowerPoint\"]',0,68),(256,2,'Quel outil est recommandé dans le cours \"AutoML et optimisation d\'hyperparamètres\" ?','[\"Python\",\"Bloc-notes\",\"Photoshop\",\"PowerPoint\"]',0,69),(257,2,'Quel outil est recommandé dans le cours \"AutoML et optimisation d\'hyperparamètres\" ?','[\"Python\",\"Bloc-notes\",\"Photoshop\",\"PowerPoint\"]',0,70),(258,2,'Quel outil est recommandé dans le cours \"Représentations et embeddings\" ?','[\"Python\",\"Bloc-notes\",\"Photoshop\",\"PowerPoint\"]',0,71),(259,2,'Quel outil est recommandé dans le cours \"Représentations et embeddings\" ?','[\"Python\",\"Bloc-notes\",\"Photoshop\",\"PowerPoint\"]',0,72),(260,2,'Quel outil est recommandé dans le cours \"Représentations et embeddings\" ?','[\"Python\",\"Bloc-notes\",\"Photoshop\",\"PowerPoint\"]',0,73),(261,2,'Quel outil est recommandé dans le cours \"Graph ML : GNN et applications\" ?','[\"Python\",\"Bloc-notes\",\"Photoshop\",\"PowerPoint\"]',0,74),(262,2,'Quel outil est recommandé dans le cours \"Graph ML : GNN et applications\" ?','[\"Python\",\"Bloc-notes\",\"Photoshop\",\"PowerPoint\"]',0,75),(263,2,'Quel outil est recommandé dans le cours \"Graph ML : GNN et applications\" ?','[\"Python\",\"Bloc-notes\",\"Photoshop\",\"PowerPoint\"]',0,76),(264,2,'Quel outil est recommandé dans le cours \"IA et robotique : perception et contrôle\" ?','[\"Python\",\"Bloc-notes\",\"Photoshop\",\"PowerPoint\"]',0,77),(265,2,'Quel outil est recommandé dans le cours \"IA et robotique : perception et contrôle\" ?','[\"Python\",\"Bloc-notes\",\"Photoshop\",\"PowerPoint\"]',0,78),(266,2,'Quel outil est recommandé dans le cours \"IA et robotique : perception et contrôle\" ?','[\"Python\",\"Bloc-notes\",\"Photoshop\",\"PowerPoint\"]',0,79),(267,2,'Quel outil est recommandé dans le cours \"Sécurité des modèles ML\" ?','[\"Python\",\"Bloc-notes\",\"Photoshop\",\"PowerPoint\"]',0,80),(268,2,'Quel outil est recommandé dans le cours \"Sécurité des modèles ML\" ?','[\"Python\",\"Bloc-notes\",\"Photoshop\",\"PowerPoint\"]',0,81),(269,2,'Quel outil est recommandé dans le cours \"Sécurité des modèles ML\" ?','[\"Python\",\"Bloc-notes\",\"Photoshop\",\"PowerPoint\"]',0,82),(270,2,'Quel outil est recommandé dans le cours \"Pratiques avancées de data labeling\" ?','[\"Python\",\"Bloc-notes\",\"Photoshop\",\"PowerPoint\"]',0,83),(271,2,'Quel outil est recommandé dans le cours \"Pratiques avancées de data labeling\" ?','[\"Python\",\"Bloc-notes\",\"Photoshop\",\"PowerPoint\"]',0,84),(272,2,'Quel outil est recommandé dans le cours \"Pratiques avancées de data labeling\" ?','[\"Python\",\"Bloc-notes\",\"Photoshop\",\"PowerPoint\"]',0,85),(273,2,'Quel outil est recommandé dans le cours \"IA pour la santé\" ?','[\"Python\",\"Bloc-notes\",\"Photoshop\",\"PowerPoint\"]',0,86),(274,2,'Quel outil est recommandé dans le cours \"IA pour la santé\" ?','[\"Python\",\"Bloc-notes\",\"Photoshop\",\"PowerPoint\"]',0,87),(275,2,'Quel outil est recommandé dans le cours \"IA pour la santé\" ?','[\"Python\",\"Bloc-notes\",\"Photoshop\",\"PowerPoint\"]',0,88),(276,2,'Quel outil est recommandé dans le cours \"Projet capstone : construire une solution IA complète\" ?','[\"Python\",\"Bloc-notes\",\"Photoshop\",\"PowerPoint\"]',0,89),(277,2,'Quel outil est recommandé dans le cours \"Projet capstone : construire une solution IA complète\" ?','[\"Python\",\"Bloc-notes\",\"Photoshop\",\"PowerPoint\"]',0,90),(278,2,'Quel outil est recommandé dans le cours \"Projet capstone : construire une solution IA complète\" ?','[\"Python\",\"Bloc-notes\",\"Photoshop\",\"PowerPoint\"]',0,91),(282,3,'Quels types d\'applications sont étudiées dans \"Introduction à l\'Intelligence Artificielle\" ?','[\"Applications IA\",\"Applications médicales\",\"Applications culinaires\",\"Applications sportives\"]',0,32),(283,3,'Quels types d\'applications sont étudiées dans \"Introduction à l\'Intelligence Artificielle\" ?','[\"Applications IA\",\"Applications médicales\",\"Applications culinaires\",\"Applications sportives\"]',0,33),(284,3,'Quels types d\'applications sont étudiées dans \"Introduction à l\'Intelligence Artificielle\" ?','[\"Applications IA\",\"Applications médicales\",\"Applications culinaires\",\"Applications sportives\"]',0,34),(285,3,'Quels types d\'applications sont étudiées dans \"Machine Learning : notions et algorithmes\" ?','[\"Applications IA\",\"Applications médicales\",\"Applications culinaires\",\"Applications sportives\"]',0,35),(288,3,'Quels types d\'applications sont étudiées dans \"Deep Learning pour vision par ordinateur\" ?','[\"Applications IA\",\"Applications médicales\",\"Applications culinaires\",\"Applications sportives\"]',0,38),(289,3,'Quels types d\'applications sont étudiées dans \"Deep Learning pour vision par ordinateur\" ?','[\"Applications IA\",\"Applications médicales\",\"Applications culinaires\",\"Applications sportives\"]',0,39),(290,3,'Quels types d\'applications sont étudiées dans \"Deep Learning pour vision par ordinateur\" ?','[\"Applications IA\",\"Applications médicales\",\"Applications culinaires\",\"Applications sportives\"]',0,40),(291,3,'Quels types d\'applications sont étudiées dans \"NLP : traitement du langage naturel\" ?','[\"Applications IA\",\"Applications médicales\",\"Applications culinaires\",\"Applications sportives\"]',0,41),(292,3,'Quels types d\'applications sont étudiées dans \"NLP : traitement du langage naturel\" ?','[\"Applications IA\",\"Applications médicales\",\"Applications culinaires\",\"Applications sportives\"]',0,42),(293,3,'Quels types d\'applications sont étudiées dans \"NLP : traitement du langage naturel\" ?','[\"Applications IA\",\"Applications médicales\",\"Applications culinaires\",\"Applications sportives\"]',0,43),(294,3,'Quels types d\'applications sont étudiées dans \"Apprentissage non supervisé et clustering\" ?','[\"Applications IA\",\"Applications médicales\",\"Applications culinaires\",\"Applications sportives\"]',0,44),(295,3,'Quels types d\'applications sont étudiées dans \"Apprentissage non supervisé et clustering\" ?','[\"Applications IA\",\"Applications médicales\",\"Applications culinaires\",\"Applications sportives\"]',0,45),(296,3,'Quels types d\'applications sont étudiées dans \"Apprentissage non supervisé et clustering\" ?','[\"Applications IA\",\"Applications médicales\",\"Applications culinaires\",\"Applications sportives\"]',0,46),(297,3,'Quels types d\'applications sont étudiées dans \"Modèles probabilistes et bayésiens\" ?','[\"Applications IA\",\"Applications médicales\",\"Applications culinaires\",\"Applications sportives\"]',0,47),(298,3,'Quels types d\'applications sont étudiées dans \"Modèles probabilistes et bayésiens\" ?','[\"Applications IA\",\"Applications médicales\",\"Applications culinaires\",\"Applications sportives\"]',0,48),(299,3,'Quels types d\'applications sont étudiées dans \"Modèles probabilistes et bayésiens\" ?','[\"Applications IA\",\"Applications médicales\",\"Applications culinaires\",\"Applications sportives\"]',0,49),(300,3,'Quels types d\'applications sont étudiées dans \"MLOps : mise en production de modèles\" ?','[\"Applications IA\",\"Applications médicales\",\"Applications culinaires\",\"Applications sportives\"]',0,50),(301,3,'Quels types d\'applications sont étudiées dans \"MLOps : mise en production de modèles\" ?','[\"Applications IA\",\"Applications médicales\",\"Applications culinaires\",\"Applications sportives\"]',0,51),(302,3,'Quels types d\'applications sont étudiées dans \"MLOps : mise en production de modèles\" ?','[\"Applications IA\",\"Applications médicales\",\"Applications culinaires\",\"Applications sportives\"]',0,52),(303,3,'Quels types d\'applications sont étudiées dans \"Éthique et IA responsable\" ?','[\"Applications IA\",\"Applications médicales\",\"Applications culinaires\",\"Applications sportives\"]',0,53),(304,3,'Quels types d\'applications sont étudiées dans \"Éthique et IA responsable\" ?','[\"Applications IA\",\"Applications médicales\",\"Applications culinaires\",\"Applications sportives\"]',0,54),(305,3,'Quels types d\'applications sont étudiées dans \"Éthique et IA responsable\" ?','[\"Applications IA\",\"Applications médicales\",\"Applications culinaires\",\"Applications sportives\"]',0,55),(306,3,'Quels types d\'applications sont étudiées dans \"Apprentissage par renforcement\" ?','[\"Applications IA\",\"Applications médicales\",\"Applications culinaires\",\"Applications sportives\"]',0,56),(307,3,'Quels types d\'applications sont étudiées dans \"Apprentissage par renforcement\" ?','[\"Applications IA\",\"Applications médicales\",\"Applications culinaires\",\"Applications sportives\"]',0,57),(308,3,'Quels types d\'applications sont étudiées dans \"Apprentissage par renforcement\" ?','[\"Applications IA\",\"Applications médicales\",\"Applications culinaires\",\"Applications sportives\"]',0,58),(309,3,'Quels types d\'applications sont étudiées dans \"Feature Engineering avancé\" ?','[\"Applications IA\",\"Applications médicales\",\"Applications culinaires\",\"Applications sportives\"]',0,59),(310,3,'Quels types d\'applications sont étudiées dans \"Feature Engineering avancé\" ?','[\"Applications IA\",\"Applications médicales\",\"Applications culinaires\",\"Applications sportives\"]',0,60),(311,3,'Quels types d\'applications sont étudiées dans \"Feature Engineering avancé\" ?','[\"Applications IA\",\"Applications médicales\",\"Applications culinaires\",\"Applications sportives\"]',0,61),(312,3,'Quels types d\'applications sont étudiées dans \"Computer Vision avancé : détection et segmentation\" ?','[\"Applications IA\",\"Applications médicales\",\"Applications culinaires\",\"Applications sportives\"]',0,62),(313,3,'Quels types d\'applications sont étudiées dans \"Computer Vision avancé : détection et segmentation\" ?','[\"Applications IA\",\"Applications médicales\",\"Applications culinaires\",\"Applications sportives\"]',0,63),(314,3,'Quels types d\'applications sont étudiées dans \"Computer Vision avancé : détection et segmentation\" ?','[\"Applications IA\",\"Applications médicales\",\"Applications culinaires\",\"Applications sportives\"]',0,64),(315,3,'Quels types d\'applications sont étudiées dans \"Time Series & Forecasting\" ?','[\"Applications IA\",\"Applications médicales\",\"Applications culinaires\",\"Applications sportives\"]',0,65),(316,3,'Quels types d\'applications sont étudiées dans \"Time Series & Forecasting\" ?','[\"Applications IA\",\"Applications médicales\",\"Applications culinaires\",\"Applications sportives\"]',0,66),(317,3,'Quels types d\'applications sont étudiées dans \"Time Series & Forecasting\" ?','[\"Applications IA\",\"Applications médicales\",\"Applications culinaires\",\"Applications sportives\"]',0,67),(318,3,'Quels types d\'applications sont étudiées dans \"AutoML et optimisation d\'hyperparamètres\" ?','[\"Applications IA\",\"Applications médicales\",\"Applications culinaires\",\"Applications sportives\"]',0,68),(319,3,'Quels types d\'applications sont étudiées dans \"AutoML et optimisation d\'hyperparamètres\" ?','[\"Applications IA\",\"Applications médicales\",\"Applications culinaires\",\"Applications sportives\"]',0,69),(320,3,'Quels types d\'applications sont étudiées dans \"AutoML et optimisation d\'hyperparamètres\" ?','[\"Applications IA\",\"Applications médicales\",\"Applications culinaires\",\"Applications sportives\"]',0,70),(321,3,'Quels types d\'applications sont étudiées dans \"Représentations et embeddings\" ?','[\"Applications IA\",\"Applications médicales\",\"Applications culinaires\",\"Applications sportives\"]',0,71),(322,3,'Quels types d\'applications sont étudiées dans \"Représentations et embeddings\" ?','[\"Applications IA\",\"Applications médicales\",\"Applications culinaires\",\"Applications sportives\"]',0,72),(323,3,'Quels types d\'applications sont étudiées dans \"Représentations et embeddings\" ?','[\"Applications IA\",\"Applications médicales\",\"Applications culinaires\",\"Applications sportives\"]',0,73),(324,3,'Quels types d\'applications sont étudiées dans \"Graph ML : GNN et applications\" ?','[\"Applications IA\",\"Applications médicales\",\"Applications culinaires\",\"Applications sportives\"]',0,74),(325,3,'Quels types d\'applications sont étudiées dans \"Graph ML : GNN et applications\" ?','[\"Applications IA\",\"Applications médicales\",\"Applications culinaires\",\"Applications sportives\"]',0,75),(326,3,'Quels types d\'applications sont étudiées dans \"Graph ML : GNN et applications\" ?','[\"Applications IA\",\"Applications médicales\",\"Applications culinaires\",\"Applications sportives\"]',0,76),(327,3,'Quels types d\'applications sont étudiées dans \"IA et robotique : perception et contrôle\" ?','[\"Applications IA\",\"Applications médicales\",\"Applications culinaires\",\"Applications sportives\"]',0,77),(328,3,'Quels types d\'applications sont étudiées dans \"IA et robotique : perception et contrôle\" ?','[\"Applications IA\",\"Applications médicales\",\"Applications culinaires\",\"Applications sportives\"]',0,78),(329,3,'Quels types d\'applications sont étudiées dans \"IA et robotique : perception et contrôle\" ?','[\"Applications IA\",\"Applications médicales\",\"Applications culinaires\",\"Applications sportives\"]',0,79),(330,3,'Quels types d\'applications sont étudiées dans \"Sécurité des modèles ML\" ?','[\"Applications IA\",\"Applications médicales\",\"Applications culinaires\",\"Applications sportives\"]',0,80),(331,3,'Quels types d\'applications sont étudiées dans \"Sécurité des modèles ML\" ?','[\"Applications IA\",\"Applications médicales\",\"Applications culinaires\",\"Applications sportives\"]',0,81),(332,3,'Quels types d\'applications sont étudiées dans \"Sécurité des modèles ML\" ?','[\"Applications IA\",\"Applications médicales\",\"Applications culinaires\",\"Applications sportives\"]',0,82),(333,3,'Quels types d\'applications sont étudiées dans \"Pratiques avancées de data labeling\" ?','[\"Applications IA\",\"Applications médicales\",\"Applications culinaires\",\"Applications sportives\"]',0,83),(334,3,'Quels types d\'applications sont étudiées dans \"Pratiques avancées de data labeling\" ?','[\"Applications IA\",\"Applications médicales\",\"Applications culinaires\",\"Applications sportives\"]',0,84),(335,3,'Quels types d\'applications sont étudiées dans \"Pratiques avancées de data labeling\" ?','[\"Applications IA\",\"Applications médicales\",\"Applications culinaires\",\"Applications sportives\"]',0,85),(336,3,'Quels types d\'applications sont étudiées dans \"IA pour la santé\" ?','[\"Applications IA\",\"Applications médicales\",\"Applications culinaires\",\"Applications sportives\"]',0,86),(337,3,'Quels types d\'applications sont étudiées dans \"IA pour la santé\" ?','[\"Applications IA\",\"Applications médicales\",\"Applications culinaires\",\"Applications sportives\"]',0,87),(338,3,'Quels types d\'applications sont étudiées dans \"IA pour la santé\" ?','[\"Applications IA\",\"Applications médicales\",\"Applications culinaires\",\"Applications sportives\"]',0,88),(339,3,'Quels types d\'applications sont étudiées dans \"Projet capstone : construire une solution IA complète\" ?','[\"Applications IA\",\"Applications médicales\",\"Applications culinaires\",\"Applications sportives\"]',0,89),(340,3,'Quels types d\'applications sont étudiées dans \"Projet capstone : construire une solution IA complète\" ?','[\"Applications IA\",\"Applications médicales\",\"Applications culinaires\",\"Applications sportives\"]',0,90),(341,3,'Quels types d\'applications sont étudiées dans \"Projet capstone : construire une solution IA complète\" ?','[\"Applications IA\",\"Applications médicales\",\"Applications culinaires\",\"Applications sportives\"]',0,91),(345,4,'Quel format est souvent utilisé pour expliquer les modèles dans \"Introduction à l\'Intelligence Artificielle\" ?','[\"Schémas et exemples\",\"Poèmes\",\"Bandes dessinées\",\"Recettes\"]',0,32),(346,4,'Quel format est souvent utilisé pour expliquer les modèles dans \"Introduction à l\'Intelligence Artificielle\" ?','[\"Schémas et exemples\",\"Poèmes\",\"Bandes dessinées\",\"Recettes\"]',0,33),(347,4,'Quel format est souvent utilisé pour expliquer les modèles dans \"Introduction à l\'Intelligence Artificielle\" ?','[\"Schémas et exemples\",\"Poèmes\",\"Bandes dessinées\",\"Recettes\"]',0,34),(348,4,'Quel format est souvent utilisé pour expliquer les modèles dans \"Machine Learning : notions et algorithmes\" ?','[\"Schémas et exemples\",\"Poèmes\",\"Bandes dessinées\",\"Recettes\"]',0,35),(351,4,'Quel format est souvent utilisé pour expliquer les modèles dans \"Deep Learning pour vision par ordinateur\" ?','[\"Schémas et exemples\",\"Poèmes\",\"Bandes dessinées\",\"Recettes\"]',0,38),(352,4,'Quel format est souvent utilisé pour expliquer les modèles dans \"Deep Learning pour vision par ordinateur\" ?','[\"Schémas et exemples\",\"Poèmes\",\"Bandes dessinées\",\"Recettes\"]',0,39),(353,4,'Quel format est souvent utilisé pour expliquer les modèles dans \"Deep Learning pour vision par ordinateur\" ?','[\"Schémas et exemples\",\"Poèmes\",\"Bandes dessinées\",\"Recettes\"]',0,40),(354,4,'Quel format est souvent utilisé pour expliquer les modèles dans \"NLP : traitement du langage naturel\" ?','[\"Schémas et exemples\",\"Poèmes\",\"Bandes dessinées\",\"Recettes\"]',0,41),(355,4,'Quel format est souvent utilisé pour expliquer les modèles dans \"NLP : traitement du langage naturel\" ?','[\"Schémas et exemples\",\"Poèmes\",\"Bandes dessinées\",\"Recettes\"]',0,42),(356,4,'Quel format est souvent utilisé pour expliquer les modèles dans \"NLP : traitement du langage naturel\" ?','[\"Schémas et exemples\",\"Poèmes\",\"Bandes dessinées\",\"Recettes\"]',0,43),(357,4,'Quel format est souvent utilisé pour expliquer les modèles dans \"Apprentissage non supervisé et clustering\" ?','[\"Schémas et exemples\",\"Poèmes\",\"Bandes dessinées\",\"Recettes\"]',0,44),(358,4,'Quel format est souvent utilisé pour expliquer les modèles dans \"Apprentissage non supervisé et clustering\" ?','[\"Schémas et exemples\",\"Poèmes\",\"Bandes dessinées\",\"Recettes\"]',0,45),(359,4,'Quel format est souvent utilisé pour expliquer les modèles dans \"Apprentissage non supervisé et clustering\" ?','[\"Schémas et exemples\",\"Poèmes\",\"Bandes dessinées\",\"Recettes\"]',0,46),(360,4,'Quel format est souvent utilisé pour expliquer les modèles dans \"Modèles probabilistes et bayésiens\" ?','[\"Schémas et exemples\",\"Poèmes\",\"Bandes dessinées\",\"Recettes\"]',0,47),(361,4,'Quel format est souvent utilisé pour expliquer les modèles dans \"Modèles probabilistes et bayésiens\" ?','[\"Schémas et exemples\",\"Poèmes\",\"Bandes dessinées\",\"Recettes\"]',0,48),(362,4,'Quel format est souvent utilisé pour expliquer les modèles dans \"Modèles probabilistes et bayésiens\" ?','[\"Schémas et exemples\",\"Poèmes\",\"Bandes dessinées\",\"Recettes\"]',0,49),(363,4,'Quel format est souvent utilisé pour expliquer les modèles dans \"MLOps : mise en production de modèles\" ?','[\"Schémas et exemples\",\"Poèmes\",\"Bandes dessinées\",\"Recettes\"]',0,50),(364,4,'Quel format est souvent utilisé pour expliquer les modèles dans \"MLOps : mise en production de modèles\" ?','[\"Schémas et exemples\",\"Poèmes\",\"Bandes dessinées\",\"Recettes\"]',0,51),(365,4,'Quel format est souvent utilisé pour expliquer les modèles dans \"MLOps : mise en production de modèles\" ?','[\"Schémas et exemples\",\"Poèmes\",\"Bandes dessinées\",\"Recettes\"]',0,52),(366,4,'Quel format est souvent utilisé pour expliquer les modèles dans \"Éthique et IA responsable\" ?','[\"Schémas et exemples\",\"Poèmes\",\"Bandes dessinées\",\"Recettes\"]',0,53),(367,4,'Quel format est souvent utilisé pour expliquer les modèles dans \"Éthique et IA responsable\" ?','[\"Schémas et exemples\",\"Poèmes\",\"Bandes dessinées\",\"Recettes\"]',0,54),(368,4,'Quel format est souvent utilisé pour expliquer les modèles dans \"Éthique et IA responsable\" ?','[\"Schémas et exemples\",\"Poèmes\",\"Bandes dessinées\",\"Recettes\"]',0,55),(369,4,'Quel format est souvent utilisé pour expliquer les modèles dans \"Apprentissage par renforcement\" ?','[\"Schémas et exemples\",\"Poèmes\",\"Bandes dessinées\",\"Recettes\"]',0,56),(370,4,'Quel format est souvent utilisé pour expliquer les modèles dans \"Apprentissage par renforcement\" ?','[\"Schémas et exemples\",\"Poèmes\",\"Bandes dessinées\",\"Recettes\"]',0,57),(371,4,'Quel format est souvent utilisé pour expliquer les modèles dans \"Apprentissage par renforcement\" ?','[\"Schémas et exemples\",\"Poèmes\",\"Bandes dessinées\",\"Recettes\"]',0,58),(372,4,'Quel format est souvent utilisé pour expliquer les modèles dans \"Feature Engineering avancé\" ?','[\"Schémas et exemples\",\"Poèmes\",\"Bandes dessinées\",\"Recettes\"]',0,59),(373,4,'Quel format est souvent utilisé pour expliquer les modèles dans \"Feature Engineering avancé\" ?','[\"Schémas et exemples\",\"Poèmes\",\"Bandes dessinées\",\"Recettes\"]',0,60),(374,4,'Quel format est souvent utilisé pour expliquer les modèles dans \"Feature Engineering avancé\" ?','[\"Schémas et exemples\",\"Poèmes\",\"Bandes dessinées\",\"Recettes\"]',0,61),(375,4,'Quel format est souvent utilisé pour expliquer les modèles dans \"Computer Vision avancé : détection et segmentation\" ?','[\"Schémas et exemples\",\"Poèmes\",\"Bandes dessinées\",\"Recettes\"]',0,62),(376,4,'Quel format est souvent utilisé pour expliquer les modèles dans \"Computer Vision avancé : détection et segmentation\" ?','[\"Schémas et exemples\",\"Poèmes\",\"Bandes dessinées\",\"Recettes\"]',0,63),(377,4,'Quel format est souvent utilisé pour expliquer les modèles dans \"Computer Vision avancé : détection et segmentation\" ?','[\"Schémas et exemples\",\"Poèmes\",\"Bandes dessinées\",\"Recettes\"]',0,64),(378,4,'Quel format est souvent utilisé pour expliquer les modèles dans \"Time Series & Forecasting\" ?','[\"Schémas et exemples\",\"Poèmes\",\"Bandes dessinées\",\"Recettes\"]',0,65),(379,4,'Quel format est souvent utilisé pour expliquer les modèles dans \"Time Series & Forecasting\" ?','[\"Schémas et exemples\",\"Poèmes\",\"Bandes dessinées\",\"Recettes\"]',0,66),(380,4,'Quel format est souvent utilisé pour expliquer les modèles dans \"Time Series & Forecasting\" ?','[\"Schémas et exemples\",\"Poèmes\",\"Bandes dessinées\",\"Recettes\"]',0,67),(381,4,'Quel format est souvent utilisé pour expliquer les modèles dans \"AutoML et optimisation d\'hyperparamètres\" ?','[\"Schémas et exemples\",\"Poèmes\",\"Bandes dessinées\",\"Recettes\"]',0,68),(382,4,'Quel format est souvent utilisé pour expliquer les modèles dans \"AutoML et optimisation d\'hyperparamètres\" ?','[\"Schémas et exemples\",\"Poèmes\",\"Bandes dessinées\",\"Recettes\"]',0,69),(383,4,'Quel format est souvent utilisé pour expliquer les modèles dans \"AutoML et optimisation d\'hyperparamètres\" ?','[\"Schémas et exemples\",\"Poèmes\",\"Bandes dessinées\",\"Recettes\"]',0,70),(384,4,'Quel format est souvent utilisé pour expliquer les modèles dans \"Représentations et embeddings\" ?','[\"Schémas et exemples\",\"Poèmes\",\"Bandes dessinées\",\"Recettes\"]',0,71),(385,4,'Quel format est souvent utilisé pour expliquer les modèles dans \"Représentations et embeddings\" ?','[\"Schémas et exemples\",\"Poèmes\",\"Bandes dessinées\",\"Recettes\"]',0,72),(386,4,'Quel format est souvent utilisé pour expliquer les modèles dans \"Représentations et embeddings\" ?','[\"Schémas et exemples\",\"Poèmes\",\"Bandes dessinées\",\"Recettes\"]',0,73),(387,4,'Quel format est souvent utilisé pour expliquer les modèles dans \"Graph ML : GNN et applications\" ?','[\"Schémas et exemples\",\"Poèmes\",\"Bandes dessinées\",\"Recettes\"]',0,74),(388,4,'Quel format est souvent utilisé pour expliquer les modèles dans \"Graph ML : GNN et applications\" ?','[\"Schémas et exemples\",\"Poèmes\",\"Bandes dessinées\",\"Recettes\"]',0,75),(389,4,'Quel format est souvent utilisé pour expliquer les modèles dans \"Graph ML : GNN et applications\" ?','[\"Schémas et exemples\",\"Poèmes\",\"Bandes dessinées\",\"Recettes\"]',0,76),(390,4,'Quel format est souvent utilisé pour expliquer les modèles dans \"IA et robotique : perception et contrôle\" ?','[\"Schémas et exemples\",\"Poèmes\",\"Bandes dessinées\",\"Recettes\"]',0,77),(391,4,'Quel format est souvent utilisé pour expliquer les modèles dans \"IA et robotique : perception et contrôle\" ?','[\"Schémas et exemples\",\"Poèmes\",\"Bandes dessinées\",\"Recettes\"]',0,78),(392,4,'Quel format est souvent utilisé pour expliquer les modèles dans \"IA et robotique : perception et contrôle\" ?','[\"Schémas et exemples\",\"Poèmes\",\"Bandes dessinées\",\"Recettes\"]',0,79),(393,4,'Quel format est souvent utilisé pour expliquer les modèles dans \"Sécurité des modèles ML\" ?','[\"Schémas et exemples\",\"Poèmes\",\"Bandes dessinées\",\"Recettes\"]',0,80),(394,4,'Quel format est souvent utilisé pour expliquer les modèles dans \"Sécurité des modèles ML\" ?','[\"Schémas et exemples\",\"Poèmes\",\"Bandes dessinées\",\"Recettes\"]',0,81),(395,4,'Quel format est souvent utilisé pour expliquer les modèles dans \"Sécurité des modèles ML\" ?','[\"Schémas et exemples\",\"Poèmes\",\"Bandes dessinées\",\"Recettes\"]',0,82),(396,4,'Quel format est souvent utilisé pour expliquer les modèles dans \"Pratiques avancées de data labeling\" ?','[\"Schémas et exemples\",\"Poèmes\",\"Bandes dessinées\",\"Recettes\"]',0,83),(397,4,'Quel format est souvent utilisé pour expliquer les modèles dans \"Pratiques avancées de data labeling\" ?','[\"Schémas et exemples\",\"Poèmes\",\"Bandes dessinées\",\"Recettes\"]',0,84),(398,4,'Quel format est souvent utilisé pour expliquer les modèles dans \"Pratiques avancées de data labeling\" ?','[\"Schémas et exemples\",\"Poèmes\",\"Bandes dessinées\",\"Recettes\"]',0,85),(399,4,'Quel format est souvent utilisé pour expliquer les modèles dans \"IA pour la santé\" ?','[\"Schémas et exemples\",\"Poèmes\",\"Bandes dessinées\",\"Recettes\"]',0,86),(400,4,'Quel format est souvent utilisé pour expliquer les modèles dans \"IA pour la santé\" ?','[\"Schémas et exemples\",\"Poèmes\",\"Bandes dessinées\",\"Recettes\"]',0,87),(401,4,'Quel format est souvent utilisé pour expliquer les modèles dans \"IA pour la santé\" ?','[\"Schémas et exemples\",\"Poèmes\",\"Bandes dessinées\",\"Recettes\"]',0,88),(402,4,'Quel format est souvent utilisé pour expliquer les modèles dans \"Projet capstone : construire une solution IA complète\" ?','[\"Schémas et exemples\",\"Poèmes\",\"Bandes dessinées\",\"Recettes\"]',0,89),(403,4,'Quel format est souvent utilisé pour expliquer les modèles dans \"Projet capstone : construire une solution IA complète\" ?','[\"Schémas et exemples\",\"Poèmes\",\"Bandes dessinées\",\"Recettes\"]',0,90),(404,4,'Quel format est souvent utilisé pour expliquer les modèles dans \"Projet capstone : construire une solution IA complète\" ?','[\"Schémas et exemples\",\"Poèmes\",\"Bandes dessinées\",\"Recettes\"]',0,91),(408,5,'Le cours \"Introduction à l\'Intelligence Artificielle\" insiste sur :','[\"La pratique\",\"La cuisine\",\"La peinture\",\"La danse\"]',0,32),(409,5,'Le cours \"Introduction à l\'Intelligence Artificielle\" insiste sur :','[\"La pratique\",\"La cuisine\",\"La peinture\",\"La danse\"]',0,33),(410,5,'Le cours \"Introduction à l\'Intelligence Artificielle\" insiste sur :','[\"La pratique\",\"La cuisine\",\"La peinture\",\"La danse\"]',0,34),(411,5,'Le cours \"Machine Learning : notions et algorithmes\" insiste sur :','[\"La pratique\",\"La cuisine\",\"La peinture\",\"La danse\"]',0,35),(414,5,'Le cours \"Deep Learning pour vision par ordinateur\" insiste sur :','[\"La pratique\",\"La cuisine\",\"La peinture\",\"La danse\"]',0,38),(415,5,'Le cours \"Deep Learning pour vision par ordinateur\" insiste sur :','[\"La pratique\",\"La cuisine\",\"La peinture\",\"La danse\"]',0,39),(416,5,'Le cours \"Deep Learning pour vision par ordinateur\" insiste sur :','[\"La pratique\",\"La cuisine\",\"La peinture\",\"La danse\"]',0,40),(417,5,'Le cours \"NLP : traitement du langage naturel\" insiste sur :','[\"La pratique\",\"La cuisine\",\"La peinture\",\"La danse\"]',0,41),(418,5,'Le cours \"NLP : traitement du langage naturel\" insiste sur :','[\"La pratique\",\"La cuisine\",\"La peinture\",\"La danse\"]',0,42),(419,5,'Le cours \"NLP : traitement du langage naturel\" insiste sur :','[\"La pratique\",\"La cuisine\",\"La peinture\",\"La danse\"]',0,43),(420,5,'Le cours \"Apprentissage non supervisé et clustering\" insiste sur :','[\"La pratique\",\"La cuisine\",\"La peinture\",\"La danse\"]',0,44),(421,5,'Le cours \"Apprentissage non supervisé et clustering\" insiste sur :','[\"La pratique\",\"La cuisine\",\"La peinture\",\"La danse\"]',0,45),(422,5,'Le cours \"Apprentissage non supervisé et clustering\" insiste sur :','[\"La pratique\",\"La cuisine\",\"La peinture\",\"La danse\"]',0,46),(423,5,'Le cours \"Modèles probabilistes et bayésiens\" insiste sur :','[\"La pratique\",\"La cuisine\",\"La peinture\",\"La danse\"]',0,47),(424,5,'Le cours \"Modèles probabilistes et bayésiens\" insiste sur :','[\"La pratique\",\"La cuisine\",\"La peinture\",\"La danse\"]',0,48),(425,5,'Le cours \"Modèles probabilistes et bayésiens\" insiste sur :','[\"La pratique\",\"La cuisine\",\"La peinture\",\"La danse\"]',0,49),(426,5,'Le cours \"MLOps : mise en production de modèles\" insiste sur :','[\"La pratique\",\"La cuisine\",\"La peinture\",\"La danse\"]',0,50),(427,5,'Le cours \"MLOps : mise en production de modèles\" insiste sur :','[\"La pratique\",\"La cuisine\",\"La peinture\",\"La danse\"]',0,51),(428,5,'Le cours \"MLOps : mise en production de modèles\" insiste sur :','[\"La pratique\",\"La cuisine\",\"La peinture\",\"La danse\"]',0,52),(429,5,'Le cours \"Éthique et IA responsable\" insiste sur :','[\"La pratique\",\"La cuisine\",\"La peinture\",\"La danse\"]',0,53),(430,5,'Le cours \"Éthique et IA responsable\" insiste sur :','[\"La pratique\",\"La cuisine\",\"La peinture\",\"La danse\"]',0,54),(431,5,'Le cours \"Éthique et IA responsable\" insiste sur :','[\"La pratique\",\"La cuisine\",\"La peinture\",\"La danse\"]',0,55),(432,5,'Le cours \"Apprentissage par renforcement\" insiste sur :','[\"La pratique\",\"La cuisine\",\"La peinture\",\"La danse\"]',0,56),(433,5,'Le cours \"Apprentissage par renforcement\" insiste sur :','[\"La pratique\",\"La cuisine\",\"La peinture\",\"La danse\"]',0,57),(434,5,'Le cours \"Apprentissage par renforcement\" insiste sur :','[\"La pratique\",\"La cuisine\",\"La peinture\",\"La danse\"]',0,58),(435,5,'Le cours \"Feature Engineering avancé\" insiste sur :','[\"La pratique\",\"La cuisine\",\"La peinture\",\"La danse\"]',0,59),(436,5,'Le cours \"Feature Engineering avancé\" insiste sur :','[\"La pratique\",\"La cuisine\",\"La peinture\",\"La danse\"]',0,60),(437,5,'Le cours \"Feature Engineering avancé\" insiste sur :','[\"La pratique\",\"La cuisine\",\"La peinture\",\"La danse\"]',0,61),(438,5,'Le cours \"Computer Vision avancé : détection et segmentation\" insiste sur :','[\"La pratique\",\"La cuisine\",\"La peinture\",\"La danse\"]',0,62),(439,5,'Le cours \"Computer Vision avancé : détection et segmentation\" insiste sur :','[\"La pratique\",\"La cuisine\",\"La peinture\",\"La danse\"]',0,63),(440,5,'Le cours \"Computer Vision avancé : détection et segmentation\" insiste sur :','[\"La pratique\",\"La cuisine\",\"La peinture\",\"La danse\"]',0,64),(441,5,'Le cours \"Time Series & Forecasting\" insiste sur :','[\"La pratique\",\"La cuisine\",\"La peinture\",\"La danse\"]',0,65),(442,5,'Le cours \"Time Series & Forecasting\" insiste sur :','[\"La pratique\",\"La cuisine\",\"La peinture\",\"La danse\"]',0,66),(443,5,'Le cours \"Time Series & Forecasting\" insiste sur :','[\"La pratique\",\"La cuisine\",\"La peinture\",\"La danse\"]',0,67),(444,5,'Le cours \"AutoML et optimisation d\'hyperparamètres\" insiste sur :','[\"La pratique\",\"La cuisine\",\"La peinture\",\"La danse\"]',0,68),(445,5,'Le cours \"AutoML et optimisation d\'hyperparamètres\" insiste sur :','[\"La pratique\",\"La cuisine\",\"La peinture\",\"La danse\"]',0,69),(446,5,'Le cours \"AutoML et optimisation d\'hyperparamètres\" insiste sur :','[\"La pratique\",\"La cuisine\",\"La peinture\",\"La danse\"]',0,70),(447,5,'Le cours \"Représentations et embeddings\" insiste sur :','[\"La pratique\",\"La cuisine\",\"La peinture\",\"La danse\"]',0,71),(448,5,'Le cours \"Représentations et embeddings\" insiste sur :','[\"La pratique\",\"La cuisine\",\"La peinture\",\"La danse\"]',0,72),(449,5,'Le cours \"Représentations et embeddings\" insiste sur :','[\"La pratique\",\"La cuisine\",\"La peinture\",\"La danse\"]',0,73),(450,5,'Le cours \"Graph ML : GNN et applications\" insiste sur :','[\"La pratique\",\"La cuisine\",\"La peinture\",\"La danse\"]',0,74),(451,5,'Le cours \"Graph ML : GNN et applications\" insiste sur :','[\"La pratique\",\"La cuisine\",\"La peinture\",\"La danse\"]',0,75),(452,5,'Le cours \"Graph ML : GNN et applications\" insiste sur :','[\"La pratique\",\"La cuisine\",\"La peinture\",\"La danse\"]',0,76),(453,5,'Le cours \"IA et robotique : perception et contrôle\" insiste sur :','[\"La pratique\",\"La cuisine\",\"La peinture\",\"La danse\"]',0,77),(454,5,'Le cours \"IA et robotique : perception et contrôle\" insiste sur :','[\"La pratique\",\"La cuisine\",\"La peinture\",\"La danse\"]',0,78),(455,5,'Le cours \"IA et robotique : perception et contrôle\" insiste sur :','[\"La pratique\",\"La cuisine\",\"La peinture\",\"La danse\"]',0,79),(456,5,'Le cours \"Sécurité des modèles ML\" insiste sur :','[\"La pratique\",\"La cuisine\",\"La peinture\",\"La danse\"]',0,80),(457,5,'Le cours \"Sécurité des modèles ML\" insiste sur :','[\"La pratique\",\"La cuisine\",\"La peinture\",\"La danse\"]',0,81),(458,5,'Le cours \"Sécurité des modèles ML\" insiste sur :','[\"La pratique\",\"La cuisine\",\"La peinture\",\"La danse\"]',0,82),(459,5,'Le cours \"Pratiques avancées de data labeling\" insiste sur :','[\"La pratique\",\"La cuisine\",\"La peinture\",\"La danse\"]',0,83),(460,5,'Le cours \"Pratiques avancées de data labeling\" insiste sur :','[\"La pratique\",\"La cuisine\",\"La peinture\",\"La danse\"]',0,84),(461,5,'Le cours \"Pratiques avancées de data labeling\" insiste sur :','[\"La pratique\",\"La cuisine\",\"La peinture\",\"La danse\"]',0,85),(462,5,'Le cours \"IA pour la santé\" insiste sur :','[\"La pratique\",\"La cuisine\",\"La peinture\",\"La danse\"]',0,86),(463,5,'Le cours \"IA pour la santé\" insiste sur :','[\"La pratique\",\"La cuisine\",\"La peinture\",\"La danse\"]',0,87),(464,5,'Le cours \"IA pour la santé\" insiste sur :','[\"La pratique\",\"La cuisine\",\"La peinture\",\"La danse\"]',0,88),(465,5,'Le cours \"Projet capstone : construire une solution IA complète\" insiste sur :','[\"La pratique\",\"La cuisine\",\"La peinture\",\"La danse\"]',0,89),(466,5,'Le cours \"Projet capstone : construire une solution IA complète\" insiste sur :','[\"La pratique\",\"La cuisine\",\"La peinture\",\"La danse\"]',0,90),(467,5,'Le cours \"Projet capstone : construire une solution IA complète\" insiste sur :','[\"La pratique\",\"La cuisine\",\"La peinture\",\"La danse\"]',0,91),(471,6,'Quelle compétence clé est travaillée dans \"Introduction à l\'Intelligence Artificielle\" ?','[\"Analyse de données\",\"Chant lyrique\",\"Décoration\",\"Jeux vidéo\"]',0,32),(472,6,'Quelle compétence clé est travaillée dans \"Introduction à l\'Intelligence Artificielle\" ?','[\"Analyse de données\",\"Chant lyrique\",\"Décoration\",\"Jeux vidéo\"]',0,33),(473,6,'Quelle compétence clé est travaillée dans \"Introduction à l\'Intelligence Artificielle\" ?','[\"Analyse de données\",\"Chant lyrique\",\"Décoration\",\"Jeux vidéo\"]',0,34),(474,6,'Quelle compétence clé est travaillée dans \"Machine Learning : notions et algorithmes\" ?','[\"Analyse de données\",\"Chant lyrique\",\"Décoration\",\"Jeux vidéo\"]',0,35),(477,6,'Quelle compétence clé est travaillée dans \"Deep Learning pour vision par ordinateur\" ?','[\"Analyse de données\",\"Chant lyrique\",\"Décoration\",\"Jeux vidéo\"]',0,38),(478,6,'Quelle compétence clé est travaillée dans \"Deep Learning pour vision par ordinateur\" ?','[\"Analyse de données\",\"Chant lyrique\",\"Décoration\",\"Jeux vidéo\"]',0,39),(479,6,'Quelle compétence clé est travaillée dans \"Deep Learning pour vision par ordinateur\" ?','[\"Analyse de données\",\"Chant lyrique\",\"Décoration\",\"Jeux vidéo\"]',0,40),(480,6,'Quelle compétence clé est travaillée dans \"NLP : traitement du langage naturel\" ?','[\"Analyse de données\",\"Chant lyrique\",\"Décoration\",\"Jeux vidéo\"]',0,41),(481,6,'Quelle compétence clé est travaillée dans \"NLP : traitement du langage naturel\" ?','[\"Analyse de données\",\"Chant lyrique\",\"Décoration\",\"Jeux vidéo\"]',0,42),(482,6,'Quelle compétence clé est travaillée dans \"NLP : traitement du langage naturel\" ?','[\"Analyse de données\",\"Chant lyrique\",\"Décoration\",\"Jeux vidéo\"]',0,43),(483,6,'Quelle compétence clé est travaillée dans \"Apprentissage non supervisé et clustering\" ?','[\"Analyse de données\",\"Chant lyrique\",\"Décoration\",\"Jeux vidéo\"]',0,44),(484,6,'Quelle compétence clé est travaillée dans \"Apprentissage non supervisé et clustering\" ?','[\"Analyse de données\",\"Chant lyrique\",\"Décoration\",\"Jeux vidéo\"]',0,45),(485,6,'Quelle compétence clé est travaillée dans \"Apprentissage non supervisé et clustering\" ?','[\"Analyse de données\",\"Chant lyrique\",\"Décoration\",\"Jeux vidéo\"]',0,46),(486,6,'Quelle compétence clé est travaillée dans \"Modèles probabilistes et bayésiens\" ?','[\"Analyse de données\",\"Chant lyrique\",\"Décoration\",\"Jeux vidéo\"]',0,47),(487,6,'Quelle compétence clé est travaillée dans \"Modèles probabilistes et bayésiens\" ?','[\"Analyse de données\",\"Chant lyrique\",\"Décoration\",\"Jeux vidéo\"]',0,48),(488,6,'Quelle compétence clé est travaillée dans \"Modèles probabilistes et bayésiens\" ?','[\"Analyse de données\",\"Chant lyrique\",\"Décoration\",\"Jeux vidéo\"]',0,49),(489,6,'Quelle compétence clé est travaillée dans \"MLOps : mise en production de modèles\" ?','[\"Analyse de données\",\"Chant lyrique\",\"Décoration\",\"Jeux vidéo\"]',0,50),(490,6,'Quelle compétence clé est travaillée dans \"MLOps : mise en production de modèles\" ?','[\"Analyse de données\",\"Chant lyrique\",\"Décoration\",\"Jeux vidéo\"]',0,51),(491,6,'Quelle compétence clé est travaillée dans \"MLOps : mise en production de modèles\" ?','[\"Analyse de données\",\"Chant lyrique\",\"Décoration\",\"Jeux vidéo\"]',0,52),(492,6,'Quelle compétence clé est travaillée dans \"Éthique et IA responsable\" ?','[\"Analyse de données\",\"Chant lyrique\",\"Décoration\",\"Jeux vidéo\"]',0,53),(493,6,'Quelle compétence clé est travaillée dans \"Éthique et IA responsable\" ?','[\"Analyse de données\",\"Chant lyrique\",\"Décoration\",\"Jeux vidéo\"]',0,54),(494,6,'Quelle compétence clé est travaillée dans \"Éthique et IA responsable\" ?','[\"Analyse de données\",\"Chant lyrique\",\"Décoration\",\"Jeux vidéo\"]',0,55),(495,6,'Quelle compétence clé est travaillée dans \"Apprentissage par renforcement\" ?','[\"Analyse de données\",\"Chant lyrique\",\"Décoration\",\"Jeux vidéo\"]',0,56),(496,6,'Quelle compétence clé est travaillée dans \"Apprentissage par renforcement\" ?','[\"Analyse de données\",\"Chant lyrique\",\"Décoration\",\"Jeux vidéo\"]',0,57),(497,6,'Quelle compétence clé est travaillée dans \"Apprentissage par renforcement\" ?','[\"Analyse de données\",\"Chant lyrique\",\"Décoration\",\"Jeux vidéo\"]',0,58),(498,6,'Quelle compétence clé est travaillée dans \"Feature Engineering avancé\" ?','[\"Analyse de données\",\"Chant lyrique\",\"Décoration\",\"Jeux vidéo\"]',0,59),(499,6,'Quelle compétence clé est travaillée dans \"Feature Engineering avancé\" ?','[\"Analyse de données\",\"Chant lyrique\",\"Décoration\",\"Jeux vidéo\"]',0,60),(500,6,'Quelle compétence clé est travaillée dans \"Feature Engineering avancé\" ?','[\"Analyse de données\",\"Chant lyrique\",\"Décoration\",\"Jeux vidéo\"]',0,61),(501,6,'Quelle compétence clé est travaillée dans \"Computer Vision avancé : détection et segmentation\" ?','[\"Analyse de données\",\"Chant lyrique\",\"Décoration\",\"Jeux vidéo\"]',0,62),(502,6,'Quelle compétence clé est travaillée dans \"Computer Vision avancé : détection et segmentation\" ?','[\"Analyse de données\",\"Chant lyrique\",\"Décoration\",\"Jeux vidéo\"]',0,63),(503,6,'Quelle compétence clé est travaillée dans \"Computer Vision avancé : détection et segmentation\" ?','[\"Analyse de données\",\"Chant lyrique\",\"Décoration\",\"Jeux vidéo\"]',0,64),(504,6,'Quelle compétence clé est travaillée dans \"Time Series & Forecasting\" ?','[\"Analyse de données\",\"Chant lyrique\",\"Décoration\",\"Jeux vidéo\"]',0,65),(505,6,'Quelle compétence clé est travaillée dans \"Time Series & Forecasting\" ?','[\"Analyse de données\",\"Chant lyrique\",\"Décoration\",\"Jeux vidéo\"]',0,66),(506,6,'Quelle compétence clé est travaillée dans \"Time Series & Forecasting\" ?','[\"Analyse de données\",\"Chant lyrique\",\"Décoration\",\"Jeux vidéo\"]',0,67),(507,6,'Quelle compétence clé est travaillée dans \"AutoML et optimisation d\'hyperparamètres\" ?','[\"Analyse de données\",\"Chant lyrique\",\"Décoration\",\"Jeux vidéo\"]',0,68),(508,6,'Quelle compétence clé est travaillée dans \"AutoML et optimisation d\'hyperparamètres\" ?','[\"Analyse de données\",\"Chant lyrique\",\"Décoration\",\"Jeux vidéo\"]',0,69),(509,6,'Quelle compétence clé est travaillée dans \"AutoML et optimisation d\'hyperparamètres\" ?','[\"Analyse de données\",\"Chant lyrique\",\"Décoration\",\"Jeux vidéo\"]',0,70),(510,6,'Quelle compétence clé est travaillée dans \"Représentations et embeddings\" ?','[\"Analyse de données\",\"Chant lyrique\",\"Décoration\",\"Jeux vidéo\"]',0,71),(511,6,'Quelle compétence clé est travaillée dans \"Représentations et embeddings\" ?','[\"Analyse de données\",\"Chant lyrique\",\"Décoration\",\"Jeux vidéo\"]',0,72),(512,6,'Quelle compétence clé est travaillée dans \"Représentations et embeddings\" ?','[\"Analyse de données\",\"Chant lyrique\",\"Décoration\",\"Jeux vidéo\"]',0,73),(513,6,'Quelle compétence clé est travaillée dans \"Graph ML : GNN et applications\" ?','[\"Analyse de données\",\"Chant lyrique\",\"Décoration\",\"Jeux vidéo\"]',0,74),(514,6,'Quelle compétence clé est travaillée dans \"Graph ML : GNN et applications\" ?','[\"Analyse de données\",\"Chant lyrique\",\"Décoration\",\"Jeux vidéo\"]',0,75),(515,6,'Quelle compétence clé est travaillée dans \"Graph ML : GNN et applications\" ?','[\"Analyse de données\",\"Chant lyrique\",\"Décoration\",\"Jeux vidéo\"]',0,76),(516,6,'Quelle compétence clé est travaillée dans \"IA et robotique : perception et contrôle\" ?','[\"Analyse de données\",\"Chant lyrique\",\"Décoration\",\"Jeux vidéo\"]',0,77),(517,6,'Quelle compétence clé est travaillée dans \"IA et robotique : perception et contrôle\" ?','[\"Analyse de données\",\"Chant lyrique\",\"Décoration\",\"Jeux vidéo\"]',0,78),(518,6,'Quelle compétence clé est travaillée dans \"IA et robotique : perception et contrôle\" ?','[\"Analyse de données\",\"Chant lyrique\",\"Décoration\",\"Jeux vidéo\"]',0,79),(519,6,'Quelle compétence clé est travaillée dans \"Sécurité des modèles ML\" ?','[\"Analyse de données\",\"Chant lyrique\",\"Décoration\",\"Jeux vidéo\"]',0,80),(520,6,'Quelle compétence clé est travaillée dans \"Sécurité des modèles ML\" ?','[\"Analyse de données\",\"Chant lyrique\",\"Décoration\",\"Jeux vidéo\"]',0,81),(521,6,'Quelle compétence clé est travaillée dans \"Sécurité des modèles ML\" ?','[\"Analyse de données\",\"Chant lyrique\",\"Décoration\",\"Jeux vidéo\"]',0,82),(522,6,'Quelle compétence clé est travaillée dans \"Pratiques avancées de data labeling\" ?','[\"Analyse de données\",\"Chant lyrique\",\"Décoration\",\"Jeux vidéo\"]',0,83),(523,6,'Quelle compétence clé est travaillée dans \"Pratiques avancées de data labeling\" ?','[\"Analyse de données\",\"Chant lyrique\",\"Décoration\",\"Jeux vidéo\"]',0,84),(524,6,'Quelle compétence clé est travaillée dans \"Pratiques avancées de data labeling\" ?','[\"Analyse de données\",\"Chant lyrique\",\"Décoration\",\"Jeux vidéo\"]',0,85),(525,6,'Quelle compétence clé est travaillée dans \"IA pour la santé\" ?','[\"Analyse de données\",\"Chant lyrique\",\"Décoration\",\"Jeux vidéo\"]',0,86),(526,6,'Quelle compétence clé est travaillée dans \"IA pour la santé\" ?','[\"Analyse de données\",\"Chant lyrique\",\"Décoration\",\"Jeux vidéo\"]',0,87),(527,6,'Quelle compétence clé est travaillée dans \"IA pour la santé\" ?','[\"Analyse de données\",\"Chant lyrique\",\"Décoration\",\"Jeux vidéo\"]',0,88),(528,6,'Quelle compétence clé est travaillée dans \"Projet capstone : construire une solution IA complète\" ?','[\"Analyse de données\",\"Chant lyrique\",\"Décoration\",\"Jeux vidéo\"]',0,89),(529,6,'Quelle compétence clé est travaillée dans \"Projet capstone : construire une solution IA complète\" ?','[\"Analyse de données\",\"Chant lyrique\",\"Décoration\",\"Jeux vidéo\"]',0,90),(530,6,'Quelle compétence clé est travaillée dans \"Projet capstone : construire une solution IA complète\" ?','[\"Analyse de données\",\"Chant lyrique\",\"Décoration\",\"Jeux vidéo\"]',0,91),(534,7,'Quel livrable est attendu dans \"Introduction à l\'Intelligence Artificielle\" ?','[\"Un prototype IA\",\"Une chorégraphie\",\"Une peinture murale\",\"Une recette filmée\"]',0,32),(535,7,'Quel livrable est attendu dans \"Introduction à l\'Intelligence Artificielle\" ?','[\"Un prototype IA\",\"Une chorégraphie\",\"Une peinture murale\",\"Une recette filmée\"]',0,33),(536,7,'Quel livrable est attendu dans \"Introduction à l\'Intelligence Artificielle\" ?','[\"Un prototype IA\",\"Une chorégraphie\",\"Une peinture murale\",\"Une recette filmée\"]',0,34),(537,7,'Quel livrable est attendu dans \"Machine Learning : notions et algorithmes\" ?','[\"Un prototype IA\",\"Une chorégraphie\",\"Une peinture murale\",\"Une recette filmée\"]',0,35),(540,7,'Quel livrable est attendu dans \"Deep Learning pour vision par ordinateur\" ?','[\"Un prototype IA\",\"Une chorégraphie\",\"Une peinture murale\",\"Une recette filmée\"]',0,38),(541,7,'Quel livrable est attendu dans \"Deep Learning pour vision par ordinateur\" ?','[\"Un prototype IA\",\"Une chorégraphie\",\"Une peinture murale\",\"Une recette filmée\"]',0,39),(542,7,'Quel livrable est attendu dans \"Deep Learning pour vision par ordinateur\" ?','[\"Un prototype IA\",\"Une chorégraphie\",\"Une peinture murale\",\"Une recette filmée\"]',0,40),(543,7,'Quel livrable est attendu dans \"NLP : traitement du langage naturel\" ?','[\"Un prototype IA\",\"Une chorégraphie\",\"Une peinture murale\",\"Une recette filmée\"]',0,41),(544,7,'Quel livrable est attendu dans \"NLP : traitement du langage naturel\" ?','[\"Un prototype IA\",\"Une chorégraphie\",\"Une peinture murale\",\"Une recette filmée\"]',0,42),(545,7,'Quel livrable est attendu dans \"NLP : traitement du langage naturel\" ?','[\"Un prototype IA\",\"Une chorégraphie\",\"Une peinture murale\",\"Une recette filmée\"]',0,43),(546,7,'Quel livrable est attendu dans \"Apprentissage non supervisé et clustering\" ?','[\"Un prototype IA\",\"Une chorégraphie\",\"Une peinture murale\",\"Une recette filmée\"]',0,44),(547,7,'Quel livrable est attendu dans \"Apprentissage non supervisé et clustering\" ?','[\"Un prototype IA\",\"Une chorégraphie\",\"Une peinture murale\",\"Une recette filmée\"]',0,45),(548,7,'Quel livrable est attendu dans \"Apprentissage non supervisé et clustering\" ?','[\"Un prototype IA\",\"Une chorégraphie\",\"Une peinture murale\",\"Une recette filmée\"]',0,46),(549,7,'Quel livrable est attendu dans \"Modèles probabilistes et bayésiens\" ?','[\"Un prototype IA\",\"Une chorégraphie\",\"Une peinture murale\",\"Une recette filmée\"]',0,47),(550,7,'Quel livrable est attendu dans \"Modèles probabilistes et bayésiens\" ?','[\"Un prototype IA\",\"Une chorégraphie\",\"Une peinture murale\",\"Une recette filmée\"]',0,48),(551,7,'Quel livrable est attendu dans \"Modèles probabilistes et bayésiens\" ?','[\"Un prototype IA\",\"Une chorégraphie\",\"Une peinture murale\",\"Une recette filmée\"]',0,49),(552,7,'Quel livrable est attendu dans \"MLOps : mise en production de modèles\" ?','[\"Un prototype IA\",\"Une chorégraphie\",\"Une peinture murale\",\"Une recette filmée\"]',0,50),(553,7,'Quel livrable est attendu dans \"MLOps : mise en production de modèles\" ?','[\"Un prototype IA\",\"Une chorégraphie\",\"Une peinture murale\",\"Une recette filmée\"]',0,51),(554,7,'Quel livrable est attendu dans \"MLOps : mise en production de modèles\" ?','[\"Un prototype IA\",\"Une chorégraphie\",\"Une peinture murale\",\"Une recette filmée\"]',0,52),(555,7,'Quel livrable est attendu dans \"Éthique et IA responsable\" ?','[\"Un prototype IA\",\"Une chorégraphie\",\"Une peinture murale\",\"Une recette filmée\"]',0,53),(556,7,'Quel livrable est attendu dans \"Éthique et IA responsable\" ?','[\"Un prototype IA\",\"Une chorégraphie\",\"Une peinture murale\",\"Une recette filmée\"]',0,54),(557,7,'Quel livrable est attendu dans \"Éthique et IA responsable\" ?','[\"Un prototype IA\",\"Une chorégraphie\",\"Une peinture murale\",\"Une recette filmée\"]',0,55),(558,7,'Quel livrable est attendu dans \"Apprentissage par renforcement\" ?','[\"Un prototype IA\",\"Une chorégraphie\",\"Une peinture murale\",\"Une recette filmée\"]',0,56),(559,7,'Quel livrable est attendu dans \"Apprentissage par renforcement\" ?','[\"Un prototype IA\",\"Une chorégraphie\",\"Une peinture murale\",\"Une recette filmée\"]',0,57),(560,7,'Quel livrable est attendu dans \"Apprentissage par renforcement\" ?','[\"Un prototype IA\",\"Une chorégraphie\",\"Une peinture murale\",\"Une recette filmée\"]',0,58),(561,7,'Quel livrable est attendu dans \"Feature Engineering avancé\" ?','[\"Un prototype IA\",\"Une chorégraphie\",\"Une peinture murale\",\"Une recette filmée\"]',0,59),(562,7,'Quel livrable est attendu dans \"Feature Engineering avancé\" ?','[\"Un prototype IA\",\"Une chorégraphie\",\"Une peinture murale\",\"Une recette filmée\"]',0,60),(563,7,'Quel livrable est attendu dans \"Feature Engineering avancé\" ?','[\"Un prototype IA\",\"Une chorégraphie\",\"Une peinture murale\",\"Une recette filmée\"]',0,61),(564,7,'Quel livrable est attendu dans \"Computer Vision avancé : détection et segmentation\" ?','[\"Un prototype IA\",\"Une chorégraphie\",\"Une peinture murale\",\"Une recette filmée\"]',0,62),(565,7,'Quel livrable est attendu dans \"Computer Vision avancé : détection et segmentation\" ?','[\"Un prototype IA\",\"Une chorégraphie\",\"Une peinture murale\",\"Une recette filmée\"]',0,63),(566,7,'Quel livrable est attendu dans \"Computer Vision avancé : détection et segmentation\" ?','[\"Un prototype IA\",\"Une chorégraphie\",\"Une peinture murale\",\"Une recette filmée\"]',0,64),(567,7,'Quel livrable est attendu dans \"Time Series & Forecasting\" ?','[\"Un prototype IA\",\"Une chorégraphie\",\"Une peinture murale\",\"Une recette filmée\"]',0,65),(568,7,'Quel livrable est attendu dans \"Time Series & Forecasting\" ?','[\"Un prototype IA\",\"Une chorégraphie\",\"Une peinture murale\",\"Une recette filmée\"]',0,66),(569,7,'Quel livrable est attendu dans \"Time Series & Forecasting\" ?','[\"Un prototype IA\",\"Une chorégraphie\",\"Une peinture murale\",\"Une recette filmée\"]',0,67),(570,7,'Quel livrable est attendu dans \"AutoML et optimisation d\'hyperparamètres\" ?','[\"Un prototype IA\",\"Une chorégraphie\",\"Une peinture murale\",\"Une recette filmée\"]',0,68),(571,7,'Quel livrable est attendu dans \"AutoML et optimisation d\'hyperparamètres\" ?','[\"Un prototype IA\",\"Une chorégraphie\",\"Une peinture murale\",\"Une recette filmée\"]',0,69),(572,7,'Quel livrable est attendu dans \"AutoML et optimisation d\'hyperparamètres\" ?','[\"Un prototype IA\",\"Une chorégraphie\",\"Une peinture murale\",\"Une recette filmée\"]',0,70),(573,7,'Quel livrable est attendu dans \"Représentations et embeddings\" ?','[\"Un prototype IA\",\"Une chorégraphie\",\"Une peinture murale\",\"Une recette filmée\"]',0,71),(574,7,'Quel livrable est attendu dans \"Représentations et embeddings\" ?','[\"Un prototype IA\",\"Une chorégraphie\",\"Une peinture murale\",\"Une recette filmée\"]',0,72),(575,7,'Quel livrable est attendu dans \"Représentations et embeddings\" ?','[\"Un prototype IA\",\"Une chorégraphie\",\"Une peinture murale\",\"Une recette filmée\"]',0,73),(576,7,'Quel livrable est attendu dans \"Graph ML : GNN et applications\" ?','[\"Un prototype IA\",\"Une chorégraphie\",\"Une peinture murale\",\"Une recette filmée\"]',0,74),(577,7,'Quel livrable est attendu dans \"Graph ML : GNN et applications\" ?','[\"Un prototype IA\",\"Une chorégraphie\",\"Une peinture murale\",\"Une recette filmée\"]',0,75),(578,7,'Quel livrable est attendu dans \"Graph ML : GNN et applications\" ?','[\"Un prototype IA\",\"Une chorégraphie\",\"Une peinture murale\",\"Une recette filmée\"]',0,76),(579,7,'Quel livrable est attendu dans \"IA et robotique : perception et contrôle\" ?','[\"Un prototype IA\",\"Une chorégraphie\",\"Une peinture murale\",\"Une recette filmée\"]',0,77),(580,7,'Quel livrable est attendu dans \"IA et robotique : perception et contrôle\" ?','[\"Un prototype IA\",\"Une chorégraphie\",\"Une peinture murale\",\"Une recette filmée\"]',0,78),(581,7,'Quel livrable est attendu dans \"IA et robotique : perception et contrôle\" ?','[\"Un prototype IA\",\"Une chorégraphie\",\"Une peinture murale\",\"Une recette filmée\"]',0,79),(582,7,'Quel livrable est attendu dans \"Sécurité des modèles ML\" ?','[\"Un prototype IA\",\"Une chorégraphie\",\"Une peinture murale\",\"Une recette filmée\"]',0,80),(583,7,'Quel livrable est attendu dans \"Sécurité des modèles ML\" ?','[\"Un prototype IA\",\"Une chorégraphie\",\"Une peinture murale\",\"Une recette filmée\"]',0,81),(584,7,'Quel livrable est attendu dans \"Sécurité des modèles ML\" ?','[\"Un prototype IA\",\"Une chorégraphie\",\"Une peinture murale\",\"Une recette filmée\"]',0,82),(585,7,'Quel livrable est attendu dans \"Pratiques avancées de data labeling\" ?','[\"Un prototype IA\",\"Une chorégraphie\",\"Une peinture murale\",\"Une recette filmée\"]',0,83),(586,7,'Quel livrable est attendu dans \"Pratiques avancées de data labeling\" ?','[\"Un prototype IA\",\"Une chorégraphie\",\"Une peinture murale\",\"Une recette filmée\"]',0,84),(587,7,'Quel livrable est attendu dans \"Pratiques avancées de data labeling\" ?','[\"Un prototype IA\",\"Une chorégraphie\",\"Une peinture murale\",\"Une recette filmée\"]',0,85),(588,7,'Quel livrable est attendu dans \"IA pour la santé\" ?','[\"Un prototype IA\",\"Une chorégraphie\",\"Une peinture murale\",\"Une recette filmée\"]',0,86),(589,7,'Quel livrable est attendu dans \"IA pour la santé\" ?','[\"Un prototype IA\",\"Une chorégraphie\",\"Une peinture murale\",\"Une recette filmée\"]',0,87),(590,7,'Quel livrable est attendu dans \"IA pour la santé\" ?','[\"Un prototype IA\",\"Une chorégraphie\",\"Une peinture murale\",\"Une recette filmée\"]',0,88),(591,7,'Quel livrable est attendu dans \"Projet capstone : construire une solution IA complète\" ?','[\"Un prototype IA\",\"Une chorégraphie\",\"Une peinture murale\",\"Une recette filmée\"]',0,89),(592,7,'Quel livrable est attendu dans \"Projet capstone : construire une solution IA complète\" ?','[\"Un prototype IA\",\"Une chorégraphie\",\"Une peinture murale\",\"Une recette filmée\"]',0,90),(593,7,'Quel livrable est attendu dans \"Projet capstone : construire une solution IA complète\" ?','[\"Un prototype IA\",\"Une chorégraphie\",\"Une peinture murale\",\"Une recette filmée\"]',0,91),(597,8,'À l\'issue du cours \"Introduction à l\'Intelligence Artificielle\", vous serez capable de :','[\"Construire un modèle basique\",\"Construire une maquette 3D\",\"Cuisiner un plat complexe\",\"Diriger un orchestre\"]',0,32),(598,8,'À l\'issue du cours \"Introduction à l\'Intelligence Artificielle\", vous serez capable de :','[\"Construire un modèle basique\",\"Construire une maquette 3D\",\"Cuisiner un plat complexe\",\"Diriger un orchestre\"]',0,33),(599,8,'À l\'issue du cours \"Introduction à l\'Intelligence Artificielle\", vous serez capable de :','[\"Construire un modèle basique\",\"Construire une maquette 3D\",\"Cuisiner un plat complexe\",\"Diriger un orchestre\"]',0,34),(600,8,'À l\'issue du cours \"Machine Learning : notions et algorithmes\", vous serez capable de :','[\"Construire un modèle basique\",\"Construire une maquette 3D\",\"Cuisiner un plat complexe\",\"Diriger un orchestre\"]',0,35),(603,8,'À l\'issue du cours \"Deep Learning pour vision par ordinateur\", vous serez capable de :','[\"Construire un modèle basique\",\"Construire une maquette 3D\",\"Cuisiner un plat complexe\",\"Diriger un orchestre\"]',0,38),(604,8,'À l\'issue du cours \"Deep Learning pour vision par ordinateur\", vous serez capable de :','[\"Construire un modèle basique\",\"Construire une maquette 3D\",\"Cuisiner un plat complexe\",\"Diriger un orchestre\"]',0,39),(605,8,'À l\'issue du cours \"Deep Learning pour vision par ordinateur\", vous serez capable de :','[\"Construire un modèle basique\",\"Construire une maquette 3D\",\"Cuisiner un plat complexe\",\"Diriger un orchestre\"]',0,40),(606,8,'À l\'issue du cours \"NLP : traitement du langage naturel\", vous serez capable de :','[\"Construire un modèle basique\",\"Construire une maquette 3D\",\"Cuisiner un plat complexe\",\"Diriger un orchestre\"]',0,41),(607,8,'À l\'issue du cours \"NLP : traitement du langage naturel\", vous serez capable de :','[\"Construire un modèle basique\",\"Construire une maquette 3D\",\"Cuisiner un plat complexe\",\"Diriger un orchestre\"]',0,42),(608,8,'À l\'issue du cours \"NLP : traitement du langage naturel\", vous serez capable de :','[\"Construire un modèle basique\",\"Construire une maquette 3D\",\"Cuisiner un plat complexe\",\"Diriger un orchestre\"]',0,43),(609,8,'À l\'issue du cours \"Apprentissage non supervisé et clustering\", vous serez capable de :','[\"Construire un modèle basique\",\"Construire une maquette 3D\",\"Cuisiner un plat complexe\",\"Diriger un orchestre\"]',0,44),(610,8,'À l\'issue du cours \"Apprentissage non supervisé et clustering\", vous serez capable de :','[\"Construire un modèle basique\",\"Construire une maquette 3D\",\"Cuisiner un plat complexe\",\"Diriger un orchestre\"]',0,45),(611,8,'À l\'issue du cours \"Apprentissage non supervisé et clustering\", vous serez capable de :','[\"Construire un modèle basique\",\"Construire une maquette 3D\",\"Cuisiner un plat complexe\",\"Diriger un orchestre\"]',0,46),(612,8,'À l\'issue du cours \"Modèles probabilistes et bayésiens\", vous serez capable de :','[\"Construire un modèle basique\",\"Construire une maquette 3D\",\"Cuisiner un plat complexe\",\"Diriger un orchestre\"]',0,47),(613,8,'À l\'issue du cours \"Modèles probabilistes et bayésiens\", vous serez capable de :','[\"Construire un modèle basique\",\"Construire une maquette 3D\",\"Cuisiner un plat complexe\",\"Diriger un orchestre\"]',0,48),(614,8,'À l\'issue du cours \"Modèles probabilistes et bayésiens\", vous serez capable de :','[\"Construire un modèle basique\",\"Construire une maquette 3D\",\"Cuisiner un plat complexe\",\"Diriger un orchestre\"]',0,49),(615,8,'À l\'issue du cours \"MLOps : mise en production de modèles\", vous serez capable de :','[\"Construire un modèle basique\",\"Construire une maquette 3D\",\"Cuisiner un plat complexe\",\"Diriger un orchestre\"]',0,50),(616,8,'À l\'issue du cours \"MLOps : mise en production de modèles\", vous serez capable de :','[\"Construire un modèle basique\",\"Construire une maquette 3D\",\"Cuisiner un plat complexe\",\"Diriger un orchestre\"]',0,51),(617,8,'À l\'issue du cours \"MLOps : mise en production de modèles\", vous serez capable de :','[\"Construire un modèle basique\",\"Construire une maquette 3D\",\"Cuisiner un plat complexe\",\"Diriger un orchestre\"]',0,52),(618,8,'À l\'issue du cours \"Éthique et IA responsable\", vous serez capable de :','[\"Construire un modèle basique\",\"Construire une maquette 3D\",\"Cuisiner un plat complexe\",\"Diriger un orchestre\"]',0,53),(619,8,'À l\'issue du cours \"Éthique et IA responsable\", vous serez capable de :','[\"Construire un modèle basique\",\"Construire une maquette 3D\",\"Cuisiner un plat complexe\",\"Diriger un orchestre\"]',0,54),(620,8,'À l\'issue du cours \"Éthique et IA responsable\", vous serez capable de :','[\"Construire un modèle basique\",\"Construire une maquette 3D\",\"Cuisiner un plat complexe\",\"Diriger un orchestre\"]',0,55),(621,8,'À l\'issue du cours \"Apprentissage par renforcement\", vous serez capable de :','[\"Construire un modèle basique\",\"Construire une maquette 3D\",\"Cuisiner un plat complexe\",\"Diriger un orchestre\"]',0,56),(622,8,'À l\'issue du cours \"Apprentissage par renforcement\", vous serez capable de :','[\"Construire un modèle basique\",\"Construire une maquette 3D\",\"Cuisiner un plat complexe\",\"Diriger un orchestre\"]',0,57),(623,8,'À l\'issue du cours \"Apprentissage par renforcement\", vous serez capable de :','[\"Construire un modèle basique\",\"Construire une maquette 3D\",\"Cuisiner un plat complexe\",\"Diriger un orchestre\"]',0,58),(624,8,'À l\'issue du cours \"Feature Engineering avancé\", vous serez capable de :','[\"Construire un modèle basique\",\"Construire une maquette 3D\",\"Cuisiner un plat complexe\",\"Diriger un orchestre\"]',0,59),(625,8,'À l\'issue du cours \"Feature Engineering avancé\", vous serez capable de :','[\"Construire un modèle basique\",\"Construire une maquette 3D\",\"Cuisiner un plat complexe\",\"Diriger un orchestre\"]',0,60),(626,8,'À l\'issue du cours \"Feature Engineering avancé\", vous serez capable de :','[\"Construire un modèle basique\",\"Construire une maquette 3D\",\"Cuisiner un plat complexe\",\"Diriger un orchestre\"]',0,61),(627,8,'À l\'issue du cours \"Computer Vision avancé : détection et segmentation\", vous serez capable de :','[\"Construire un modèle basique\",\"Construire une maquette 3D\",\"Cuisiner un plat complexe\",\"Diriger un orchestre\"]',0,62),(628,8,'À l\'issue du cours \"Computer Vision avancé : détection et segmentation\", vous serez capable de :','[\"Construire un modèle basique\",\"Construire une maquette 3D\",\"Cuisiner un plat complexe\",\"Diriger un orchestre\"]',0,63),(629,8,'À l\'issue du cours \"Computer Vision avancé : détection et segmentation\", vous serez capable de :','[\"Construire un modèle basique\",\"Construire une maquette 3D\",\"Cuisiner un plat complexe\",\"Diriger un orchestre\"]',0,64),(630,8,'À l\'issue du cours \"Time Series & Forecasting\", vous serez capable de :','[\"Construire un modèle basique\",\"Construire une maquette 3D\",\"Cuisiner un plat complexe\",\"Diriger un orchestre\"]',0,65),(631,8,'À l\'issue du cours \"Time Series & Forecasting\", vous serez capable de :','[\"Construire un modèle basique\",\"Construire une maquette 3D\",\"Cuisiner un plat complexe\",\"Diriger un orchestre\"]',0,66),(632,8,'À l\'issue du cours \"Time Series & Forecasting\", vous serez capable de :','[\"Construire un modèle basique\",\"Construire une maquette 3D\",\"Cuisiner un plat complexe\",\"Diriger un orchestre\"]',0,67),(633,8,'À l\'issue du cours \"AutoML et optimisation d\'hyperparamètres\", vous serez capable de :','[\"Construire un modèle basique\",\"Construire une maquette 3D\",\"Cuisiner un plat complexe\",\"Diriger un orchestre\"]',0,68),(634,8,'À l\'issue du cours \"AutoML et optimisation d\'hyperparamètres\", vous serez capable de :','[\"Construire un modèle basique\",\"Construire une maquette 3D\",\"Cuisiner un plat complexe\",\"Diriger un orchestre\"]',0,69),(635,8,'À l\'issue du cours \"AutoML et optimisation d\'hyperparamètres\", vous serez capable de :','[\"Construire un modèle basique\",\"Construire une maquette 3D\",\"Cuisiner un plat complexe\",\"Diriger un orchestre\"]',0,70),(636,8,'À l\'issue du cours \"Représentations et embeddings\", vous serez capable de :','[\"Construire un modèle basique\",\"Construire une maquette 3D\",\"Cuisiner un plat complexe\",\"Diriger un orchestre\"]',0,71),(637,8,'À l\'issue du cours \"Représentations et embeddings\", vous serez capable de :','[\"Construire un modèle basique\",\"Construire une maquette 3D\",\"Cuisiner un plat complexe\",\"Diriger un orchestre\"]',0,72),(638,8,'À l\'issue du cours \"Représentations et embeddings\", vous serez capable de :','[\"Construire un modèle basique\",\"Construire une maquette 3D\",\"Cuisiner un plat complexe\",\"Diriger un orchestre\"]',0,73),(639,8,'À l\'issue du cours \"Graph ML : GNN et applications\", vous serez capable de :','[\"Construire un modèle basique\",\"Construire une maquette 3D\",\"Cuisiner un plat complexe\",\"Diriger un orchestre\"]',0,74),(640,8,'À l\'issue du cours \"Graph ML : GNN et applications\", vous serez capable de :','[\"Construire un modèle basique\",\"Construire une maquette 3D\",\"Cuisiner un plat complexe\",\"Diriger un orchestre\"]',0,75),(641,8,'À l\'issue du cours \"Graph ML : GNN et applications\", vous serez capable de :','[\"Construire un modèle basique\",\"Construire une maquette 3D\",\"Cuisiner un plat complexe\",\"Diriger un orchestre\"]',0,76),(642,8,'À l\'issue du cours \"IA et robotique : perception et contrôle\", vous serez capable de :','[\"Construire un modèle basique\",\"Construire une maquette 3D\",\"Cuisiner un plat complexe\",\"Diriger un orchestre\"]',0,77),(643,8,'À l\'issue du cours \"IA et robotique : perception et contrôle\", vous serez capable de :','[\"Construire un modèle basique\",\"Construire une maquette 3D\",\"Cuisiner un plat complexe\",\"Diriger un orchestre\"]',0,78),(644,8,'À l\'issue du cours \"IA et robotique : perception et contrôle\", vous serez capable de :','[\"Construire un modèle basique\",\"Construire une maquette 3D\",\"Cuisiner un plat complexe\",\"Diriger un orchestre\"]',0,79),(645,8,'À l\'issue du cours \"Sécurité des modèles ML\", vous serez capable de :','[\"Construire un modèle basique\",\"Construire une maquette 3D\",\"Cuisiner un plat complexe\",\"Diriger un orchestre\"]',0,80),(646,8,'À l\'issue du cours \"Sécurité des modèles ML\", vous serez capable de :','[\"Construire un modèle basique\",\"Construire une maquette 3D\",\"Cuisiner un plat complexe\",\"Diriger un orchestre\"]',0,81),(647,8,'À l\'issue du cours \"Sécurité des modèles ML\", vous serez capable de :','[\"Construire un modèle basique\",\"Construire une maquette 3D\",\"Cuisiner un plat complexe\",\"Diriger un orchestre\"]',0,82),(648,8,'À l\'issue du cours \"Pratiques avancées de data labeling\", vous serez capable de :','[\"Construire un modèle basique\",\"Construire une maquette 3D\",\"Cuisiner un plat complexe\",\"Diriger un orchestre\"]',0,83),(649,8,'À l\'issue du cours \"Pratiques avancées de data labeling\", vous serez capable de :','[\"Construire un modèle basique\",\"Construire une maquette 3D\",\"Cuisiner un plat complexe\",\"Diriger un orchestre\"]',0,84),(650,8,'À l\'issue du cours \"Pratiques avancées de data labeling\", vous serez capable de :','[\"Construire un modèle basique\",\"Construire une maquette 3D\",\"Cuisiner un plat complexe\",\"Diriger un orchestre\"]',0,85),(651,8,'À l\'issue du cours \"IA pour la santé\", vous serez capable de :','[\"Construire un modèle basique\",\"Construire une maquette 3D\",\"Cuisiner un plat complexe\",\"Diriger un orchestre\"]',0,86),(652,8,'À l\'issue du cours \"IA pour la santé\", vous serez capable de :','[\"Construire un modèle basique\",\"Construire une maquette 3D\",\"Cuisiner un plat complexe\",\"Diriger un orchestre\"]',0,87),(653,8,'À l\'issue du cours \"IA pour la santé\", vous serez capable de :','[\"Construire un modèle basique\",\"Construire une maquette 3D\",\"Cuisiner un plat complexe\",\"Diriger un orchestre\"]',0,88),(654,8,'À l\'issue du cours \"Projet capstone : construire une solution IA complète\", vous serez capable de :','[\"Construire un modèle basique\",\"Construire une maquette 3D\",\"Cuisiner un plat complexe\",\"Diriger un orchestre\"]',0,89),(655,8,'À l\'issue du cours \"Projet capstone : construire une solution IA complète\", vous serez capable de :','[\"Construire un modèle basique\",\"Construire une maquette 3D\",\"Cuisiner un plat complexe\",\"Diriger un orchestre\"]',0,90),(656,8,'À l\'issue du cours \"Projet capstone : construire une solution IA complète\", vous serez capable de :','[\"Construire un modèle basique\",\"Construire une maquette 3D\",\"Cuisiner un plat complexe\",\"Diriger un orchestre\"]',0,91),(657,1,'Quelle est la définition du spectre résiduel d\'un opérateur borné ?','[\"L\'ensemble des λ où T - λI n\'est pas injectif\", \"L\'ensemble des λ où T - λI est injectif mais son image n\'est pas dense\", \"L\'ensemble des λ où T - λI est surjectif mais non inversible\"]',1,92),(658,2,'Le spectre d\'un opérateur compact auto-adjoint peut-il contenir un continuum ?','[\"Oui, si l\'opérateur est de rang infini\", \"Non, il est purement ponctuel avec accumulation possible en zéro\", \"Seulement dans les espaces non séparables\"]',1,92),(659,1,'Quel théorème garantit l\'existence d\'une mesure spectrale pour un opérateur auto-adjoint borné ?','[\"Théorème de Hahn-Banach\", \"Théorème spectral de Hilbert\", \"Théorème de Banach-Steinhaus\"]',1,93),(660,2,'Comment définit-on f(T) pour une fonction borélienne bornée f et un opérateur auto-adjoint T ?','[\"Par limite uniforme des polynômes en T\", \"Par intégration de f par rapport à la mesure spectrale\", \"Par série de Fourier sur le spectre\"]',1,93),(661,3,'Quelle propriété caractérise les opérateurs normaux ?','[\"Ils commutent avec leur adjoint\", \"Ils sont compacts et auto-adjoints\", \"Leur spectre est réel\"]',0,93),(662,1,'Quelle condition est nécessaire pour qu\'un opérateur symétrique soit auto-adjoint ?','[\"Son domaine doit être dense\", \"Les indices de défaut doivent être nuls\", \"Il doit être borné sur son domaine\"]',1,94),(663,2,'À quoi sert la transformée de Cayley pour un opérateur auto-adjoint non borné ?','[\"À le rendre compact\", \"À le relier à un opérateur unitaire borné\", \"À calculer son spectre essentiel\"]',1,94),(664,1,'Quelle est une caractéristique fondamentale introduite par Pierre Larousse dans son dictionnaire ?','[\"La séparation stricte entre définitions linguistiques et contenu encyclopédique\", \"La combinaison de définitions précises et d\'informations encyclopédiques illustrées\"]',1,95),(665,2,'Dans un article, que suit généralement la prononciation phonétique ?','[\"L\'étymologie du mot\", \"La catégorie grammaticale abrégée\"]',1,95),(666,1,'Que signale principalement la marque \'(familier)\' à côté d\'un mot ?','[\"Que le mot est d\'origine étrangère\", \"Que le mot est approprié pour un registre de langue informel\"]',1,96),(667,2,'Quelle relation lexicale décrit le lien entre un terme général et un terme spécifique, comme \'végétal\' et \'chêne\' ?','[\"La synonymie\", \"L\'hyperonymie/hyponymie\"]',1,96),(668,1,'Quel est l\'avantage principal de l\'utilisation d\'environnements virtuels avec DeepSeek ?','[\"Isolation des dépendances entre projets différents\", \"Amélioration automatique des performances calcul\", \"Génération aléatoire de architectures réseaux\"]',1,97),(669,2,'Quelle fonctionnalité permet de gérer efficacement les datasets volumineux ?','[\"Intégration avec DVC pour versioning données\", \"Compression automatique des images\", \"Suppression des doublons en mémoire\"]',1,97),(673,1,'Quel impact principal a la quantification INT8 sur un modèle ?','[\"Réduction significative de la mémoire requise\", \"Augmentation automatique de la précision\", \"Accélération du temps d\'entraînement\"]',0,99),(674,2,'Quel outil orchestre le déploiement de conteneurs à grande échelle ?','[\"Kubernetes pour la gestion clusters\", \"Docker pour l\'isolation processus\", \"Git pour le versioning code\"]',0,99),(675,1,'kjkkj','[\"kjkj\", \"ygygy\"]',0,100),(676,2,'hhuhuu','[\"yyy\", \"yuy\"]',1,100),(677,1,'What property distinguishes a bounded linear operator on a normed space?','[\"It has a finite operator norm\", \"Its kernel is finite-dimensional\", \"It is defined on the entire space\", \"It commutes with its adjoint\"]',0,101),(678,2,'In a Hilbert space, the concept of orthogonality is defined using which structure?','[\"The norm induced by the inner product\", \"The metric topology\", \"The graph of the operator\", \"The Banach space completion\"]',0,101),(679,3,'Which property is characteristic of a compact operator?','[\"It maps the unit ball to a relatively compact set\", \"Its spectrum consists only of eigenvalues\", \"It is always self-adjoint\", \"It has a closed range\"]',0,101),(680,1,'The resolvent set of an operator T consists of all complex numbers λ for which:','[\"(T - λI) is invertible\", \"(T - λI) is compact\", \"λ is an eigenvalue of T\", \"The norm of T is less than |λ|\"]',0,102),(681,2,'The spectral radius formula for a bounded operator T is given by:','[\"lim ||T^n||^(1/n) as n→∞\", \"The maximum of the real parts of the spectrum\", \"The norm of the resolvent at infinity\", \"The diameter of the numerical range\"]',0,102),(682,1,'A necessary condition for an operator to have a real spectrum is that it is:','[\"Self-adjoint\", \"Compact\", \"Unitary\", \"Bounded below\"]',0,103),(683,2,'The spectral theorem for a bounded self-adjoint operator A implies it is unitarily equivalent to:','[\"A multiplication operator on an L^2 space\", \"A diagonal matrix\", \"A finite-rank operator\", \"The identity operator\"]',0,103),(684,1,'For an unbounded operator, the domain is typically:','[\"A dense subspace of the Hilbert space\", \"The entire Hilbert space\", \"A closed subspace\", \"A finite-dimensional space\"]',0,104),(685,2,'The Cayley transform is used in the spectral theory of unbounded operators to relate them to:','[\"Unitary operators\", \"Compact operators\", \"Nilpotent operators\", \"Projection operators\"]',0,104),(686,1,'The polar decomposition of an operator T expresses it as the product of a partial isometry and:','[\"The positive operator |T| = (T*T)^(1/2)\", \"Its adjoint T*\", \"A compact operator\", \"A diagonal operator\"]',0,105),(687,2,'The singular value decomposition is most directly applicable to which class of operators?','[\"Compact operators\", \"Unbounded operators\", \"Every bounded operator\", \"Only self-adjoint operators\"]',0,105);
/*!40000 ALTER TABLE `questions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quizzes`
--

DROP TABLE IF EXISTS `quizzes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `quizzes` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `quiz_name` varchar(255) NOT NULL,
  `scope` enum('course','chapter','content') NOT NULL,
  `scope_id` int unsigned NOT NULL,
  `time_limit` int unsigned DEFAULT NULL,
  `date_creation` datetime DEFAULT CURRENT_TIMESTAMP,
  `date_update` datetime DEFAULT CURRENT_TIMESTAMP,
  `sequence` int NOT NULL DEFAULT '1',
  `is_visible` bit(1) NOT NULL DEFAULT b'1',
  PRIMARY KEY (`id`),
  KEY `ix_quiz_scope_scopeid` (`scope`,`scope_id`)
) ENGINE=InnoDB AUTO_INCREMENT=106 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quizzes`
--

LOCK TABLES `quizzes` WRITE;
/*!40000 ALTER TABLE `quizzes` DISABLE KEYS */;
INSERT INTO `quizzes` VALUES (1,'Quiz - Introduction à l\'Intelligence Artificielle','course',1,90,'2025-11-25 22:50:17','2025-11-25 22:50:17',1,_binary ''),(2,'Quiz - Machine Learning : notions et algorithmes','course',2,90,'2025-11-25 22:50:17','2025-11-25 22:50:17',1,_binary ''),(3,'Quiz - Deep Learning pour vision par ordinateur','course',3,90,'2025-11-25 22:50:17','2025-11-25 22:50:17',1,_binary ''),(4,'Quiz - NLP : traitement du langage naturel','course',4,90,'2025-11-25 22:50:17','2025-11-25 22:50:17',1,_binary ''),(5,'Quiz - Apprentissage non supervisé et clustering','course',5,90,'2025-11-25 22:50:17','2025-11-25 22:50:17',1,_binary ''),(6,'Quiz - Modèles probabilistes et bayésiens','course',6,90,'2025-11-25 22:50:17','2025-11-25 22:50:17',1,_binary ''),(7,'Quiz - MLOps : mise en production de modèles','course',7,90,'2025-11-25 22:50:17','2025-11-25 22:50:17',1,_binary ''),(8,'Quiz - Éthique et IA responsable','course',8,90,'2025-11-25 22:50:17','2025-11-25 22:50:17',1,_binary ''),(9,'Quiz - Apprentissage par renforcement','course',9,90,'2025-11-25 22:50:17','2025-11-25 22:50:17',1,_binary ''),(10,'Quiz - Feature Engineering avancé','course',10,90,'2025-11-25 22:50:17','2025-11-25 22:50:17',1,_binary ''),(11,'Quiz - Computer Vision avancé : détection et segmentation','course',11,90,'2025-11-25 22:50:17','2025-11-25 22:50:17',1,_binary ''),(12,'Quiz - Time Series & Forecasting','course',12,90,'2025-11-25 22:50:17','2025-11-25 22:50:17',1,_binary ''),(13,'Quiz - AutoML et optimisation d\'hyperparamètres','course',13,90,'2025-11-25 22:50:17','2025-11-25 22:50:17',1,_binary ''),(14,'Quiz - Représentations et embeddings','course',14,90,'2025-11-25 22:50:17','2025-11-25 22:50:17',1,_binary ''),(15,'Quiz - Graph ML : GNN et applications','course',15,90,'2025-11-25 22:50:17','2025-11-25 22:50:17',1,_binary ''),(16,'Quiz - IA et robotique : perception et contrôle','course',16,90,'2025-11-25 22:50:17','2025-11-25 22:50:17',1,_binary ''),(17,'Quiz - Sécurité des modèles ML','course',17,90,'2025-11-25 22:50:17','2025-11-25 22:50:17',1,_binary ''),(18,'Quiz - Pratiques avancées de data labeling','course',18,90,'2025-11-25 22:50:17','2025-11-25 22:50:17',1,_binary ''),(19,'Quiz - IA pour la santé','course',19,90,'2025-11-25 22:50:17','2025-11-25 22:50:17',1,_binary ''),(20,'Quiz - Projet capstone : construire une solution IA complète','course',20,90,'2025-11-25 22:50:17','2025-11-25 22:50:17',1,_binary ''),(32,'Quiz supplémentaire 3 - Introduction à l\'Intelligence Artificielle','course',1,120,'2025-11-25 22:57:13','2025-11-25 22:57:13',13,_binary ''),(33,'Quiz supplémentaire 2 - Introduction à l\'Intelligence Artificielle','course',1,120,'2025-11-25 22:57:13','2025-11-25 22:57:13',12,_binary ''),(34,'Quiz supplémentaire 1 - Introduction à l\'Intelligence Artificielle','course',1,120,'2025-11-25 22:57:13','2025-11-25 22:57:13',11,_binary ''),(35,'Quiz supplémentaire 3 - Machine Learning : notions et algorithmes','course',2,120,'2025-11-25 22:57:13','2025-11-25 22:57:13',2,_binary ''),(38,'Quiz supplémentaire 3 - Deep Learning pour vision par ordinateur','course',3,120,'2025-11-25 22:57:13','2025-11-25 22:57:13',13,_binary ''),(39,'Quiz supplémentaire 2 - Deep Learning pour vision par ordinateur','course',3,120,'2025-11-25 22:57:13','2025-11-25 22:57:13',12,_binary ''),(40,'Quiz supplémentaire 1 - Deep Learning pour vision par ordinateur','course',3,120,'2025-11-25 22:57:13','2025-11-25 22:57:13',11,_binary ''),(41,'Quiz supplémentaire 3 - NLP : traitement du langage naturel','course',4,120,'2025-11-25 22:57:13','2025-11-25 22:57:13',13,_binary ''),(42,'Quiz supplémentaire 2 - NLP : traitement du langage naturel','course',4,120,'2025-11-25 22:57:13','2025-11-25 22:57:13',12,_binary ''),(43,'Quiz supplémentaire 1 - NLP : traitement du langage naturel','course',4,120,'2025-11-25 22:57:13','2025-11-25 22:57:13',11,_binary ''),(44,'Quiz supplémentaire 3 - Apprentissage non supervisé et clustering','course',5,120,'2025-11-25 22:57:13','2025-11-25 22:57:13',13,_binary ''),(45,'Quiz supplémentaire 2 - Apprentissage non supervisé et clustering','course',5,120,'2025-11-25 22:57:13','2025-11-25 22:57:13',12,_binary ''),(46,'Quiz supplémentaire 1 - Apprentissage non supervisé et clustering','course',5,120,'2025-11-25 22:57:13','2025-11-25 22:57:13',11,_binary ''),(47,'Quiz supplémentaire 3 - Modèles probabilistes et bayésiens','course',6,120,'2025-11-25 22:57:13','2025-11-25 22:57:13',13,_binary ''),(48,'Quiz supplémentaire 2 - Modèles probabilistes et bayésiens','course',6,120,'2025-11-25 22:57:13','2025-11-25 22:57:13',12,_binary ''),(49,'Quiz supplémentaire 1 - Modèles probabilistes et bayésiens','course',6,120,'2025-11-25 22:57:13','2025-11-25 22:57:13',11,_binary ''),(50,'Quiz supplémentaire 3 - MLOps : mise en production de modèles','course',7,120,'2025-11-25 22:57:13','2025-11-25 22:57:13',13,_binary ''),(51,'Quiz supplémentaire 2 - MLOps : mise en production de modèles','course',7,120,'2025-11-25 22:57:13','2025-11-25 22:57:13',12,_binary ''),(52,'Quiz supplémentaire 1 - MLOps : mise en production de modèles','course',7,120,'2025-11-25 22:57:13','2025-11-25 22:57:13',11,_binary ''),(53,'Quiz supplémentaire 3 - Éthique et IA responsable','course',8,120,'2025-11-25 22:57:13','2025-11-25 22:57:13',13,_binary ''),(54,'Quiz supplémentaire 2 - Éthique et IA responsable','course',8,120,'2025-11-25 22:57:13','2025-11-25 22:57:13',12,_binary ''),(55,'Quiz supplémentaire 1 - Éthique et IA responsable','course',8,120,'2025-11-25 22:57:13','2025-11-25 22:57:13',11,_binary ''),(56,'Quiz supplémentaire 3 - Apprentissage par renforcement','course',9,120,'2025-11-25 22:57:13','2025-11-25 22:57:13',13,_binary ''),(57,'Quiz supplémentaire 2 - Apprentissage par renforcement','course',9,120,'2025-11-25 22:57:13','2025-11-25 22:57:13',12,_binary ''),(58,'Quiz supplémentaire 1 - Apprentissage par renforcement','course',9,120,'2025-11-25 22:57:13','2025-11-25 22:57:13',11,_binary ''),(59,'Quiz supplémentaire 3 - Feature Engineering avancé','course',10,120,'2025-11-25 22:57:13','2025-11-25 22:57:13',13,_binary ''),(60,'Quiz supplémentaire 2 - Feature Engineering avancé','course',10,120,'2025-11-25 22:57:13','2025-11-25 22:57:13',12,_binary ''),(61,'Quiz supplémentaire 1 - Feature Engineering avancé','course',10,120,'2025-11-25 22:57:13','2025-11-25 22:57:13',11,_binary ''),(62,'Quiz supplémentaire 3 - Computer Vision avancé : détection et segmentation','course',11,120,'2025-11-25 22:57:13','2025-11-25 22:57:13',13,_binary ''),(63,'Quiz supplémentaire 2 - Computer Vision avancé : détection et segmentation','course',11,120,'2025-11-25 22:57:13','2025-11-25 22:57:13',12,_binary ''),(64,'Quiz supplémentaire 1 - Computer Vision avancé : détection et segmentation','course',11,120,'2025-11-25 22:57:13','2025-11-25 22:57:13',11,_binary ''),(65,'Quiz supplémentaire 3 - Time Series & Forecasting','course',12,120,'2025-11-25 22:57:13','2025-11-25 22:57:13',13,_binary ''),(66,'Quiz supplémentaire 2 - Time Series & Forecasting','course',12,120,'2025-11-25 22:57:13','2025-11-25 22:57:13',12,_binary ''),(67,'Quiz supplémentaire 1 - Time Series & Forecasting','course',12,120,'2025-11-25 22:57:13','2025-11-25 22:57:13',11,_binary ''),(68,'Quiz supplémentaire 3 - AutoML et optimisation d\'hyperparamètres','course',13,120,'2025-11-25 22:57:13','2025-11-25 22:57:13',13,_binary ''),(69,'Quiz supplémentaire 2 - AutoML et optimisation d\'hyperparamètres','course',13,120,'2025-11-25 22:57:13','2025-11-25 22:57:13',12,_binary ''),(70,'Quiz supplémentaire 1 - AutoML et optimisation d\'hyperparamètres','course',13,120,'2025-11-25 22:57:13','2025-11-25 22:57:13',11,_binary ''),(71,'Quiz supplémentaire 3 - Représentations et embeddings','course',14,120,'2025-11-25 22:57:13','2025-11-25 22:57:13',13,_binary ''),(72,'Quiz supplémentaire 2 - Représentations et embeddings','course',14,120,'2025-11-25 22:57:13','2025-11-25 22:57:13',12,_binary ''),(73,'Quiz supplémentaire 1 - Représentations et embeddings','course',14,120,'2025-11-25 22:57:13','2025-11-25 22:57:13',11,_binary ''),(74,'Quiz supplémentaire 3 - Graph ML : GNN et applications','course',15,120,'2025-11-25 22:57:13','2025-11-25 22:57:13',13,_binary ''),(75,'Quiz supplémentaire 2 - Graph ML : GNN et applications','course',15,120,'2025-11-25 22:57:13','2025-11-25 22:57:13',12,_binary ''),(76,'Quiz supplémentaire 1 - Graph ML : GNN et applications','course',15,120,'2025-11-25 22:57:13','2025-11-25 22:57:13',11,_binary ''),(77,'Quiz supplémentaire 3 - IA et robotique : perception et contrôle','course',16,120,'2025-11-25 22:57:13','2025-11-25 22:57:13',13,_binary ''),(78,'Quiz supplémentaire 2 - IA et robotique : perception et contrôle','course',16,120,'2025-11-25 22:57:13','2025-11-25 22:57:13',12,_binary ''),(79,'Quiz supplémentaire 1 - IA et robotique : perception et contrôle','course',16,120,'2025-11-25 22:57:13','2025-11-25 22:57:13',11,_binary ''),(80,'Quiz supplémentaire 3 - Sécurité des modèles ML','course',17,120,'2025-11-25 22:57:13','2025-11-25 22:57:13',13,_binary ''),(81,'Quiz supplémentaire 2 - Sécurité des modèles ML','course',17,120,'2025-11-25 22:57:13','2025-11-25 22:57:13',12,_binary ''),(82,'Quiz supplémentaire 1 - Sécurité des modèles ML','course',17,120,'2025-11-25 22:57:13','2025-11-25 22:57:13',11,_binary ''),(83,'Quiz supplémentaire 3 - Pratiques avancées de data labeling','course',18,120,'2025-11-25 22:57:13','2025-11-25 22:57:13',13,_binary ''),(84,'Quiz supplémentaire 2 - Pratiques avancées de data labeling','course',18,120,'2025-11-25 22:57:13','2025-11-25 22:57:13',12,_binary ''),(85,'Quiz supplémentaire 1 - Pratiques avancées de data labeling','course',18,120,'2025-11-25 22:57:13','2025-11-25 22:57:13',11,_binary ''),(86,'Quiz supplémentaire 3 - IA pour la santé','course',19,120,'2025-11-25 22:57:13','2025-11-25 22:57:13',13,_binary ''),(87,'Quiz supplémentaire 2 - IA pour la santé','course',19,120,'2025-11-25 22:57:13','2025-11-25 22:57:13',12,_binary ''),(88,'Quiz supplémentaire 1 - IA pour la santé','course',19,120,'2025-11-25 22:57:13','2025-11-25 22:57:13',11,_binary ''),(89,'Quiz supplémentaire 3 - Projet capstone : construire une solution IA complète','course',20,120,'2025-11-25 22:57:13','2025-11-25 22:57:13',13,_binary ''),(90,'Quiz supplémentaire 2 - Projet capstone : construire une solution IA complète','course',20,120,'2025-11-25 22:57:13','2025-11-25 22:57:13',12,_binary ''),(91,'Quiz supplémentaire 1 - Projet capstone : construire une solution IA complète','course',20,120,'2025-11-25 22:57:13','2025-11-25 22:57:13',11,_binary ''),(92,'Quiz spectre fondamental','course',24,15,'2025-12-11 17:07:30','2025-12-11 17:07:30',1,_binary ''),(93,'Quiz décomposition auto-adjointe','course',24,20,'2025-12-11 17:07:30','2025-12-11 17:07:30',2,_binary ''),(94,'Quiz opérateurs non bornés','course',24,15,'2025-12-11 17:07:30','2025-12-11 17:07:30',3,_binary ''),(95,'Quiz Module1 : Histoire et Structure','course',25,10,'2025-12-11 17:13:48','2025-12-11 17:13:48',1,_binary ''),(96,'Quiz Module2 : Usage Linguistique','course',25,10,'2025-12-11 17:13:48','2025-12-11 17:13:48',2,_binary ''),(97,'Quiz fondamentaux plateforme test update','course',27,15,'2025-12-11 17:29:43','2025-12-25 13:02:15',1,_binary ''),(99,'Quiz production déploiement','course',27,15,'2025-12-11 17:29:43','2025-12-11 17:29:43',2,_binary ''),(100,'test','course',27,20,'2025-12-25 14:02:35','2025-12-25 13:03:25',3,_binary '\0'),(101,'Fundamentals of Linear Operators','course',32,15,'2025-12-27 23:11:43','2025-12-27 23:11:43',1,_binary ''),(102,'Spectral Theory Basics','course',32,20,'2025-12-27 23:11:43','2025-12-27 23:11:43',2,_binary ''),(103,'Self-Adjoint Operators','course',32,15,'2025-12-27 23:11:43','2025-12-27 23:11:43',3,_binary ''),(104,'Unbounded Operators','course',32,15,'2025-12-27 23:11:43','2025-12-27 23:11:43',4,_binary ''),(105,'Operator Decompositions','course',32,15,'2025-12-27 23:11:43','2025-12-27 23:11:43',5,_binary '');
/*!40000 ALTER TABLE `quizzes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `school`
--

DROP TABLE IF EXISTS `school`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `school` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `address` varchar(1000) DEFAULT NULL,
  `phone_primary` varchar(45) NOT NULL,
  `phone_secondary` varchar(45) DEFAULT NULL,
  `registration_date` datetime NOT NULL,
  `introduction_brief` varchar(1000) DEFAULT NULL,
  `image` varchar(2000) DEFAULT NULL,
  `active_account` bit(1) DEFAULT b'1',
  `country_city_id` int DEFAULT NULL,
  `country_id` int DEFAULT NULL,
  `school_type_id` int NOT NULL,
  `package_id` int DEFAULT NULL,
  `renewal_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `school_school_type_FK` (`school_type_id`),
  KEY `school_package_FK` (`package_id`),
  CONSTRAINT `school_package_FK` FOREIGN KEY (`package_id`) REFERENCES `package` (`id`),
  CONSTRAINT `school_school_type_FK` FOREIGN KEY (`school_type_id`) REFERENCES `school_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `school`
--

LOCK TABLES `school` WRITE;
/*!40000 ALTER TABLE `school` DISABLE KEYS */;
INSERT INTO `school` VALUES (1,'High Smart Education','school@smart.edu','12345678',NULL,'+212661374512',NULL,'2025-11-25 21:40:05',NULL,NULL,_binary '',NULL,116,2,5,'2026-11-27 00:00:00');
/*!40000 ALTER TABLE `school` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `school_calendar`
--

DROP TABLE IF EXISTS `school_calendar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `school_calendar` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `school_id` int NOT NULL,
  `title` varchar(100) NOT NULL,
  `start` datetime NOT NULL,
  `end` datetime DEFAULT NULL,
  `allDay` bit(1) NOT NULL DEFAULT b'0',
  `backgroundColor` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `school_calendar_fk_idx` (`school_id`),
  CONSTRAINT `school_calendar_fk` FOREIGN KEY (`school_id`) REFERENCES `school` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `school_calendar`
--

LOCK TABLES `school_calendar` WRITE;
/*!40000 ALTER TABLE `school_calendar` DISABLE KEYS */;
/*!40000 ALTER TABLE `school_calendar` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `school_payment_invoice_view`
--

DROP TABLE IF EXISTS `school_payment_invoice_view`;
/*!50001 DROP VIEW IF EXISTS `school_payment_invoice_view`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `school_payment_invoice_view` AS SELECT 
 1 AS `package_name`,
 1 AS `price_per_student`,
 1 AS `id`,
 1 AS `school_id`,
 1 AS `package_id`,
 1 AS `number_of_students`,
 1 AS `number_of_months`,
 1 AS `amount_paid_reel`,
 1 AS `amount_paid_global`,
 1 AS `payment_method`,
 1 AS `discount_percentage`,
 1 AS `payment_date`,
 1 AS `renewal_date`,
 1 AS `payment_status`,
 1 AS `transaction_reference`,
 1 AS `date_insert`,
 1 AS `complete_name`,
 1 AS `user_email`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `school_payment_view`
--

DROP TABLE IF EXISTS `school_payment_view`;
/*!50001 DROP VIEW IF EXISTS `school_payment_view`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `school_payment_view` AS SELECT 
 1 AS `package_name`,
 1 AS `id`,
 1 AS `school_id`,
 1 AS `package_id`,
 1 AS `number_of_students`,
 1 AS `number_of_months`,
 1 AS `amount_paid_reel`,
 1 AS `amount_paid_global`,
 1 AS `payment_method`,
 1 AS `discount_percentage`,
 1 AS `payment_date`,
 1 AS `renewal_date`,
 1 AS `payment_status`,
 1 AS `transaction_reference`,
 1 AS `date_insert`,
 1 AS `last_payment`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `school_profile`
--

DROP TABLE IF EXISTS `school_profile`;
/*!50001 DROP VIEW IF EXISTS `school_profile`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `school_profile` AS SELECT 
 1 AS `id`,
 1 AS `name`,
 1 AS `email`,
 1 AS `password`,
 1 AS `address`,
 1 AS `phone_primary`,
 1 AS `phone_secondary`,
 1 AS `registration_date`,
 1 AS `active_account`,
 1 AS `image`,
 1 AS `country_id`,
 1 AS `introduction_brief`,
 1 AS `country_city_id`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `school_qualification`
--

DROP TABLE IF EXISTS `school_qualification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `school_qualification` (
  `id` int NOT NULL AUTO_INCREMENT,
  `qualification_id` int NOT NULL,
  `school_id` int NOT NULL,
  `nbr_class` int NOT NULL DEFAULT '0',
  `classrooms_names` varchar(500) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uc_school_qualification` (`qualification_id`,`school_id`),
  KEY `qualification_school_idx` (`school_id`),
  KEY `school_qualification_qualification_cn_idx` (`qualification_id`),
  CONSTRAINT `school_qualification_cn` FOREIGN KEY (`school_id`) REFERENCES `school` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `school_qualification_qualification_cn` FOREIGN KEY (`qualification_id`) REFERENCES `qualification` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `school_qualification`
--

LOCK TABLES `school_qualification` WRITE;
/*!40000 ALTER TABLE `school_qualification` DISABLE KEYS */;
INSERT INTO `school_qualification` VALUES (1,1,1,2,'G1,G2'),(2,2,1,2,'mm,mmmm');
/*!40000 ALTER TABLE `school_qualification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `school_qualification_view`
--

DROP TABLE IF EXISTS `school_qualification_view`;
/*!50001 DROP VIEW IF EXISTS `school_qualification_view`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `school_qualification_view` AS SELECT 
 1 AS `id`,
 1 AS `code`,
 1 AS `label`,
 1 AS `level`,
 1 AS `education`,
 1 AS `nbr_class`,
 1 AS `classrooms_names`,
 1 AS `school_qualification_id`,
 1 AS `qualification_id`,
 1 AS `school_id`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `school_subject`
--

DROP TABLE IF EXISTS `school_subject`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `school_subject` (
  `id` int NOT NULL AUTO_INCREMENT,
  `subject_id` int NOT NULL,
  `qualification_id` int NOT NULL,
  `school_id` int NOT NULL,
  PRIMARY KEY (`id`,`school_id`),
  UNIQUE KEY `uc_school_subject` (`subject_id`,`qualification_id`,`school_id`),
  KEY `school_subject_cn_idx` (`school_id`),
  KEY `school_subject_subject_cn_idx` (`subject_id`),
  KEY `school_subject_qualification_cn_idx` (`qualification_id`),
  CONSTRAINT `school_subject_cn` FOREIGN KEY (`school_id`) REFERENCES `school` (`id`),
  CONSTRAINT `school_subject_qualification_cn` FOREIGN KEY (`qualification_id`) REFERENCES `qualification` (`id`),
  CONSTRAINT `school_subject_subject_cn` FOREIGN KEY (`subject_id`) REFERENCES `subject` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `school_subject`
--

LOCK TABLES `school_subject` WRITE;
/*!40000 ALTER TABLE `school_subject` DISABLE KEYS */;
INSERT INTO `school_subject` VALUES (1,1,1,1);
/*!40000 ALTER TABLE `school_subject` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `school_subject_view`
--

DROP TABLE IF EXISTS `school_subject_view`;
/*!50001 DROP VIEW IF EXISTS `school_subject_view`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `school_subject_view` AS SELECT 
 1 AS `id`,
 1 AS `subject_id`,
 1 AS `qualification_id`,
 1 AS `school_id`,
 1 AS `label_subject`,
 1 AS `code`,
 1 AS `label_qualification`,
 1 AS `level`,
 1 AS `education`,
 1 AS `classrooms_names`,
 1 AS `school_qualification_id`,
 1 AS `school_subject_id`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `school_type`
--

DROP TABLE IF EXISTS `school_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `school_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `label_fr` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `label_en` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `label_es` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `school_type`
--

LOCK TABLES `school_type` WRITE;
/*!40000 ALTER TABLE `school_type` DISABLE KEYS */;
INSERT INTO `school_type` VALUES (1,'Écoles primaires','Primary Schools','Escuelas Primarias'),(2,'Écoles secondaires','Secondary Schools','Escuelas Secundarias'),(3,'Écoles professionnelles','Vocational Schools','Escuelas Profesionales'),(4,'Écoles spécialisées','Specialized Schools','Escuelas Especializadas'),(5,'Établissements d\'enseignement supérieur','Higher Education Institutions','Instituciones de Educación Superior'),(6,'Centres de formation professionnelle','Professional Training Centers','Centros de Formación Profesional'),(7,'Organisations gouvernementales','Government Organizations','Organizaciones Gubernamentales'),(8,'Organisations non gouvernementales (ONG)','Non-Governmental Organizations (NGOs)','Organizaciones No Gubernamentales (ONGs)'),(9,'Entreprises','Businesses','Empresas'),(10,'Écoles à domicile et parents éducateurs','Homeschools and Parent Educators','Escuelas en Casa y Padres Educadores'),(11,'Enseignant indépendant','Independent teacher','Profesor independiente');
/*!40000 ALTER TABLE `school_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `school_type_qualification`
--

DROP TABLE IF EXISTS `school_type_qualification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `school_type_qualification` (
  `id` int NOT NULL AUTO_INCREMENT,
  `label_fr` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `label_en` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `label_es` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `level_fr` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `level_en` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `level_es` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `school_type_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `school_type_qualification_school_type_FK` (`school_type_id`),
  CONSTRAINT `school_type_qualification_school_type_FK` FOREIGN KEY (`school_type_id`) REFERENCES `school_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `school_type_qualification`
--

LOCK TABLES `school_type_qualification` WRITE;
/*!40000 ALTER TABLE `school_type_qualification` DISABLE KEYS */;
INSERT INTO `school_type_qualification` VALUES (1,'CP','PC','CP','Primaire','Primary','Primaria',1),(2,'CE1','CE1','CE1','Primaire','Primary','Primaria',1),(3,'CE2','CE2','CE2','Primaire','Primary','Primaria',1),(4,'CM1','CM1','CM1','Primaire','Primary','Primaria',1),(5,'CM2','CM2','CM2','Primaire','Primary','Primaria',1),(6,'Sixième Année','Sixth Grade','Sexto Grado','Collège','Middle School','Colegio',2),(7,'Cinquième Année','Fifth Grade','Quinto Grado','Collège','Middle School','Colegio',2),(8,'Quatrième Année','Fourth Grade','Cuarto Grado','Collège','Middle School','Colegio',2),(9,'Troisième Année','Third Grade','Tercer Grado','Collège','Middle School','Colegio',2),(10,'Tronc Commun','Common Core','Tronco Común','Lycée','High School','Instituto',2),(11,'Première Année Baccalauréat','First Year of Baccalaureate','Primer Año de Bachillerato','Lycée','High School','Instituto',2),(12,'Deuxième Année Baccalauréat','Second Year of Baccalaureate','Segundo Año de Bachillerato','Lycée','High School','Instituto',2),(13,'CAP (Certificat d’Aptitude Professionnelle)','CAP (Vocational Aptitude Certificate)','CAP (Certificado de Aptitud Profesional)','École Professionnelle','Professional School','Escuela Profesional',3),(14,'BEP (Brevet d’Études Professionnelles)','BEP (Vocational Studies Certificate)','BEP (Brevet de Estudios Profesionales)','École Professionnelle','Professional School','Escuela Profesional',3),(15,'BTS (Brevet de Technicien Supérieur)','BTS (Higher Technician Certificate)','BTS (Brevet de Técnico Superior)','École Professionnelle','Professional School','Escuela Profesional',3),(16,'Informatique','Computer Science','Informática','École Spécialisée','Specialized School','Escuela Especializada',4),(17,'Design graphique','Graphic Design','Diseño gráfico','École Spécialisée','Specialized School','Escuela Especializada',4),(18,'Arts culinaires','Culinary Arts','Artes culinarias','École Spécialisée','Specialized School','Escuela Especializada',4),(19,'Mécanique automobile','Automotive Mechanics','Mecánica automotriz','École Spécialisée','Specialized School','Escuela Especializada',4),(20,'Université','University','Universidad','Enseignement Supérieur','Higher Education','Educación Superior',5),(21,'Grande école','Graduate School','Escuela de Posgrado','Enseignement Supérieur','Higher Education','Educación Superior',5),(22,'Institut universitaire de technologie (IUT)','University Institute of Technology','Instituto Universitario de Tecnología','Enseignement Supérieur','Higher Education','Educación Superior',5),(23,'École d\'ingénieurs','Engineering School','Escuela de Ingeniería','Enseignement Supérieur','Higher Education','Educación Superior',5),(24,'Ministère de l\' Éducation','Ministry of Education','Ministerio de Educación','Organisation Gouvernementale','Government Organization','Organización Gubernamental',7),(25,'Conseil de l\'Éducation','Education Council','Consejo de Educación','Organisation Gouvernementale','Government Organization','Organización Gubernamental',7),(26,'Inspection de l\' Éducation','Education Inspection','Inspección de Educación','Organisation Gouvernementale','Government Organization','Organización Gubernamental',7),(27,'Association éducative','Educational Association','Asociación Educativa','Organisation Non Gouvernementale','Non-Governmental Organization','Organización No Gubernamental',8),(28,'Fondation pour l\' éducation','Education Foundation',' Fundación para la Educación','Organisation Non Gouvernementale',' Non-Governmental Organization','Organización no Gubernamental',8),(29,'ONG pour l\'enseignement','NGO for Education','ONG para la Educación','Organisation Non Gouvernementale','Non-Governmental Organization','Organización No Gubernamental',8),(30,'Entreprise de formation','Training Company','Empresa de Formación','Entreprise','Company','Empresa',9),(31,'Entreprise de technologie éducative','Educational Technology Company','Empresa de Tecnología Educativa','Entreprise','Company','Empresa',9),(32,'Entreprise de consultation en éducation','Education Consulting Company','Empresa de Consultoría Educativa','Entreprise','Company','Empresa',9),(33,'Centre de formation professionnelle','Vocational Training Center','Centro de Formación Profesional','Centre de Formation Professionnelle','Vocational Training Center','Centro de Formación Profesional',6),(34,'Centre de développement des compétences','Skills Development Center','Centro de Desarrollo de Habilidades','Centre de Formation Professionnelle','Vocational Training Center','Centro de Formación Profesional',6),(35,'Centre de formation continue','Continuing Education Center','Centro de Formación Continua','Centre de Formation Professionnelle','Vocational Training Center','Centro de Formación Profesional',6),(36,'Formations diverses','Various Training Programs','Programas de Formación Variados','Divers','Various','Varios',11);
/*!40000 ALTER TABLE `school_type_qualification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `school_type_qualification_view`
--

DROP TABLE IF EXISTS `school_type_qualification_view`;
/*!50001 DROP VIEW IF EXISTS `school_type_qualification_view`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `school_type_qualification_view` AS SELECT 
 1 AS `id`,
 1 AS `label_fr`,
 1 AS `label_en`,
 1 AS `label_es`,
 1 AS `level_fr`,
 1 AS `level_en`,
 1 AS `level_es`,
 1 AS `school_type_id`,
 1 AS `school_type_fr`,
 1 AS `school_type_en`,
 1 AS `school_type_es`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `school_type_subject`
--

DROP TABLE IF EXISTS `school_type_subject`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `school_type_subject` (
  `id` int NOT NULL AUTO_INCREMENT,
  `school_type_id` int NOT NULL,
  `label_fr` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `label_en` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `label_es` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `school_type_id` (`school_type_id`),
  CONSTRAINT `school_type_subject_ibfk_1` FOREIGN KEY (`school_type_id`) REFERENCES `school_type_qualification` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=456 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `school_type_subject`
--

LOCK TABLES `school_type_subject` WRITE;
/*!40000 ALTER TABLE `school_type_subject` DISABLE KEYS */;
INSERT INTO `school_type_subject` VALUES (57,3,'Technologie de l\'information','Information Technology','Tecnología de la Información'),(58,3,'Génie mécanique','Mechanical Engineering','Ingeniería Mecánica'),(59,3,'Design graphique','Graphic Design','Diseño Gráfico'),(60,3,'Cuisine et pâtisserie','Culinary Arts and Pastry','Artes Culinarias y Repostería'),(61,3,'Gestion hôtelière','Hotel Management','Gestión Hotelera'),(62,3,'Développement web','Web Development','Desarrollo Web'),(63,3,'Électricité','Electricity','Electricidad'),(64,3,'Plomberie','Plumbing','Fontanería'),(65,3,'Menuiserie','Carpentry','Carpintería'),(66,3,'Soudage','Welding','Soldadura'),(67,3,'Soins infirmiers','Nursing','Enfermería'),(68,3,'Comptabilité','Accounting','Contabilidad'),(69,3,'Finance','Finance','Finanzas'),(70,3,'Ressources humaines','Human Resources','Recursos Humanos'),(71,3,'Marketing','Marketing','Marketing'),(72,3,'Vente au détail','Retail Sales','Ventas al Por Menor'),(73,3,'Service à la clientèle','Customer Service','Servicio al Cliente'),(74,3,'Administration des affaires','Business Administration','Administración de Empresas'),(75,3,'Droit des affaires','Business Law','Derecho Comercial'),(76,3,'Gestion de projet','Project Management','Gestión de Proyectos'),(77,3,'Communication d\'entreprise','Corporate Communication','Comunicación Empresarial'),(78,3,'Marketing numérique','Digital Marketing','Marketing Digital'),(79,3,'Logistique et chaîne d\'approvisionnement','Logistics and Supply Chain Management','Logística y Gestión de la Cadena de Suministro'),(80,3,'Gestion de la qualité','Quality Management','Gestión de la Calidad'),(81,4,'Musique','Music','Música'),(82,4,'Arts visuels','Visual Arts','Artes Visuales'),(83,4,'Danse','Dance','Danza'),(84,4,'Théâtre','Theatre','Teatro'),(85,4,'Photographie','Photography','Fotografía'),(86,4,'Cinéma','Film Studies','Cine'),(87,4,'Architecture','Architecture','Arquitectura'),(88,4,'Design de mode','Fashion Design','Diseño de Moda'),(89,4,'Design d\'intérieur','Interior Design','Diseño de Interiores'),(90,4,'Design industriel','Industrial Design','Diseño Industrial'),(91,4,'Arts du spectacle','Performing Arts','Artes Escénicas'),(92,4,'Arts plastiques','Fine Arts','Bellas Artes'),(93,4,'Arts numériques','Digital Arts','Artes Digitales'),(94,4,'Graphisme','Graphic Design','Diseño Gráfico'),(95,4,'Animation','Animation','Animación'),(96,4,'Effets spéciaux','Special Effects','Efectos Especiales'),(97,4,'Sculpture','Sculpture','Escultura'),(98,4,'Céramique','Ceramics','Cerámica'),(99,4,'Arts du spectacle','Performing Arts','Artes Escénicas'),(100,4,'Arts culinaires','Culinary Arts','Artes Culinarias'),(101,4,'Oenologie','Wine Studies','Enología'),(102,4,'Pâtisserie','Pastry Arts','Repostería'),(103,4,'Coiffure','Hairstyling','Peluquería'),(104,4,'Maquillage artistique','Makeup Artistry','Maquillaje Artístico'),(105,5,'Sciences informatiques','Computer Science','Ciencias de la Computación'),(106,5,'Ingénierie électrique','Electrical Engineering','Ingeniería Eléctrica'),(107,5,'Ingénierie mécanique','Mechanical Engineering','Ingeniería Mecánica'),(108,5,'Génie civil','Civil Engineering','Ingeniería Civil'),(109,5,'Sciences de l\'environnement','Environmental Sciences','Ciencias Ambientales'),(110,5,'Biologie','Biology','Biología'),(111,5,'Chimie','Chemistry','Química'),(112,5,'Physique','Physics','Física'),(113,5,'Mathématiques','Mathematics','Matemáticas'),(114,5,'Économie','Economics','Economía'),(115,5,'Affaires internationales','International Affairs','Asuntos Internacionales'),(116,5,'Droit','Law','Derecho'),(117,5,'Sciences politiques','Political Science','Ciencia Política'),(118,5,'Psychologie','Psychology','Psicología'),(119,5,'Sociologie','Sociology','Sociología'),(120,5,'Histoire','History','Historia'),(121,5,'Géographie','Geography','Geografía'),(122,5,'Philosophie','Philosophy','Filosofía'),(123,5,'Linguistique','Linguistics','Lingüística'),(124,5,'Langues étrangères','Foreign Languages','Idiomas Extranjeros'),(125,5,'Littérature','Literature','Literatura'),(126,5,'Anthropologie','Anthropology','Antropología'),(127,5,'Archéologie','Archaeology','Arqueología'),(128,5,'Arts visuels','Visual Arts','Artes Visuales'),(129,5,'Musique','Music','Música'),(130,5,'Théâtre','Theatre','Teatro'),(131,5,'Cinéma','Film Studies','Cine'),(132,5,'Journalisme','Journalism','Periodismo'),(133,5,'Communication','Communication','Comunicación'),(134,5,'Marketing','Marketing','Marketing'),(135,5,'Gestion','Management','Gestión'),(136,5,'Comptabilité','Accounting','Contabilidad'),(137,5,'Finance','Finance','Finanzas'),(138,5,'Ressources humaines','Human Resources','Recursos Humanos'),(139,5,'Gestion de projet','Project Management','Gestión de Proyectos'),(140,5,'Informatique','Computer Science','Informática'),(141,5,'Développement de logiciels','Software Development','Desarrollo de Software'),(142,5,'Sécurité informatique','Cybersecurity','Seguridad Informática'),(143,5,'Intelligence artificielle','Artificial Intelligence','Inteligencia Artificial'),(144,5,'Science des données','Data Science','Ciencia de Datos'),(145,5,'Génie logiciel','Software Engineering','Ingeniería de Software'),(146,5,'Réseaux informatiques','Computer Networks','Redes Informáticas'),(147,5,'Web Design','Web Design','Diseño Web'),(148,5,'Développement Web','Web Development','Desarrollo Web'),(149,5,'Conception de jeux vidéo','Video Game Design','Diseño de Videojuegos'),(150,5,'Animation','Animation','Animación'),(151,6,'Informatique','Computer Science','Informática'),(152,6,'Développement Web','Web Development','Desarrollo Web'),(153,6,'Design graphique','Graphic Design','Diseño Gráfico'),(154,6,'Marketing numérique','Digital Marketing','Marketing Digital'),(155,6,'Gestion d\'entreprise','Business Management','Gestión Empresarial'),(156,6,'Comptabilité','Accounting','Contabilidad'),(157,6,'Finance','Finance','Finanzas'),(158,6,'Ressources humaines','Human Resources','Recursos Humanos'),(159,6,'Gestion de projet','Project Management','Gestión de Proyectos'),(160,6,'Vente et négociation','Sales and Negotiation','Ventas y Negociación'),(161,6,'Service à la clientèle','Customer Service','Servicio al Cliente'),(162,6,'Communication interpersonnelle','Interpersonal Communication','Comunicación Interpersonal'),(163,6,'Leadership et management','Leadership and Management','Liderazgo y Gestión'),(164,6,'Compétences en résolution de problèmes','Problem-Solving Skills','Habilidades para Resolver Problemas'),(165,6,'Compétences en prise de décision','Decision-Making Skills','Habilidades para Tomar Decisiones'),(166,6,'Marketing et publicité','Marketing and Advertising','Marketing y Publicidad'),(167,6,'Relations publiques','Public Relations','Relaciones Públicas'),(168,6,'Commerce international','International Business','Negocios Internacionales'),(169,6,'Logistique et chaîne d\'approvisionnement','Logistics and Supply Chain Management','Logística y Gestión de la Cadena de Suministro'),(170,6,'Gestion de la qualité','Quality Management','Gestión de la Calidad'),(171,6,'Gestion de la production','Production Management','Gestión de la Producción'),(172,6,'Santé et sécurité au travail','Occupational Health and Safety','Salud y Seguridad en el Trabajo'),(173,6,'Soins de santé','Healthcare','Cuidado de la Salud'),(174,6,'Soins infirmiers auxiliaires','Nursing Assistant','Auxiliar de Enfermería'),(175,6,'Assistance médicale','Medical Assisting','Asistencia Médica'),(176,6,'Technicien en pharmacie','Pharmacy Technician','Técnico de Farmacia'),(177,6,'Assistance dentaire','Dental Assisting','Asistencia Dental'),(178,6,'Aide-vétérinaire','Veterinary Assistant','Auxiliar Veterinario'),(179,6,'Technicien en radiologie','Radiologic Technology','Tecnología Radiológica'),(180,7,'Politique publique','Public Policy','Política Pública'),(181,7,'Administration publique','Public Administration','Administración Pública'),(182,7,'Analyse des politiques','Policy Analysis','Análisis de Políticas'),(183,7,'Gestion publique','Public Management','Gestión Pública'),(184,7,'Droit administratif','Administrative Law','Derecho Administrativo'),(185,7,'Droit constitutionnel','Constitutional Law','Derecho Constitucional'),(186,7,'Droit pénal','Criminal Law','Derecho Penal'),(187,7,'Droit international','International Law','Derecho Internacional'),(188,7,'Droit de l\'environnement','Environmental Law','Derecho Ambiental'),(189,7,'Droit de la santé','Health Law','Derecho de la Salud'),(190,7,'Droit de l\'éducation','Education Law','Derecho de la Educación'),(191,7,'Droit du travail','Labor Law','Derecho Laboral'),(192,7,'Droit des affaires publiques','Public Business Law','Derecho Empresarial Público'),(193,7,'Économie publique','Public Economics','Economía Pública'),(194,7,'Sociologie politique','Political Sociology','Sociología Política'),(195,7,'Psychologie politique','Political Psychology','Psicología Política'),(196,7,'Études de sécurité','Security Studies','Estudios de Seguridad'),(197,7,'Études de développement','Development Studies','Estudios de Desarrollo'),(198,7,'Diplomatie','Diplomacy','Diplomacia'),(199,7,'Relations internationales','International Relations','Relaciones Internacionales'),(200,7,'Droits de l\'homme','Human Rights','Derechos Humanos'),(201,7,'Gouvernance démocratique','Democratic Governance','Gobernanza Democrática'),(202,7,'Gestion des catastrophes','Disaster Management','Gestión de Desastres'),(203,7,'Gestion de crise','Crisis Management','Gestión de Crisis'),(204,7,'Planification urbaine','Urban Planning','Planificación Urbana'),(205,7,'Politiques sociales','Social Policies','Políticas Sociales'),(206,8,'Développement communautaire','Community Development','Desarrollo Comunitario'),(207,8,'Aide humanitaire','Humanitarian Aid','Ayuda Humanitaria'),(208,8,'Droit international humanitaire','International Humanitarian Law','Derecho Humanitario Internacional'),(209,8,'Santé publique','Public Health','Salud Pública'),(210,8,'Éducation internationale','International Education','Educación Internacional'),(211,8,'Développement international','International Development','Desarrollo Internacional'),(212,8,'Environnement et durabilité','Environment and Sustainability','Medio Ambiente y Sostenibilidad'),(213,8,'Droits de l\'enfant','Children\'s Rights','Derechos del Niño'),(214,8,'Droits de la femme','Women\'s Rights','Derechos de la Mujer'),(215,8,'Droits de l\'homme','Human Rights','Derechos Humanos'),(216,8,'Lutte contre la pauvreté','Poverty Alleviation','Lucha contra la Pobreza'),(218,8,'Justice sociale','Social Justice','Justicia Social'),(219,8,'Diversité et inclusion','Diversity and Inclusion','Diversidad e Inclusión'),(220,8,'Paix et résolution des conflits','Peacebuilding and Conflict Resolution','Construcción de Paz y Resolución de Conflictos'),(221,8,'Gestion des catastrophes','Disaster Management','Gestión de Desastres'),(222,8,'Coopération internationale','International Cooperation','Cooperación Internacional'),(223,8,'Médiation et négociation','Mediation and Negotiation','Mediación y Negociación'),(224,8,'Éducation aux droits de l\'homme','Human Rights Education','Educación en Derechos Humanos'),(225,8,'Éducation à la paix','Peace Education','Educación para la Paz'),(226,8,'Éducation aux réfugiés','Refugee Education','Educación para Refugiados'),(227,8,'Sensibilisation à l\'environnement','Environmental Awareness','Conciencia Ambiental'),(228,8,'Autonomisation des jeunes','Youth Empowerment','Empoderamiento Juvenil'),(229,8,'Soutien aux personnes handicapées','Support for People with Disabilities','Apoyo a Personas con Discapacidad'),(230,8,'Protection des animaux','Animal Protection','Protección Animal'),(231,9,'Gestion d\'entreprise','Business Management','Gestión Empresarial'),(232,9,'Stratégie d\'entreprise','Business Strategy','Estrategia Empresarial'),(233,9,'Finance d\'entreprise','Corporate Finance','Finanzas Corporativas'),(234,9,'Comptabilité et finance','Accounting and Finance','Contabilidad y Finanzas'),(235,9,'Ressources humaines','Human Resources','Recursos Humanos'),(236,9,'Gestion de projet','Project Management','Gestión de Proyectos'),(237,9,'Marketing et publicité','Marketing and Advertising','Marketing y Publicidad'),(238,9,'Commerce international','International Business','Negocios Internacionales'),(239,9,'Logistique et chaîne d\'approvisionnement','Logistics and Supply Chain Management','Logística y Gestión de la Cadena de Suministro'),(240,9,'Gestion de la qualité','Quality Management','Gestión de la Calidad'),(241,9,'Gestion des opérations','Operations Management','Gestión de Operaciones'),(242,9,'Gestion de la chaîne d\'approvisionnement','Supply Chain Management','Gestión de la Cadena de Suministro'),(243,9,'Gestion de la production','Production Management','Gestión de la Producción'),(244,9,'Gestion des stocks','Inventory Management','Gestión de Inventario'),(245,9,'Gestion des achats','Purchasing Management','Gestión de Compras'),(246,9,'Gestion des ventes','Sales Management','Gestión de Ventas'),(247,9,'Gestion des clients','Customer Management','Gestión de Clientes'),(248,9,'Gestion des fournisseurs','Supplier Management','Gestión de Proveedores'),(249,9,'Gestion des ressources','Resource Management','Gestión de Recursos'),(250,9,'Gestion de l\'innovation','Innovation Management','Gestión de Innovación'),(251,9,'Gestion de la technologie','Technology Management','Gestión de Tecnología'),(252,9,'Analyse des données','Data Analysis','Análisis de Datos'),(253,9,'Business Intelligence','Business Intelligence','Inteligencia de Negocios'),(254,9,'Analyse de marché','Market Analysis','Análisis de Mercado'),(255,9,'Analyse concurrentielle','Competitive Analysis','Análisis Competitivo'),(256,9,'Étude de faisabilité','Feasibility Study','Estudio de Viabilidad'),(257,9,'Évaluation des investissements','Investment Evaluation','Evaluación de Inversiones'),(258,9,'Évaluation des risques','Risk Assessment','Evaluación de Riesgos'),(259,9,'Planification stratégique','Strategic Planning','Planificación Estratégica'),(260,10,'Langue et littérature','Language and Literature','Lengua y Literatura'),(261,10,'Mathématiques','Mathematics','Matemáticas'),(262,10,'Sciences','Science','Ciencias'),(263,10,'Histoire et géographie','History and Geography','Historia y Geografía'),(264,10,'Éducation artistique','Art Education','Educación Artística'),(265,10,'Éducation physique et santé','Physical Education and Health','Educación Física y Salud'),(266,10,'Éducation morale et civique','Moral and Civic Education','Educación Moral y Cívica'),(267,10,'Langue seconde','Second Language','Segunda Lengua'),(268,10,'Éducation religieuse','Religious Education','Educación Religiosa'),(269,10,'Éducation à la famille et à la vie','Family and Life Education','Educación Familiar y para la Vida'),(270,10,'Éducation environnementale','Environmental Education','Educación Ambiental'),(271,10,'Éducation aux médias','Media Education','Educación Mediática'),(272,10,'Éducation financière','Financial Education','Educación Financiera'),(273,10,'Éducation aux droits de l\'homme','Human Rights Education','Educación en Derechos Humanos'),(274,10,'Éducation à la citoyenneté','Citizenship Education','Educación Ciudadana'),(275,10,'Éducation à la paix','Peace Education','Educación para la Paz'),(276,10,'Éducation aux valeurs','Values Education','Educación en Valores'),(277,10,'Éducation aux compétences de vie','Life Skills Education','Educación en Habilidades para la Vida'),(278,10,'Éducation aux compétences sociales','Social Skills Education','Educación en Habilidades Sociales'),(279,10,'Éducation aux compétences émotionnelles','Emotional Skills Education','Educación en Habilidades Emocionales'),(280,10,'Éducation aux compétences cognitives','Cognitive Skills Education','Educación en Habilidades Cognitivas'),(281,11,'Développement personnel','Personal Development','Desarrollo Personal'),(282,11,'Communication efficace','Effective Communication','Comunicación Efectiva'),(283,11,'Gestion du temps','Time Management','Gestión del Tiempo'),(284,11,'Leadership et motivation','Leadership and Motivation','Liderazgo y Motivación'),(285,11,'Gestion du stress','Stress Management','Gestión del Estrés'),(286,11,'Créativité et innovation','Creativity and Innovation','Creatividad e Innovación'),(287,11,'Pensée critique','Critical Thinking','Pensamiento Crítico'),(288,11,'Résolution de problèmes','Problem Solving','Resolución de Problemas'),(289,11,'Prise de décision','Decision Making','Toma de Decisiones'),(290,11,'Intelligence émotionnelle','Emotional Intelligence','Inteligencia Emocional'),(291,11,'Confiance en soi','Self-Confidence','Autoconfianza'),(292,11,'Estime de soi','Self-Esteem','Autoestima'),(293,11,'Équilibre travail-vie personnelle','Work-Life Balance','Equilibrio entre Trabajo y Vida Personal'),(294,11,'Développement des compétences interpersonnelles','Interpersonal Skills Development','Desarrollo de Habilidades Interpersonales'),(295,11,'Formation en techniques de présentation','Presentation Skills Training','Formación en Técnicas de Presentación'),(296,11,'Formation à la négociation','Negotiation Skills Training','Formación en Habilidades de Negociación'),(297,11,'Formation en médiation','Mediation Training','Formación en Mediación'),(298,11,'Formation en coaching','Coaching Training','Formación en Coaching'),(299,11,'Formation à la résolution de conflits','Conflict Resolution Training','Formación en Resolución de Conflictos'),(300,11,'Formation en intelligence artificielle','Artificial Intelligence Training','Formación en Inteligencia Artificial'),(301,11,'Formation en blockchain','Blockchain Training','Formación en Blockchain'),(302,11,'Formation en cybersécurité','Cybersecurity Training','Formación en Ciberseguridad'),(303,11,'Formation en analyse de données','Data Analysis Training','Formación en Análisis de Datos'),(304,11,'Formation en développement web','Web Development Training','Formación en Desarrollo Web'),(305,11,'Formation en marketing digital','Digital Marketing Training','Formación en Marketing Digital'),(306,11,'Formation en gestion de projet','Project Management Training','Formación en Gestión de Proyectos'),(355,2,'Langue Arabe','Arabic Language','Lengua Árabe'),(356,2,'Éducation Islamique','Islamic Education','Educación Islámica'),(357,2,'Histoire - Géographie et Éducation Civique','History - Geography and Civic Education','Historia - Geografía y Educación Cívica'),(358,2,'Français','French','Francés'),(359,2,'Mathématiques','Mathematics','Matemáticas'),(360,2,'Sciences Naturelles','Natural Sciences','Ciencias Naturales'),(361,2,'Sciences Physiques','Physical Sciences','Ciencias Físicas'),(362,2,'Éducation Physique','Physical Education','Educación Física'),(363,2,'Arts Plastiques','Visual Arts','Artes Plásticas'),(364,2,'Culture Féminine ou Initiation à la Technologie','Female Culture or Introduction to Technology','Cultura Femenina o Introducción a la Tecnología'),(365,2,'Éducation Musicale','Music Education','Educación Musical'),(366,2,'Anglais','English','Inglés'),(367,2,'Philosophie','Philosophy','Filosofía'),(368,2,'Économie','Economics','Economía'),(369,2,'Technologie','Technology','Tecnología'),(370,2,'Sciences de la Vie et de la Terre','Life and Earth Sciences','Ciencias de la Vida y de la Tierra'),(371,2,'Physique-Chimie','Physics-Chemistry','Física y Química'),(372,2,'Éducation Civique, Juridique et Sociale','Civic, Legal and Social Education','Educación Cívica, Jurídica y Social'),(373,2,'Économie et Sciences Sociales','Economics and Social Sciences','Economía y Ciencias Sociales'),(374,2,'Langue Vivante 1','First Modern Language','Primera Lengua Moderna'),(375,2,'Langue Vivante 2','Second Modern Language','Segunda Lengua Moderna'),(376,2,'Sciences Politiques','Political Science','Ciencias Políticas'),(377,2,'Informatique','Computer Science','Informática'),(426,1,'Grammaire anglaise, orthographe, compréhension de lecture et écriture','English Grammar, Spelling, Reading Comprehension and Writing','Gramática Inglesa, Ortografía, Comprensión de Lectura y Escritura'),(427,1,'Sciences','Sciences','Ciencias'),(428,1,'Mathématiques','Mathematics','Matemáticas'),(429,1,'Histoire','History','Historia'),(430,1,'Géographie','Geography','Geografía'),(431,1,'Littérature et alphabétisation','Literature and Literacy','Literatura y Alfabetización'),(432,1,'Technologie de l\'information et de la communication (TIC)','Information and Communication Technology (ICT)','Tecnología de la Información y la Comunicación (TIC)'),(433,1,'Musique','Music','Música'),(434,1,'Théâtre','Theatre','Teatro'),(435,1,'Art','Art','Arte'),(436,1,'Éducation personnelle, sociale, sanitaire et économique (EPSHE)','Personal, Social, Health and Economic Education (PSHE)','Educación Personal, Social, Sanitaria y Económica (PSHE)'),(437,1,'Perspectives mondiales','Global Perspectives','Perspectivas Globales'),(438,1,'Éducation physique','Physical Education','Educación Física'),(439,1,'Français','French','Francés'),(440,1,'Sciences de la Vie et de la Terre (SVT)','Life and Earth Sciences','Ciencias de la Vida y de la Tierra'),(441,1,'Physique-Chimie','Physics-Chemistry','Física y Química'),(442,1,'Technologie','Technology','Tecnología'),(443,1,'Langue vivante 1 (anglais, espagnol, allemand, etc.)','First Modern Language (English, Spanish, German, etc.)','Primera Lengua Moderna (inglés, español, alemán, etc.)'),(444,1,'Arts plastiques','Visual Arts','Artes Plásticas'),(445,1,'Éducation musicale','Music Education','Educación Musical'),(446,1,'Éducation civique, juridique et sociale (ECJS)','Civic, Legal and Social Education','Educación Cívica, Jurídica y Social'),(447,16,'Intelligence Artificielle','Artificial Intelligence','Inteligencia Artificial'),(448,20,'Intelligence Artificielle','Artificial Intelligence','Inteligencia Artificial'),(449,21,'Intelligence Artificielle','Artificial Intelligence','Inteligencia Artificial'),(450,23,'Intelligence Artificielle','Artificial Intelligence','Inteligencia Artificial'),(451,24,'Intelligence Artificielle','Artificial Intelligence','Inteligencia Artificial'),(452,36,'Intelligence Artificielle','Artificial Intelligence','Inteligencia Artificial'),(453,35,'Intelligence Artificielle','Artificial Intelligence','Inteligencia Artificial'),(454,33,'Intelligence Artificielle','Artificial Intelligence','Inteligencia Artificial'),(455,31,'Intelligence Artificielle','Artificial Intelligence','Inteligencia Artificial');
/*!40000 ALTER TABLE `school_type_subject` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `school_type_subject_view`
--

DROP TABLE IF EXISTS `school_type_subject_view`;
/*!50001 DROP VIEW IF EXISTS `school_type_subject_view`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `school_type_subject_view` AS SELECT 
 1 AS `id`,
 1 AS `label_fr`,
 1 AS `label_en`,
 1 AS `label_es`,
 1 AS `school_type_id`,
 1 AS `school_type_fr`,
 1 AS `school_type_en`,
 1 AS `school_type_es`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `student`
--

DROP TABLE IF EXISTS `student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student` (
  `id` int NOT NULL AUTO_INCREMENT,
  `school_id` int NOT NULL,
  `school_qualification_id` int NOT NULL,
  `classroom` varchar(45) NOT NULL DEFAULT '',
  `first_name` varchar(100) DEFAULT NULL,
  `last_name` varchar(100) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `date_birth` date DEFAULT NULL,
  `address` varchar(1000) DEFAULT NULL,
  `phone_primary` varchar(45) NOT NULL,
  `phone_secondary` varchar(45) DEFAULT NULL,
  `registration_date` date NOT NULL,
  `image` varchar(2000) DEFAULT NULL,
  `num_of_courses_enrolled` int DEFAULT NULL,
  `num_of_courses_completed` int DEFAULT NULL,
  `active_account` bit(1) DEFAULT b'1',
  `country_city_id` int DEFAULT NULL,
  `country_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_student_school_idx` (`school_id`),
  KEY `fk_student_school_qualification_idx` (`school_qualification_id`),
  CONSTRAINT `fk_student_school` FOREIGN KEY (`school_id`) REFERENCES `school` (`id`),
  CONSTRAINT `fk_student_school_qualification` FOREIGN KEY (`school_qualification_id`) REFERENCES `school_qualification` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student`
--

LOCK TABLES `student` WRITE;
/*!40000 ALTER TABLE `student` DISABLE KEYS */;
INSERT INTO `student` VALUES (1,1,1,'G1','Mehdi','Life','student@smart.edu','12345678','1978-08-07','cabo negro comp collines de cab bloc G aprt G17 Martil','+212650001010','','2025-11-25',NULL,NULL,NULL,_binary '',252,116);
/*!40000 ALTER TABLE `student` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `student_activity`
--

DROP TABLE IF EXISTS `student_activity`;
/*!50001 DROP VIEW IF EXISTS `student_activity`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `student_activity` AS SELECT 
 1 AS `id`,
 1 AS `student_id`,
 1 AS `course_id`,
 1 AS `date_activity`,
 1 AS `activity`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `student_answers`
--

DROP TABLE IF EXISTS `student_answers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student_answers` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `student_id` int NOT NULL,
  `quiz_id` int unsigned NOT NULL,
  `question_id` int unsigned NOT NULL,
  `selected_choice_index` int NOT NULL,
  `begin_timestamp` datetime NOT NULL,
  `end_timestamp` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_answer_once` (`student_id`,`quiz_id`,`question_id`),
  KEY `fk_student_answers_quiz` (`quiz_id`),
  KEY `fk_student_answers_question` (`question_id`),
  CONSTRAINT `fk_student_answers_question` FOREIGN KEY (`question_id`) REFERENCES `questions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_student_answers_quiz` FOREIGN KEY (`quiz_id`) REFERENCES `quizzes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_student_answers_student` FOREIGN KEY (`student_id`) REFERENCES `student` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_answers`
--

LOCK TABLES `student_answers` WRITE;
/*!40000 ALTER TABLE `student_answers` DISABLE KEYS */;
/*!40000 ALTER TABLE `student_answers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `student_calendar_assistance_count_view`
--

DROP TABLE IF EXISTS `student_calendar_assistance_count_view`;
/*!50001 DROP VIEW IF EXISTS `student_calendar_assistance_count_view`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `student_calendar_assistance_count_view` AS SELECT 
 1 AS `id`,
 1 AS `instructor_id`,
 1 AS `student_id`,
 1 AS `event_calendar_id`,
 1 AS `title`,
 1 AS `start`,
 1 AS `end`,
 1 AS `allDay`,
 1 AS `backgroundColor`,
 1 AS `event_description`,
 1 AS `count_assistance`,
 1 AS `list_instructor_calendar_assistance_ids`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `student_instructor_calendar_assistance_view`
--

DROP TABLE IF EXISTS `student_instructor_calendar_assistance_view`;
/*!50001 DROP VIEW IF EXISTS `student_instructor_calendar_assistance_view`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `student_instructor_calendar_assistance_view` AS SELECT 
 1 AS `id`,
 1 AS `instructor_calendar_id`,
 1 AS `student_id`,
 1 AS `course_id`,
 1 AS `course_chapter_id`,
 1 AS `course_chapter_content_id`,
 1 AS `date_demand`,
 1 AS `description_demand`,
 1 AS `accepted`,
 1 AS `acceptance_date`,
 1 AS `response_demand`,
 1 AS `response_demand_link`,
 1 AS `course_title`,
 1 AS `instructor_id`,
 1 AS `chapter_title`,
 1 AS `content_brief`,
 1 AS `student_last_name`,
 1 AS `student_first_name`,
 1 AS `classroom`,
 1 AS `instructor_last_name`,
 1 AS `instructor_first_name`,
 1 AS `school_subject_id`,
 1 AS `label_subject`,
 1 AS `education`,
 1 AS `level`,
 1 AS `label_qualification`,
 1 AS `event_calendar_id`,
 1 AS `pl_title`,
 1 AS `pl_start`,
 1 AS `pl_end`,
 1 AS `pl_allday`,
 1 AS `pl_backgroundColor`,
 1 AS `attachment_url`,
 1 AS `pl_event_description`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `student_profile`
--

DROP TABLE IF EXISTS `student_profile`;
/*!50001 DROP VIEW IF EXISTS `student_profile`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `student_profile` AS SELECT 
 1 AS `id`,
 1 AS `school_id`,
 1 AS `first_name`,
 1 AS `last_name`,
 1 AS `email`,
 1 AS `password`,
 1 AS `address`,
 1 AS `phone_primary`,
 1 AS `phone_secondary`,
 1 AS `registration_date`,
 1 AS `active_account`,
 1 AS `image`,
 1 AS `country_city_id`,
 1 AS `country_id`,
 1 AS `school_qualification_id`,
 1 AS `education`,
 1 AS `classroom`,
 1 AS `level`,
 1 AS `qualification`,
 1 AS `date_birth`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `student_quiz_results`
--

DROP TABLE IF EXISTS `student_quiz_results`;
/*!50001 DROP VIEW IF EXISTS `student_quiz_results`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `student_quiz_results` AS SELECT 
 1 AS `student_id`,
 1 AS `quiz_id`,
 1 AS `quiz_name`,
 1 AS `scope`,
 1 AS `scope_id`,
 1 AS `time_limit`,
 1 AS `total_questions`,
 1 AS `correct_answers`,
 1 AS `score`,
 1 AS `first_timestamp`,
 1 AS `latest_timestamp`,
 1 AS `row_id`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `student_subject_course_view`
--

DROP TABLE IF EXISTS `student_subject_course_view`;
/*!50001 DROP VIEW IF EXISTS `student_subject_course_view`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `student_subject_course_view` AS SELECT 
 1 AS `student_id`,
 1 AS `school_id`,
 1 AS `school_qualification_id`,
 1 AS `school_subject_id`,
 1 AS `classroom`,
 1 AS `subject_id`,
 1 AS `qualification_id`,
 1 AS `label_subject`,
 1 AS `code`,
 1 AS `level`,
 1 AS `label_qualification`,
 1 AS `total_course`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `student_subject_view`
--

DROP TABLE IF EXISTS `student_subject_view`;
/*!50001 DROP VIEW IF EXISTS `student_subject_view`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `student_subject_view` AS SELECT 
 1 AS `student_id`,
 1 AS `school_id`,
 1 AS `school_qualification_id`,
 1 AS `classroom`,
 1 AS `school_subject_id`,
 1 AS `subject_id`,
 1 AS `qualification_id`,
 1 AS `label_subject`,
 1 AS `code`,
 1 AS `level`,
 1 AS `label_qualification`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `subject`
--

DROP TABLE IF EXISTS `subject`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `subject` (
  `id` int NOT NULL AUTO_INCREMENT,
  `label` varchar(200) NOT NULL,
  `school_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `subject_school_FK` (`school_id`),
  CONSTRAINT `subject_school_FK` FOREIGN KEY (`school_id`) REFERENCES `school` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subject`
--

LOCK TABLES `subject` WRITE;
/*!40000 ALTER TABLE `subject` DISABLE KEYS */;
INSERT INTO `subject` VALUES (1,'Intelligence artificielle',1);
/*!40000 ALTER TABLE `subject` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subscription_client`
--

DROP TABLE IF EXISTS `subscription_client`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `subscription_client` (
  `id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone` varchar(45) DEFAULT NULL,
  `address` varchar(1000) DEFAULT NULL,
  `registration_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `package_id` int NOT NULL,
  `school_type_id` int NOT NULL,
  `payment_completed` bit(1) NOT NULL DEFAULT b'0',
  `payment_method` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `amount_subscription` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subscription_client`
--

LOCK TABLES `subscription_client` WRITE;
/*!40000 ALTER TABLE `subscription_client` DISABLE KEYS */;
/*!40000 ALTER TABLE `subscription_client` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_connection_log`
--

DROP TABLE IF EXISTS `user_connection_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_connection_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `role` varchar(20) NOT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` varchar(255) DEFAULT NULL,
  `timestamp` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `os_name` varchar(100) DEFAULT NULL,
  `browser_name` varchar(100) DEFAULT NULL,
  `device_name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_connection_log`
--

LOCK TABLES `user_connection_log` WRITE;
/*!40000 ALTER TABLE `user_connection_log` DISABLE KEYS */;
INSERT INTO `user_connection_log` VALUES (1,1,'School','127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36','2025-11-25 20:40:27','Windows 10','Chrome 142.0.0','Desktop'),(2,1,'Instructor','127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36','2025-11-25 21:09:59','Windows 10','Chrome 142.0.0','Desktop'),(3,1,'Instructor','127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36','2025-11-25 22:04:19','Windows 10','Chrome 142.0.0','Desktop'),(4,1,'School','127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36','2025-11-26 20:33:40','Windows 10','Chrome 142.0.0','Desktop'),(5,1,'Instructor','127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36','2025-11-26 20:44:03','Windows 10','Chrome 142.0.0','Desktop'),(6,1,'Instructor','127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36','2025-11-26 22:01:05','Windows 10','Chrome 142.0.0','Desktop'),(7,1,'School','127.0.0.1','Mozilla/5.0 (iPhone; CPU iPhone OS 16_7_12 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.6.1 Mobile/15E148 Safari/604.1','2025-11-26 22:26:19','iOS 16.7.12','Mobile Safari 16.6.1','iPhone'),(8,1,'School','127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36','2025-11-26 22:31:11','Windows 10','Chrome 142.0.0','Desktop'),(9,1,'Student','127.0.0.1','Mozilla/5.0 (iPhone; CPU iPhone OS 16_7_12 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.6.1 Mobile/15E148 Safari/604.1','2025-11-26 22:37:08','iOS 16.7.12','Mobile Safari 16.6.1','iPhone'),(10,1,'Instructor','127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36','2025-11-26 22:38:22','Windows 10','Chrome 142.0.0','Desktop'),(11,1,'Student','127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36','2025-11-26 22:41:32','Windows 10','Chrome 142.0.0','Desktop'),(12,1,'Instructor','127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0','2025-11-26 22:44:04','Windows 10','Edge 142.0.0','Desktop'),(13,1,'Instructor','127.0.0.1','Mozilla/5.0 (iPhone; CPU iPhone OS 16_7_12 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.6.1 Mobile/15E148 Safari/604.1','2025-11-26 23:05:55','iOS 16.7.12','Mobile Safari 16.6.1','iPhone'),(14,1,'Instructor','127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36','2025-11-26 23:10:24','Windows 10','Chrome 142.0.0','Desktop'),(15,1,'Instructor','127.0.0.1','Mozilla/5.0 (iPhone; CPU iPhone OS 16_7_12 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) FxiOS/145.3  Mobile/15E148 Safari/604.1','2025-12-01 21:50:17','iOS 16.7.12','Firefox iOS 145.3','iPhone'),(16,1,'Student','127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0','2025-12-03 12:44:00','Windows 10','Edge 142.0.0','Desktop'),(17,1,'School','127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36','2025-12-15 23:10:32','Windows 10','Chrome 142.0.0','Desktop'),(18,1,'Instructor','127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36','2025-12-16 21:56:23','Windows 10','Chrome 143.0.0','Desktop'),(19,1,'School','127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36 Edg/143.0.0.0','2025-12-23 20:15:53','Windows 10','Edge 143.0.0','Desktop'),(20,1,'School','127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36 Edg/143.0.0.0','2025-12-23 21:47:32','Windows 10','Edge 143.0.0','Desktop'),(21,1,'Instructor','127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36 Edg/143.0.0.0','2025-12-23 21:50:57','Windows 10','Edge 143.0.0','Desktop'),(22,1,'School','127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36','2025-12-26 11:20:16','Windows 10','Chrome 143.0.0','Desktop'),(23,1,'Instructor','127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36','2025-12-26 11:40:02','Windows 10','Chrome 143.0.0','Desktop'),(24,1,'Student','127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36 Edg/143.0.0.0','2025-12-26 11:49:04','Windows 10','Edge 143.0.0','Desktop'),(25,1,'Instructor','127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36','2025-12-26 22:52:24','Windows 10','Chrome 143.0.0','Desktop'),(26,1,'Instructor','127.0.0.1','Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Mobile Safari/537.36','2025-12-26 22:54:49','Android 10','Chrome Mobile 143.0.0','K'),(27,1,'Student','127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36 Edg/143.0.0.0','2025-12-26 23:06:47','Windows 10','Edge 143.0.0','Desktop'),(28,1,'Instructor','127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36','2025-12-27 19:43:06','Windows 10','Chrome 143.0.0','Desktop');
/*!40000 ALTER TABLE `user_connection_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `users_app`
--

DROP TABLE IF EXISTS `users_app`;
/*!50001 DROP VIEW IF EXISTS `users_app`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `users_app` AS SELECT 
 1 AS `id`,
 1 AS `email`,
 1 AS `password`,
 1 AS `phone_primary`,
 1 AS `active_account`,
 1 AS `role`,
 1 AS `full_name`,
 1 AS `school_type_id`,
 1 AS `registration_date`,
 1 AS `renewal_date`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping events for database 'elearningdb'
--

--
-- Dumping routines for database 'elearningdb'
--
/*!50003 DROP FUNCTION IF EXISTS `GenerateProgressHTML` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `GenerateProgressHTML`(p_number INT) RETURNS varchar(255) CHARSET utf8mb4
    DETERMINISTIC
BEGIN

    DECLARE result VARCHAR(255);
    SET result = if (p_number>0,    
			    CONCAT('<div class="elevation-1 mt-1 pl-1 pr-1 text-md border rounded text-bold ',if(p_number=100,'text-red','text-dark'),'" style="',

			                        'background: linear-gradient(90deg, #caffd7 ', 
			                        p_number, 
			                        '%, #ffffff00 0%);">',

			                        p_number, 

			                        '<i class="ml-1 text-xs text-black fa fa-percent"></i></div>')                       
			                        ,'<i class="mt-2 text-xs text-gray fa fa-ellipsis"></i>'	)  ;

                        

    RETURN result;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `getImageTag` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `getImageTag`(image varchar(2000),image_url varchar(200)) RETURNS longtext CHARSET utf8mb4
    DETERMINISTIC
BEGIN
    DECLARE base64_image LONGTEXT;
    DECLARE default_img TEXT;
    DECLARE html_img TEXT;
    
    SET default_img = '/static/app-assets/img/avatar-sds.jpg';
    SET html_img = '<img role="button" onclick="toastr.image(this.src)" height="40" class="rounded-pill elevation-2" src="';
    
    IF image IS NOT NULL THEN
        SET base64_image = CONCAT(image_url, image);
        RETURN CONCAT(html_img, base64_image, '" />');
    ELSE
        RETURN CONCAT(html_img, default_img, '" />');
    END IF;

end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `get_duration_str` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `get_duration_str`(start_ts DATETIME, end_ts DATETIME) RETURNS varchar(50) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
    DECLARE total_seconds INT;
    DECLARE hours INT;
    DECLARE minutes INT;
    DECLARE seconds INT;
    DECLARE result VARCHAR(50);

    IF start_ts IS NULL OR end_ts IS NULL THEN
        RETURN '';
    END IF;

    SET total_seconds = TIMESTAMPDIFF(SECOND, start_ts, end_ts);
    SET hours = FLOOR(total_seconds / 3600);
    SET minutes = FLOOR((total_seconds % 3600) / 60);
    SET seconds = total_seconds % 60;

    SET result = CONCAT(minutes, 'mn ', seconds, 's');

    IF hours > 0 THEN
        SET result = CONCAT(hours, 'h ', result);
    END IF;
    
    SET result = CONCAT('<div class="text-capitalize">', result, '</div>');

    RETURN result;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `lipsum` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `lipsum`(p_max_words SMALLINT
                       ,p_min_words SMALLINT
                       ,p_start_with_lipsum TINYINT(1)
                       ) RETURNS varchar(10000) CHARSET utf8mb4
    NO SQL
BEGIN
    

        DECLARE v_max_words SMALLINT DEFAULT 50;
        DECLARE v_random_item SMALLINT DEFAULT 0;
        DECLARE v_random_word VARCHAR(25) DEFAULT '';
        DECLARE v_start_with_lipsum TINYINT DEFAULT 0;
        DECLARE v_result VARCHAR(10000) DEFAULT '';
        DECLARE v_iter INT DEFAULT 1;
        DECLARE v_text_lipsum VARCHAR(1500) DEFAULT 'a ac accumsan ad adipiscing aenean aliquam aliquet amet ante aptent arcu at auctor augue bibendum blandit class commodo condimentum congue consectetuer consequat conubia convallis cras cubilia cum curabitur curae; cursus dapibus diam dictum dignissim dis dolor donec dui duis egestas eget eleifend elementum elit enim erat eros est et etiam eu euismod facilisi facilisis fames faucibus felis fermentum feugiat fringilla fusce gravida habitant hendrerit hymenaeos iaculis id imperdiet in inceptos integer interdum ipsum justo lacinia lacus laoreet lectus leo libero ligula litora lobortis lorem luctus maecenas magna magnis malesuada massa mattis mauris metus mi molestie mollis montes morbi mus nam nascetur natoque nec neque netus nibh nisi nisl non nonummy nostra nulla nullam nunc odio orci ornare parturient pede pellentesque penatibus per pharetra phasellus placerat porta porttitor posuere praesent pretium primis proin pulvinar purus quam quis quisque rhoncus ridiculus risus rutrum sagittis sapien scelerisque sed sem semper senectus sit sociis sociosqu sodales sollicitudin suscipit suspendisse taciti tellus tempor tempus tincidunt torquent tortor tristique turpis ullamcorper ultrices ultricies urna ut varius vehicula vel velit venenatis vestibulum vitae vivamus viverra volutpat vulputate';
        DECLARE v_text_lipsum_wordcount INT DEFAULT 180;
        DECLARE v_sentence_wordcount INT DEFAULT 0;
        DECLARE v_sentence_start BOOLEAN DEFAULT 1;
        DECLARE v_sentence_end BOOLEAN DEFAULT 0;
        DECLARE v_sentence_lenght TINYINT DEFAULT 9;

        SET v_max_words := COALESCE(p_max_words, v_max_words);
        SET v_start_with_lipsum := COALESCE(p_start_with_lipsum , v_start_with_lipsum);

        IF p_min_words IS NOT NULL THEN
            SET v_max_words := FLOOR(p_min_words + (RAND() * (v_max_words - p_min_words)));
        END IF;

        IF v_max_words < v_sentence_lenght THEN
            SET v_sentence_lenght := v_max_words;
        END IF;

        IF p_start_with_lipsum = 1 THEN
            SET v_result := CONCAT(v_result,'Lorem ipsum dolor sit amet.');
            SET v_max_words := v_max_words - 5;
        END IF;

        WHILE v_iter <= v_max_words DO
            SET v_random_item := FLOOR(1 + (RAND() * v_text_lipsum_wordcount));
            SET v_random_word := REPLACE(SUBSTRING(SUBSTRING_INDEX(v_text_lipsum, ' ' ,v_random_item),
                                           CHAR_LENGTH(SUBSTRING_INDEX(v_text_lipsum,' ', v_random_item -1)) + 1),
                                           ' ', '');

            SET v_sentence_wordcount := v_sentence_wordcount + 1;
            IF v_sentence_wordcount = v_sentence_lenght THEN
                SET v_sentence_end := 1 ;
            END IF;

            IF v_sentence_start = 1 THEN
                SET v_random_word := CONCAT(UPPER(SUBSTRING(v_random_word, 1, 1))
                                            ,LOWER(SUBSTRING(v_random_word FROM 2)));
                SET v_sentence_start := 0 ;
            END IF;

            IF v_sentence_end = 1 THEN
                IF v_iter <> v_max_words THEN
                    SET v_random_word := CONCAT(v_random_word, '.');
                END IF;
                SET v_sentence_lenght := FLOOR(9 + (RAND() * 7));
                SET v_sentence_end := 0 ;
                SET v_sentence_start := 1 ;
                SET v_sentence_wordcount := 0 ;
            END IF;

            SET v_result := CONCAT(v_result,' ', v_random_word);
            SET v_iter := v_iter + 1;
        END WHILE;

        RETURN TRIM(CONCAT(v_result,'.'));
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `dashboard_instructor_course_chapter_content_sp` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `dashboard_instructor_course_chapter_content_sp`(	
IN _instructor_id INT, IN _date_start DATETIME,  IN _date_end DATETIME)
BEGIN
	SELECT 
	row_number() OVER (order by cc.content_type_id ,MONTH(cc.date_update),YEAR(cc.date_update) )  AS `row_id`, 
		_instructor_id as `instructor_id`,
		COUNT(cc.content_type_id) as `count`,  
		content_type_id as `content_type_id`,    
		MONTH(cc.date_update) as `month_date_update`,
		YEAR(cc.date_update) as `year_date_update`
	FROM
		course_chapter_content cc
		WHERE exists(
			select 1 from course_chapter ch 
			JOIN    course c ON c.id = ch.course_id
			where  ch.id = cc.course_chapter_id and c.instructor_id = _instructor_id
		)
		and (cc.date_update between _date_start and  DATE_ADD(_date_end, INTERVAL 1 DAY))
	GROUP BY  MONTH(cc.date_update),YEAR(cc.date_update),cc.content_type_id 
	ORDER BY  cc.content_type_id ,MONTH(cc.date_update),YEAR(cc.date_update) ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `dashboard_school_course_chapter_content_sp` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `dashboard_school_course_chapter_content_sp`(	
IN _school_id INT, IN _date_start DATETIME,  IN _date_end DATETIME)
BEGIN
	SELECT 
	row_number() OVER (order by cc.content_type_id ,MONTH(cc.date_update),YEAR(cc.date_update) )  AS `row_id`, 
		_school_id as `_school_id`,
		COUNT(cc.content_type_id) as `count`,  
		content_type_id as `content_type_id`,    
		MONTH(cc.date_update) as `month_date_update`,
		YEAR(cc.date_update) as `year_date_update`
	FROM
		course_chapter_content cc
		WHERE exists(
			select 1 from course_chapter ch 
			JOIN    course c ON c.id = ch.course_id
            join instructor ins on ins.id= c.instructor_id
			where  ch.id = cc.course_chapter_id and ins.school_id = _school_id
		)
		and (cc.date_update between _date_start and DATE_ADD(_date_end, INTERVAL 1 DAY))
	GROUP BY  MONTH(cc.date_update),YEAR(cc.date_update),cc.content_type_id 
	ORDER BY  cc.content_type_id ,MONTH(cc.date_update),YEAR(cc.date_update) ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `dashboard_student_course_chapter_content_sp` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `dashboard_student_course_chapter_content_sp`(	
IN _student_id INT, IN _date_start DATETIME,  IN _date_end DATETIME)
BEGIN
	SELECT 
	row_number() OVER (order by cc.content_type_id ,MONTH(cc.date_update),YEAR(cc.date_update) )  AS `row_id`, 
		_student_id as `_student_id`,
		COUNT(cc.content_type_id) as `count`,  
		content_type_id as `content_type_id`,    
		MONTH(cc.date_update) as `month_date_update`,
		YEAR(cc.date_update) as `year_date_update`
	FROM
		course_chapter_content cc
		WHERE exists(
			select 1 from course_chapter ch 
			JOIN  course c ON c.id = ch.course_id
            join school_subject ss on ss.id=c.school_subject_id
            join school_qualification sq on ss.qualification_id = sq.qualification_id
            join student s on sq.id = s.school_qualification_id and s.school_id=sq.school_id
			where  ch.id = cc.course_chapter_id 
            and s.id = _student_id
		)
		and (cc.date_update between _date_start and DATE_ADD(_date_end, INTERVAL 1 DAY))
	GROUP BY  MONTH(cc.date_update),YEAR(cc.date_update),cc.content_type_id 
	ORDER BY  cc.content_type_id ,MONTH(cc.date_update),YEAR(cc.date_update);
 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insert_subscription_client` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_subscription_client`(
    IN p_first_name VARCHAR(100),
    IN p_last_name VARCHAR(100),
    IN p_email VARCHAR(255),
    IN p_phone VARCHAR(45),
    IN p_address VARCHAR(1000),
    IN p_package_id INT,
    IN p_school_type_id INT,
    IN p_payment_completed BIT,
    IN p_payment_method VARCHAR(20),
    IN p_amount_subscription DECIMAL(10,2)
)
BEGIN
    INSERT INTO subscription_client
    (first_name, last_name, email, phone, address, package_id, school_type_id, payment_completed, payment_method, amount_subscription)
    VALUES
    (p_first_name, p_last_name, p_email, p_phone, p_address, p_package_id, p_school_type_id, p_payment_completed, p_payment_method, p_amount_subscription);

    SELECT LAST_INSERT_ID();
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `instructor_list_student` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `instructor_list_student`(IN _id INT, IN _allInfos INT)
BEGIN
SELECT 
    id,
    school_id,
    first_name,
    last_name,
    email,
    'student' as role,
    case when _allInfos=1 then address else '' end as address,
    case when _allInfos=1 then phone_primary else '' end phone_primary,
    case when _allInfos=1 then phone_secondary else '' end phone_secondary,
    case when _allInfos=1 then registration_date else null end registration_date,
    case when _allInfos=1 then if(active_account,1,0) else 0 end active_account,
    case when _allInfos=1 then image else null end image,
    case when _allInfos=1 then country_city_id else 0 end country_city_id,
    classroom,
    level,
    qualification
FROM
    student_profile s
WHERE active_account=True and
     EXISTS( SELECT 
            1
        FROM
            instructor_student_subject_qualification_view p
        WHERE

            instructor_id = _id

                AND p.student_id = s.id)
                
order by classroom,
    level,
    qualification,first_name,last_name;


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `messages_box_inbox_sp` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `messages_box_inbox_sp`(
in _email varchar(255), in _message_id bigint)
begin

	
drop temporary table if exists tmp_ids;



create temporary table if not exists tmp_ids

select

	distinct id,

	_email as email

from

	elearningdb.messages_box_inbox_view

where

	(user_sender_email = _email

		or user_recipient_email = _email)

	and id = coalesce(_message_id, id);



select

	id,

	user_sender_id,

	user_sender_role,

	user_sender_full_name,

	user_sender_email,

	subject,

	date_update,

	case

		when to_trash then 1

		else 0

	end to_trash,

	GROUP_CONCAT(user_recipient_full_name) as users_recipient_full_name,

	count(user_recipient_id) nbr_users_recipient,

	case

		when ( user_sender_email = _email) then 1

		else 0

	end as 'my_message',

	cast(SUM(case when (user_recipient_email = _email) then message_box_recipient_id else 0 end ) as unsigned )as 'message_box_recipient_id',

	cast( SUM(case when (user_sender_email = _email or user_recipient_email = _email) then (case when is_read then 1 else 0 end) else 0 end) as unsigned )as 'is_read'

from

	elearningdb.messages_box_inbox_view v

where

	exists(

	select

		1

	from

		tmp_ids t

	where

		t.id = v.id

		and email = _email)

group by

	id,

	user_sender_id,

	user_sender_role,

	user_sender_full_name,
	user_sender_email,

	subject,

	date_update,

	to_trash;



drop temporary table tmp_ids;

end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `messages_box_sp` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `messages_box_sp`(in _id INT, in _email varchar(255))
begin

select

	id,

	user_sender_id,

	user_sender_role,

	user_sender_full_name,

	user_sender_email,

	subject,

	date_update,

	body,

	case

		when to_trash then 1

		else 0

	end to_trash,

	GROUP_CONCAT(user_recipient_full_name) as users_recipient_full_name,

	count(user_recipient_id) nbr_users_recipient,

	JSON_ARRAYAGG( JSON_OBJECT(
    'user_recipient_id', user_recipient_id,
    'user_recipient_role', user_recipient_role ,
    'user_recipient_email', user_recipient_email ,    
    'users_recipient_full_name', user_recipient_full_name,
    'is_read' , case when is_read then 1 else 0 end
  )
  ) as users_recipient_info,

	case

		when ( user_sender_email = _email) then 1

		else 0

	end as 'my_message',

	cast(
SUM(
case when (user_recipient_email = _email) then message_box_recipient_id else 0 end 
) 
as unsigned )as 'message_box_recipient_id',

	cast(
SUM(case when (user_sender_email = _email or user_recipient_email = _email) then (case when is_read then 1 else 0 end) else 0 end) 
as unsigned )as 'is_read'

FROM elearningdb.messages_box_view
where id=_id 
group by 
id,
user_sender_id,
user_sender_role,
user_sender_full_name,
user_sender_email,
subject,
body,
date_update,
to_trash;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `message_box_count_read` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `message_box_count_read`(
IN _user_id int, IN _role varchar(10),IN _is_read BIT
)
BEGIN
SELECT 
    COUNT(mb.id) AS count,
    MAX(date_update) AS max_messagebox_date
FROM
    messages_box_recipients mb
        JOIN
    messages_box m ON m.id = mb.message_box_id
        AND to_trash = FALSE
        AND (concat(user_sender_role,user_sender_id )  <> concat(  user_recipient_role,user_recipient_id))
WHERE
    user_recipient_id = _user_id
        AND user_recipient_role = _role
        AND is_read = _is_read
;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `rpt_instructor_courses` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `rpt_instructor_courses`(

    IN _school_id INT, 

    IN _instructor_id INT, 

    IN _date_start DATETIME,  

    IN _date_end DATETIME

)
BEGIN

	

    DECLARE v_instructor_id INT;

    

    SET v_instructor_id = _instructor_id;



    IF v_instructor_id <= 0 THEN

        SET v_instructor_id = 0;

    END IF;

	

    SELECT 

        DATE_FORMAT(date_creation, '%d/%m/%Y') AS 'Date création',

        concat('<p class="text-clamp">',course_title,'</p>') 'Cours' ,
       concat('<a role="button" class="btn btn-outline-dark hide-print btn-sm" onclick="courselinkReport(',c.school_subject_id,',',c.id,')" ><i class="fa fa-up-right-from-square"></i></a>') AS 'Consulter',


        language_name AS 'Langue',

        label_subject AS 'Matière',

        education as `Enseignement`,

        level AS 'Niveau', 

        label_qualification AS 'Classe',

        CONCAT(first_name, ' ', last_name) AS 'Professeur'


    FROM

        course_instructor_view c 

    WHERE

        c.instructor_id = IF(v_instructor_id = 0, c.instructor_id, v_instructor_id)

        and c.school_id=_school_id and is_visible =1

        AND date_creation BETWEEN _date_start AND _date_end

    ORDER BY level,label_qualification,label_subject,date_creation desc;



END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `rpt_instructor_enrollment_courses` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `rpt_instructor_enrollment_courses`(

    IN _school_id INT, 

    IN _instructor_id INT, 

    IN _date_start DATETIME,  

    IN _date_end DATETIME

)
BEGIN

	

    DECLARE v_instructor_id INT;

    

    SET v_instructor_id = _instructor_id;



    IF v_instructor_id <= 0 THEN

        SET v_instructor_id = 0;

    END IF;

	

    SELECT 

        DATE_FORMAT(e.enrollment_date, '%d/%m/%Y') AS 'Lu le',  
        concat('<a role="button" class="btn btn-outline-dark hide-print btn-sm" onclick="courselinkReport(', e.school_subject_id, ',', e.id,',', e.student_id, ')" ><i class="fa fa-up-right-from-square"></i></a>') as 'Consulter',

        CONCAT(student_first_name, ' ', student_last_name) AS 'Étudiant',  

        concat('<p class="text-clamp">',course_title,'</p>') 'Cours' ,  

        

GenerateProgressHTML(cpv.course_completion_percentage) 'Achèvement du cours',

         

        DATE_FORMAT(e.date_creation, '%d/%m/%Y') as 'Date création',        

        education as `Enseignement`,

        level as 'Niveau', 

        label_qualification as 'Classe',

        classroom as 'N: Classe',   

        language_name as 'Langue',

        label_subject as 'Matière',        

        CONCAT(i.first_name, ' ', i.last_name) as 'Professeur'

    FROM

        enrollment_course_view e join

        instructor i on i.id =e.instructor_id 

        left join course_progress_view cpv on cpv.enrollment_id =e.enrollment_id

    WHERE

        instructor_id = IF(v_instructor_id = 0, instructor_id, v_instructor_id)

        and e.school_id = _school_id

        AND enrollment_date BETWEEN _date_start AND _date_end

    ORDER BY level,label_qualification,classroom,label_subject,course_title,enrollment_date desc;



END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `rpt_instructor_feedback_course` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `rpt_instructor_feedback_course`(
IN _instructor_id INT, IN _date_start DATETIME,  IN _date_end DATETIME)
BEGIN

SELECT 
DATE_FORMAT(submission_date,'%d/%m/%Y')  'Date',
concat('<a role="button" class="btn btn-outline-dark hide-print btn-sm" onclick="courselinkReport(', e.school_subject_id, ',', e.id,',', e.student_id, ')" ><i class="fa fa-up-right-from-square"></i></a>') as 'Consulter',
concat(student_first_name,' ' ,student_last_name) 'Étudiant',
concat('<p class="text-clamp">',course_title,'</p>') 'Cours' ,
concat('<b  class="text-md">',rating_score,'</b>')  'Score',
concat('<p  class="text-clamp">',feedback_text,'</p>') 'Évaluation',

GenerateProgressHTML(cpv.course_completion_percentage) 'Achèvement du cours',
	
language_name 'Langue',
label_subject 'Matière',
education as `Enseignement`,
 level 'Niveau', 
 label_qualification 'Classe',
classroom 'N: Classe'
FROM
    feedback_course_view e
    left join course_progress_view cpv on cpv.enrollment_id =e.enrollment_id 
WHERE
    e.instructor_id = _instructor_id
        AND (submission_date BETWEEN _date_start AND _date_end)
ORDER BY level,label_qualification,classroom,label_subject,submission_date desc;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `rpt_instructor_my_students` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `rpt_instructor_my_students`(IN _id INT,in image_url varchar(200), IN _allInfos INT)
begin
	

SELECT 


case when _allInfos=1 then getImageTag(image,image_url)  else null end 'Image',  
concat(first_name,' ' ,last_name) 'Étudiant',
    email, 
    concat('<a role="button" title="Dashboard" class="btn btn-outline-danger hide-print btn-sm" onclick="monitoringlinkReport(', s.id, ')" ><i class="fa fa-compass"></i></a>') as 'Centre de Suivi',
    education as `Enseignement`,
    level as Niveau,
    qualification as 'Classe',
    classroom 'N: Classe',

    case when _allInfos=1 then 
    concat('<p class="text-clamp">',address,'</p>')
    else '' end as 'Adresse',

    case when _allInfos=1 then phone_primary else '' end 'Tél_principale',

    case when _allInfos=1 then phone_secondary else '' end 'Tél_secondaire',

    case when _allInfos=1 then country_en else '' end 'Pays',
    case when _allInfos=1 then city else '' end 'Ville',  
    case when _allInfos=1 then DATE_FORMAT(registration_date,'%d/%m/%Y')  else null end 'Date enregistrement'

FROM

    student_profile s
    left join country c on c.id = s.country_id
    left join country_city cc  on cc.id = s.country_city_id 
 

WHERE active_account=True and

    EXISTS( SELECT 

            1

        FROM

            instructor_student_subject_qualification_view p
        WHERE

            instructor_id = _id

                AND p.student_id = s.id)

                

order by level,qualification,classroom, first_name,last_name;





END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `rpt_instructor_quiz_courses` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `rpt_instructor_quiz_courses`(
 IN _school_id INT, 

    IN _instructor_id INT, 

    IN _date_start DATETIME,  

    IN _date_end DATETIME

)
BEGIN

	

    DECLARE v_instructor_id INT;

    

    SET v_instructor_id = _instructor_id;



    IF v_instructor_id <= 0 THEN

        SET v_instructor_id = 0;

    END IF;

	

     SELECT 
        DATE_FORMAT(latest_timestamp, '%d/%m/%Y') AS 'Quiz soumis le', 
		concat('<a role="button" class="btn btn-outline-dark hide-print btn-sm" onclick="quizlinkReport(', r.quiz_id,',', e.student_id, ')" ><i class="fa fa-up-right-from-square"></i></a>') as 'Consulter',

        CONCAT(student_first_name, ' ', student_last_name) AS 'Étudiant', 
        concat('<p class="text-clamp">',quiz_name,'</p>') 'Quiz' , 
        concat('<span class="text-md">',total_questions,'</span>') "Questions",
        concat('<b class="text-md">',correct_answers,'</b>')  "Correct",
        GenerateProgressHTML(score) 'Score',
        
        concat('<span class="text-sm">',get_duration_str(first_timestamp, latest_timestamp) ,'</span>')'Temps passé',
        concat('<span class="text-sm">',coalesce(time_limit,""),'</span>') 'Limite de temps',
        
        DATE_FORMAT(first_timestamp, '%d/%m/%Y %H:%i:%s') AS 'Commencé le', 
        DATE_FORMAT(latest_timestamp, '%d/%m/%Y %H:%i:%s') AS 'Terminé le',  

        education as `Enseignement`,
        concat('<p class="text-clamp">',course_title,'</p>') 'Cours' , 
        level as 'Niveau', 

        label_qualification as 'Classe',

        classroom as 'N: Classe',   

        language_name as 'Langue',

        label_subject as 'Matière',        

        CONCAT(i.first_name, ' ', i.last_name) as 'Professeur'

    FROM
        enrollment_course_view e join
        instructor i on i.id =e.instructor_id 
        join course_progress_view cpv on cpv.enrollment_id =e.enrollment_id
        join student_quiz_results r on r.scope_id = e.id and r.`scope`="course"

    WHERE

        instructor_id = IF(v_instructor_id = 0, instructor_id, v_instructor_id)

        and e.school_id = _school_id

        AND first_timestamp BETWEEN _date_start AND _date_end

    ORDER BY level,label_qualification,classroom,label_subject,course_title,quiz_name,latest_timestamp desc;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `rpt_school_courses_assistance` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `rpt_school_courses_assistance`(
in _school_id int, IN _date_start DATETIME,  IN _date_end DATETIME)
begin
select

	DATE_FORMAT(date_demand, '%d/%m/%Y %H:%i') AS 'Date création',
	concat('<a role="button" class="btn btn-outline-dark hide-print btn-sm" onclick="courselinkReport(', school_subject_id, ',', course_id,',', student_id, ')" ><i class="fa fa-up-right-from-square"></i></a>') as 'Consulter',

	education as `Enseignement`,

    level AS 'Niveau', 

    label_qualification AS 'Classe',

	classroom as 'N: Classe', 

	concat(student_first_name, ' ' , student_last_name) 'Étudiant',	

	concat('<p  class="text-clamp">',description_demand,'</p>') as 'Demande',

	concat(instructor_first_name, ' ' , instructor_last_name) 'Professeur',	

	concat('<p  class="text-clamp">',response_demand,'</p>') as 'Réponse',

	label_subject AS 'Matière',

	concat('<p  class="text-clamp">',course_title,'</p>') AS 'Cours',

	concat('<p  class="text-clamp">',chapter_title,'</p>') as 'Chapitre',

	concat('<p  class="text-clamp">',content_brief,'</p>') as 'Section',
	
	 CASE
        WHEN accepted=1 THEN '&#10004;'
        WHEN accepted=0  THEN '&#10007;'
        ELSE '...' 
      END  'Statut',	
        

	DATE_FORMAT(acceptance_date, '%d/%m/%Y %H:%i') AS 'Date statut'
from

	instructor_calendar_assistance_view

where

	school_id = _school_id

	 AND (date_demand BETWEEN _date_start AND _date_end)

ORDER BY date_demand desc;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `rpt_school_instructor_feedback_course` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `rpt_school_instructor_feedback_course`(
IN _school_id INT,IN _instructor_id INT, IN _date_start DATETIME,  IN _date_end DATETIME)
BEGIN



	 DECLARE v_instructor_id INT;

    

    SET v_instructor_id = _instructor_id;



    IF v_instructor_id <= 0 THEN

        SET v_instructor_id = 0;

    END IF;

   

SELECT 

DATE_FORMAT(submission_date,'%d/%m/%Y')  'Date',

concat(student_first_name,' ' ,student_last_name) 'Étudiant',
concat('<a role="button" class="btn btn-outline-dark hide-print btn-sm" onclick="courselinkReport(',e.school_subject_id,',',e.id,',',e.student_id,')" ><i class="fa fa-up-right-from-square"></i></a>') AS 'Consulter',

concat('<p  class="text-clamp">',course_title,'</p>') AS 'Cours',

concat('<b  class="text-md">',rating_score,'</b>')  'Score',
concat('<p  class="text-clamp">',feedback_text,'</p>') 'Évaluation',
GenerateProgressHTML(cpv.course_completion_percentage) 'Achèvement du cours',         

language_name 'Langue',

label_subject 'Matière',


education as `Enseignement`,

 level 'Niveau', 

 label_qualification 'Classe',

replace (classroom,',',' - ') 'N: Classe',

CONCAT(i.first_name, ' ', i.last_name) AS 'Professeur'

FROM

    feedback_course_view e join

        instructor i on i.id =e.instructor_id 
        left join course_progress_view cpv on cpv.enrollment_id =e.enrollment_id 

WHERE

    instructor_id = IF(v_instructor_id = 0, instructor_id, v_instructor_id)

    and e.school_id = _school_id

    AND (submission_date BETWEEN _date_start AND _date_end)

ORDER BY level,label_qualification,classroom,label_subject,submission_date desc;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `rpt_school_my_instructors` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `rpt_school_my_instructors`(IN _school_id INT,in image_url varchar(200))
BEGIN

SELECT 



getImageTag(image,image_url) 'Image',  

concat(first_name, ' ' , last_name) 'Enseignant',

    email, 
    education as 'Enseignement',

    level as Niveau,

    label_qualification as 'Classe',

    replace (classrooms_teaching,',',' - ') 'N: Classe',
    coalesce( LENGTH(classrooms_teaching) - LENGTH(REPLACE(classrooms_teaching, ',', ''))+1 ,0) as 'Total',

    concat('<p class="text-clamp">',address,'</p>')  as 'Adresse',

     phone_primary 'Tél_principale',

     phone_secondary 'Tél_secondaire',

     country_en 'Pays',

     city 'Ville',  
	 DATE_FORMAT(date_birth, '%d/%m/%Y') 'Date de naissance',
     DATE_FORMAT(registration_date, '%d/%m/%Y') 'Date enregistrement',

     concat('<p title="',introduction_brief,'"  class="text-clamp">',introduction_brief,'</p>') as introduction_brief,

     if(active_account,'&#10004;','&#10007;') 'Actif'

from

     instructor_profile ip 

    join instructor_subject_view  i on i.instructor_id =ip.id 

left join country c on

c.id = ip.country_id

left join country_city cc on

cc.id = ip.country_city_id 

 

WHERE ip.school_id= _school_id



                

order by first_name,last_name, education,level,label_qualification,classrooms_teaching ;





END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `rpt_school_my_students` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `rpt_school_my_students`(IN _school_id INT,in image_url varchar(200))
BEGIN

SELECT 
getImageTag(image,image_url) 'Image',  

concat(first_name, ' ' , last_name) 'Étudiant',
    email, 
    concat('<a role="button" title="Dashboard" class="btn btn-outline-danger hide-print btn-sm" onclick="monitoringlinkReport(', s.id, ')" ><i class="fa fa-compass"></i></a>') as 'Centre de Suivi',

    education as 'Enseignement',

    level as Niveau,

    qualification as 'Classe',

    classroom 'N: Classe',
    
    DATE_FORMAT(date_birth, '%d/%m/%Y') 'Date de naissance',

     concat('<p class="text-clamp">',address,'</p>')  as 'Adresse',

     phone_primary 'Tél_principale',

     phone_secondary 'Tél_secondaire',

     country_en 'Pays',

     city 'Ville',       

     DATE_FORMAT(registration_date, '%d/%m/%Y') 'Date enregistrement',

     if(active_account,'&#10004;','&#10007;') 'Actif'

from

    student_profile s

left join country c on

c.id = s.country_id

left join country_city cc on

cc.id = s.country_city_id 

 

WHERE school_id= _school_id



                

order by level,qualification,classroom, first_name,last_name;





END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `rpt_school_qualifications` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `rpt_school_qualifications`(IN _school_id INT)
begin



select 

	    education  as 'Enseignement',

        level AS 'Niveau', 

        label AS 'Classe',               
       concat('<p class="text-clamp">',replace (classrooms_names,',',' - '),'</p>')  'N: Classe',

        nbr_class as 'Total'

	from school_qualification_view sqv 

	where school_id = _school_id

order by education,level,label,classrooms_names;

end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `rpt_school_subjects` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `rpt_school_subjects`(IN _school_id INT)
begin



select 


	    label_subject AS 'Matière',
	    education as 'Enseignement',

        level AS 'Niveau', 

        label_qualification AS 'Classe',

        replace (classrooms_names,',',' - ') 'N: Classe',
        coalesce( LENGTH(classrooms_names) - LENGTH(REPLACE(classrooms_names, ',', ''))+1 ,0) as 'Total'

	from school_subject_view

	where school_id = _school_id

order by label_subject,education,level,label_qualification,classrooms_names;

end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `school_infos_commun` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `school_infos_commun`(IN _id INT, IN _allInfos INT)
BEGIN
SELECT 
    id,
    id as school_id,
    name as first_name,
    '' as last_name,
    email,
    'school' as role,
  case when _allInfos=1 then address else '' end as address,
  case when _allInfos=1 then phone_primary else '' end phone_primary,
  case when _allInfos=1 then phone_secondary else '' end phone_secondary,
  case when _allInfos=1 then registration_date else null end registration_date,
  case when _allInfos=1 then if(active_account,1,0) else 0 end active_account,
  case when _allInfos=1 then image else null end image,
  case when _allInfos=1 then introduction_brief else '' end introduction_brief,
  case when _allInfos=1 then country_city_id else 0 end country_city_id
FROM
   school_profile  s
    
WHERE active_account=True and id= _id;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `school_list_classrooms_occupied` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `school_list_classrooms_occupied`(IN _id INT)
BEGIN
SELECT DISTINCT
    school_qualification_id, classroom
FROM
    (SELECT DISTINCT
        school_qualification_id, classroom
    FROM
        instructor_subject_classroom_view t
    WHERE
        school_id = _id 
        UNION ALL 
	SELECT DISTINCT
        school_qualification_id, classroom
    FROM
        student
    WHERE
        school_id = _id) c
WHERE
    LENGTH(classroom) > 0
    order by  school_qualification_id, classroom;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `school_list_instructor` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `school_list_instructor`(IN _id INT, IN _allInfos INT)
BEGIN
SELECT 
    id,
    school_id,
    first_name,
    last_name,
    email,
    'instructor' as role,
  case when _allInfos=1 then address else '' end as address,
  case when _allInfos=1 then phone_primary else '' end phone_primary,
  case when _allInfos=1 then phone_secondary else '' end phone_secondary,
  case when _allInfos=1 then registration_date else null end registration_date,
  case when _allInfos=1 then if(active_account,1,0) else 0 end active_account,
  case when _allInfos=1 then image else null end image,
  case when _allInfos=1 then introduction_brief else '' end introduction_brief,
  case when _allInfos=1 then country_city_id else 0 end country_city_id
FROM
  instructor_profile    s
    
WHERE active_account=True and school_id= _id
order by first_name,last_name;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `school_list_student` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `school_list_student`(IN _id INT, IN _allInfos INT)
BEGIN
SELECT 
    id,
    school_id,
    first_name,
    last_name,
    email,
    'student' as role,
    case when _allInfos=1 then address else '' end as address,
    case when _allInfos=1 then phone_primary else '' end phone_primary,
    case when _allInfos=1 then phone_secondary else '' end phone_secondary,
    case when _allInfos=1 then registration_date else null end registration_date,
    case when _allInfos=1 then if(active_account,1,0) else 0 end active_account,
    case when _allInfos=1 then image else null end image,
    case when _allInfos=1 then country_city_id else 0 end country_city_id,
    classroom,
    level,
    qualification
FROM
    student_profile s
WHERE active_account=True and school_id=_id
                
order by  classroom,
    level,
    qualification, first_name,last_name;


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `student_course_instructor_list` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `student_course_instructor_list`(
IN _student_id INT,IN _school_subject_id INT,IN _instructor_id INT)
BEGIN
 SELECT 
  `w`.`student_id` ,
    c.*
FROM
    ((`student_subject_course_view` `w`
    JOIN `instructor_subject_classroom_view` `i` ON (((`w`.`school_qualification_id` = `i`.`school_qualification_id`)
        AND (`w`.`school_subject_id` = `i`.`school_subject_id`)
        AND (`w`.`classroom` = `i`.`classroom`))))
    JOIN `course_instructor_view` `c` ON (((`c`.`instructor_id` = `i`.`instructor_id`)
        AND (`c`.`school_subject_id` = `w`.`school_subject_id`))))
WHERE
    `w`.`student_id` = coalesce(_student_id,`w`.`student_id`)
    and `c`.`school_subject_id`= coalesce(_school_subject_id,`c`.`school_subject_id`)
    and `c`.`instructor_id` = coalesce(_instructor_id,`c`.`instructor_id`)
    and c.is_visible=True
    order by c.date_start_course desc
    ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `student_list_instructor` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `student_list_instructor`(IN _id INT, IN _allInfos INT)
BEGIN
SELECT 
    id,
    school_id,
    first_name,
    last_name,
    email,
    'instructor' as role,
  case when _allInfos=1 then address else '' end as address,
  case when _allInfos=1 then phone_primary else '' end phone_primary,
  case when _allInfos=1 then phone_secondary else '' end phone_secondary,
  case when _allInfos=1 then registration_date else null end registration_date,
  case when _allInfos=1 then if(active_account,1,0) else 0 end active_account,
  case when _allInfos=1 then image else null end image,
  case when _allInfos=1 then introduction_brief else '' end introduction_brief,
  case when _allInfos=1 then country_city_id else 0 end country_city_id
FROM
  instructor_profile    s
    
WHERE active_account=True and
    EXISTS( SELECT 
            1
        FROM
            instructor_student_subject_qualification_view p
        WHERE
            instructor_id = s.id
                AND p.student_id = _id)
order by first_name,last_name;


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `country_region_city`
--

/*!50001 DROP VIEW IF EXISTS `country_region_city`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `country_region_city` AS select `r`.`region` AS `region`,`c`.`id` AS `id`,`c`.`city` AS `city`,`c`.`region_id` AS `region_id` from (`country_region` `r` join `country_city` `c` on((`c`.`region_id` = `r`.`id`))) order by `r`.`region`,`c`.`city` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `course_chapter_content_view`
--

/*!50001 DROP VIEW IF EXISTS `course_chapter_content_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `course_chapter_content_view` AS select `ch`.`id` AS `chapter_id`,`ch`.`course_id` AS `course_id`,`ch`.`chapter_title` AS `chapter_title`,`ch`.`chapter_description` AS `chapter_description`,`ch`.`num_of_reading` AS `num_of_reading`,`ch`.`num_of_contents` AS `num_of_contents`,`ch`.`is_visible` AS `chapter_is_visible`,`ch`.`sequence` AS `chapter_sequence`,`ct`.`id` AS `content_id`,`ct`.`content_type_id` AS `content_type_id`,`ct`.`is_important` AS `is_important`,`ct`.`time_required_in_sec` AS `time_required_in_sec`,`ct`.`is_open_for_free` AS `is_open_for_free`,`ct`.`is_visible` AS `content_is_visible`,`ct`.`content_url` AS `content_url`,`ct`.`content_text` AS `content_text`,`ct`.`content_brief` AS `content_brief`,`ct`.`date_creation` AS `date_creation`,`ct`.`date_update` AS `date_update`,`ct`.`sequence` AS `content_sequence`,`ctp`.`content_type` AS `content_type`,`ct`.`content_cover_url` AS `content_cover_url`,`ct`.`file_size_in_bytes` AS `file_size_in_bytes` from ((`course_chapter` `ch` join `course_chapter_content` `ct` on((`ct`.`course_chapter_id` = `ch`.`id`))) join `content_type` `ctp` on((`ctp`.`id` = `ct`.`content_type_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `course_chapter_progress_view`
--

/*!50001 DROP VIEW IF EXISTS `course_chapter_progress_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `course_chapter_progress_view` AS select `learning_progress_view`.`enrollment_id` AS `enrollment_id`,`learning_progress_view`.`student_id` AS `student_id`,`learning_progress_view`.`course_id` AS `course_id`,`learning_progress_view`.`course_chapter_id` AS `course_chapter_id`,count(0) AS `total_chapter`,round(((sum((case when (`learning_progress_view`.`status` = 'C') then 1 when (`learning_progress_view`.`status` = 'B') then 0.5 else 0 end)) / count(0)) * 100),0) AS `chapter_completion_percentage`,round(avg(((sum((case when (`learning_progress_view`.`status` = 'C') then 1 when (`learning_progress_view`.`status` = 'B') then 0.5 else 0 end)) / count(0)) * 100)) OVER (PARTITION BY `learning_progress_view`.`enrollment_id` ) ,0) AS `course_completion_percentage` from `learning_progress_view` group by `learning_progress_view`.`enrollment_id`,`learning_progress_view`.`student_id`,`learning_progress_view`.`course_id`,`learning_progress_view`.`course_chapter_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `course_chapter_view`
--

/*!50001 DROP VIEW IF EXISTS `course_chapter_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `course_chapter_view` AS select `c`.`course_title` AS `course_title`,`c`.`course_brief` AS `course_brief`,`c`.`instructor_id` AS `instructor_id`,`c`.`num_of_chapters` AS `num_of_chapters`,`c`.`course_fee` AS `course_fee`,`c`.`language_id` AS `language_id`,`c`.`school_subject_id` AS `school_subject_id`,`c`.`is_visible` AS `is_course_visible`,`c`.`date_creation` AS `date_creation`,`c`.`date_update` AS `date_update`,`c`.`date_start_course` AS `date_start_course`,`c`.`date_end_course` AS `date_end_course`,`l`.`language_name` AS `language_name`,`l`.`language_code` AS `language_code`,`ss`.`school_id` AS `school_id`,`s`.`label` AS `label_subject`,`q`.`code` AS `code_qualification`,`q`.`education` AS `education`,`q`.`level` AS `level`,`q`.`label` AS `label_qualification`,`ch`.`id` AS `id`,`ch`.`course_id` AS `course_id`,`ch`.`chapter_title` AS `chapter_title`,`ch`.`chapter_description` AS `chapter_description`,`ch`.`num_of_reading` AS `num_of_reading`,`ch`.`num_of_contents` AS `num_of_contents`,`ch`.`is_visible` AS `is_visible`,`ch`.`sequence` AS `sequence`,`ch`.`date_chapter_creation` AS `date_chapter_creation`,`ch`.`date_chapter_update` AS `date_chapter_update` from (((((`course` `c` join `course_chapter` `ch` on((`c`.`id` = `ch`.`course_id`))) join `language` `l` on((`l`.`id` = `c`.`language_id`))) join `school_subject` `ss` on((`ss`.`id` = `c`.`school_subject_id`))) join `subject` `s` on((`s`.`id` = `ss`.`subject_id`))) join `qualification` `q` on((`q`.`id` = `ss`.`qualification_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `course_instructor_enrollment_view`
--

/*!50001 DROP VIEW IF EXISTS `course_instructor_enrollment_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `course_instructor_enrollment_view` AS select `c`.`id` AS `id`,`c`.`course_title` AS `course_title`,`c`.`course_brief` AS `course_brief`,`c`.`instructor_id` AS `instructor_id`,`c`.`num_of_chapters` AS `num_of_chapters`,`c`.`course_fee` AS `course_fee`,`c`.`language_id` AS `language_id`,`c`.`school_subject_id` AS `school_subject_id`,`c`.`is_visible` AS `is_visible`,`c`.`date_creation` AS `date_creation`,`c`.`date_update` AS `date_update`,`c`.`date_start_course` AS `date_start_course`,`c`.`date_end_course` AS `date_end_course`,`l`.`language_name` AS `language_name`,`ss`.`school_id` AS `school_id`,`s`.`label` AS `label_subject`,`q`.`code` AS `code_qualification`,`q`.`education` AS `education`,`q`.`level` AS `level`,`q`.`label` AS `label_qualification`,`pr`.`first_name` AS `first_name`,`pr`.`last_name` AS `last_name`,`pr`.`active_account` AS `active_account`,`pr`.`email` AS `email`,`pr`.`num_of_published_courses` AS `num_of_published_courses`,`en`.`id` AS `enrollment_id`,`en`.`student_id` AS `student_id`,`en`.`enrollment_date` AS `enrollment_date`,`en`.`last_activity` AS `last_activity` from ((((((`course` `c` join `language` `l` on((`l`.`id` = `c`.`language_id`))) join `instructor` `pr` on((`pr`.`id` = `c`.`instructor_id`))) join `school_subject` `ss` on((`ss`.`id` = `c`.`school_subject_id`))) join `subject` `s` on((`s`.`id` = `ss`.`subject_id`))) join `qualification` `q` on((`q`.`id` = `ss`.`qualification_id`))) join `enrollment` `en` on((`en`.`course_id` = `c`.`id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `course_instructor_view`
--

/*!50001 DROP VIEW IF EXISTS `course_instructor_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `course_instructor_view` AS select `c`.`id` AS `id`,`c`.`course_title` AS `course_title`,`c`.`course_brief` AS `course_brief`,`c`.`instructor_id` AS `instructor_id`,`c`.`num_of_chapters` AS `num_of_chapters`,`c`.`course_fee` AS `course_fee`,`c`.`language_id` AS `language_id`,`c`.`school_subject_id` AS `school_subject_id`,`c`.`is_visible` AS `is_visible`,`c`.`date_creation` AS `date_creation`,`c`.`date_update` AS `date_update`,`c`.`date_start_course` AS `date_start_course`,`c`.`date_end_course` AS `date_end_course`,`l`.`language_name` AS `language_name`,`l`.`language_code` AS `language_code`,`ss`.`school_id` AS `school_id`,`s`.`label` AS `label_subject`,`q`.`code` AS `code_qualification`,`q`.`education` AS `education`,`q`.`level` AS `level`,`q`.`label` AS `label_qualification`,`pr`.`first_name` AS `first_name`,`pr`.`last_name` AS `last_name`,`pr`.`active_account` AS `active_account`,`pr`.`email` AS `email`,`pr`.`num_of_published_courses` AS `num_of_published_courses` from (((((`course` `c` join `language` `l` on((`l`.`id` = `c`.`language_id`))) join `instructor` `pr` on((`pr`.`id` = `c`.`instructor_id`))) join `school_subject` `ss` on((`ss`.`id` = `c`.`school_subject_id`))) join `subject` `s` on((`s`.`id` = `ss`.`subject_id`))) join `qualification` `q` on((`q`.`id` = `ss`.`qualification_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `course_progress_view`
--

/*!50001 DROP VIEW IF EXISTS `course_progress_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `course_progress_view` AS select `lpv`.`enrollment_id` AS `enrollment_id`,`lpv`.`student_id` AS `student_id`,`lpv`.`course_id` AS `course_id`,round(((sum(`lpv`.`status_value`) / count(distinct `lpv`.`course_chapter_content_id`)) * 100),0) AS `course_completion_percentage` from (select `learning_progress_view`.`enrollment_id` AS `enrollment_id`,`learning_progress_view`.`student_id` AS `student_id`,`learning_progress_view`.`course_id` AS `course_id`,`learning_progress_view`.`course_chapter_content_id` AS `course_chapter_content_id`,max((case when (`learning_progress_view`.`status` = 'C') then 1 when (`learning_progress_view`.`status` = 'B') then 0.5 else 0 end)) AS `status_value` from `learning_progress_view` group by `learning_progress_view`.`enrollment_id`,`learning_progress_view`.`student_id`,`learning_progress_view`.`course_id`,`learning_progress_view`.`course_chapter_content_id`) `lpv` group by `lpv`.`enrollment_id`,`lpv`.`student_id`,`lpv`.`course_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `course_view`
--

/*!50001 DROP VIEW IF EXISTS `course_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `course_view` AS select `c`.`id` AS `id`,`c`.`course_title` AS `course_title`,`c`.`course_brief` AS `course_brief`,`c`.`instructor_id` AS `instructor_id`,`c`.`num_of_chapters` AS `num_of_chapters`,`c`.`course_fee` AS `course_fee`,`c`.`language_id` AS `language_id`,`c`.`school_subject_id` AS `school_subject_id`,`c`.`is_visible` AS `is_visible`,`c`.`date_creation` AS `date_creation`,`c`.`date_update` AS `date_update`,`c`.`date_start_course` AS `date_start_course`,`c`.`date_end_course` AS `date_end_course`,`l`.`language_name` AS `language_name`,`l`.`language_code` AS `language_code`,`ss`.`school_id` AS `school_id`,`s`.`label` AS `label_subject`,`q`.`code` AS `code_qualification`,`q`.`education` AS `education`,`q`.`level` AS `level`,`q`.`label` AS `label_qualification`,(select count(0) from `quizzes` `qz` where ((`qz`.`scope_id` = `c`.`id`) and (`qz`.`scope` = 'course'))) AS `num_of_quizzes` from ((((`course` `c` join `language` `l` on((`l`.`id` = `c`.`language_id`))) join `school_subject` `ss` on((`ss`.`id` = `c`.`school_subject_id`))) join `subject` `s` on((`s`.`id` = `ss`.`subject_id`))) join `qualification` `q` on((`q`.`id` = `ss`.`qualification_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `dashboard_instructor_calendar_assistance_view`
--

/*!50001 DROP VIEW IF EXISTS `dashboard_instructor_calendar_assistance_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `dashboard_instructor_calendar_assistance_view` AS select row_number() OVER (ORDER BY `co`.`instructor_id` )  AS `row_id`,`co`.`instructor_id` AS `instructor_id`,count(`c`.`id`) AS `count`,min(`c`.`date_demand`) AS `min_date_demand`,max(`c`.`date_demand`) AS `max_date_demand` from (`instructor_calendar_assistance` `c` join `course` `co` on((`co`.`id` = `c`.`course_id`))) where (`c`.`accepted` is null) group by `co`.`instructor_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `dashboard_instructor_course_view`
--

/*!50001 DROP VIEW IF EXISTS `dashboard_instructor_course_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `dashboard_instructor_course_view` AS select row_number() OVER (ORDER BY `course`.`instructor_id` )  AS `row_id`,`course`.`instructor_id` AS `instructor_id`,`course`.`is_visible` AS `is_visible`,count(`course`.`is_visible`) AS `count`,max(`course`.`date_creation`) AS `max_date_creation`,max(`course`.`date_update`) AS `max_date_update` from `course` group by `course`.`is_visible`,`course`.`instructor_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `dashboard_instructor_enrollment_course_view`
--

/*!50001 DROP VIEW IF EXISTS `dashboard_instructor_enrollment_course_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `dashboard_instructor_enrollment_course_view` AS select row_number() OVER (ORDER BY `c`.`instructor_id` )  AS `row_id`,`c`.`instructor_id` AS `instructor_id`,count(distinct `c`.`id`) AS `count_courses`,count(distinct (case when (`e`.`id` is not null) then `c`.`id` end)) AS `count`,min(`e`.`enrollment_date`) AS `min_enrollment_date`,max(`e`.`enrollment_date`) AS `max_enrollment_date` from (`course` `c` left join `enrollment` `e` on((`c`.`id` = `e`.`course_id`))) where (`c`.`is_visible` = 1) group by `c`.`instructor_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `dashboard_school_calendar_assistance_view`
--

/*!50001 DROP VIEW IF EXISTS `dashboard_school_calendar_assistance_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `dashboard_school_calendar_assistance_view` AS select row_number() OVER (ORDER BY `ins`.`school_id` )  AS `row_id`,`ins`.`school_id` AS `school_id`,count(`c`.`id`) AS `count`,min(`c`.`date_demand`) AS `min_date_demand`,max(`c`.`date_demand`) AS `max_date_demand` from ((`instructor_calendar_assistance` `c` join `course` `co` on((`co`.`id` = `c`.`course_id`))) join `instructor` `ins` on((`ins`.`id` = `co`.`instructor_id`))) where (`c`.`accepted` is null) group by `ins`.`school_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `dashboard_school_course_view`
--

/*!50001 DROP VIEW IF EXISTS `dashboard_school_course_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `dashboard_school_course_view` AS select row_number() OVER (ORDER BY `ins`.`school_id` )  AS `row_id`,`ins`.`school_id` AS `school_id`,`course`.`is_visible` AS `is_visible`,count(`course`.`is_visible`) AS `count`,max(`course`.`date_creation`) AS `max_date_creation`,max(`course`.`date_update`) AS `max_date_update` from (`course` join `instructor` `ins` on((`ins`.`id` = `course`.`instructor_id`))) group by `course`.`is_visible`,`ins`.`school_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `dashboard_school_enrollment_course_view`
--

/*!50001 DROP VIEW IF EXISTS `dashboard_school_enrollment_course_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `dashboard_school_enrollment_course_view` AS select row_number() OVER (ORDER BY `ins`.`school_id` )  AS `row_id`,`ins`.`school_id` AS `school_id`,count(distinct `c`.`id`) AS `count_courses`,count(distinct (case when (`e`.`id` is not null) then `c`.`id` end)) AS `count`,min(`e`.`enrollment_date`) AS `min_enrollment_date`,max(`e`.`enrollment_date`) AS `max_enrollment_date` from ((`course` `c` join `instructor` `ins` on((`c`.`instructor_id` = `ins`.`id`))) left join `enrollment` `e` on((`c`.`id` = `e`.`course_id`))) where (`c`.`is_visible` = 1) group by `ins`.`school_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `dashboard_student_calendar_assistance_view`
--

/*!50001 DROP VIEW IF EXISTS `dashboard_student_calendar_assistance_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `dashboard_student_calendar_assistance_view` AS select row_number() OVER (ORDER BY `c`.`student_id` )  AS `row_id`,`c`.`student_id` AS `student_id`,count(`c`.`id`) AS `count`,min(`c`.`date_demand`) AS `min_date_demand`,max(`c`.`date_demand`) AS `max_date_demand` from (`instructor_calendar_assistance` `c` join `course` `co` on((`co`.`id` = `c`.`course_id`))) where ((`c`.`accepted` = 1) and (`c`.`acceptance_date` >= curdate())) group by `c`.`student_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `dashboard_student_course_view`
--

/*!50001 DROP VIEW IF EXISTS `dashboard_student_course_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `dashboard_student_course_view` AS select row_number() OVER (ORDER BY `w`.`student_id` )  AS `row_id`,`w`.`student_id` AS `student_id`,count(`c`.`id`) AS `nbr_course`,max(`c`.`date_update`) AS `max_course_date_update`,count(distinct `i`.`instructor_id`) AS `nbr_instructor`,count(distinct `w`.`school_subject_id`) AS `nbr_subject` from ((`student_subject_course_view` `w` join `instructor_subject_classroom_view` `i` on(((`w`.`school_qualification_id` = `i`.`school_qualification_id`) and (`w`.`school_subject_id` = `i`.`school_subject_id`) and (`w`.`classroom` = `i`.`classroom`)))) left join `course` `c` on(((`c`.`instructor_id` = `i`.`instructor_id`) and (`c`.`school_subject_id` = `w`.`school_subject_id`)))) group by `w`.`student_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `dashboard_student_enrollment_course_view`
--

/*!50001 DROP VIEW IF EXISTS `dashboard_student_enrollment_course_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `dashboard_student_enrollment_course_view` AS select row_number() OVER (ORDER BY `w`.`student_id` )  AS `row_id`,`w`.`student_id` AS `student_id`,count(distinct `c`.`id`) AS `count_courses`,count(distinct (case when (`e`.`id` is not null) then `c`.`id` end)) AS `count`,min(`e`.`enrollment_date`) AS `min_enrollment_date`,max(`e`.`enrollment_date`) AS `max_enrollment_date` from (((`student_subject_course_view` `w` join `instructor_subject_classroom_view` `i` on(((`w`.`school_qualification_id` = `i`.`school_qualification_id`) and (`w`.`school_subject_id` = `i`.`school_subject_id`) and (`w`.`classroom` = `i`.`classroom`)))) join `course` `c` on(((`c`.`instructor_id` = `i`.`instructor_id`) and (`c`.`school_subject_id` = `w`.`school_subject_id`)))) left join `enrollment` `e` on(((`c`.`id` = `e`.`course_id`) and (`e`.`student_id` = `w`.`student_id`)))) group by `w`.`student_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `enrollment_course_view`
--

/*!50001 DROP VIEW IF EXISTS `enrollment_course_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `enrollment_course_view` AS select `c`.`id` AS `id`,`c`.`id` AS `course_id`,`c`.`course_title` AS `course_title`,`c`.`course_brief` AS `course_brief`,`c`.`instructor_id` AS `instructor_id`,`c`.`num_of_chapters` AS `num_of_chapters`,`c`.`course_fee` AS `course_fee`,`c`.`language_id` AS `language_id`,`c`.`school_subject_id` AS `school_subject_id`,`c`.`is_visible` AS `is_visible`,`c`.`date_creation` AS `date_creation`,`c`.`date_update` AS `date_update`,`l`.`language_name` AS `language_name`,`ss`.`school_id` AS `school_id`,`s`.`label` AS `label_subject`,`q`.`code` AS `code_qualification`,`q`.`education` AS `education`,`q`.`level` AS `level`,`q`.`label` AS `label_qualification`,`en`.`id` AS `enrollment_id`,`en`.`enrollment_date` AS `enrollment_date`,`en`.`last_activity` AS `last_activity`,`en`.`student_id` AS `student_id`,`st`.`first_name` AS `student_first_name`,`st`.`last_name` AS `student_last_name`,`st`.`classroom` AS `classroom` from ((((((`course` `c` join `language` `l` on((`l`.`id` = `c`.`language_id`))) join `school_subject` `ss` on((`ss`.`id` = `c`.`school_subject_id`))) join `subject` `s` on((`s`.`id` = `ss`.`subject_id`))) join `qualification` `q` on((`q`.`id` = `ss`.`qualification_id`))) join `enrollment` `en` on((`en`.`course_id` = `c`.`id`))) join `student` `st` on((`st`.`id` = `en`.`student_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `feedback_course_view`
--

/*!50001 DROP VIEW IF EXISTS `feedback_course_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `feedback_course_view` AS select `c`.`id` AS `id`,`c`.`course_title` AS `course_title`,`c`.`course_brief` AS `course_brief`,`c`.`instructor_id` AS `instructor_id`,`c`.`num_of_chapters` AS `num_of_chapters`,`c`.`course_fee` AS `course_fee`,`c`.`language_id` AS `language_id`,`c`.`school_subject_id` AS `school_subject_id`,`c`.`is_visible` AS `is_visible`,`c`.`date_creation` AS `date_creation`,`c`.`date_update` AS `date_update`,`l`.`language_name` AS `language_name`,`ss`.`school_id` AS `school_id`,`s`.`label` AS `label_subject`,`q`.`code` AS `code_qualification`,`q`.`education` AS `education`,`q`.`level` AS `level`,`q`.`label` AS `label_qualification`,`en`.`id` AS `enrollment_id`,`en`.`enrollment_date` AS `enrollment_date`,`en`.`student_id` AS `student_id`,`st`.`first_name` AS `student_first_name`,`st`.`last_name` AS `student_last_name`,`st`.`classroom` AS `classroom`,`fb`.`id` AS `feedback_id`,`fb`.`rating_score` AS `rating_score`,`fb`.`feedback_text` AS `feedback_text`,`fb`.`submission_date` AS `submission_date` from (((((((`course` `c` join `language` `l` on((`l`.`id` = `c`.`language_id`))) join `school_subject` `ss` on((`ss`.`id` = `c`.`school_subject_id`))) join `subject` `s` on((`s`.`id` = `ss`.`subject_id`))) join `qualification` `q` on((`q`.`id` = `ss`.`qualification_id`))) join `enrollment` `en` on((`en`.`course_id` = `c`.`id`))) join `feedback` `fb` on((`fb`.`enrollment_id` = `en`.`id`))) join `student` `st` on((`st`.`id` = `en`.`student_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `instructor_calendar_assistance_count_view`
--

/*!50001 DROP VIEW IF EXISTS `instructor_calendar_assistance_count_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `instructor_calendar_assistance_count_view` AS select `c`.`id` AS `id`,`c`.`instructor_id` AS `instructor_id`,`c`.`event_calendar_id` AS `event_calendar_id`,coalesce(`c`.`title`,`ev`.`event_calendar_en`) AS `title`,`c`.`start` AS `start`,`c`.`end` AS `end`,`c`.`allDay` AS `allDay`,`c`.`backgroundColor` AS `backgroundColor`,`c`.`event_description` AS `event_description`,count(`a`.`instructor_calendar_id`) AS `count_assistance`,ifnull(convert(group_concat(`a`.`id` separator ',') using utf8mb4),'') AS `list_instructor_calendar_assistance_ids` from ((`instructor_calendar` `c` left join (select `instructor_calendar_assistance`.`id` AS `id`,`instructor_calendar_assistance`.`instructor_calendar_id` AS `instructor_calendar_id`,`instructor_calendar_assistance`.`student_id` AS `student_id`,`instructor_calendar_assistance`.`course_id` AS `course_id`,`instructor_calendar_assistance`.`course_chapter_id` AS `course_chapter_id`,`instructor_calendar_assistance`.`course_chapter_content_id` AS `course_chapter_content_id`,`instructor_calendar_assistance`.`date_demand` AS `date_demand`,`instructor_calendar_assistance`.`description_demand` AS `description_demand`,`instructor_calendar_assistance`.`accepted` AS `accepted`,`instructor_calendar_assistance`.`acceptance_date` AS `acceptance_date`,`instructor_calendar_assistance`.`response_demand` AS `response_demand` from `instructor_calendar_assistance` where (`instructor_calendar_assistance`.`instructor_calendar_id` is not null)) `a` on((`c`.`id` = `a`.`instructor_calendar_id`))) left join `event_calendar` `ev` on((`ev`.`id` = `c`.`event_calendar_id`))) group by `c`.`id`,`a`.`instructor_calendar_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `instructor_calendar_assistance_view`
--

/*!50001 DROP VIEW IF EXISTS `instructor_calendar_assistance_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `instructor_calendar_assistance_view` AS select `ica`.`id` AS `id`,`ica`.`instructor_calendar_id` AS `instructor_calendar_id`,`ica`.`student_id` AS `student_id`,`ica`.`course_id` AS `course_id`,`ica`.`course_chapter_id` AS `course_chapter_id`,`ica`.`course_chapter_content_id` AS `course_chapter_content_id`,`ica`.`date_demand` AS `date_demand`,`ica`.`description_demand` AS `description_demand`,`ica`.`accepted` AS `accepted`,`ica`.`acceptance_date` AS `acceptance_date`,`ica`.`response_demand` AS `response_demand`,`ica`.`response_demand_link` AS `response_demand_link`,`c`.`course_title` AS `course_title`,`c`.`instructor_id` AS `instructor_id`,`ch`.`chapter_title` AS `chapter_title`,`cchc`.`content_brief` AS `content_brief`,`st`.`last_name` AS `student_last_name`,`st`.`first_name` AS `student_first_name`,`ins`.`last_name` AS `instructor_last_name`,`ins`.`first_name` AS `instructor_first_name`,`ins`.`school_id` AS `school_id`,`c`.`school_subject_id` AS `school_subject_id`,`s`.`label` AS `label_subject`,`q`.`education` AS `education`,`q`.`level` AS `level`,`q`.`label` AS `label_qualification`,`st`.`classroom` AS `classroom`,`ica`.`attachment_url` AS `attachment_url` from ((((((((`instructor_calendar_assistance` `ica` join `course` `c` on((`c`.`id` = `ica`.`course_id`))) left join `course_chapter` `ch` on(((`ch`.`id` = `ica`.`course_chapter_id`) and (`ch`.`course_id` = `c`.`id`)))) left join `course_chapter_content` `cchc` on(((`cchc`.`id` = `ica`.`course_chapter_content_id`) and (`ch`.`id` = `cchc`.`course_chapter_id`)))) join `student` `st` on((`st`.`id` = `ica`.`student_id`))) join `instructor` `ins` on((`ins`.`id` = `c`.`instructor_id`))) join `school_subject` `ss` on((`ss`.`id` = `c`.`school_subject_id`))) join `subject` `s` on((`s`.`id` = `ss`.`subject_id`))) join `qualification` `q` on((`q`.`id` = `ss`.`qualification_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `instructor_calendar_view`
--

/*!50001 DROP VIEW IF EXISTS `instructor_calendar_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `instructor_calendar_view` AS select `c`.`id` AS `id`,`c`.`instructor_id` AS `instructor_id`,`c`.`event_calendar_id` AS `event_calendar_id`,coalesce(`c`.`title`,`ev`.`event_calendar_en`) AS `title`,`c`.`start` AS `start`,`c`.`end` AS `end`,`c`.`allDay` AS `allDay`,`c`.`event_description` AS `event_description`,`c`.`backgroundColor` AS `backgroundColor` from (`instructor_calendar` `c` left join `event_calendar` `ev` on((`ev`.`id` = `c`.`event_calendar_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `instructor_profile`
--

/*!50001 DROP VIEW IF EXISTS `instructor_profile`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `instructor_profile` AS select `instructor`.`id` AS `id`,`instructor`.`school_id` AS `school_id`,`instructor`.`first_name` AS `first_name`,`instructor`.`last_name` AS `last_name`,`instructor`.`email` AS `email`,`instructor`.`password` AS `password`,`instructor`.`address` AS `address`,`instructor`.`phone_primary` AS `phone_primary`,`instructor`.`phone_secondary` AS `phone_secondary`,`instructor`.`registration_date` AS `registration_date`,`instructor`.`active_account` AS `active_account`,`instructor`.`image` AS `image`,`instructor`.`introduction_brief` AS `introduction_brief`,`instructor`.`country_city_id` AS `country_city_id`,`instructor`.`country_id` AS `country_id`,`instructor`.`date_birth` AS `date_birth` from `instructor` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `instructor_student_subject_qualification_view`
--

/*!50001 DROP VIEW IF EXISTS `instructor_student_subject_qualification_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `instructor_student_subject_qualification_view` AS select `i`.`id` AS `view_id`,`s`.`id` AS `student_id`,`s`.`school_id` AS `school_id`,`s`.`school_qualification_id` AS `school_qualification_id`,`s`.`classroom` AS `classroom`,`s`.`first_name` AS `first_name`,`s`.`last_name` AS `last_name`,`s`.`email` AS `email`,`s`.`password` AS `password`,`s`.`address` AS `address`,`s`.`phone_primary` AS `phone_primary`,`s`.`phone_secondary` AS `phone_secondary`,`s`.`registration_date` AS `registration_date`,`s`.`image` AS `image`,`s`.`num_of_courses_enrolled` AS `num_of_courses_enrolled`,`s`.`num_of_courses_completed` AS `num_of_courses_completed`,`s`.`active_account` AS `active_account`,`s`.`country_city_id` AS `country_city_id`,`s`.`country_id` AS `country_id`,`i`.`school_subject_id` AS `school_subject_id`,`i`.`instructor_id` AS `instructor_id`,`i`.`subject_id` AS `subject_id`,`i`.`qualification_id` AS `qualification_id`,`i`.`label_subject` AS `label_subject`,`i`.`code` AS `code`,`i`.`label_qualification` AS `label_qualification`,`i`.`level` AS `level`,`i`.`education` AS `education` from (`student` `s` join `instructor_subject_view` `i` on(((`s`.`school_qualification_id` = `i`.`school_qualification_id`) and (`s`.`classroom` = `i`.`classrooms_teaching`) and (`s`.`school_id` = `i`.`school_id`)))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `instructor_subject_classroom_view`
--

/*!50001 DROP VIEW IF EXISTS `instructor_subject_classroom_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `instructor_subject_classroom_view` AS select `t`.`id` AS `id`,`t`.`instructor_id` AS `instructor_id`,`t`.`school_subject_id` AS `school_subject_id`,`ss`.`school_qualification_id` AS `school_qualification_id`,`t`.`subject_price` AS `subject_price`,`ss`.`subject_id` AS `subject_id`,`ss`.`qualification_id` AS `qualification_id`,`ss`.`school_id` AS `school_id`,`ss`.`label_subject` AS `label_subject`,`ss`.`code` AS `code`,`ss`.`label_qualification` AS `label_qualification`,`ss`.`level` AS `level`,`ss`.`education` AS `education`,`j`.`classroom` AS `classroom` from ((`instructor_subject` `t` join `school_subject_view` `ss` on((`t`.`school_subject_id` = `ss`.`id`))) join json_table(replace(json_array(`t`.`classrooms_teaching`),',','","'), '$[*]' columns (`classroom` varchar(50) character set utf8mb4 path '$')) `j`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `instructor_subject_view`
--

/*!50001 DROP VIEW IF EXISTS `instructor_subject_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `instructor_subject_view` AS select `si`.`id` AS `id`,`si`.`school_subject_id` AS `school_subject_id`,`ss`.`school_qualification_id` AS `school_qualification_id`,`si`.`instructor_id` AS `instructor_id`,`ss`.`subject_id` AS `subject_id`,`ss`.`qualification_id` AS `qualification_id`,`ss`.`school_id` AS `school_id`,`ss`.`label_subject` AS `label_subject`,`ss`.`code` AS `code`,`ss`.`label_qualification` AS `label_qualification`,`ss`.`level` AS `level`,`ss`.`education` AS `education`,`si`.`classrooms_teaching` AS `classrooms_teaching` from (`instructor_subject` `si` join `school_subject_view` `ss` on(((`si`.`school_subject_id` = `ss`.`id`) and (length(`si`.`classrooms_teaching`) > 0)))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `learning_progress_view`
--

/*!50001 DROP VIEW IF EXISTS `learning_progress_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `learning_progress_view` AS select row_number() OVER (ORDER BY `lp`.`id` )  AS `row_id`,coalesce(`lp`.`id`,0) AS `id`,`e`.`id` AS `enrollment_id`,`e`.`student_id` AS `student_id`,`e`.`course_id` AS `course_id`,`cs`.`school_subject_id` AS `school_subject_id`,`ccc`.`course_chapter_id` AS `course_chapter_id`,`ccc`.`id` AS `course_chapter_content_id`,`lp`.`begin_timestamp` AS `begin_timestamp`,`lp`.`completion_timestamp` AS `completion_timestamp`,coalesce(`lp`.`status`,'N') AS `status`,`e`.`enrollment_date` AS `enrollment_date`,`e`.`last_activity` AS `last_activity` from ((((`enrollment` `e` join `course_chapter` `cc` on(((`cc`.`course_id` = `e`.`course_id`) and (`cc`.`is_visible` = 1)))) join `course_chapter_content` `ccc` on(((`ccc`.`course_chapter_id` = `cc`.`id`) and (`ccc`.`is_visible` = 1)))) join `course` `cs` on((`cs`.`id` = `e`.`course_id`))) left join `learning_progress` `lp` on(((`lp`.`course_chapter_content_id` = `ccc`.`id`) and (`e`.`id` = `lp`.`enrollment_id`)))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `messages_box_inbox_view`
--

/*!50001 DROP VIEW IF EXISTS `messages_box_inbox_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `messages_box_inbox_view` AS select `mb`.`id` AS `id`,`mb`.`user_sender_id` AS `user_sender_id`,`mb`.`user_sender_role` AS `user_sender_role`,`mb`.`subject` AS `subject`,`mb`.`date_update` AS `date_update`,`mb`.`to_trash` AS `to_trash`,`mb_r`.`id` AS `message_box_recipient_id`,`mb_r`.`user_recipient_id` AS `user_recipient_id`,`mb_r`.`user_recipient_role` AS `user_recipient_role`,`mb_r`.`is_read` AS `is_read`,`sender`.`full_name` AS `user_sender_full_name`,`sender`.`email` AS `user_sender_email`,`recp`.`full_name` AS `user_recipient_full_name`,`recp`.`email` AS `user_recipient_email` from (((`messages_box` `mb` join `messages_box_recipients` `mb_r` on((`mb_r`.`message_box_id` = `mb`.`id`))) join `users_app` `sender` on(((`mb`.`user_sender_id` = `sender`.`id`) and (`mb`.`user_sender_role` = `sender`.`role`)))) join `users_app` `recp` on(((`mb_r`.`user_recipient_id` = `recp`.`id`) and (`mb_r`.`user_recipient_role` = `recp`.`role`)))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `messages_box_view`
--

/*!50001 DROP VIEW IF EXISTS `messages_box_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `messages_box_view` AS select `mb`.`id` AS `id`,`mb`.`user_sender_id` AS `user_sender_id`,`mb`.`user_sender_role` AS `user_sender_role`,`mb`.`subject` AS `subject`,`mb`.`body` AS `body`,`mb`.`date_update` AS `date_update`,`mb`.`to_trash` AS `to_trash`,`mb_r`.`id` AS `message_box_recipient_id`,`mb_r`.`user_recipient_id` AS `user_recipient_id`,`mb_r`.`user_recipient_role` AS `user_recipient_role`,`mb_r`.`is_read` AS `is_read`,`sender`.`full_name` AS `user_sender_full_name`,`sender`.`email` AS `user_sender_email`,`recp`.`full_name` AS `user_recipient_full_name`,`recp`.`email` AS `user_recipient_email` from (((`messages_box` `mb` join `messages_box_recipients` `mb_r` on((`mb_r`.`message_box_id` = `mb`.`id`))) join `users_app` `sender` on(((`mb`.`user_sender_id` = `sender`.`id`) and (`mb`.`user_sender_role` = `sender`.`role`)))) join `users_app` `recp` on(((`mb_r`.`user_recipient_id` = `recp`.`id`) and (`mb_r`.`user_recipient_role` = `recp`.`role`)))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `school_payment_invoice_view`
--

/*!50001 DROP VIEW IF EXISTS `school_payment_invoice_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `school_payment_invoice_view` AS select `pk`.`name` AS `package_name`,`pk`.`price_per_student` AS `price_per_student`,`p`.`id` AS `id`,`p`.`school_id` AS `school_id`,`p`.`package_id` AS `package_id`,`p`.`number_of_students` AS `number_of_students`,`p`.`number_of_months` AS `number_of_months`,`p`.`amount_paid_reel` AS `amount_paid_reel`,`p`.`amount_paid_global` AS `amount_paid_global`,`st`.`label` AS `payment_method`,`p`.`discount_percentage` AS `discount_percentage`,`p`.`payment_date` AS `payment_date`,`p`.`renewal_date` AS `renewal_date`,`p`.`payment_status` AS `payment_status`,`p`.`transaction_reference` AS `transaction_reference`,`p`.`date_insert` AS `date_insert`,`s`.`name` AS `complete_name`,`s`.`email` AS `user_email` from (((`payment` `p` join `school` `s` on((`s`.`id` = `p`.`school_id`))) join `package` `pk` on((`pk`.`id` = `p`.`package_id`))) join `payment_status` `st` on((`st`.`code` = `p`.`payment_status`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `school_payment_view`
--

/*!50001 DROP VIEW IF EXISTS `school_payment_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `school_payment_view` AS with `last_payment_cte` as (select `p`.`school_id` AS `school_id`,max(`p`.`id`) AS `last_payment_id` from `payment` `p` where (`p`.`school_id`,`p`.`date_insert`) in (select `p2`.`school_id`,max(`p2`.`date_insert`) AS `max_date_insert` from `payment` `p2` where (`p2`.`payment_status` = 1) group by `p2`.`school_id`) group by `p`.`school_id`) select `p2`.`name` AS `package_name`,`p`.`id` AS `id`,`p`.`school_id` AS `school_id`,`p`.`package_id` AS `package_id`,`p`.`number_of_students` AS `number_of_students`,`p`.`number_of_months` AS `number_of_months`,`p`.`amount_paid_reel` AS `amount_paid_reel`,`p`.`amount_paid_global` AS `amount_paid_global`,`p`.`payment_method` AS `payment_method`,`p`.`discount_percentage` AS `discount_percentage`,`p`.`payment_date` AS `payment_date`,`p`.`renewal_date` AS `renewal_date`,`p`.`payment_status` AS `payment_status`,`p`.`transaction_reference` AS `transaction_reference`,`p`.`date_insert` AS `date_insert`,(case when (`p`.`id` = `lp`.`last_payment_id`) then 1 else 0 end) AS `last_payment` from ((`payment` `p` join `package` `p2` on((`p`.`package_id` = `p2`.`id`))) left join `last_payment_cte` `lp` on((`p`.`school_id` = `lp`.`school_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `school_profile`
--

/*!50001 DROP VIEW IF EXISTS `school_profile`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `school_profile` AS select `school`.`id` AS `id`,`school`.`name` AS `name`,`school`.`email` AS `email`,`school`.`password` AS `password`,`school`.`address` AS `address`,`school`.`phone_primary` AS `phone_primary`,`school`.`phone_secondary` AS `phone_secondary`,`school`.`registration_date` AS `registration_date`,`school`.`active_account` AS `active_account`,`school`.`image` AS `image`,`school`.`country_id` AS `country_id`,`school`.`introduction_brief` AS `introduction_brief`,`school`.`country_city_id` AS `country_city_id` from `school` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `school_qualification_view`
--

/*!50001 DROP VIEW IF EXISTS `school_qualification_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `school_qualification_view` AS select `q`.`id` AS `id`,`q`.`code` AS `code`,`q`.`label` AS `label`,`q`.`level` AS `level`,`q`.`education` AS `education`,`sq`.`nbr_class` AS `nbr_class`,`sq`.`classrooms_names` AS `classrooms_names`,`sq`.`id` AS `school_qualification_id`,`sq`.`qualification_id` AS `qualification_id`,`sq`.`school_id` AS `school_id` from (`school_qualification` `sq` join `qualification` `q` on((`q`.`id` = `sq`.`qualification_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `school_subject_view`
--

/*!50001 DROP VIEW IF EXISTS `school_subject_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `school_subject_view` AS select `ss`.`id` AS `id`,`ss`.`subject_id` AS `subject_id`,`ss`.`qualification_id` AS `qualification_id`,`ss`.`school_id` AS `school_id`,`s`.`label` AS `label_subject`,`q`.`code` AS `code`,`q`.`label` AS `label_qualification`,`q`.`level` AS `level`,`q`.`education` AS `education`,`sq`.`classrooms_names` AS `classrooms_names`,`sq`.`id` AS `school_qualification_id`,`ss`.`id` AS `school_subject_id` from (((`school_subject` `ss` join `school_qualification` `sq` on(((`sq`.`qualification_id` = `ss`.`qualification_id`) and (`sq`.`school_id` = `ss`.`school_id`)))) join `subject` `s` on((`s`.`id` = `ss`.`subject_id`))) join `qualification` `q` on((`q`.`id` = `ss`.`qualification_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `school_type_qualification_view`
--

/*!50001 DROP VIEW IF EXISTS `school_type_qualification_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `school_type_qualification_view` AS select `q`.`id` AS `id`,`q`.`label_fr` AS `label_fr`,`q`.`label_en` AS `label_en`,`q`.`label_es` AS `label_es`,`q`.`level_fr` AS `level_fr`,`q`.`level_en` AS `level_en`,`q`.`level_es` AS `level_es`,`q`.`school_type_id` AS `school_type_id`,`t`.`label_fr` AS `school_type_fr`,`t`.`label_en` AS `school_type_en`,`t`.`label_es` AS `school_type_es` from (`school_type_qualification` `q` join `school_type` `t` on((`t`.`id` = `q`.`school_type_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `school_type_subject_view`
--

/*!50001 DROP VIEW IF EXISTS `school_type_subject_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `school_type_subject_view` AS select `q`.`id` AS `id`,`q`.`label_fr` AS `label_fr`,`q`.`label_en` AS `label_en`,`q`.`label_es` AS `label_es`,`t`.`id` AS `school_type_id`,`t`.`label_fr` AS `school_type_fr`,`t`.`label_en` AS `school_type_en`,`t`.`label_es` AS `school_type_es` from (`school_type_subject` `q` join `school_type` `t` on((`t`.`id` = `q`.`school_type_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `student_activity`
--

/*!50001 DROP VIEW IF EXISTS `student_activity`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `student_activity` AS select `t`.`id` AS `id`,`t`.`student_id` AS `student_id`,`t`.`course_id` AS `course_id`,`t`.`date_activity` AS `date_activity`,`t`.`activity` AS `activity` from (select `e`.`id` AS `id`,`e`.`student_id` AS `student_id`,`e`.`course_id` AS `course_id`,`e`.`last_activity` AS `date_activity`,'enrollment' AS `activity` from `enrollment` `e` union all select `a`.`id` AS `id`,`a`.`student_id` AS `student_id`,`a`.`course_id` AS `course_id`,`a`.`date_demand` AS `date_demand`,'assistance' AS `activity` from `instructor_calendar_assistance` `a` union all select `f`.`id` AS `id`,`e`.`student_id` AS `student_id`,`e`.`course_id` AS `course_id`,`f`.`submission_date` AS `submission_date`,'feedback' AS `activity` from (`feedback` `f` join `enrollment` `e` on((`e`.`id` = `f`.`enrollment_id`)))) `t` order by `t`.`date_activity` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `student_calendar_assistance_count_view`
--

/*!50001 DROP VIEW IF EXISTS `student_calendar_assistance_count_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `student_calendar_assistance_count_view` AS select `c`.`id` AS `id`,`c`.`instructor_id` AS `instructor_id`,`a`.`student_id` AS `student_id`,`c`.`event_calendar_id` AS `event_calendar_id`,coalesce(`c`.`title`,`ev`.`event_calendar_en`) AS `title`,`c`.`start` AS `start`,`c`.`end` AS `end`,`c`.`allDay` AS `allDay`,`c`.`backgroundColor` AS `backgroundColor`,`c`.`event_description` AS `event_description`,count(`a`.`instructor_calendar_id`) AS `count_assistance`,ifnull(convert(group_concat(`a`.`id` separator ',') using utf8mb4),'') AS `list_instructor_calendar_assistance_ids` from ((`instructor_calendar` `c` join (select `instructor_calendar_assistance`.`id` AS `id`,`instructor_calendar_assistance`.`instructor_calendar_id` AS `instructor_calendar_id`,`instructor_calendar_assistance`.`student_id` AS `student_id`,`instructor_calendar_assistance`.`course_id` AS `course_id`,`instructor_calendar_assistance`.`course_chapter_id` AS `course_chapter_id`,`instructor_calendar_assistance`.`course_chapter_content_id` AS `course_chapter_content_id`,`instructor_calendar_assistance`.`date_demand` AS `date_demand`,`instructor_calendar_assistance`.`description_demand` AS `description_demand`,`instructor_calendar_assistance`.`accepted` AS `accepted`,`instructor_calendar_assistance`.`acceptance_date` AS `acceptance_date`,`instructor_calendar_assistance`.`response_demand` AS `response_demand` from `instructor_calendar_assistance` where (`instructor_calendar_assistance`.`instructor_calendar_id` is not null)) `a` on((`c`.`id` = `a`.`instructor_calendar_id`))) left join `event_calendar` `ev` on((`ev`.`id` = `c`.`event_calendar_id`))) group by `c`.`id`,`a`.`student_id`,`a`.`instructor_calendar_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `student_instructor_calendar_assistance_view`
--

/*!50001 DROP VIEW IF EXISTS `student_instructor_calendar_assistance_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `student_instructor_calendar_assistance_view` AS select `ica`.`id` AS `id`,`ica`.`instructor_calendar_id` AS `instructor_calendar_id`,`ica`.`student_id` AS `student_id`,`ica`.`course_id` AS `course_id`,`ica`.`course_chapter_id` AS `course_chapter_id`,`ica`.`course_chapter_content_id` AS `course_chapter_content_id`,`ica`.`date_demand` AS `date_demand`,`ica`.`description_demand` AS `description_demand`,`ica`.`accepted` AS `accepted`,`ica`.`acceptance_date` AS `acceptance_date`,`ica`.`response_demand` AS `response_demand`,`ica`.`response_demand_link` AS `response_demand_link`,`c`.`course_title` AS `course_title`,`c`.`instructor_id` AS `instructor_id`,`ch`.`chapter_title` AS `chapter_title`,`cchc`.`content_brief` AS `content_brief`,`st`.`last_name` AS `student_last_name`,`st`.`first_name` AS `student_first_name`,`st`.`classroom` AS `classroom`,`ins`.`last_name` AS `instructor_last_name`,`ins`.`first_name` AS `instructor_first_name`,`c`.`school_subject_id` AS `school_subject_id`,`s`.`label` AS `label_subject`,`q`.`education` AS `education`,`q`.`level` AS `level`,`q`.`label` AS `label_qualification`,`pl`.`event_calendar_id` AS `event_calendar_id`,coalesce(`pl`.`title`,`ev`.`event_calendar_en`) AS `pl_title`,`pl`.`start` AS `pl_start`,`pl`.`end` AS `pl_end`,`pl`.`allDay` AS `pl_allday`,`pl`.`backgroundColor` AS `pl_backgroundColor`,`ica`.`attachment_url` AS `attachment_url`,`pl`.`event_description` AS `pl_event_description` from ((((((((((`instructor_calendar_assistance` `ica` join `course` `c` on((`c`.`id` = `ica`.`course_id`))) join `course_chapter` `ch` on(((`ch`.`id` = `ica`.`course_chapter_id`) and (`ch`.`course_id` = `c`.`id`)))) join `course_chapter_content` `cchc` on(((`cchc`.`id` = `ica`.`course_chapter_content_id`) and (`ch`.`id` = `cchc`.`course_chapter_id`)))) join `student` `st` on((`st`.`id` = `ica`.`student_id`))) join `instructor` `ins` on((`ins`.`id` = `c`.`instructor_id`))) join `school_subject` `ss` on((`ss`.`id` = `c`.`school_subject_id`))) join `subject` `s` on((`s`.`id` = `ss`.`subject_id`))) join `qualification` `q` on((`q`.`id` = `ss`.`qualification_id`))) left join `instructor_calendar` `pl` on((`pl`.`id` = `ica`.`instructor_calendar_id`))) left join `event_calendar` `ev` on((`ev`.`id` = `pl`.`event_calendar_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `student_profile`
--

/*!50001 DROP VIEW IF EXISTS `student_profile`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `student_profile` AS select `student`.`id` AS `id`,`student`.`school_id` AS `school_id`,`student`.`first_name` AS `first_name`,`student`.`last_name` AS `last_name`,`student`.`email` AS `email`,`student`.`password` AS `password`,`student`.`address` AS `address`,`student`.`phone_primary` AS `phone_primary`,`student`.`phone_secondary` AS `phone_secondary`,`student`.`registration_date` AS `registration_date`,`student`.`active_account` AS `active_account`,`student`.`image` AS `image`,`student`.`country_city_id` AS `country_city_id`,`student`.`country_id` AS `country_id`,`student`.`school_qualification_id` AS `school_qualification_id`,`school_qualification_view`.`education` AS `education`,`student`.`classroom` AS `classroom`,`school_qualification_view`.`level` AS `level`,`school_qualification_view`.`label` AS `qualification`,`student`.`date_birth` AS `date_birth` from (`student` left join `school_qualification_view` on((`school_qualification_view`.`school_qualification_id` = `student`.`school_qualification_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `student_quiz_results`
--

/*!50001 DROP VIEW IF EXISTS `student_quiz_results`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `student_quiz_results` AS select `grouped`.`student_id` AS `student_id`,`grouped`.`quiz_id` AS `quiz_id`,`grouped`.`quiz_name` AS `quiz_name`,`grouped`.`scope` AS `scope`,`grouped`.`scope_id` AS `scope_id`,`grouped`.`time_limit` AS `time_limit`,`grouped`.`total_questions` AS `total_questions`,`grouped`.`correct_answers` AS `correct_answers`,round(((`grouped`.`correct_answers` * 100) / `grouped`.`total_questions`),0) AS `score`,`grouped`.`first_timestamp` AS `first_timestamp`,`grouped`.`latest_timestamp` AS `latest_timestamp`,row_number() OVER (ORDER BY `grouped`.`student_id`,`grouped`.`quiz_id` )  AS `row_id` from (select `sa`.`student_id` AS `student_id`,`q`.`id` AS `quiz_id`,`q`.`quiz_name` AS `quiz_name`,`q`.`scope` AS `scope`,`q`.`scope_id` AS `scope_id`,`q`.`time_limit` AS `time_limit`,(select count(0) from `questions` where (`questions`.`quiz_id` = `q`.`id`)) AS `total_questions`,sum((case when (`sa`.`selected_choice_index` = `qu`.`correct_answer`) then 1 else 0 end)) AS `correct_answers`,min(`sa`.`begin_timestamp`) AS `first_timestamp`,max(`sa`.`end_timestamp`) AS `latest_timestamp` from ((`student_answers` `sa` join `quizzes` `q` on((`q`.`id` = `sa`.`quiz_id`))) join `questions` `qu` on((`qu`.`id` = `sa`.`question_id`))) group by `sa`.`student_id`,`q`.`id`,`q`.`quiz_name`,`q`.`scope`,`q`.`scope_id`,`q`.`time_limit`) `grouped` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `student_subject_course_view`
--

/*!50001 DROP VIEW IF EXISTS `student_subject_course_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `student_subject_course_view` AS select `s`.`id` AS `student_id`,`s`.`school_id` AS `school_id`,`s`.`school_qualification_id` AS `school_qualification_id`,`ss`.`id` AS `school_subject_id`,`s`.`classroom` AS `classroom`,`ss`.`subject_id` AS `subject_id`,`ss`.`qualification_id` AS `qualification_id`,`sbj`.`label` AS `label_subject`,`q`.`code` AS `code`,`q`.`level` AS `level`,`q`.`label` AS `label_qualification`,`a`.`total_course` AS `total_course` from (((((`student` `s` join `school_qualification` `sq` on(((`sq`.`id` = `s`.`school_qualification_id`) and (`s`.`school_id` = `sq`.`school_id`)))) join `school_subject` `ss` on(((`ss`.`qualification_id` = `sq`.`qualification_id`) and (`s`.`school_id` = `ss`.`school_id`)))) join `qualification` `q` on((`q`.`id` = `sq`.`qualification_id`))) join `subject` `sbj` on((`sbj`.`id` = `ss`.`subject_id`))) left join lateral (select count(`c`.`id`) AS `total_course` from `course` `c` where ((`c`.`school_subject_id` = `ss`.`id`) and exists(select 1 from `instructor_subject` `iss` where ((`iss`.`instructor_id` = `c`.`instructor_id`) and (`iss`.`school_subject_id` = `c`.`school_subject_id`) and (locate(concat(concat(',',`s`.`classroom`),','),concat(concat(',',`iss`.`classrooms_teaching`),',')) > 0))))) `a` on((1 = 1))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `student_subject_view`
--

/*!50001 DROP VIEW IF EXISTS `student_subject_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `student_subject_view` AS select `s`.`id` AS `student_id`,`s`.`school_id` AS `school_id`,`s`.`school_qualification_id` AS `school_qualification_id`,`s`.`classroom` AS `classroom`,`ss`.`id` AS `school_subject_id`,`ss`.`subject_id` AS `subject_id`,`ss`.`qualification_id` AS `qualification_id`,`sbj`.`label` AS `label_subject`,`q`.`code` AS `code`,`q`.`level` AS `level`,`q`.`label` AS `label_qualification` from ((((`student` `s` join `school_qualification` `sq` on(((`sq`.`id` = `s`.`school_qualification_id`) and (`s`.`school_id` = `sq`.`school_id`)))) join `school_subject` `ss` on(((`ss`.`qualification_id` = `sq`.`qualification_id`) and (`s`.`school_id` = `ss`.`school_id`)))) join `qualification` `q` on((`q`.`id` = `sq`.`qualification_id`))) join `subject` `sbj` on((`sbj`.`id` = `ss`.`subject_id`))) where exists(select 1 from `instructor_subject_classroom_view` `iss` where ((`iss`.`school_subject_id` = `ss`.`id`) and (`iss`.`classroom` = `s`.`classroom`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `users_app`
--

/*!50001 DROP VIEW IF EXISTS `users_app`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `users_app` AS select `s`.`id` AS `id`,`s`.`email` AS `email`,`s`.`password` AS `password`,`s`.`phone_primary` AS `phone_primary`,`s`.`active_account` AS `active_account`,'School' AS `role`,`s`.`name` AS `full_name`,`s`.`school_type_id` AS `school_type_id`,`s`.`registration_date` AS `registration_date`,`s`.`renewal_date` AS `renewal_date` from `school` `s` union all select `i`.`id` AS `id`,`i`.`email` AS `email`,`i`.`password` AS `password`,`i`.`phone_primary` AS `phone_primary`,`i`.`active_account` AS `active_account`,'Instructor' AS `role`,concat(`i`.`first_name`,' ',`i`.`last_name`) AS `full_name`,`s`.`school_type_id` AS `school_type_id`,`i`.`registration_date` AS `registration_date`,`s`.`renewal_date` AS `renewal_date` from (`instructor` `i` join `school` `s` on((`i`.`school_id` = `s`.`id`))) union all select `t`.`id` AS `id`,`t`.`email` AS `email`,`t`.`password` AS `password`,`t`.`phone_primary` AS `phone_primary`,`t`.`active_account` AS `active_account`,'Student' AS `role`,concat(`t`.`first_name`,' ',`t`.`last_name`) AS `full_name`,`s`.`school_type_id` AS `school_type_id`,`t`.`registration_date` AS `registration_date`,`s`.`renewal_date` AS `renewal_date` from (`student` `t` join `school` `s` on((`t`.`school_id` = `s`.`id`))) */;
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

-- Dump completed on 2025-12-28  0:15:54
