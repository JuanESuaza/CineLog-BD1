-- MySQL dump 10.13  Distrib 8.0.46, for Linux (x86_64)
--
-- Host: localhost    Database: cinelog_db
-- ------------------------------------------------------
-- Server version	8.0.46

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
-- Table structure for table `CALIFICACION`
--

DROP TABLE IF EXISTS `CALIFICACION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CALIFICACION` (
  `id_usuario` int NOT NULL,
  `id_contenido` int NOT NULL,
  `puntuacion` decimal(3,1) NOT NULL,
  `resenia` text COLLATE utf8mb4_unicode_ci,
  `fecha_calificacion` date NOT NULL,
  PRIMARY KEY (`id_usuario`,`id_contenido`),
  KEY `IDX_CALIFICACION_CONT` (`id_contenido`),
  CONSTRAINT `FK_CAL_CONT` FOREIGN KEY (`id_contenido`) REFERENCES `CONTENIDO` (`id_contenido`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAL_USR` FOREIGN KEY (`id_usuario`) REFERENCES `USUARIO` (`id_usuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `CK_PUNTUACION` CHECK (((`puntuacion` >= 1.0) and (`puntuacion` <= 10.0)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Calificaciones de usuarios sobre contenidos (1 activa por par)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CALIFICACION`
--

LOCK TABLES `CALIFICACION` WRITE;
/*!40000 ALTER TABLE `CALIFICACION` DISABLE KEYS */;
INSERT INTO `CALIFICACION` VALUES (1,1,9.5,'Una de las mejores conclusiones de franquicia que he visto. El final de Tony me rompió el corazón.','2026-01-10'),(1,4,9.8,'Nolan en su máxima expresión. La secuencia del Trinity Test es simplemente perfecta.','2026-01-15'),(1,5,8.5,'Visualmente impresionante. Denis Villeneuve construyó un mundo increíble.','2026-02-01'),(1,11,9.0,'El episodio 3 me hizo llorar como nunca. Pedro Pascal es un actor increíble.','2026-03-01'),(2,1,8.0,'Muy buena película aunque siento que Infinity War fue mejor.','2026-01-20'),(2,2,9.2,'El mejor cliffhanger de la historia del cine.','2026-01-20'),(2,11,9.5,'La mejor serie que he visto en años. El episodio de Bill y Frank es perfecto.','2026-02-10'),(2,12,8.8,'Zendaya lleva la serie en sus hombros. Visualmente única.','2026-02-15'),(3,7,9.7,'Una obra maestra del cine de fantasía. Jackson creó algo único.','2026-01-05'),(3,8,9.5,'La batalla del Abismo de Helm es épica. La mejor de la trilogía para mí.','2026-01-06'),(3,9,9.3,'El fin de una era. Imperfecta pero emotiva.','2026-01-07'),(4,5,9.0,NULL,'2026-02-05'),(4,6,8.7,'Parte dos mejora todo lo de la primera entrega.','2026-02-05'),(5,10,8.5,'Una película de detectives brillante. Anya Taylor-Joy y Daniel Craig son perfectos.','2026-01-30'),(6,2,9.0,'Severa pelicula','2026-05-08'),(6,4,10.0,'Severa','2026-05-08'),(9,1,5.0,'Muy buena pelicula','2026-05-17');
/*!40000 ALTER TABLE `CALIFICACION` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CONTENIDO`
--

DROP TABLE IF EXISTS `CONTENIDO`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CONTENIDO` (
  `id_contenido` int NOT NULL AUTO_INCREMENT,
  `titulo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tipo` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Película | Serie',
  `anio_estreno` smallint DEFAULT NULL,
  `sinopsis` text COLLATE utf8mb4_unicode_ci,
  `idioma` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `url_portada` text COLLATE utf8mb4_unicode_ci,
  `fecha_agregado` date NOT NULL DEFAULT (curdate()),
  PRIMARY KEY (`id_contenido`),
  KEY `IDX_CONTENIDO_TITULO` (`titulo`),
  KEY `IDX_CONTENIDO_TIPO` (`tipo`),
  KEY `IDX_CONTENIDO_ANIO` (`anio_estreno`),
  CONSTRAINT `CK_TIPO` CHECK ((`tipo` in (_utf8mb4'Película',_utf8mb4'Serie')))
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Catálogo unificado de películas y series';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CONTENIDO`
--

LOCK TABLES `CONTENIDO` WRITE;
/*!40000 ALTER TABLE `CONTENIDO` DISABLE KEYS */;
INSERT INTO `CONTENIDO` VALUES (1,'Avengers: Endgame','Película',2019,'Los Vengadores sobrevivientes se unen para revertir el chasquido de Thanos y restaurar el universo.','Inglés','https://image.tmdb.org/t/p/w500/or06FN3Dka5tukK1e9sl16pB3iy.jpg','2026-01-01'),(2,'Avengers: Infinity War','Película',2018,'Los Vengadores y sus aliados deben estar dispuestos a sacrificarlo todo para derrotar al poderoso Thanos.','Inglés','https://image.tmdb.org/t/p/w500/7WsyChQLEftFiDOVTGkv3hFpyyt.jpg','2026-01-01'),(3,'Iron Man','Película',2008,'El empresario Tony Stark construye una armadura de alta tecnología y se convierte en el superhéroe Iron Man.','Inglés','https://image.tmdb.org/t/p/w500/78lPtwv72eTNqFW9COBYI0dWDJa.jpg','2026-01-01'),(4,'Oppenheimer','Película',2023,'La historia del físico J. Robert Oppenheimer y su papel en el desarrollo de la bomba atómica durante la Segunda Guerra Mundial.','Inglés','https://image.tmdb.org/t/p/w500/8Gxv8gSFCU0XGDykEGv7zR1n2ua.jpg','2026-01-01'),(5,'Dune: Parte Uno','Película',2021,'Paul Atreides, un joven brillante, viaja al planeta más peligroso del universo para proteger a su familia.','Inglés','https://image.tmdb.org/t/p/w500/d5NXSklXo0qyIYkgV94XAgMIckC.jpg','2026-01-01'),(6,'Dune: Parte Dos','Película',2024,'Paul Atreides se une a los Fremen y comienza un viaje espiritual y político para convertirse en Muad\'Dib.','Inglés','https://image.tmdb.org/t/p/w500/1pdfLvkbY9ohJlCjQH2CZjjYVvJ.jpg','2026-01-01'),(7,'El Señor de los Anillos: La Comunidad del Anillo','Película',2001,'El hobbit Frodo Bolsón hereda el Anillo Único y emprende un viaje para destruirlo.','Inglés','https://image.tmdb.org/t/p/w500/6oom5QYQ2yQTMJIbnvbkBL9cHo6.jpg','2026-01-01'),(8,'El Señor de los Anillos: Las Dos Torres','Película',2002,'La Comunidad del Anillo se divide mientras la guerra de los Reinos de los Hombres avanza.','Inglés','https://image.tmdb.org/t/p/w500/5VTN0pR8gcqV3EPUHHfMGnJYN9L.jpg','2026-01-01'),(9,'El Señor de los Anillos: El Retorno del Rey','Película',2003,'La batalla final por la Tierra Media determina el destino de todos sus habitantes.','Inglés','https://image.tmdb.org/t/p/w500/rCzpDGLbOoPwLjy3OAm5NUPOTrC.jpg','2026-01-01'),(10,'Knives Out','Película',2019,'Un detective investiga la muerte de un famoso escritor tras la reunión familiar en su mansión.','Inglés','https://image.tmdb.org/t/p/w500/pThyQovXQrw2m0s9x82twj48Jq4.jpg','2026-01-01'),(11,'The Last of Us','Serie',2023,'En un mundo post-apocalíptico devastado por una infección fúngica, Joel debe escoltar a Ellie a través de los peligros de los Estados Unidos.','Inglés','https://image.tmdb.org/t/p/w500/uKvVjHNqB5VmOrdxqAt2F7J78ED.jpg','2026-01-01'),(12,'Euphoria','Serie',2019,'Sigue a un grupo de adolescentes mientras navegan por las drogas, el amor, la identidad y el trauma.','Inglés','https://image.tmdb.org/t/p/w500/jtnfNzqZwN4E32FGGxx1YZaBWWf.jpg','2026-01-01'),(13,'The Mandalorian','Serie',2019,'Un guerrero mandaloriano viaja por la galaxia protegiendo a un misterioso niño de la especie del Maestro Yoda.','Inglés','https://image.tmdb.org/t/p/w500/eU1i6eHXlzMOlEq0ku1Rzq7Y4wA.jpg','2026-01-01'),(14,'The Queen\'s Gambit','Serie',2020,'Una joven huérfana se convierte en una prodigiosa jugadora de ajedrez mientras lucha contra su adicción a las drogas.','Inglés','https://image.tmdb.org/t/p/w500/zU0htwkhNvBQdVSIKB9s6hgVeFK.jpg','2026-01-01'),(15,'Severance','Serie',2022,'Los empleados de una corporación se someten a un procedimiento que separa sus recuerdos laborales de los personales.','Inglés','https://image.tmdb.org/t/p/w500/lFf6LLrQjYldcZItzOkGmMMigP7.jpg','2026-01-01'),(16,'La Pasión de Cristo','Película',2004,'Relata las últimas 12 horas de la vida de Jesucristo, desde su arresto en el jardín de Getsemaní hasta su crucifixión.','Arameo/Latín','https://es.web.img2.acsta.net/c_310_420/medias/nmedia/18/67/78/89/20068058.jpg','2026-05-17'),(17,'Ben-Hur','Película',1959,'Un príncipe judío traicionado por su amigo romano busca venganza mientras cruza el mundo antiguo en una épica historia de fe y redención.','Inglés','https://image.tmdb.org/t/p/w500/m4WQ1dBIrEIHZNCoAjdpxwSKWyH.jpg','2026-05-17'),(18,'El Príncipe de Egipto','Película',1998,'La historia de Moisés, desde su vida como príncipe de Egipto hasta su destino como líder del pueblo hebreo.','Inglés','https://en.wikipedia.org/wiki/Special:Redirect/file/Prince_of_egypt_ver2.jpg','2026-05-17'),(19,'Silencio','Película',2016,'Dos jesuitas portugueses viajan al Japón del siglo XVII en busca de su mentor desaparecido y enfrentan una brutal persecución religiosa.','Inglés','https://upload.wikimedia.org/wikipedia/en/3/36/Silence_%282016_film%29.png','2026-05-17');
/*!40000 ALTER TABLE `CONTENIDO` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CONTENIDO_GENERO`
--

DROP TABLE IF EXISTS `CONTENIDO_GENERO`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CONTENIDO_GENERO` (
  `id_contenido` int NOT NULL,
  `id_genero` int NOT NULL,
  PRIMARY KEY (`id_contenido`,`id_genero`),
  KEY `FK_CG_GEN` (`id_genero`),
  CONSTRAINT `FK_CG_CONT` FOREIGN KEY (`id_contenido`) REFERENCES `CONTENIDO` (`id_contenido`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CG_GEN` FOREIGN KEY (`id_genero`) REFERENCES `GENERO` (`id_genero`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Relación N:M entre contenidos y géneros';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CONTENIDO_GENERO`
--

LOCK TABLES `CONTENIDO_GENERO` WRITE;
/*!40000 ALTER TABLE `CONTENIDO_GENERO` DISABLE KEYS */;
INSERT INTO `CONTENIDO_GENERO` VALUES (1,1),(2,1),(3,1),(13,1),(1,2),(2,2),(5,2),(6,2),(7,2),(8,2),(9,2),(13,2),(17,2),(18,2),(1,3),(2,3),(3,3),(5,3),(6,3),(11,3),(13,3),(15,3),(4,4),(7,4),(8,4),(9,4),(11,4),(12,4),(14,4),(15,4),(16,4),(17,4),(19,4),(12,5),(4,7),(10,7),(11,7),(14,7),(15,7),(19,7),(18,8),(5,9),(6,9),(7,9),(8,9),(9,9),(10,11),(16,14),(17,14),(18,14),(19,14);
/*!40000 ALTER TABLE `CONTENIDO_GENERO` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CONTENIDO_PERSONA`
--

DROP TABLE IF EXISTS `CONTENIDO_PERSONA`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CONTENIDO_PERSONA` (
  `id_contenido` int NOT NULL,
  `id_persona` int NOT NULL,
  `rol` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Actor | Director | Actor y Director',
  PRIMARY KEY (`id_contenido`,`id_persona`),
  KEY `FK_CP_PER` (`id_persona`),
  CONSTRAINT `FK_CP_CONT` FOREIGN KEY (`id_contenido`) REFERENCES `CONTENIDO` (`id_contenido`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CP_PER` FOREIGN KEY (`id_persona`) REFERENCES `PERSONA` (`id_persona`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Participación de personas en contenidos con su rol';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CONTENIDO_PERSONA`
--

LOCK TABLES `CONTENIDO_PERSONA` WRITE;
/*!40000 ALTER TABLE `CONTENIDO_PERSONA` DISABLE KEYS */;
INSERT INTO `CONTENIDO_PERSONA` VALUES (1,1,'Actor'),(1,2,'Actor'),(1,4,'Director'),(1,5,'Director'),(2,1,'Actor'),(2,2,'Actor'),(2,4,'Director'),(2,5,'Director'),(3,1,'Actor'),(4,3,'Director'),(4,6,'Actor'),(5,10,'Director'),(5,11,'Actor'),(5,12,'Actor'),(6,10,'Director'),(6,11,'Actor'),(6,12,'Actor'),(7,4,'Director'),(8,4,'Director'),(9,4,'Director'),(10,7,'Actor'),(11,8,'Actor'),(12,12,'Actor'),(13,8,'Actor'),(14,9,'Actor');
/*!40000 ALTER TABLE `CONTENIDO_PERSONA` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `EPISODIO`
--

DROP TABLE IF EXISTS `EPISODIO`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `EPISODIO` (
  `id_episodio` int NOT NULL AUTO_INCREMENT,
  `numero_episodio` smallint NOT NULL,
  `titulo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `duracion_minutos` smallint DEFAULT NULL,
  `fecha_emision` date DEFAULT NULL,
  `id_temporada` int NOT NULL,
  PRIMARY KEY (`id_episodio`),
  KEY `IDX_EPISODIO_TEMP` (`id_temporada`),
  CONSTRAINT `FK_EP_TEMP` FOREIGN KEY (`id_temporada`) REFERENCES `TEMPORADA` (`id_temporada`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Episodios de una temporada';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `EPISODIO`
--

LOCK TABLES `EPISODIO` WRITE;
/*!40000 ALTER TABLE `EPISODIO` DISABLE KEYS */;
INSERT INTO `EPISODIO` VALUES (1,1,'Cuando estás perdido en las tinieblas',81,'2023-01-15',1),(2,2,'Infectados',55,'2023-01-22',1),(3,3,'Más allá',76,'2023-01-29',1),(4,4,'Por favor, espérame',47,'2023-02-05',1),(5,5,'Endure and Survive',60,'2023-02-10',1),(6,6,'Kin',58,'2023-02-19',1),(7,7,'Left Behind',51,'2023-02-26',1),(8,8,'When We Are in Need',50,'2023-03-05',1),(9,9,'Look for the Light',43,'2023-03-12',1);
/*!40000 ALTER TABLE `EPISODIO` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `FINALALTERNATIVO`
--

DROP TABLE IF EXISTS `FINALALTERNATIVO`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `FINALALTERNATIVO` (
  `id_usuario` int NOT NULL,
  `id_contenido` int NOT NULL,
  `texto_final` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_escritura` date NOT NULL,
  PRIMARY KEY (`id_usuario`,`id_contenido`),
  KEY `FK_FA_CONT` (`id_contenido`),
  CONSTRAINT `FK_FA_CONT` FOREIGN KEY (`id_contenido`) REFERENCES `CONTENIDO` (`id_contenido`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_FA_USR` FOREIGN KEY (`id_usuario`) REFERENCES `USUARIO` (`id_usuario`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Finales alternativos escritos por usuarios';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FINALALTERNATIVO`
--

LOCK TABLES `FINALALTERNATIVO` WRITE;
/*!40000 ALTER TABLE `FINALALTERNATIVO` DISABLE KEYS */;
INSERT INTO `FINALALTERNATIVO` VALUES (1,1,'En mi versión, Tony no muere. Usa el guante y logra sobrevivir gracias a la ayuda de Doctor Strange que proyecta un escudo de energía en el momento justo. Tony se retira con Pepper y Morgan, viviendo en paz mientras los demás Vengadores continúan protegiendo el universo.','2026-01-12'),(2,11,'En mi final, Joel y Ellie llegan al hospital y Joel no traiciona a la Humanidad. Joel le explica la situación a Ellie honestamente. Ellie decide voluntariamente sacrificarse, pero en el último momento los científicos descubren que pueden sintetizar la cura sin matarla. Joel y Ellie sobreviven y el mundo comienza a sanar.','2026-02-12'),(3,9,'Frodo decide quedarse en la Tierra Media en lugar de partir a los Puertos Grises. Sam, Merry y Pippin envejecen junto a él en la Comarca. En sus últimos años, Frodo escribe un segundo libro donde narra todo lo que no contó en el primero.','2026-01-08'),(4,5,'Paul rechaza el rol de Muad\'Dib y lidera una revolución pacífica junto a los Fremen para expulsar al Emperador sin convertirse en un mesías de guerra. La paz llega, aunque más lentamente.','2026-02-06'),(6,1,'Todos van por tacos!!!','2026-05-08'),(9,9,'El heroe decide destruir el anillo de otra forma.','2026-05-17');
/*!40000 ALTER TABLE `FINALALTERNATIVO` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `GENERO`
--

DROP TABLE IF EXISTS `GENERO`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `GENERO` (
  `id_genero` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id_genero`),
  UNIQUE KEY `UK_GENERO_NM` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Géneros cinematográficos y televisivos';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `GENERO`
--

LOCK TABLES `GENERO` WRITE;
/*!40000 ALTER TABLE `GENERO` DISABLE KEYS */;
INSERT INTO `GENERO` VALUES (1,'Acción'),(8,'Animación'),(2,'Aventura'),(3,'Ciencia Ficción'),(5,'Comedia'),(11,'Crimen'),(12,'Documental'),(4,'Drama'),(9,'Fantasía'),(14,'Religioso'),(10,'Romance'),(13,'Suspenso'),(6,'Terror'),(7,'Thriller');
/*!40000 ALTER TABLE `GENERO` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `LISTA`
--

DROP TABLE IF EXISTS `LISTA`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `LISTA` (
  `id_lista` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` text COLLATE utf8mb4_unicode_ci,
  `fecha_creacion` date NOT NULL DEFAULT (curdate()),
  `id_usuario` int NOT NULL,
  PRIMARY KEY (`id_lista`),
  KEY `IDX_LISTA_USR` (`id_usuario`),
  CONSTRAINT `FK_LISTA_USR` FOREIGN KEY (`id_usuario`) REFERENCES `USUARIO` (`id_usuario`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Listas personalizadas creadas por los usuarios';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `LISTA`
--

LOCK TABLES `LISTA` WRITE;
/*!40000 ALTER TABLE `LISTA` DISABLE KEYS */;
INSERT INTO `LISTA` VALUES (1,'Mi Top de Películas','Las películas que más me han marcado en la vida','2026-02-01',1),(2,'Saga del Infinito en orden','Las películas del MCU de la Saga del Infinito en orden cronológico','2026-02-10',1),(3,'Mejores Series del Momento','Series que estoy viendo o que recomiedo totalmente','2026-01-15',2),(4,'Películas para una noche lluviosa','Películas perfectas para ver en casa cuando llueve','2026-03-05',3),(5,'Mi Top de Ciencia Ficción','Las mejores películas y series de Sci-Fi según yo','2026-02-20',4),(7,'Pa Qliar','Pa Qliar','2026-05-08',6),(8,'Lista pa follar con medias','Lista pa follar con medias','2026-05-08',7),(9,'Mis favoritas','Lista de contenidos favoritos','2026-05-17',9),(11,'Primarias','','2026-05-17',10);
/*!40000 ALTER TABLE `LISTA` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `LISTACONTENIDO`
--

DROP TABLE IF EXISTS `LISTACONTENIDO`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `LISTACONTENIDO` (
  `id_lista` int NOT NULL,
  `id_contenido` int NOT NULL,
  `posicion` smallint NOT NULL,
  PRIMARY KEY (`id_lista`,`id_contenido`),
  KEY `FK_LC_CONT` (`id_contenido`),
  CONSTRAINT `FK_LC_CONT` FOREIGN KEY (`id_contenido`) REFERENCES `CONTENIDO` (`id_contenido`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_LC_LISTA` FOREIGN KEY (`id_lista`) REFERENCES `LISTA` (`id_lista`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Relación ordenada entre listas y contenidos';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `LISTACONTENIDO`
--

LOCK TABLES `LISTACONTENIDO` WRITE;
/*!40000 ALTER TABLE `LISTACONTENIDO` DISABLE KEYS */;
INSERT INTO `LISTACONTENIDO` VALUES (1,1,1),(1,4,2),(1,5,3),(1,7,4),(1,10,5),(2,1,3),(2,2,2),(2,3,1),(3,11,1),(3,14,3),(3,15,2),(4,4,3),(4,7,2),(4,9,1),(5,5,1),(5,6,2),(5,11,3),(7,5,2),(7,9,1),(8,2,1),(8,5,2),(9,1,3),(9,2,4),(9,4,5),(9,10,2),(9,11,1),(11,3,1);
/*!40000 ALTER TABLE `LISTACONTENIDO` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PELICULA`
--

DROP TABLE IF EXISTS `PELICULA`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PELICULA` (
  `id_contenido` int NOT NULL,
  `duracion_minutos` smallint NOT NULL,
  PRIMARY KEY (`id_contenido`),
  CONSTRAINT `FK_PEL_CONT` FOREIGN KEY (`id_contenido`) REFERENCES `CONTENIDO` (`id_contenido`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Atributos exclusivos de películas (MERE)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PELICULA`
--

LOCK TABLES `PELICULA` WRITE;
/*!40000 ALTER TABLE `PELICULA` DISABLE KEYS */;
INSERT INTO `PELICULA` VALUES (1,181),(2,149),(3,126),(4,180),(5,155),(6,166),(7,178),(8,179),(9,201),(10,130),(16,127),(17,212),(18,99),(19,161);
/*!40000 ALTER TABLE `PELICULA` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PERSONA`
--

DROP TABLE IF EXISTS `PERSONA`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PERSONA` (
  `id_persona` int NOT NULL AUTO_INCREMENT,
  `primer_nombre` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `segundo_nombre` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `primer_apellido` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `segundo_apellido` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fecha_nacimiento` date DEFAULT NULL,
  `nacionalidad` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `descripcion` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id_persona`),
  KEY `IDX_PERSONA_APELLIDO` (`primer_apellido`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Actores y directores del catálogo';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PERSONA`
--

LOCK TABLES `PERSONA` WRITE;
/*!40000 ALTER TABLE `PERSONA` DISABLE KEYS */;
INSERT INTO `PERSONA` VALUES (1,'Robert',NULL,'Downey','Jr.','1965-04-04','Estadounidense','Actor conocido por interpretar a Tony Stark / Iron Man en el MCU.'),(2,'Scarlett',NULL,'Johansson',NULL,'1984-11-22','Estadounidense','Actriz conocida por su papel de Natasha Romanoff / Black Widow en el MCU.'),(3,'Christopher',NULL,'Nolan',NULL,'1970-07-30','Británico','Director reconocido por películas como Inception, Interstellar y Oppenheimer.'),(4,'Anthony',NULL,'Russo',NULL,'1970-02-03','Estadounidense','Director junto a su hermano Joe Russo de Avengers: Infinity War y Endgame.'),(5,'Joe',NULL,'Russo',NULL,'1971-07-18','Estadounidense','Director junto a su hermano Anthony Russo de Avengers: Infinity War y Endgame.'),(6,'Cillian',NULL,'Murphy',NULL,'1976-05-25','Irlandés','Actor conocido por Peaky Blinders y su papel de J. Robert Oppenheimer.'),(7,'Ana',NULL,'de Armas',NULL,'1988-04-30','Cubana','Actriz conocida por Knives Out, No Time to Die y Blonde.'),(8,'Pedro',NULL,'Pascal',NULL,'1975-04-02','Chileno','Actor conocido por The Mandalorian y The Last of Us.'),(9,'Anya','Taylor','Joy',NULL,'1996-04-16','Británica','Actriz conocida por The Queen\'s Gambit y The Menu.'),(10,'Denis',NULL,'Villeneuve',NULL,'1967-10-03','Canadiense','Director de Dune, Arrival e Incendies.'),(11,'Timothée',NULL,'Chalamet',NULL,'1995-12-27','Estadounidense','Actor conocido por Call Me by Your Name y Dune.'),(12,'Zendaya',NULL,'Coleman',NULL,'1996-09-01','Estadounidense','Actriz conocida por Euphoria, Dune y Challengers.');
/*!40000 ALTER TABLE `PERSONA` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SAGA`
--

DROP TABLE IF EXISTS `SAGA`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `SAGA` (
  `id_saga` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` text COLLATE utf8mb4_unicode_ci,
  `id_universo` int NOT NULL,
  PRIMARY KEY (`id_saga`),
  KEY `FK_SAGA_UNIV` (`id_universo`),
  CONSTRAINT `FK_SAGA_UNIV` FOREIGN KEY (`id_universo`) REFERENCES `UNIVERSO` (`id_universo`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Sagas narrativas dentro de un universo';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SAGA`
--

LOCK TABLES `SAGA` WRITE;
/*!40000 ALTER TABLE `SAGA` DISABLE KEYS */;
INSERT INTO `SAGA` VALUES (1,'Saga del Infinito','Arco narrativo del MCU que culmina con Avengers: Infinity War y Endgame.',1),(2,'Saga de los Vengadores','Historias centradas en el equipo de los Vengadores dentro del MCU.',1),(3,'Saga Multiversal','Arco narrativo del MCU que explora el multiverso tras los eventos de Endgame.',1),(4,'La Trilogía del Anillo','Las tres películas principales de la adaptación de Tolkien por Peter Jackson.',4),(5,'La Trilogía del Hobbit','Precuela de El Señor de los Anillos, también adaptada por Peter Jackson.',4),(6,'La Trilogía de la Fuerza','Saga Skywalker: episodios VII, VIII y IX de Star Wars.',3);
/*!40000 ALTER TABLE `SAGA` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SAGA_CONTENIDO`
--

DROP TABLE IF EXISTS `SAGA_CONTENIDO`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `SAGA_CONTENIDO` (
  `id_saga` int NOT NULL,
  `id_contenido` int NOT NULL,
  PRIMARY KEY (`id_saga`,`id_contenido`),
  KEY `FK_SC_CONT` (`id_contenido`),
  CONSTRAINT `FK_SC_CONT` FOREIGN KEY (`id_contenido`) REFERENCES `CONTENIDO` (`id_contenido`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_SC_SAGA` FOREIGN KEY (`id_saga`) REFERENCES `SAGA` (`id_saga`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Relación N:M entre sagas y contenidos';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SAGA_CONTENIDO`
--

LOCK TABLES `SAGA_CONTENIDO` WRITE;
/*!40000 ALTER TABLE `SAGA_CONTENIDO` DISABLE KEYS */;
INSERT INTO `SAGA_CONTENIDO` VALUES (1,1),(2,1),(1,2),(2,2),(2,3),(4,7),(4,8),(4,9),(6,13);
/*!40000 ALTER TABLE `SAGA_CONTENIDO` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SERIE`
--

DROP TABLE IF EXISTS `SERIE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `SERIE` (
  `id_contenido` int NOT NULL,
  `en_emision` tinyint(1) NOT NULL DEFAULT '0' COMMENT '1=En emisión, 0=Finalizada',
  `num_temporadas` smallint NOT NULL DEFAULT '1',
  PRIMARY KEY (`id_contenido`),
  CONSTRAINT `FK_SER_CONT` FOREIGN KEY (`id_contenido`) REFERENCES `CONTENIDO` (`id_contenido`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Atributos exclusivos de series (MERE)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SERIE`
--

LOCK TABLES `SERIE` WRITE;
/*!40000 ALTER TABLE `SERIE` DISABLE KEYS */;
INSERT INTO `SERIE` VALUES (11,1,2),(12,1,3),(13,1,3),(14,0,1),(15,1,2);
/*!40000 ALTER TABLE `SERIE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TEMPORADA`
--

DROP TABLE IF EXISTS `TEMPORADA`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TEMPORADA` (
  `id_temporada` int NOT NULL AUTO_INCREMENT,
  `numero_temporada` smallint NOT NULL,
  `anio_estreno` smallint DEFAULT NULL,
  `id_contenido` int NOT NULL,
  PRIMARY KEY (`id_temporada`),
  KEY `FK_TEMP_CONT` (`id_contenido`),
  CONSTRAINT `FK_TEMP_CONT` FOREIGN KEY (`id_contenido`) REFERENCES `CONTENIDO` (`id_contenido`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Temporadas de una serie';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TEMPORADA`
--

LOCK TABLES `TEMPORADA` WRITE;
/*!40000 ALTER TABLE `TEMPORADA` DISABLE KEYS */;
INSERT INTO `TEMPORADA` VALUES (1,1,2023,11),(2,2,2025,11),(3,1,2019,12),(4,2,2022,12),(5,1,2019,13),(6,2,2020,13),(7,3,2023,13),(8,1,2020,14),(9,1,2022,15),(10,2,2024,15);
/*!40000 ALTER TABLE `TEMPORADA` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `UNIVERSO`
--

DROP TABLE IF EXISTS `UNIVERSO`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `UNIVERSO` (
  `id_universo` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id_universo`),
  UNIQUE KEY `UK_UNIVERSO_NM` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Universos narrativos que agrupan sagas';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `UNIVERSO`
--

LOCK TABLES `UNIVERSO` WRITE;
/*!40000 ALTER TABLE `UNIVERSO` DISABLE KEYS */;
INSERT INTO `UNIVERSO` VALUES (1,'Universo Cinematográfico de Marvel','Franquicia de superhéroes de Marvel Studios basada en los cómics de Marvel Comics.'),(2,'Universo de DC','Franquicia de superhéroes de DC Studios basada en los cómics de DC Comics.'),(3,'Universo de Star Wars','Saga galáctica creada por George Lucas ambientada hace mucho tiempo en una galaxia muy, muy lejana.'),(4,'Universo de El Señor de los Anillos','Universo de fantasía épica creado por J.R.R. Tolkien, adaptado al cine por Peter Jackson.');
/*!40000 ALTER TABLE `UNIVERSO` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `USUARIO`
--

DROP TABLE IF EXISTS `USUARIO`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `USUARIO` (
  `id_usuario` int NOT NULL AUTO_INCREMENT,
  `primer_nombre` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `segundo_nombre` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `primer_apellido` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `segundo_apellido` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nombre_usuario` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `correo_electronico` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `contrasenia` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Almacenada como hash bcrypt',
  `fecha_nacimiento` date NOT NULL,
  PRIMARY KEY (`id_usuario`),
  UNIQUE KEY `UK_USUARIO_NM` (`nombre_usuario`),
  UNIQUE KEY `UK_USUARIO_CE` (`correo_electronico`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Usuarios registrados en la plataforma CineLog';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `USUARIO`
--

LOCK TABLES `USUARIO` WRITE;
/*!40000 ALTER TABLE `USUARIO` DISABLE KEYS */;
INSERT INTO `USUARIO` VALUES (1,'Daniel',NULL,'Bautista','Acosta','danielletto','daniel.bautista@unbosque.edu.co','$2b$12$placeholder_hash_1','2005-03-15'),(2,'Nicole','Diane','Cruz','Garcia','nicoledianecd','nicole.cruz@unbosque.edu.co','$2b$12$placeholder_hash_2','2004-11-08'),(3,'Juan','David','Alvarez',NULL,'juandavid_av','juan.alvarez@unbosque.edu.co','$2b$12$placeholder_hash_3','2005-06-22'),(4,'Maria',NULL,'Gonzalez','Lopez','mariag_films','maria.gonzalez@email.com','$2b$12$placeholder_hash_4','1998-07-14'),(5,'Carlos',NULL,'Ramirez',NULL,'carlosram99','carlos.ramirez@email.com','$2b$12$placeholder_hash_5','1999-02-28'),(6,'Juan',NULL,'Dick',NULL,'Juandick','jdalfonso75@gmail.com','$2b$12$nVsquSxjQ2m12p08g4vpE.PHLgU0uSSPrzrUV/AYnkV8cUbZjsEnC','2004-06-15'),(7,'Suaza ',NULL,'Suaza',NULL,'jsuaza','esuazam@gmail.com','$2b$12$LO95Mq/Q26hRUAY4IEKOOev7QwcBuj6Cm2ysoshYRF0fXAcV2865C','2006-02-16'),(8,'Nicolas',NULL,'Forero',NULL,'Niko','nsforero06@gmail.com','$2b$12$TPTKO66eqtlHAqvENfQgBeEca1Kd.4FsnkH1cQMUx4O7ieMhUR8g.','2006-12-13'),(9,'Nicolas',NULL,'Suarez',NULL,'nisua4','nisua4@test.com','$2a$10$IifJLiTW2hw57O1jfxVO5u18EphtM582E71PjORq0IO1XS6y6m4HC','2000-01-01'),(10,'Ana ',NULL,'Martinez',NULL,'amartin21','am.martinez@gmail.com','$2a$10$SYJvpzLdxaMn42HIj.K1e.8gwAkhRFtqCk/lf2/ltdQWYuyOI2W9a','2001-01-01');
/*!40000 ALTER TABLE `USUARIO` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `V_CALIFICACIONES_DETALLE`
--

DROP TABLE IF EXISTS `V_CALIFICACIONES_DETALLE`;
/*!50001 DROP VIEW IF EXISTS `V_CALIFICACIONES_DETALLE`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `V_CALIFICACIONES_DETALLE` AS SELECT 
 1 AS `nombre_usuario`,
 1 AS `titulo`,
 1 AS `tipo`,
 1 AS `puntuacion`,
 1 AS `resenia`,
 1 AS `fecha_calificacion`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `V_CATALOGO_COMPLETO`
--

DROP TABLE IF EXISTS `V_CATALOGO_COMPLETO`;
/*!50001 DROP VIEW IF EXISTS `V_CATALOGO_COMPLETO`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `V_CATALOGO_COMPLETO` AS SELECT 
 1 AS `id_contenido`,
 1 AS `titulo`,
 1 AS `tipo`,
 1 AS `anio_estreno`,
 1 AS `idioma`,
 1 AS `url_portada`,
 1 AS `puntuacion_promedio`,
 1 AS `total_calificaciones`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `V_LISTAS_DETALLE`
--

DROP TABLE IF EXISTS `V_LISTAS_DETALLE`;
/*!50001 DROP VIEW IF EXISTS `V_LISTAS_DETALLE`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `V_LISTAS_DETALLE` AS SELECT 
 1 AS `nombre_usuario`,
 1 AS `nombre_lista`,
 1 AS `posicion`,
 1 AS `contenido`,
 1 AS `tipo`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `V_PELICULAS`
--

DROP TABLE IF EXISTS `V_PELICULAS`;
/*!50001 DROP VIEW IF EXISTS `V_PELICULAS`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `V_PELICULAS` AS SELECT 
 1 AS `id_contenido`,
 1 AS `titulo`,
 1 AS `anio_estreno`,
 1 AS `sinopsis`,
 1 AS `idioma`,
 1 AS `url_portada`,
 1 AS `duracion_minutos`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `V_REPARTO_COMPLETO`
--

DROP TABLE IF EXISTS `V_REPARTO_COMPLETO`;
/*!50001 DROP VIEW IF EXISTS `V_REPARTO_COMPLETO`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `V_REPARTO_COMPLETO` AS SELECT 
 1 AS `contenido`,
 1 AS `tipo`,
 1 AS `persona`,
 1 AS `rol`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `V_SERIES`
--

DROP TABLE IF EXISTS `V_SERIES`;
/*!50001 DROP VIEW IF EXISTS `V_SERIES`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `V_SERIES` AS SELECT 
 1 AS `id_contenido`,
 1 AS `titulo`,
 1 AS `anio_estreno`,
 1 AS `sinopsis`,
 1 AS `idioma`,
 1 AS `url_portada`,
 1 AS `en_emision`,
 1 AS `num_temporadas`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `V_CALIFICACIONES_DETALLE`
--

/*!50001 DROP VIEW IF EXISTS `V_CALIFICACIONES_DETALLE`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `V_CALIFICACIONES_DETALLE` AS select `u`.`nombre_usuario` AS `nombre_usuario`,`c`.`titulo` AS `titulo`,`c`.`tipo` AS `tipo`,`cal`.`puntuacion` AS `puntuacion`,`cal`.`resenia` AS `resenia`,`cal`.`fecha_calificacion` AS `fecha_calificacion` from ((`CALIFICACION` `cal` join `USUARIO` `u` on((`cal`.`id_usuario` = `u`.`id_usuario`))) join `CONTENIDO` `c` on((`cal`.`id_contenido` = `c`.`id_contenido`))) order by `cal`.`fecha_calificacion` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `V_CATALOGO_COMPLETO`
--

/*!50001 DROP VIEW IF EXISTS `V_CATALOGO_COMPLETO`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `V_CATALOGO_COMPLETO` AS select `c`.`id_contenido` AS `id_contenido`,`c`.`titulo` AS `titulo`,`c`.`tipo` AS `tipo`,`c`.`anio_estreno` AS `anio_estreno`,`c`.`idioma` AS `idioma`,`c`.`url_portada` AS `url_portada`,round(avg(`cal`.`puntuacion`),1) AS `puntuacion_promedio`,count(`cal`.`id_usuario`) AS `total_calificaciones` from (`CONTENIDO` `c` left join `CALIFICACION` `cal` on((`c`.`id_contenido` = `cal`.`id_contenido`))) group by `c`.`id_contenido`,`c`.`titulo`,`c`.`tipo`,`c`.`anio_estreno`,`c`.`idioma`,`c`.`url_portada` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `V_LISTAS_DETALLE`
--

/*!50001 DROP VIEW IF EXISTS `V_LISTAS_DETALLE`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `V_LISTAS_DETALLE` AS select `u`.`nombre_usuario` AS `nombre_usuario`,`l`.`nombre` AS `nombre_lista`,`lc`.`posicion` AS `posicion`,`c`.`titulo` AS `contenido`,`c`.`tipo` AS `tipo` from (((`LISTA` `l` join `USUARIO` `u` on((`l`.`id_usuario` = `u`.`id_usuario`))) join `LISTACONTENIDO` `lc` on((`l`.`id_lista` = `lc`.`id_lista`))) join `CONTENIDO` `c` on((`lc`.`id_contenido` = `c`.`id_contenido`))) order by `l`.`id_lista`,`lc`.`posicion` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `V_PELICULAS`
--

/*!50001 DROP VIEW IF EXISTS `V_PELICULAS`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `V_PELICULAS` AS select `c`.`id_contenido` AS `id_contenido`,`c`.`titulo` AS `titulo`,`c`.`anio_estreno` AS `anio_estreno`,`c`.`sinopsis` AS `sinopsis`,`c`.`idioma` AS `idioma`,`c`.`url_portada` AS `url_portada`,`p`.`duracion_minutos` AS `duracion_minutos` from (`CONTENIDO` `c` join `PELICULA` `p` on((`c`.`id_contenido` = `p`.`id_contenido`))) where (`c`.`tipo` = 'Película') */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `V_REPARTO_COMPLETO`
--

/*!50001 DROP VIEW IF EXISTS `V_REPARTO_COMPLETO`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `V_REPARTO_COMPLETO` AS select `c`.`titulo` AS `contenido`,`c`.`tipo` AS `tipo`,concat(`p`.`primer_nombre`,' ',`p`.`primer_apellido`) AS `persona`,`cp`.`rol` AS `rol` from ((`CONTENIDO_PERSONA` `cp` join `CONTENIDO` `c` on((`cp`.`id_contenido` = `c`.`id_contenido`))) join `PERSONA` `p` on((`cp`.`id_persona` = `p`.`id_persona`))) order by `c`.`titulo`,`cp`.`rol` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `V_SERIES`
--

/*!50001 DROP VIEW IF EXISTS `V_SERIES`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `V_SERIES` AS select `c`.`id_contenido` AS `id_contenido`,`c`.`titulo` AS `titulo`,`c`.`anio_estreno` AS `anio_estreno`,`c`.`sinopsis` AS `sinopsis`,`c`.`idioma` AS `idioma`,`c`.`url_portada` AS `url_portada`,`s`.`en_emision` AS `en_emision`,`s`.`num_temporadas` AS `num_temporadas` from (`CONTENIDO` `c` join `SERIE` `s` on((`c`.`id_contenido` = `s`.`id_contenido`))) where (`c`.`tipo` = 'Serie') */;
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

-- Dump completed on 2026-05-18  0:15:28
