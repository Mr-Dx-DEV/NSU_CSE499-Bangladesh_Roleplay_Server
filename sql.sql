-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               12.1.2-MariaDB - MariaDB Server
-- Server OS:                    Win64
-- HeidiSQL Version:             12.11.0.7065
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for qbox_27adff
CREATE DATABASE IF NOT EXISTS `qbox_27adff` /*!40100 DEFAULT CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci */;
USE `qbox_27adff`;

-- Dumping structure for table qbox_27adff.bank_accounts_new
CREATE TABLE IF NOT EXISTS `bank_accounts_new` (
  `id` varchar(50) NOT NULL,
  `amount` int(11) DEFAULT 0,
  `transactions` longtext DEFAULT NULL,
  `auth` longtext DEFAULT NULL,
  `isFrozen` int(11) DEFAULT 0,
  `creator` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table qbox_27adff.bank_accounts_new: ~25 rows (approximately)
INSERT INTO `bank_accounts_new` (`id`, `amount`, `transactions`, `auth`, `isFrozen`, `creator`) VALUES
	('ambulance', 0, '[]', '[]', 0, NULL),
	('ballas', 0, '[]', '[]', 0, NULL),
	('bcso', 0, '[]', '[]', 0, NULL),
	('bus', 0, '[]', '[]', 0, NULL),
	('cardealer', 0, '[]', '[]', 0, NULL),
	('cartel', 0, '[]', '[]', 0, NULL),
	('families', 0, '[]', '[]', 0, NULL),
	('garbage', 0, '[]', '[]', 0, NULL),
	('hotdog', 0, '[]', '[]', 0, NULL),
	('judge', 0, '[]', '[]', 0, NULL),
	('lawyer', 0, '[]', '[]', 0, NULL),
	('lostmc', 0, '[]', '[]', 0, NULL),
	('mechanic', 0, '[]', '[]', 0, NULL),
	('none', 0, '[]', '[]', 0, NULL),
	('police', 0, '[]', '[]', 0, NULL),
	('realestate', 0, '[]', '[]', 0, NULL),
	('reporter', 0, '[]', '[]', 0, NULL),
	('sasp', 0, '[]', '[]', 0, NULL),
	('taxi', 0, '[]', '[]', 0, NULL),
	('tow', 0, '[]', '[]', 0, NULL),
	('triads', 0, '[]', '[]', 0, NULL),
	('trucker', 0, '[]', '[]', 0, NULL),
	('unemployed', 0, '[]', '[]', 0, NULL),
	('vagos', 0, '[]', '[]', 0, NULL),
	('vineyard', 0, '[]', '[]', 0, NULL);

-- Dumping structure for table qbox_27adff.bans
CREATE TABLE IF NOT EXISTS `bans` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `license` varchar(50) DEFAULT NULL,
  `discord` varchar(50) DEFAULT NULL,
  `ip` varchar(50) DEFAULT NULL,
  `reason` text DEFAULT NULL,
  `expire` int(11) DEFAULT NULL,
  `bannedby` varchar(255) NOT NULL DEFAULT 'LeBanhammer',
  PRIMARY KEY (`id`),
  KEY `license` (`license`),
  KEY `discord` (`discord`),
  KEY `ip` (`ip`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table qbox_27adff.bans: ~0 rows (approximately)

-- Dumping structure for table qbox_27adff.dealers
CREATE TABLE IF NOT EXISTS `dealers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '0',
  `coords` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `time` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `createdby` varchar(50) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table qbox_27adff.dealers: ~0 rows (approximately)

-- Dumping structure for table qbox_27adff.lapraces
CREATE TABLE IF NOT EXISTS `lapraces` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `checkpoints` text DEFAULT NULL,
  `records` text DEFAULT NULL,
  `creator` varchar(50) DEFAULT NULL,
  `distance` int(11) DEFAULT NULL,
  `raceid` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `raceid` (`raceid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table qbox_27adff.lapraces: ~0 rows (approximately)

-- Dumping structure for table qbox_27adff.management_outfits
CREATE TABLE IF NOT EXISTS `management_outfits` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `job_name` varchar(50) NOT NULL,
  `type` varchar(50) NOT NULL,
  `minrank` int(11) NOT NULL DEFAULT 0,
  `name` varchar(50) NOT NULL DEFAULT 'Cool Outfit',
  `gender` varchar(50) NOT NULL DEFAULT 'male',
  `model` varchar(50) DEFAULT NULL,
  `props` text DEFAULT NULL,
  `components` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table qbox_27adff.management_outfits: ~0 rows (approximately)

-- Dumping structure for table qbox_27adff.occasion_vehicles
CREATE TABLE IF NOT EXISTS `occasion_vehicles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `seller` varchar(50) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `description` longtext DEFAULT NULL,
  `plate` varchar(50) DEFAULT NULL,
  `model` varchar(50) DEFAULT NULL,
  `mods` text DEFAULT NULL,
  `occasionid` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `occasionId` (`occasionid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table qbox_27adff.occasion_vehicles: ~0 rows (approximately)

-- Dumping structure for table qbox_27adff.ox_doorlock
CREATE TABLE IF NOT EXISTS `ox_doorlock` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `data` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table qbox_27adff.ox_doorlock: ~6 rows (approximately)
INSERT INTO `ox_doorlock` (`id`, `name`, `data`) VALUES
	(1, 'vangelico_jewellery', '{"maxDistance":2,"groups":{"police":0},"doors":[{"model":1425919976,"coords":{"x":-631.9553833007813,"y":-236.33326721191407,"z":38.2065315246582},"heading":306},{"model":9467943,"coords":{"x":-630.426513671875,"y":-238.4375457763672,"z":38.2065315246582},"heading":306}],"state":1,"coords":{"x":-631.19091796875,"y":-237.38540649414063,"z":38.2065315246582},"hideUi":true}'),
	(2, 'BigBankThermite1', '{"heading":160,"doors":false,"maxDistance":2,"hideUi":true,"groups":{"police":0},"coords":{"x":251.85757446289063,"y":221.0654754638672,"z":101.83240509033203},"model":-1508355822,"state":1,"autolock":1800}'),
	(3, 'BigBankThermite2', '{"coords":{"x":261.3004150390625,"y":214.50514221191407,"z":101.83240509033203},"autolock":1800,"maxDistance":2,"groups":{"police":0},"model":-1508355822,"doors":false,"hideUi":true,"heading":250,"state":1}'),
	(4, 'BigBankLPDoor', '{"coords":{"x":256.3115539550781,"y":220.65785217285157,"z":106.42955780029297},"autolock":1800,"maxDistance":2,"model":-222270721,"doors":false,"lockpick":true,"hideUi":true,"heading":340,"state":1,"lockpickDifficulty":["hard"]}'),
	(5, 'PaletoThermiteDoor', '{"coords":{"x":-106.47130584716797,"y":6476.15771484375,"z":31.95479965209961},"autolock":1800,"maxDistance":2,"groups":{"police":0},"model":1309269072,"doors":false,"hideUi":true,"heading":315,"state":1}'),
	(6, 'BigBankRedCardDoor', '{"coords":{"x":262.1980895996094,"y":222.518798828125,"z":106.42955780029297},"autolock":1800,"maxDistance":2,"groups":{"police":0},"model":746855201,"doors":false,"hideUi":true,"heading":250,"state":1}');

-- Dumping structure for table qbox_27adff.ox_inventory
CREATE TABLE IF NOT EXISTS `ox_inventory` (
  `owner` varchar(60) DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `data` longtext DEFAULT NULL,
  `lastupdated` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  UNIQUE KEY `owner` (`owner`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- Dumping data for table qbox_27adff.ox_inventory: ~0 rows (approximately)

-- Dumping structure for table qbox_27adff.players
CREATE TABLE IF NOT EXISTS `players` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(10) unsigned DEFAULT NULL,
  `citizenid` varchar(50) NOT NULL,
  `cid` int(11) DEFAULT NULL,
  `license` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `money` text NOT NULL,
  `charinfo` text DEFAULT NULL,
  `job` text NOT NULL,
  `gang` text DEFAULT NULL,
  `position` text NOT NULL,
  `metadata` text NOT NULL,
  `inventory` longtext DEFAULT NULL,
  `phone_number` varchar(20) DEFAULT NULL,
  `last_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `last_logged_out` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`citizenid`),
  KEY `id` (`id`),
  KEY `last_updated` (`last_updated`),
  KEY `license` (`license`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table qbox_27adff.players: ~1 rows (approximately)
INSERT INTO `players` (`id`, `userId`, `citizenid`, `cid`, `license`, `name`, `money`, `charinfo`, `job`, `gang`, `position`, `metadata`, `inventory`, `phone_number`, `last_updated`, `last_logged_out`) VALUES
	(1, 1, 'BI315886', 1, 'license2:a045ed84bc7b147ab67442c4be4c70a4bb7d0ad5', 'DEV Dx', '{"cash":500,"crypto":0,"bank":5070}', '{"birthdate":"2006-12-31","cid":1,"phone":"6227634698","gender":0,"backstory":"placeholder backstory","account":"US08QBX2170448178","nationality":"Bangladeshi","lastname":"Dx","firstname":"Mr"}', '{"bankAuth":false,"label":"Civilian","grade":{"level":0,"name":"Freelancer"},"onduty":true,"name":"unemployed","isboss":false,"payment":10}', '{"label":"No Gang","grade":{"level":0,"name":"Unaffiliated"},"name":"none","bankAuth":false,"isboss":false}', '{"x":-1341.191162109375,"y":-2956.707763671875,"z":13.9296875,"w":79.37007904052735}', '{"inlaststand":false,"health":200,"walletid":"QB-41724171","hunger":36.99999999999996,"attachmentcraftingrep":0,"callsign":"NO CALLSIGN","status":[],"jailitems":[],"thirst":43.00000000000004,"jobrep":{"hotdog":0,"taxi":0,"tow":0,"trucker":0},"injail":0,"phonedata":{"SerialNumber":84902934,"InstalledApps":[]},"dealerrep":0,"bloodtype":"B-","isdead":false,"inside":{"apartment":[]},"tracker":false,"phone":[],"craftingrep":0,"ishandcuffed":false,"criminalrecord":{"hasRecord":false},"optin":true,"stress":0,"fingerprint":"957NBVI6E911F2Y","licences":{"weapon":false,"id":true,"driver":true},"armor":0}', '[{"name":"money","count":500,"slot":1},{"name":"phone","count":1,"slot":2},{"name":"id_card","count":1,"slot":3,"metadata":{"cardtype":"id_card","citizenid":"BI315886","badge":"none","firstname":"Mr","lastname":"Dx","nationality":"Bangladeshi","mugShot":"data:image/png;base64,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","birthdate":"2006-12-31","sex":"M"}},{"name":"driver_license","count":1,"slot":4,"metadata":{"cardtype":"driver_license","citizenid":"BI315886","badge":"none","firstname":"Mr","lastname":"Dx","nationality":"Bangladeshi","mugShot":"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAYAAACqaXHeAAAAAXNSR0IArs4c6QAADjJJREFUeF7tm12MG9UVx//r8cyOM2uvjTfOOt6YuKSbbAhEG4UEQloEaqUK0QeWRoWoD6VUaisqpAreivoEfWpVtc+lfaj4eCEvrWhpVT6UkjYRsEKEJixJvXXW2ZWzxrPj9Xoys+Otzv2YGTu7gay9CagcybLH8+F7fvd/7j33w30AVvB/bH1fAPhCAV+EwPVtA6LtDY6qqnBdl33JPjf55+tl16UNIMc0TWM+OS0Pmqb7/qkqGADHcfg1y/xUo9G4Lgw2HIBhGCFnVSAag+s2oar83XEakNcwJQgABI3MXgbsRXPDYGwIALVfhxFP8UIvN9skTgDIJAQgOM+v57fJ0PD6VLh2A97yxoRG7wFEgWQy6zuJZRdKRIHjOlAUBUpUR6RPg+s1oCpcHa7L5a5EVHgrHlQdcG1AiQKexx1v1DcmJHoKQO1XoemB5JlTrZYvXwZB1ZijZF7LBYLTHIIagWMD1Ex4pIa+oOY3AkLPAJDzRtyAaNDhkBcAtIjCFOC1PCZre9mGJmqeXdACHLcBXU/BtmtMIVTzDNDnCQA5TxBWA+B5HnRdR8trASRzqnlhCoJjGQJM+stgoSDNvbwxodAzBSSTSV7WFa5p+7IDvV+DpkRgLXE1MEX08xDxHAFB4+GgqrybtBdrgderfKJ2hKxX3WRPAJC0qSujbozVdj93hjmsRNrcsD3uQETV0HIdeOKsI4AoK85VAZCSZOLUCwg9AyBLTTUkAZAKOk3pC+CwmnSDa0gFnwRAKqBXKugagExYWG1rGtSoglTcgO04aF52UdicZgzqTRtWswnL4uFAvYHnOpDBIUOAABSGMyhkM+y9YpkYzQ+ze/701iTOlSsiZHgK3a0KugKg6ioUcElLe/zIBNKDBnbmM+wrywnOU2ErpoWp6RI792GxhDnTxLfvPYwPpku4dXseu3Nplgt4ovu0l5tQNQ3GJt52/PhXz7X9nrvI2xLPD6arRtAVJ7sCoEQVqFHeiB28bQxPPPIQy/zCFgYgVRI+36y1N3quY7Xd7yDoMQjC5Nkinvvza8E1i4AL98YA0Ad0P3V9/udP80KtAUAOhjqroBMAlm24raBdCAOgew3NwO/+8hre/ajIHiUVsF4VdKWAMIAnHpnAwdt29wQAOdNa8eB4LigEwpYcSLUB8BY9tNC6MQpQdQOKiL3nfvYkK2ekD2hRIi8tqkPVgvSYekGZ1NAQ2G6GrqWGNOStY9vwIvy860gQMZyeLuGl14+z7+2GCJEV2aFepzZAiaqIRDUGYP/unfjRtx7wAYSLoKjceVUkQPZyow1Ax1AA1KK4AgoBUPopVQ5D4KPJp3//PAew2A7w2twHugyBJChmVwOgqLygQMR3nhVYAJATIF5EgWs3oeriepvXtITgrdhXB0D+L68fwoYAkM4rGg19eS8hU2B72YRz2fFVQAA0PZT029wZR4DwXBuuUAApQeZNL71xHKeLpRusAFHwfWM78b0HeQgkBrjkjYEEl2inJoWDtQpPaGI38evWNDFBYtXm2SWeXWfvf/jrcbx3vgRbPO9apS+v70oBlAVSanqtAKTzDJDHu7zU5qHVffg8A2gsWlCEEnynbRvmJV77ZPpNYhQpvxCjSXmo9LUPpj5TCqDaJxU89uA3MT42ysqsiCmeRp1ndLbDu6cwgHBVXxEiHQ0ayzUotJJ8TGHovKP8TIQAq8EBHd84sA+35PiAZeqi6bfaDIAb9M9aVIUamuIa3z2KyffPtEm/KucJOgJCptx7h/kY49V3JnHu4qyfia4eP5/8bVdtgASwI5cFvci8Pn1NAKwGeaeAyX9/2Fa68Z072HEYgLMcpMRalEaaKowWB0oAmIk24pNdXf2KrgAc/cohLKlgtX++PMd+oSkKJKe9WysROKEpbQmAan/f7p2A3cS7Z89j8sNzPgBZ2664j0AQALJkhLcJO7Zy4LNzJo7988R6/e8uETq8axQH79jj/zhBkArQVEqBddQXLQaA5E8mQ2AtAHaEO9qw+TS4oRv+ZwmAnCf5n5+dQ1qP4+TU1I0BcGhXAfffc4//47PlMqoi8bFEiqqJsUJYBXTDfXceQGHbCMvizl2Ywav/OikAaXBdh80R0js61hIz0RgyQ7znqMybqFyq4bWz7e3ItdDoKgToh575wXdBjo8fOIDJU6d8AHSOIEgArPajml+bjx2Z4OXsAEDDXUdMLUsASTEZQpdrTgt7dm3nzs+beOn4+uVPz+sawOMPfJ35IQE48Tg7rgsFRJYBGcsU2+aiicJIDvfddbANwLmZMs7PzICGu64TmifsUMBIIsEUcPrsNLv/hgOYGB9DNjeCbC6H4VwOZy4UWc2X50wkBnRIAK5o0XM03zeS4/IPKYA+EoSSmPPTxOKoKgAUMhkUKxXs+1Ler/1u5d8TBewdLeD20QL2frnA/EmmeHzWLd6IqX069BRPc+3aPEudyYzBFIxBPpq0qhX2qlcr0BNp6AkxjrAswPFgNZfYPYnYJtRsG2dKZXZ85sKM/5nTvHbrOgToJ3/xk8fw3kdFBkFRREcvyhK/idc0Oc/eF+vM8bUAYEVDcluOX2tZsBbqsJaChVHDiPtOH3uLN5zdWE8BUEF25HjhE3ED8YQBRFOB82YViGrI5Au89slCCqDD+jzfC6AP8rZEAqg3OYTaEk+ExvI5PPvisW58Z/f2BIAMA3pgJp5EghwXECgEWG2aVfZK3zLGjkkBjYUanMVqmxOV8yXEBnkIEIS1APRC/j0DQA+ipCi/eQjZHM/Vs2JBBLoOS0x9Wx+bcE0+EkwKJ2k4X10IpsLVBN9YYQiIipgBqZr8mhKpCMDpYpmtMXRrPVEAFSI/lOavrRlkM0M+AFoNClv1P0HWViyVYdpAejCOtACSHBG9g7ipE8DbxSIqZr0nzvdUAb4KrgIgkUqh+M5J1ESNmwt1KP1xVBfqDMJofgT6CB9VNhaW0LAaSMR4o0oKqJp1FGvzn20Amqpg/NadVyiA5F+vmWhavDcgkwDCCoknhmAMGshs28wghBUwVSzDgoPT07wb7IX1LASoMIWhJLJbMth+880o3Jxn5bPtJopnA9lrYh+ALLwupssbom2o2DwLzAylWMYnJ0xmL1YwO1tB8WMLptm7XWM9BZCJG9iR590gQWAAQmt/qaE0IsLhemUO8cww3AU+yclkb1YgAcjvZGNIzs9drMBSlK5XhMPK6SkAenB2QPdrn451sbWFPic3pyEVYFVmeTk6psAasSQql4Ia1jcFiRUBmO1yFrgzbK4bAHKejADkbh1nn61Ls0wBRnIzO65Mf+ArQEL43AHYv4tPbUnLip2i6S08PzAWm9C3Bl1d4zLvyxtzXBF1UeHzVRPVag3Q5AoTf+KZklBOZ1Wu87jnCqA9PA/fe5AlKiwkVgFgXwxa8VpHCLTEbpBOAGPbhnHsLTEPuE5nV7ttQwA88+gE66oIgrbYANV+WAFUEAnB2dy+LrCaAsj5sXwWz774Sg9d54/qKYDsSAG5AQUP33uAPZwgTL0/5QNIb9kMNFvQs2K0N1sGUu07S825IpN+WAETd/M2gxRgt3QUZ/jmiF5YzwD4/b7n4qdH7vfL9uabJ1EuzSCXH0Eun4PZpyC9nc8dVKeLMOT+QnGHNX0eldkqKnPzyAwPQclmMLadZ4fHXp/09yOcE/uMuoXQEwDSeSpMYWsaE3fu88t1rjiDcqnMIJClt/HpbGl2xx8k5ueCTHHP+E5ktnO1kJ2ZnsNUkT+HrBcQugYQdn41ALTff+ZCCEJHoyfXEXyvojqr+Uw2jcxwGjSaXAtALyB0BaBAUg5tTbnvq4cxPtTebREAMoJAdv6/JVSLQQyHAQyNjGA4y/MF5jxZCMBYIYvJYg2vvv4PH0pj2cXszPq7xnUDyOULSAwmYdd41vbkU3yPkF6bginmA/1SijFBk1aGF/ienprY/x/eG2zEYtDozxaGDmMTr/mI2BwRi+nQN+nQb7mDff/LX/9G8NFh1S2Uy+sbIK0LgHSeSkAAyPlDhw7hxIkTDABtkbVFCkx5gdzEQAOjZrN9V1B1nk+QNJZs5jTtFpHOdwJIplPA1j04dPAATpw8xSDQ88nWC+GaAFCNxwdTrOalEYCXj73MDglAaqmIWlgBfXwW2N/JIULCV0DDQkNsijJiOrQYd4hUQNYUIz9SQBgAnXvo6Hd8ABIC7Ua9ltHipwJADlOth81aMP0QIADkPNlaAHwIqwAIP5cASOclAF/+sZivgNUA0He6AFgsFj8ViDUBZId596MPaCjkCyiWeMNF2+PoD0xsmxzt7m428NsXuALePnkCiYVzcN0WHLExQlnhClD6I3AsF/YKH+HbzSaaS3bbP8L0mIGYobK9wWRshUgA0w0duhGDOzSKA3cfZuePvfgC/vj3v8GVW+0VhW3XJxu/bZyVuXqJzyGWSnx/cqddAYAcHx/ny1azc2UUtufYg8wF3th1Aji493b88ImnrgAQ/FCwxcW73ILX57HNkWEA5DhZbBP964RGjGqwPrjkgJxnlbEKgFfeeI0BIMdp0UUCSIowpdVlsnw+zyDQDvOTp4L1hL7cSH7l4F2HUZ7hhBzbBUEg59l7JXBeOiVrn447AQw1i6z2SQXcOIBIv4LWZQ/0x4gwAIh/hdE1qXQGihLaJ+y6kHuEyHmyTgUQAHKaIIQByLLmtgSJFLvfdZHL5VivMVOeQd/EkaPsr7MSQDrJh60EgMysBxua5EPVmMGU4DYbuGv/fl8BdH76Db6DM4AQYc6TdQKg75p1PiNEtU9KkN0+Wxlmf5zikiYApISxrx2VxWDvj37/Ud95dr0IgTCA0oUS8tvyoPfscJYBkPY/koNbsMcyHJAAAAAASUVORK5CYII=","birthdate":"2006-12-31","sex":"M"}}]', NULL, '2025-11-27 05:13:41', '2025-11-27 05:13:41');

-- Dumping structure for table qbox_27adff.playerskins
CREATE TABLE IF NOT EXISTS `playerskins` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(255) NOT NULL,
  `model` varchar(255) NOT NULL,
  `skin` text NOT NULL,
  `active` tinyint(4) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `citizenid` (`citizenid`),
  KEY `active` (`active`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table qbox_27adff.playerskins: ~1 rows (approximately)
INSERT INTO `playerskins` (`id`, `citizenid`, `model`, `skin`, `active`) VALUES
	(1, 'BI315886', 'mp_m_freemode_01', '{"components":[{"drawable":0,"texture":0,"component_id":0},{"drawable":0,"texture":0,"component_id":2},{"drawable":0,"texture":0,"component_id":5},{"drawable":0,"texture":0,"component_id":7},{"drawable":0,"texture":0,"component_id":8},{"drawable":0,"texture":0,"component_id":9},{"drawable":0,"texture":0,"component_id":10},{"drawable":0,"texture":0,"component_id":1},{"drawable":515,"texture":1,"component_id":11},{"drawable":1,"texture":0,"component_id":3},{"drawable":185,"texture":0,"component_id":4},{"drawable":10,"texture":0,"component_id":6}],"headBlend":{"shapeSecond":0,"skinFirst":0,"shapeFirst":0,"skinSecond":0,"skinThird":0,"shapeThird":0,"shapeMix":0,"skinMix":0,"thirdMix":0},"headOverlays":{"lipstick":{"opacity":0,"color":0,"style":0,"secondColor":0},"blemishes":{"opacity":0,"color":0,"style":0,"secondColor":0},"blush":{"opacity":0,"color":0,"style":0,"secondColor":0},"eyebrows":{"opacity":0,"color":0,"style":0,"secondColor":0},"complexion":{"opacity":0,"color":0,"style":0,"secondColor":0},"beard":{"opacity":1,"color":0,"style":10,"secondColor":0},"ageing":{"opacity":0,"color":0,"style":0,"secondColor":0},"makeUp":{"opacity":0,"color":0,"style":0,"secondColor":0},"sunDamage":{"opacity":0,"color":0,"style":0,"secondColor":0},"moleAndFreckles":{"opacity":0,"color":0,"style":0,"secondColor":0},"bodyBlemishes":{"opacity":0,"color":0,"style":0,"secondColor":0},"chestHair":{"opacity":0,"color":0,"style":0,"secondColor":0}},"tattoos":[],"model":"mp_m_freemode_01","eyeColor":-1,"props":[{"drawable":-1,"texture":-1,"prop_id":0},{"drawable":-1,"texture":-1,"prop_id":2},{"drawable":-1,"texture":-1,"prop_id":6},{"drawable":-1,"texture":-1,"prop_id":7},{"drawable":17,"texture":1,"prop_id":1}],"faceFeatures":{"jawBoneWidth":0,"nosePeakLowering":0,"jawBoneBackSize":0,"eyesOpening":0,"noseBoneTwist":0,"noseBoneHigh":0,"chinBoneLenght":0,"cheeksWidth":0,"cheeksBoneHigh":0,"neckThickness":0,"eyeBrownForward":0,"eyeBrownHigh":0,"nosePeakSize":0,"nosePeakHigh":0,"chinHole":0,"lipsThickness":0,"chinBoneSize":0,"chinBoneLowering":0,"cheeksBoneWidth":0,"noseWidth":0},"hair":{"highlight":0,"color":0,"style":19,"texture":0}}', 1);

-- Dumping structure for table qbox_27adff.player_groups
CREATE TABLE IF NOT EXISTS `player_groups` (
  `citizenid` varchar(50) NOT NULL,
  `group` varchar(50) NOT NULL,
  `type` varchar(50) NOT NULL,
  `grade` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`citizenid`,`type`,`group`),
  CONSTRAINT `fk_citizenid` FOREIGN KEY (`citizenid`) REFERENCES `players` (`citizenid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table qbox_27adff.player_groups: ~0 rows (approximately)

-- Dumping structure for table qbox_27adff.player_jobs_activity
CREATE TABLE IF NOT EXISTS `player_jobs_activity` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `job` varchar(255) NOT NULL,
  `last_checkin` int(11) NOT NULL,
  `last_checkout` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `id` (`id` DESC) USING BTREE,
  KEY `last_checkout` (`last_checkout`) USING BTREE,
  KEY `citizenid_job` (`citizenid`,`job`) USING BTREE,
  CONSTRAINT `1` FOREIGN KEY (`citizenid`) REFERENCES `players` (`citizenid`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table qbox_27adff.player_jobs_activity: ~1 rows (approximately)
INSERT INTO `player_jobs_activity` (`id`, `citizenid`, `job`, `last_checkin`, `last_checkout`) VALUES
	(1, 'BI315886', 'unemployed', 1764216321, 1764220421);

-- Dumping structure for table qbox_27adff.player_mails
CREATE TABLE IF NOT EXISTS `player_mails` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(50) DEFAULT NULL,
  `sender` varchar(50) DEFAULT NULL,
  `subject` varchar(50) DEFAULT NULL,
  `message` text DEFAULT NULL,
  `read` tinyint(4) DEFAULT 0,
  `mailid` int(11) DEFAULT NULL,
  `date` timestamp NULL DEFAULT current_timestamp(),
  `button` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `citizenid` (`citizenid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table qbox_27adff.player_mails: ~0 rows (approximately)

-- Dumping structure for table qbox_27adff.player_outfits
CREATE TABLE IF NOT EXISTS `player_outfits` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(50) DEFAULT NULL,
  `outfitname` varchar(50) NOT NULL DEFAULT '0',
  `model` varchar(50) DEFAULT NULL,
  `props` text DEFAULT NULL,
  `components` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `citizenid_outfitname_model` (`citizenid`,`outfitname`,`model`),
  KEY `citizenid` (`citizenid`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table qbox_27adff.player_outfits: ~0 rows (approximately)

-- Dumping structure for table qbox_27adff.player_outfit_codes
CREATE TABLE IF NOT EXISTS `player_outfit_codes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `outfitid` int(11) NOT NULL,
  `code` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `FK_player_outfit_codes_player_outfits` (`outfitid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table qbox_27adff.player_outfit_codes: ~0 rows (approximately)

-- Dumping structure for table qbox_27adff.player_transactions
CREATE TABLE IF NOT EXISTS `player_transactions` (
  `id` varchar(50) NOT NULL,
  `isFrozen` int(11) DEFAULT 0,
  `transactions` longtext DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table qbox_27adff.player_transactions: ~0 rows (approximately)

-- Dumping structure for table qbox_27adff.player_vehicles
CREATE TABLE IF NOT EXISTS `player_vehicles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `license` varchar(50) DEFAULT NULL,
  `citizenid` varchar(50) DEFAULT NULL,
  `vehicle` varchar(50) DEFAULT NULL,
  `hash` varchar(50) DEFAULT NULL,
  `mods` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `plate` varchar(15) NOT NULL,
  `fakeplate` varchar(50) DEFAULT NULL,
  `garage` varchar(50) DEFAULT NULL,
  `fuel` int(11) DEFAULT 100,
  `engine` float DEFAULT 1000,
  `body` float DEFAULT 1000,
  `state` int(11) DEFAULT 1,
  `depotprice` int(11) NOT NULL DEFAULT 0,
  `drivingdistance` int(50) DEFAULT NULL,
  `status` text DEFAULT NULL,
  `coords` text DEFAULT NULL,
  `glovebox` longtext DEFAULT NULL,
  `trunk` longtext DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `plate` (`plate`),
  KEY `citizenid` (`citizenid`),
  CONSTRAINT `1` FOREIGN KEY (`citizenid`) REFERENCES `players` (`citizenid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table qbox_27adff.player_vehicles: ~0 rows (approximately)

-- Dumping structure for table qbox_27adff.properties
CREATE TABLE IF NOT EXISTS `properties` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `property_name` varchar(255) NOT NULL,
  `coords` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`coords`)),
  `price` int(11) NOT NULL DEFAULT 0,
  `owner` varchar(50) DEFAULT NULL,
  `interior` varchar(255) NOT NULL,
  `keyholders` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT json_object() CHECK (json_valid(`keyholders`)),
  `rent_interval` int(11) DEFAULT NULL,
  `interact_options` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT json_object() CHECK (json_valid(`interact_options`)),
  `stash_options` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT json_object() CHECK (json_valid(`stash_options`)),
  `garage` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`garage`)),
  PRIMARY KEY (`id`),
  KEY `owner` (`owner`),
  CONSTRAINT `1` FOREIGN KEY (`owner`) REFERENCES `players` (`citizenid`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table qbox_27adff.properties: ~1 rows (approximately)
INSERT INTO `properties` (`id`, `property_name`, `coords`, `price`, `owner`, `interior`, `keyholders`, `rent_interval`, `interact_options`, `stash_options`, `garage`) VALUES
	(1, 'Del Perro Heights Apt 1', '{"x":-1447.3499755859376,"y":-537.8400268554688,"z":34.7400016784668}', 0, 'BI315886', 'DellPerroHeightsApt4', '{}', NULL, '[{"type":"logout","coords":{"x":-1454.0799560546876,"y":-553.25,"z":72.83999633789063}},{"type":"clothing","coords":{"x":-1449.8800048828126,"y":-549.25,"z":72.83999633789063}},{"type":"exit","coords":{"x":-1453.02001953125,"y":-539.5,"z":74.04000091552735,"w":35.33000183105469}}]', '[{"coords":{"x":-1466.8299560546876,"y":-527.030029296875,"z":73.44000244140625},"maxWeight":150000,"slots":50}]', NULL);

-- Dumping structure for table qbox_27adff.properties_decorations
CREATE TABLE IF NOT EXISTS `properties_decorations` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `property_id` int(11) NOT NULL,
  `model` varchar(255) NOT NULL,
  `coords` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`coords`)),
  `rotation` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`rotation`)),
  PRIMARY KEY (`id`),
  KEY `property_id` (`property_id`),
  CONSTRAINT `1` FOREIGN KEY (`property_id`) REFERENCES `properties` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table qbox_27adff.properties_decorations: ~0 rows (approximately)

-- Dumping structure for table qbox_27adff.users
CREATE TABLE IF NOT EXISTS `users` (
  `userId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(255) DEFAULT NULL,
  `license` varchar(50) DEFAULT NULL,
  `license2` varchar(50) DEFAULT NULL,
  `fivem` varchar(20) DEFAULT NULL,
  `discord` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`userId`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table qbox_27adff.users: ~1 rows (approximately)
INSERT INTO `users` (`userId`, `username`, `license`, `license2`, `fivem`, `discord`) VALUES
	(1, 'DEV Dx', 'license:dd7efc1d5db42797e8b4c351e1b536aee84c43e7', 'license2:a045ed84bc7b147ab67442c4be4c70a4bb7d0ad5', 'fivem:8771348', 'discord:811436286006657025');

-- Dumping structure for table qbox_27adff.vehicle_financing
CREATE TABLE IF NOT EXISTS `vehicle_financing` (
  `vehicleId` int(11) NOT NULL,
  `balance` int(11) DEFAULT NULL,
  `paymentamount` int(11) DEFAULT NULL,
  `paymentsleft` int(11) DEFAULT NULL,
  `financetime` int(11) DEFAULT NULL,
  PRIMARY KEY (`vehicleId`),
  CONSTRAINT `vehicleId` FOREIGN KEY (`vehicleId`) REFERENCES `player_vehicles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table qbox_27adff.vehicle_financing: ~0 rows (approximately)

-- Dumping structure for table qbox_27adff.weed_plants
CREATE TABLE IF NOT EXISTS `weed_plants` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `property` varchar(30) DEFAULT NULL,
  `stage` tinyint(4) NOT NULL DEFAULT 1,
  `sort` varchar(30) NOT NULL,
  `gender` enum('male','female') NOT NULL,
  `food` tinyint(4) NOT NULL DEFAULT 100,
  `health` tinyint(4) NOT NULL DEFAULT 100,
  `stageProgress` tinyint(4) NOT NULL DEFAULT 0,
  `coords` tinytext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Dumping data for table qbox_27adff.weed_plants: ~0 rows (approximately)

-- Dumping structure for table qbox_27adff.xt_prison
CREATE TABLE IF NOT EXISTS `xt_prison` (
  `identifier` varchar(100) NOT NULL,
  `jailtime` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`identifier`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- Dumping data for table qbox_27adff.xt_prison: ~1 rows (approximately)
INSERT INTO `xt_prison` (`identifier`, `jailtime`) VALUES
	('BI315886', 0);

-- Dumping structure for table qbox_27adff.xt_prison_items
CREATE TABLE IF NOT EXISTS `xt_prison_items` (
  `owner` varchar(60) DEFAULT NULL,
  `data` longtext DEFAULT NULL,
  UNIQUE KEY `owner` (`owner`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- Dumping data for table qbox_27adff.xt_prison_items: ~0 rows (approximately)

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
