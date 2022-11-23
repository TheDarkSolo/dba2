-- -------------------------------------------------------------
-- TablePlus 5.1.0(468)
--
-- https://tableplus.com/
--
-- Database: db
-- Generation Time: 2022-11-21 23:45:49.9600
-- -------------------------------------------------------------


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


CREATE TABLE `Country` (
  `cname` varchar(50) NOT NULL,
  `population` bigint DEFAULT NULL,
  PRIMARY KEY (`cname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `Discover` (
  `cname` varchar(50) NOT NULL,
  `disease_code` varchar(50) NOT NULL,
  `first_enc_date` date DEFAULT NULL,
  PRIMARY KEY (`cname`,`disease_code`),
  KEY `disease_code` (`disease_code`),
  CONSTRAINT `discover_ibfk_1` FOREIGN KEY (`disease_code`) REFERENCES `Disease` (`disease_code`),
  CONSTRAINT `discover_ibfk_2` FOREIGN KEY (`cname`) REFERENCES `Country` (`cname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `Disease` (
  `disease_code` varchar(50) NOT NULL,
  `pathogen` varchar(20) DEFAULT NULL,
  `description` varchar(140) DEFAULT NULL,
  `id` int DEFAULT NULL,
  PRIMARY KEY (`disease_code`),
  KEY `id` (`id`),
  KEY `idx_pathogen` (`pathogen`),
  CONSTRAINT `disease_ibfk_1` FOREIGN KEY (`id`) REFERENCES `DiseaseType` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `DiseaseType` (
  `id` int NOT NULL AUTO_INCREMENT,
  `description` varchar(140) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `Doctor` (
  `email` varchar(60) NOT NULL,
  `degree` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`email`),
  CONSTRAINT `doctor_ibfk_1` FOREIGN KEY (`email`) REFERENCES `Users` (`email`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `PublicServant` (
  `email` varchar(60) NOT NULL,
  `department` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`email`),
  CONSTRAINT `publicservant_ibfk_1` FOREIGN KEY (`email`) REFERENCES `Users` (`email`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `Record` (
  `email` varchar(60) NOT NULL,
  `cname` varchar(50) NOT NULL,
  `disease_code` varchar(50) NOT NULL,
  `total_deaths` int DEFAULT NULL,
  `total_patients` int DEFAULT NULL,
  PRIMARY KEY (`email`,`cname`,`disease_code`),
  KEY `disease_code` (`disease_code`),
  KEY `cname` (`cname`),
  CONSTRAINT `record_ibfk_1` FOREIGN KEY (`disease_code`) REFERENCES `Disease` (`disease_code`),
  CONSTRAINT `record_ibfk_2` FOREIGN KEY (`cname`) REFERENCES `Country` (`cname`),
  CONSTRAINT `record_ibfk_3` FOREIGN KEY (`email`) REFERENCES `PublicServant` (`email`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `Specialize` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(60) NOT NULL,
  PRIMARY KEY (`id`,`email`),
  KEY `email` (`email`),
  CONSTRAINT `specialize_ibfk_1` FOREIGN KEY (`id`) REFERENCES `DiseaseType` (`id`),
  CONSTRAINT `specialize_ibfk_2` FOREIGN KEY (`email`) REFERENCES `Doctor` (`email`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `Users` (
  `email` varchar(60) NOT NULL,
  `name` varchar(30) DEFAULT NULL,
  `surname` varchar(40) DEFAULT NULL,
  `salary` int DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `cname` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`email`),
  KEY `cname` (`cname`),
  CONSTRAINT `users_ibfk_1` FOREIGN KEY (`cname`) REFERENCES `Country` (`cname`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `Country` (`cname`, `population`) VALUES
('Canada', 25000000),
('China', 1200000000),
('India', 1000000000),
('Israel', 9500000),
('Italy', 59000000),
('Japan', 125000000),
('Poland', 38000000),
('Russia', 145000000),
('Spain', 47000000),
('UK', 65000000);

INSERT INTO `Discover` (`cname`, `disease_code`, `first_enc_date`) VALUES
('Canada', 'D1', '1980-12-05'),
('China', 'D2', '1991-05-06'),
('India', 'D3', '1993-03-02'),
('Israel', 'D4', '2005-03-14'),
('Italy', 'D5', '1985-11-04'),
('Japan', 'D6', '1999-09-01'),
('Poland', 'D7', '2001-06-07'),
('Russia', 'D8', '2003-11-11'),
('Spain', 'D9', '2020-01-01'),
('UK', 'D10', '1965-01-01');

INSERT INTO `Disease` (`disease_code`, `pathogen`, `description`, `id`) VALUES
('D1', 'bacteria', 'asthma', 1),
('D10', 'virus', 'honorea', 10),
('D2', 'parasites', 'flu', 2),
('D3', 'fungi', 'covid-19', 3),
('D4', 'virus', 'black death', 4),
('D5', 'bacteria', 'hiv', 5),
('D6', 'virus', 'anthrax', 6),
('D7', 'parasites', 'spanish flu', 7),
('D8', 'bacteria', 'zika', 8),
('D9', 'fungi', 'ebola', 9);

INSERT INTO `DiseaseType` (`id`, `description`) VALUES
(1, 'infectious diseases'),
(2, 'virology'),
(3, 'physical disease'),
(4, 'physiological diseases'),
(5, 'psychological disease'),
(6, 'deficiency diseases'),
(7, 'virology'),
(8, 'infectious diseases'),
(9, 'deficiency diseases'),
(10, 'hereditary diseases');

INSERT INTO `Doctor` (`email`, `degree`) VALUES
('aisha@nu.edu.kz', 'MD'),
('alibek@nu.edu.kz', 'PhD'),
('amanbek@nu.edu.kz', 'MD'),
('ayan@nu.edu.kz', 'MD'),
('gulsim@nu.edu.kz', 'MD'),
('mairagul@nu.edu.kz', 'PhD'),
('meiramgul@nu.edu.kz', 'MD'),
('tore@nu.edu.kz', 'MD'),
('yermek@nu.edu.kz', 'PhD'),
('zhazira@nu.edu.kz', 'PhD');

INSERT INTO `PublicServant` (`email`, `department`) VALUES
('servant1@nu.edu.kz', 'dept1'),
('servant10@nu.edu.kz', 'dept2'),
('servant2@nu.edu.kz', 'dept2'),
('servant3@nu.edu.kz', 'dept1'),
('servant4@nu.edu.kz', 'dept2'),
('servant5@nu.edu.kz', 'dept1'),
('servant6@nu.edu.kz', 'dept2'),
('servant7@nu.edu.kz', 'dept2'),
('servant8@nu.edu.kz', 'dept2'),
('servant9@nu.edu.kz', 'dept1');

INSERT INTO `Record` (`email`, `cname`, `disease_code`, `total_deaths`, `total_patients`) VALUES
('servant1@nu.edu.kz', 'China', 'D3', 4400, 50000),
('servant1@nu.edu.kz', 'Japan', 'D3', 5000, 105000),
('servant1@nu.edu.kz', 'Poland', 'D3', 20000, 950000),
('servant1@nu.edu.kz', 'UK', 'D3', 15000, 20000),
('servant10@nu.edu.kz', 'Italy', 'D8', 5, 3000),
('servant2@nu.edu.kz', 'Canada', 'D2', 1000, 85000),
('servant3@nu.edu.kz', 'Israel', 'D1', 500000, 600000),
('servant4@nu.edu.kz', 'China', 'D4', 2500, 99999),
('servant6@nu.edu.kz', 'Russia', 'D5', 500, 305000),
('servant8@nu.edu.kz', 'Spain', 'D2', 100, 50000);

INSERT INTO `Specialize` (`id`, `email`) VALUES
(1, 'alibek@nu.edu.kz'),
(2, 'amanbek@nu.edu.kz'),
(3, 'tore@nu.edu.kz'),
(4, 'meiramgul@nu.edu.kz'),
(5, 'ayan@nu.edu.kz'),
(6, 'tore@nu.edu.kz'),
(7, 'tore@nu.edu.kz'),
(8, 'yermek@nu.edu.kz'),
(9, 'meiramgul@nu.edu.kz'),
(10, 'meiramgul@nu.edu.kz');

INSERT INTO `Users` (`email`, `name`, `surname`, `salary`, `phone`, `cname`) VALUES
('aisha@nu.edu.kz', 'Aisha', 'Aishova', 19000, '29', 'India'),
('alibek@nu.edu.kz', 'Alibek', 'Aliev', 11000, '21', 'China'),
('amanbek@nu.edu.kz', 'Amanbek', 'Amov', 17000, '27', 'Israel'),
('ayan@nu.edu.kz', 'Ayan', 'Ayov', 15000, '25', 'UK'),
('gulsim@nu.edu.kz', 'Gulsim', 'Gulova', 12000, '22', 'Poland'),
('mairagul@nu.edu.kz', 'Mairagul', 'Maiova', 20000, '30', 'Spain'),
('meiramgul@nu.edu.kz', 'Meiramgul', 'Meirova', 18000, '28', 'Italy'),
('servant1@nu.edu.kz', 'S1', 'S1S', 8, '11', 'Spain'),
('servant10@nu.edu.kz', 'S10', 'S10S', 10000, '20', 'China'),
('servant2@nu.edu.kz', 'S2', 'S2S', 2000, '12', 'India'),
('servant3@nu.edu.kz', 'S3', 'S3S', 3000, '13', 'Italy'),
('servant4@nu.edu.kz', 'S4', 'S4S', 4000, '14', 'Israel'),
('servant5@nu.edu.kz', 'S5', 'S5S', 5000, '15', 'Russia'),
('servant6@nu.edu.kz', 'S6', 'S6S', 6000, '16', 'UK'),
('servant7@nu.edu.kz', 'S7', 'S7S', 7000, '17', 'Japan'),
('servant8@nu.edu.kz', 'S8', 'S8S', 8000, '18', 'Canada'),
('servant9@nu.edu.kz', 'S9', 'S9S', 9000, '19', 'Poland'),
('tore@nu.edu.kz', 'Tore', 'Torov', 13000, '23', 'Canada'),
('yermek@nu.edu.kz', 'Armanbek', 'Arov', 14000, '24', 'Japan'),
('zhazira@nu.edu.kz', 'Zhazira', 'Zhazova', 16000, '26', 'Russia');



/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;