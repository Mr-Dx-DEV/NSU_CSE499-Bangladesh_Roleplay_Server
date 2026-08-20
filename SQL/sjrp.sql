-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Creato il: Feb 21, 2022 alle 21:24
-- Versione del server: 10.4.21-MariaDB
-- Versione PHP: 7.3.31

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `sjrp`
--

-- --------------------------------------------------------

--
-- Struttura della tabella `apartments`
--

CREATE TABLE `apartments` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `label` varchar(255) DEFAULT NULL,
  `citizenid` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struttura della tabella `bank_accounts`
--

CREATE TABLE `bank_accounts` (
  `record_id` bigint(255) NOT NULL,
  `citizenid` varchar(250) DEFAULT NULL,
  `buisness` varchar(50) DEFAULT NULL,
  `buisnessid` int(11) DEFAULT NULL,
  `gangid` varchar(50) DEFAULT NULL,
  `amount` bigint(255) NOT NULL DEFAULT 0,
  `account_type` enum('Current','Savings','Buisness','Gang') NOT NULL DEFAULT 'Current'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struttura della tabella `bank_statements`
--

CREATE TABLE `bank_statements` (
  `record_id` bigint(255) NOT NULL,
  `citizenid` varchar(50) DEFAULT NULL,
  `account` varchar(50) DEFAULT NULL,
  `business` varchar(50) DEFAULT NULL,
  `businessid` int(11) DEFAULT NULL,
  `gangid` varchar(50) DEFAULT NULL,
  `deposited` int(11) DEFAULT NULL,
  `withdraw` int(11) DEFAULT NULL,
  `balance` int(11) DEFAULT NULL,
  `date` varchar(50) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struttura della tabella `bans`
--

CREATE TABLE `bans` (
  `id` int(11) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `license` varchar(50) DEFAULT NULL,
  `discord` varchar(50) DEFAULT NULL,
  `ip` varchar(50) DEFAULT NULL,
  `reason` text DEFAULT NULL,
  `expire` int(11) DEFAULT NULL,
  `bannedby` varchar(255) NOT NULL DEFAULT 'LeBanhammer'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struttura della tabella `boost_queue`
--

CREATE TABLE `boost_queue` (
  `identifier` varchar(60) NOT NULL,
  `pSrc` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dump dei dati per la tabella `boost_queue`
--

INSERT INTO `boost_queue` (`identifier`, `pSrc`) VALUES
('NVI25523', 1),
('RQM53819', 2),
('ZHV82018', 5);

-- --------------------------------------------------------

--
-- Struttura della tabella `bropixel_boosting`
--

CREATE TABLE `bropixel_boosting` (
  `#` int(11) NOT NULL,
  `citizenid` varchar(255) NOT NULL,
  `BNE` text NOT NULL DEFAULT '0',
  `background` varchar(255) DEFAULT NULL,
  `vin` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dump dei dati per la tabella `bropixel_boosting`
--

INSERT INTO `bropixel_boosting` (`#`, `citizenid`, `BNE`, `background`, `vin`) VALUES
(19, 'NVI25523', '0', NULL, NULL),
(20, 'RQM53819', '0', NULL, NULL),
(21, 'ZHV82018', '0', 'images/background.png', NULL);

-- --------------------------------------------------------

--
-- Struttura della tabella `communityservice`
--

CREATE TABLE `communityservice` (
  `citizenid` varchar(100) NOT NULL,
  `actions_remaining` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struttura della tabella `crypto`
--

CREATE TABLE `crypto` (
  `crypto` varchar(50) NOT NULL DEFAULT 'qbit',
  `worth` int(11) NOT NULL DEFAULT 0,
  `history` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struttura della tabella `crypto_transactions`
--

CREATE TABLE `crypto_transactions` (
  `id` int(11) NOT NULL,
  `citizenid` varchar(50) DEFAULT NULL,
  `title` varchar(50) DEFAULT NULL,
  `message` varchar(50) DEFAULT NULL,
  `date` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struttura della tabella `dealers`
--

CREATE TABLE `dealers` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL DEFAULT '0',
  `coords` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `time` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `createdby` varchar(50) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struttura della tabella `fine_types`
--

CREATE TABLE `fine_types` (
  `id` int(11) NOT NULL,
  `label` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `amount` int(11) DEFAULT NULL,
  `category` int(11) DEFAULT NULL,
  `jailtime` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `fine_types`
--

INSERT INTO `fine_types` (`id`, `label`, `amount`, `category`, `jailtime`) VALUES
(1, 'Murder', 3000, 0, 15),
(2, 'Involuntary Manslaughter', 1000, 0, 5),
(3, 'Vehicular Manslaughter', 750, 0, 5),
(4, 'Attempted Murder on LEO', 2000, 0, 10),
(5, 'Attempted Murder', 1500, 0, 50),
(6, 'Assault w/ Deadly Weapon on LEO', 1500, 0, 45),
(7, 'Assault w/ Deadly Weapon', 1000, 0, 30),
(8, 'Assault on LEO', 750, 0, 15),
(9, 'Assault', 1000, 0, 10),
(10, 'Kidnapping of an LEO', 1000, 0, 20),
(11, 'Kidnapping / Hostage Taking', 750, 0, 20),
(12, 'Bank Robbery', 3000, 0, 50),
(13, 'Armored Truck Robbery', 2000, 0, 20),
(14, 'Jewelery Store Robbery ', 3000, 0, 20),
(15, 'Store Robbery', 2000, 0, 15),
(16, 'House Robbery', 1000, 0, 10),
(17, 'Corruption', 10000, 0, 650),
(18, 'Felony Driving Under the Influence', 500, 0, 10),
(19, 'Grand Theft Auto', 500, 0, 5),
(20, 'Evading Arrest', 500, 0, 10),
(21, 'Driving Under the Influence', 500, 0, 5),
(22, 'Hit and Run', 500, 0, 5),
(23, 'Operating a Motor Vehicle without a License', 500, 0, 10),
(24, 'Criminal Speeding', 300, 0, 10),
(25, 'Excessive Speeding 4', 250, 0, 0),
(26, 'Excessive Speeding 3', 200, 0, 0),
(27, 'Excessive Speeding 2', 150, 0, 0),
(28, 'Excessive Speeding', 100, 0, 0),
(29, 'Operating an Unregisted Motor Vehicle', 250, 0, 5),
(30, 'Reckless Endangerment', 250, 0, 5),
(31, 'Careless Driving', 250, 0, 0),
(32, 'Operating a Non-Street Legal Vehicle', 200, 0, 5),
(33, 'Failure to Stop', 250, 0, 0),
(34, 'Obstructing Traffic', 150, 0, 0),
(35, 'Illegal Lane Change', 100, 0, 0),
(36, 'Failure to Yield to an Emergency Vehicle', 150, 0, 0),
(37, 'Illegal Parking', 100, 0, 0),
(38, 'Excessive Vehicle Noise', 100, 0, 0),
(39, 'Driving without Proper Use of Headlights', 100, 0, 0),
(40, 'Illegal U-Turn', 100, 0, 0),
(41, 'Drug Manufacturing/Cultivation', 1500, 0, 20),
(42, 'Possession of Schedule 1 Drug', 2500, 0, 15),
(43, 'Possession of Schedule 2 Drug', 3000, 0, 20),
(44, 'Sale/Distribution of Schedule 1 Drug', 3500, 0, 20),
(45, 'Sale/Distribution of Schedule 2 Drug', 4000, 0, 20),
(46, 'Drug Trafficking', 3000, 0, 20),
(47, 'Weapons Caching of Class 2s', 3500, 0, 20),
(48, 'Weapons Caching of Class 1s', 3000, 0, 40),
(49, 'Weapons Trafficking of Class 2s', 3000, 0, 20),
(50, 'Weapons Trafficking of Class 1s', 3500, 0, 20),
(51, 'Possession of a Class 2 Firearm', 2500, 0, 20),
(52, 'Possession of a Class 1 Firearm', 1500, 0, 15),
(53, 'Brandishing a Firearm', 1000, 0, 5),
(54, 'Unlawful discharge of a firearm', 1500, 0, 10),
(55, 'Perjury', 1000, 0, 60),
(56, 'Arson', 500, 0, 30),
(57, 'False Impersonation of a Government Official', 2000, 0, 25),
(58, 'Possession of Dirty Money', 2000, 0, 25),
(59, 'Possession of Stolen Goods', 1000, 0, 15),
(60, 'Unlawful Solicitation', 1500, 0, 20),
(61, 'Larceny', 150, 0, 20),
(62, 'Felony Attempted Commision of an Offence/Crime', 1500, 0, 20),
(63, 'Tampering With Evidence', 20000, 0, 20),
(64, 'Illegal Gambling', 2000, 0, 20),
(65, 'Bribery', 2000, 0, 20),
(66, 'Stalking', 1500, 0, 20),
(67, 'Organizing an illegal event', 3500, 0, 15),
(68, 'Participating in an illegal event', 2500, 0, 5),
(69, 'Criminal Mischief', 1000, 0, 15),
(70, 'Prostitution', 2500, 0, 15),
(71, 'Failure to Identify', 1500, 0, 15),
(72, 'Obstruction of Justice', 25000, 0, 15),
(73, 'Resisting Arrest', 1000, 0, 10),
(74, 'Disturbing the Peace', 1000, 0, 10),
(75, 'Threat to do Bodily Harm', 1000, 0, 10),
(76, 'Terroristic Threat', 5000, 0, 10),
(77, 'Damage to Government Property', 500, 0, 10),
(78, 'Contempt of Court', 25000, 0, 10),
(79, 'Failure to Obey a Lawful Order', 500, 0, 10),
(80, 'False Report', 240, 0, 10),
(81, 'Trespassing', 1000, 0, 10),
(82, 'Loitering', 250, 0, 0),
(83, 'Public Intoxication', 1000, 0, 0),
(84, 'Indecent Exposure', 500, 0, 0),
(85, 'Verbal Harassment ', 500, 0, 0),
(86, 'Aiding and Abetting', 500, 0, 0),
(87, 'Incident Report', 0, 0, 0),
(88, 'Written Citation', 0, 0, 0),
(89, 'Stealing PD Stuffs', 25000, 0, 20),
(90, 'Verbal Warning', 0, 0, 0);

-- --------------------------------------------------------

--
-- Struttura della tabella `gloveboxitems`
--

CREATE TABLE `gloveboxitems` (
  `id` int(11) NOT NULL,
  `plate` varchar(255) NOT NULL DEFAULT '[]',
  `items` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struttura della tabella `houselocations`
--

CREATE TABLE `houselocations` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `label` varchar(255) DEFAULT NULL,
  `coords` text DEFAULT NULL,
  `owned` tinyint(1) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `tier` tinyint(4) DEFAULT NULL,
  `garage` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struttura della tabella `house_plants`
--

CREATE TABLE `house_plants` (
  `id` int(11) NOT NULL,
  `building` varchar(50) DEFAULT NULL,
  `stage` varchar(50) DEFAULT 'stage-a',
  `sort` varchar(50) DEFAULT NULL,
  `gender` varchar(50) DEFAULT NULL,
  `food` int(11) DEFAULT 100,
  `health` int(11) DEFAULT 100,
  `progress` int(11) DEFAULT 0,
  `coords` text DEFAULT NULL,
  `plantid` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struttura della tabella `lapraces`
--

CREATE TABLE `lapraces` (
  `id` int(11) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `checkpoints` text DEFAULT NULL,
  `records` text DEFAULT NULL,
  `creator` varchar(50) DEFAULT NULL,
  `distance` int(11) DEFAULT NULL,
  `raceid` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struttura della tabella `mdt_reports`
--

CREATE TABLE `mdt_reports` (
  `id` int(11) NOT NULL,
  `char_id` int(11) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `incident` longtext DEFAULT NULL,
  `charges` longtext DEFAULT NULL,
  `author` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `date` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struttura della tabella `mdt_warrants`
--

CREATE TABLE `mdt_warrants` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `char_id` int(11) DEFAULT NULL,
  `report_id` int(11) DEFAULT NULL,
  `report_title` varchar(255) DEFAULT NULL,
  `charges` longtext DEFAULT NULL,
  `date` varchar(255) DEFAULT NULL,
  `expire` varchar(255) DEFAULT NULL,
  `notes` varchar(255) DEFAULT NULL,
  `author` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struttura della tabella `occasion_vehicles`
--

CREATE TABLE `occasion_vehicles` (
  `id` int(11) NOT NULL,
  `seller` varchar(50) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `description` longtext DEFAULT NULL,
  `plate` varchar(50) DEFAULT NULL,
  `model` varchar(50) DEFAULT NULL,
  `mods` text DEFAULT NULL,
  `occasionid` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struttura della tabella `paychecks`
--

CREATE TABLE `paychecks` (
  `citizenid` varchar(250) CHARACTER SET latin1 COLLATE latin1_spanish_ci DEFAULT NULL,
  `collectamount` int(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dump dei dati per la tabella `paychecks`
--

INSERT INTO `paychecks` (`citizenid`, `collectamount`) VALUES
('NVI25523', 860),
('RQM53819', 10270),
('NQL27025', 3750),
('ZHV82018', 8260);

-- --------------------------------------------------------

--
-- Struttura della tabella `permissions`
--

CREATE TABLE `permissions` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `license` varchar(255) NOT NULL,
  `permission` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dump dei dati per la tabella `permissions`
--

INSERT INTO `permissions` (`id`, `name`, `license`, `permission`) VALUES
(3, 'King˳Hunter18', 'license:b5dd4648502c28e6e4a07235b2efff9de75c5729', 'god'),
(23, 'PG', 'license:faf61e9db444d1fb675f7685db8925290761798f', 'god');

-- --------------------------------------------------------

--
-- Struttura della tabella `phone_gallery`
--

CREATE TABLE `phone_gallery` (
  `citizenid` varchar(255) NOT NULL,
  `image` varchar(255) NOT NULL,
  `date` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struttura della tabella `phone_invoices`
--

CREATE TABLE `phone_invoices` (
  `id` int(10) NOT NULL,
  `citizenid` varchar(50) DEFAULT NULL,
  `amount` int(11) NOT NULL DEFAULT 0,
  `society` tinytext DEFAULT NULL,
  `sender` varchar(50) DEFAULT NULL,
  `sendercitizenid` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struttura della tabella `phone_messages`
--

CREATE TABLE `phone_messages` (
  `id` int(11) NOT NULL,
  `citizenid` varchar(50) DEFAULT NULL,
  `number` varchar(50) DEFAULT NULL,
  `messages` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struttura della tabella `phone_tweets`
--

CREATE TABLE `phone_tweets` (
  `id` int(11) NOT NULL,
  `citizenid` varchar(50) DEFAULT NULL,
  `firstName` varchar(25) DEFAULT NULL,
  `lastName` varchar(25) DEFAULT NULL,
  `message` text DEFAULT NULL,
  `date` datetime DEFAULT current_timestamp(),
  `url` text DEFAULT NULL,
  `picture` text DEFAULT './img/default.png',
  `tweetId` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struttura della tabella `players`
--

CREATE TABLE `players` (
  `id` int(11) NOT NULL,
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
  `last_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `tattoos` longtext DEFAULT NULL,
  `skin` longtext DEFAULT NULL,
  `luckywheel_spins` varchar(1) DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dump dei dati per la tabella `players`
--

INSERT INTO `players` (`id`, `citizenid`, `cid`, `license`, `name`, `money`, `charinfo`, `job`, `gang`, `position`, `metadata`, `inventory`, `last_updated`, `tattoos`, `skin`, `luckywheel_spins`) VALUES
(9733, 'NQL27025', 1, 'license:b5dd4648502c28e6e4a07235b2efff9de75c5729', 'King˳Hunter18', '{\"cash\":9999994999,\"crypto\":0,\"bank\":5000}', '{\"backstory\":\"placeholder backstory\",\"account\":\"US06QBCore1601462674\",\"birthdate\":\"1231-03-21\",\"firstname\":\"123\",\"gender\":0,\"cid\":\"1\",\"phone\":\"1519743418\",\"lastname\":\"213\",\"nationality\":\"123\"}', '{\"name\":\"police\",\"onduty\":true,\"payment\":750,\"grade\":{\"name\":\"IGP\",\"level\":10},\"label\":\"Bangladesh Police\",\"isboss\":true}', '{\"grade\":{\"name\":\"none\",\"level\":0},\"isboss\":false,\"name\":\"none\",\"label\":\"No Gang Affiliaton\"}', '{\"x\":719.2088012695313,\"y\":-981.3230590820313,\"z\":24.123779296875}', '{\"status\":[],\"ishandcuffed\":false,\"jobrep\":{\"hotdog\":0,\"trucker\":0,\"taxi\":0,\"tow\":0},\"walletid\":\"QB-38670963\",\"thirst\":83.5,\"tracker\":false,\"stress\":7,\"armor\":0,\"bloodtype\":\"O-\",\"fitbit\":[],\"dealerrep\":0,\"inside\":{\"apartment\":[]},\"attachmentcraftingrep\":0,\"phone\":[],\"communityservice\":0,\"fingerprint\":\"qq596l16qKb8808\",\"phonedata\":{\"SerialNumber\":52237344,\"InstalledApps\":[]},\"licences\":{\"driver\":true,\"weapon\":false,\"business\":false},\"commandbinds\":[],\"jailitems\":[],\"callsign\":\"NO CALLSIGN\",\"criminalrecord\":{\"hasRecord\":false},\"isdead\":false,\"injail\":0,\"craftingrep\":0,\"hunger\":83.5,\"inlaststand\":false}', '[{\"name\":\"weapon_m4\",\"amount\":1,\"slot\":1,\"type\":\"weapon\",\"info\":{\"quality\":95.19999999999982,\"ammo\":224,\"serie\":\"52VGL2rA375JnMp\"}},{\"name\":\"magicitem11\",\"amount\":2,\"slot\":2,\"type\":\"item\",\"info\":[]},{\"name\":\"magicitem12\",\"amount\":1,\"slot\":3,\"type\":\"item\",\"info\":[]},{\"name\":\"magicitem13\",\"amount\":1,\"slot\":4,\"type\":\"item\",\"info\":[]},{\"name\":\"magicitem9\",\"amount\":1,\"slot\":5,\"type\":\"item\",\"info\":[]},{\"name\":\"magicitem10\",\"amount\":2,\"slot\":6,\"type\":\"item\",\"info\":[]},{\"name\":\"magicitem14\",\"amount\":1,\"slot\":7,\"type\":\"item\",\"info\":[]},{\"name\":\"weapon_pistol\",\"amount\":1,\"slot\":8,\"type\":\"weapon\",\"info\":{\"quality\":89.4999999999996,\"serie\":\"46tqJ6Hw117eBTi\",\"ammo\":63}}]', '2022-02-21 20:23:21', NULL, '{\"model\":\"mp_m_freemode_01\",\"headBlend\":{\"shapeFirst\":0,\"skinMix\":0,\"skinSecond\":0,\"skinFirst\":0,\"shapeMix\":0,\"shapeSecond\":0},\"headOverlays\":{\"makeUp\":{\"opacity\":0,\"style\":0,\"color\":0},\"sunDamage\":{\"opacity\":0,\"style\":0,\"color\":0},\"ageing\":{\"opacity\":0,\"style\":0,\"color\":0},\"beard\":{\"opacity\":0,\"style\":0,\"color\":0},\"complexion\":{\"opacity\":0,\"style\":0,\"color\":0},\"blemishes\":{\"opacity\":0,\"style\":0,\"color\":0},\"moleAndFreckles\":{\"opacity\":0,\"style\":0,\"color\":0},\"lipstick\":{\"opacity\":0,\"style\":0,\"color\":0},\"blush\":{\"opacity\":0,\"style\":0,\"color\":0},\"eyebrows\":{\"opacity\":0,\"style\":0,\"color\":0},\"bodyBlemishes\":{\"opacity\":0,\"style\":0,\"color\":0},\"chestHair\":{\"opacity\":0,\"style\":0,\"color\":0}},\"eyeColor\":-1,\"props\":[{\"texture\":-1,\"drawable\":-1,\"prop_id\":0},{\"texture\":-1,\"drawable\":-1,\"prop_id\":1},{\"texture\":-1,\"drawable\":-1,\"prop_id\":2},{\"texture\":-1,\"drawable\":-1,\"prop_id\":6},{\"texture\":-1,\"drawable\":-1,\"prop_id\":7}],\"faceFeatures\":{\"nosePeakHigh\":0,\"noseBoneHigh\":0,\"lipsThickness\":0,\"jawBoneBackSize\":0,\"eyeBrownHigh\":0,\"eyesOpening\":0,\"chinBoneLowering\":0,\"nosePeakSize\":0,\"noseWidth\":0,\"cheeksBoneWidth\":0,\"nosePeakLowering\":0,\"jawBoneWidth\":0,\"cheeksWidth\":0,\"chinBoneSize\":0,\"noseBoneTwist\":0,\"eyeBrownForward\":0,\"chinHole\":0,\"neckThickness\":0,\"cheeksBoneHigh\":0,\"chinBoneLenght\":0},\"hair\":{\"highlight\":0,\"style\":0,\"color\":0},\"components\":[{\"component_id\":0,\"texture\":0,\"drawable\":0},{\"component_id\":1,\"texture\":0,\"drawable\":0},{\"component_id\":2,\"texture\":0,\"drawable\":0},{\"component_id\":3,\"texture\":0,\"drawable\":0},{\"component_id\":4,\"texture\":0,\"drawable\":0},{\"component_id\":5,\"texture\":0,\"drawable\":0},{\"component_id\":6,\"texture\":0,\"drawable\":0},{\"component_id\":7,\"texture\":0,\"drawable\":0},{\"component_id\":8,\"texture\":0,\"drawable\":0},{\"component_id\":9,\"texture\":0,\"drawable\":0},{\"component_id\":10,\"texture\":0,\"drawable\":0},{\"component_id\":11,\"texture\":0,\"drawable\":0}]}', '1'),
(9740, 'NVI25523', 1, 'license:5eee9b7a194d6f69591ed0245c3a4f600b58c832', 'MightyZuby', '{\"crypto\":0,\"cash\":10057.0,\"bank\":5137}', '{\"account\":\"US08QBCore2698917595\",\"backstory\":\"placeholder backstory\",\"birthdate\":\"1995-09-14\",\"cid\":\"1\",\"phone\":\"1590580684\",\"lastname\":\"HUku\",\"nationality\":\"Bangladeshi\",\"firstname\":\"Huku\",\"gender\":0}', '{\"payment\":50,\"grade\":{\"level\":0,\"name\":\"Driver\"},\"onduty\":true,\"name\":\"trucker\",\"label\":\"Trucker\",\"isboss\":false}', '{\"isboss\":false,\"label\":\"No Gang Affiliaton\",\"grade\":{\"level\":0,\"name\":\"none\"},\"name\":\"none\"}', '{\"x\":1006.2593383789063,\"y\":-202.1802215576172,\"z\":69.5677490234375}', '{\"craftingrep\":0,\"status\":[],\"communityservice\":0,\"injail\":0,\"ishandcuffed\":false,\"hunger\":98.5,\"inlaststand\":false,\"phonedata\":{\"SerialNumber\":49161540,\"InstalledApps\":[]},\"jailitems\":[],\"attachmentcraftingrep\":0,\"criminalrecord\":{\"hasRecord\":false},\"jobrep\":{\"taxi\":0,\"trucker\":0,\"tow\":0,\"hotdog\":0},\"dealerrep\":0,\"commandbinds\":[],\"inside\":{\"apartment\":[]},\"stress\":0,\"armor\":0,\"phone\":[],\"bloodtype\":\"B-\",\"callsign\":\"NO CALLSIGN\",\"fingerprint\":\"DO862p34Izl7491\",\"fitbit\":[],\"tracker\":false,\"walletid\":\"QB-37450419\",\"thirst\":98.5,\"licences\":{\"driver\":true,\"weapon\":false,\"business\":false},\"isdead\":false}', '[{\"name\":\"weapon_musket\",\"slot\":1,\"type\":\"weapon\",\"info\":{\"ammo\":5,\"quality\":98.49999999999995},\"amount\":1},{\"name\":\"shotgun_ammo\",\"slot\":2,\"type\":\"item\",\"info\":[],\"amount\":9},{\"name\":\"hunting_knife\",\"slot\":3,\"type\":\"item\",\"info\":{\"level\":1,\"animals\":0},\"amount\":1},{\"name\":\"id_card\",\"slot\":4,\"type\":\"item\",\"info\":{\"lastname\":\"HUku\",\"gender\":0,\"nationality\":\"Bangladeshi\",\"citizenid\":\"NVI25523\",\"firstname\":\"Huku\",\"birthdate\":\"1995-09-14\"},\"amount\":1},{\"name\":\"sandwich\",\"slot\":5,\"type\":\"item\",\"info\":\"\",\"amount\":5},{\"name\":\"water_bottle\",\"slot\":6,\"type\":\"item\",\"info\":\"\",\"amount\":5},{\"name\":\"lockpick\",\"slot\":7,\"type\":\"item\",\"info\":\"\",\"amount\":1},{\"name\":\"phone\",\"slot\":8,\"type\":\"item\",\"info\":[],\"amount\":1},{\"name\":\"weapon_pistol\",\"slot\":9,\"type\":\"weapon\",\"info\":{\"ammo\":8,\"serie\":\"58Qia9Ij079BMpn\",\"quality\":87.24999999999952},\"amount\":1},{\"name\":\"pistol_ammo\",\"slot\":10,\"type\":\"item\",\"info\":[],\"amount\":7},{\"name\":\"rentalpapers\",\"slot\":11,\"type\":\"item\",\"info\":{\"plate\":\"42BFC879\",\"model\":\"Weeny Issi Sport\",\"citizenid\":\"NVI25523\",\"firstname\":\"Huku\",\"lastname\":\"HUku\"},\"amount\":1},{\"name\":\"lion_meat\",\"slot\":12,\"type\":\"item\",\"info\":\"\",\"amount\":7},{\"name\":\"rabbit_meat\",\"slot\":13,\"type\":\"item\",\"info\":\"\",\"amount\":2},{\"name\":\"pixellaptop\",\"slot\":15,\"type\":\"item\",\"info\":[],\"amount\":1}]', '2022-02-21 18:31:45', NULL, '{\"headBlend\":{\"shapeMix\":0,\"shapeSecond\":0,\"skinFirst\":0,\"skinMix\":0,\"skinSecond\":0,\"shapeFirst\":0},\"props\":[{\"drawable\":-1,\"prop_id\":0,\"texture\":-1},{\"drawable\":-1,\"prop_id\":1,\"texture\":-1},{\"drawable\":-1,\"prop_id\":2,\"texture\":-1},{\"drawable\":-1,\"prop_id\":6,\"texture\":-1},{\"drawable\":-1,\"prop_id\":7,\"texture\":-1}],\"eyeColor\":-1,\"headOverlays\":{\"moleAndFreckles\":{\"opacity\":0,\"style\":0,\"color\":0},\"ageing\":{\"opacity\":0,\"style\":0,\"color\":0},\"blemishes\":{\"opacity\":0,\"style\":0,\"color\":0},\"bodyBlemishes\":{\"opacity\":0,\"style\":0,\"color\":0},\"lipstick\":{\"opacity\":0,\"style\":0,\"color\":0},\"eyebrows\":{\"opacity\":0,\"style\":0,\"color\":0},\"blush\":{\"opacity\":0,\"style\":0,\"color\":0},\"sunDamage\":{\"opacity\":0,\"style\":0,\"color\":0},\"beard\":{\"opacity\":1,\"style\":9,\"color\":0},\"makeUp\":{\"opacity\":0,\"style\":0,\"color\":0},\"complexion\":{\"opacity\":0,\"style\":0,\"color\":0},\"chestHair\":{\"opacity\":0,\"style\":0,\"color\":0}},\"model\":\"mp_m_freemode_01\",\"components\":[{\"texture\":0,\"component_id\":0,\"drawable\":0},{\"texture\":0,\"component_id\":2,\"drawable\":0},{\"texture\":0,\"component_id\":3,\"drawable\":0},{\"texture\":0,\"component_id\":4,\"drawable\":0},{\"texture\":0,\"component_id\":5,\"drawable\":0},{\"texture\":0,\"component_id\":6,\"drawable\":0},{\"texture\":0,\"component_id\":7,\"drawable\":0},{\"texture\":0,\"component_id\":8,\"drawable\":0},{\"texture\":0,\"component_id\":9,\"drawable\":0},{\"texture\":0,\"component_id\":10,\"drawable\":0},{\"texture\":0,\"component_id\":11,\"drawable\":0},{\"texture\":0,\"component_id\":1,\"drawable\":2}],\"hair\":{\"highlight\":0,\"style\":4,\"color\":0},\"faceFeatures\":{\"chinHole\":0,\"nosePeakSize\":0,\"jawBoneWidth\":0,\"chinBoneLowering\":0,\"cheeksBoneHigh\":0,\"eyeBrownForward\":0,\"noseBoneTwist\":0,\"lipsThickness\":0,\"eyesOpening\":0,\"noseBoneHigh\":0,\"jawBoneBackSize\":0,\"nosePeakHigh\":0,\"chinBoneSize\":0,\"cheeksWidth\":0,\"eyeBrownHigh\":0,\"nosePeakLowering\":0,\"neckThickness\":0,\"chinBoneLenght\":0,\"cheeksBoneWidth\":0,\"noseWidth\":0}}', '1'),
(9745, 'RQM53819', 1, 'license:faf61e9db444d1fb675f7685db8925290761798f', 'yasin', '{\"cash\":732.0,\"crypto\":0,\"bank\":5000}', '{\"backstory\":\"placeholder backstory\",\"account\":\"US05QBCore9316473714\",\"birthdate\":\"1993-08-29\",\"firstname\":\"Mr\",\"gender\":0,\"cid\":\"1\",\"phone\":\"1532163358\",\"nationality\":\"SJRP\",\"lastname\":\"GG\"}', '{\"name\":\"police\",\"onduty\":false,\"payment\":750,\"grade\":{\"name\":\"IGP\",\"level\":10},\"label\":\"Bangladesh Police\",\"isboss\":true}', '{\"grade\":{\"name\":\"none\",\"level\":0},\"label\":\"No Gang Affiliaton\",\"name\":\"none\",\"isboss\":false}', '{\"x\":5322.1318359375,\"y\":-5592.6064453125,\"z\":64.6812744140625}', '{\"status\":[],\"ishandcuffed\":false,\"jobrep\":{\"hotdog\":0,\"tow\":0,\"taxi\":0,\"trucker\":0},\"walletid\":\"QB-79065488\",\"thirst\":97.0,\"tracker\":false,\"isdead\":false,\"armor\":0,\"phone\":[],\"fitbit\":[],\"dealerrep\":0,\"inside\":{\"apartment\":[]},\"communityservice\":0,\"bloodtype\":\"A+\",\"attachmentcraftingrep\":0,\"fingerprint\":\"Fj004G76GFp2565\",\"phonedata\":{\"SerialNumber\":65823275,\"InstalledApps\":[]},\"licences\":{\"driver\":true,\"weapon\":false,\"business\":false},\"commandbinds\":[],\"stress\":0,\"callsign\":\"NO CALLSIGN\",\"criminalrecord\":{\"hasRecord\":false},\"hunger\":97.0,\"injail\":0,\"craftingrep\":0,\"jailitems\":[],\"inlaststand\":false}', '[{\"name\":\"weapon_musket\",\"amount\":1,\"slot\":1,\"type\":\"weapon\",\"info\":{\"quality\":99.09999999999997,\"ammo\":37}},{\"name\":\"shotgun_ammo\",\"amount\":6,\"slot\":2,\"type\":\"item\",\"info\":[]},{\"name\":\"weapon_pistol\",\"amount\":1,\"slot\":3,\"type\":\"weapon\",\"info\":{\"quality\":86.94999999999949,\"ammo\":7,\"serie\":\"93Pkf9bZ395BPHS\"}},{\"name\":\"pistol_ammo\",\"amount\":6,\"slot\":4,\"type\":\"item\",\"info\":[]},{\"name\":\"pixellaptop\",\"amount\":1,\"slot\":5,\"type\":\"item\",\"info\":[]},{\"name\":\"metalscrap\",\"amount\":1,\"slot\":6,\"type\":\"item\",\"info\":[]},{\"name\":\"black_usb\",\"amount\":1,\"slot\":7,\"type\":\"item\",\"info\":[]},{\"name\":\"phone\",\"amount\":1,\"slot\":8,\"type\":\"item\",\"info\":{\"phone\":\"1532163358\",\"lastname\":\"GG\",\"firstname\":\"Mr\"}},{\"name\":\"hunting_knife\",\"amount\":1,\"slot\":10,\"type\":\"item\",\"info\":{\"animals\":0,\"level\":1}}]', '2022-02-21 20:24:03', NULL, '{\"model\":\"mp_m_freemode_01\",\"props\":[{\"texture\":-1,\"prop_id\":0,\"drawable\":-1},{\"texture\":-1,\"prop_id\":1,\"drawable\":-1},{\"texture\":-1,\"prop_id\":2,\"drawable\":-1},{\"texture\":-1,\"prop_id\":6,\"drawable\":-1},{\"texture\":-1,\"prop_id\":7,\"drawable\":-1}],\"eyeColor\":-1,\"headOverlays\":{\"complexion\":{\"opacity\":0,\"style\":0,\"color\":0},\"ageing\":{\"opacity\":0,\"style\":0,\"color\":0},\"moleAndFreckles\":{\"opacity\":0,\"style\":0,\"color\":0},\"bodyBlemishes\":{\"opacity\":0,\"style\":0,\"color\":0},\"blemishes\":{\"opacity\":0,\"style\":0,\"color\":0},\"eyebrows\":{\"opacity\":0,\"style\":0,\"color\":0},\"blush\":{\"opacity\":0,\"style\":0,\"color\":0},\"sunDamage\":{\"opacity\":0,\"style\":0,\"color\":0},\"beard\":{\"opacity\":0,\"style\":0,\"color\":0},\"makeUp\":{\"opacity\":0,\"style\":0,\"color\":0},\"lipstick\":{\"opacity\":0,\"style\":0,\"color\":0},\"chestHair\":{\"opacity\":0,\"style\":0,\"color\":0}},\"headBlend\":{\"shapeMix\":0,\"shapeSecond\":0,\"skinFirst\":0,\"skinMix\":0,\"skinSecond\":0,\"shapeFirst\":0},\"components\":[{\"texture\":0,\"component_id\":0,\"drawable\":0},{\"texture\":0,\"component_id\":1,\"drawable\":0},{\"texture\":0,\"component_id\":2,\"drawable\":0},{\"texture\":0,\"component_id\":3,\"drawable\":0},{\"texture\":0,\"component_id\":4,\"drawable\":0},{\"texture\":0,\"component_id\":5,\"drawable\":0},{\"texture\":0,\"component_id\":6,\"drawable\":0},{\"texture\":0,\"component_id\":7,\"drawable\":0},{\"texture\":0,\"component_id\":8,\"drawable\":0},{\"texture\":0,\"component_id\":9,\"drawable\":0},{\"texture\":0,\"component_id\":10,\"drawable\":0},{\"texture\":0,\"component_id\":11,\"drawable\":0}],\"hair\":{\"highlight\":0,\"style\":0,\"color\":0},\"faceFeatures\":{\"chinHole\":0,\"cheeksBoneWidth\":0,\"nosePeakLowering\":0,\"chinBoneLowering\":0,\"cheeksBoneHigh\":0,\"eyeBrownForward\":0,\"noseWidth\":0,\"lipsThickness\":0,\"eyesOpening\":0,\"noseBoneHigh\":0,\"jawBoneBackSize\":0,\"nosePeakHigh\":0,\"eyeBrownHigh\":0,\"cheeksWidth\":0,\"nosePeakSize\":0,\"chinBoneLenght\":0,\"neckThickness\":0,\"jawBoneWidth\":0,\"noseBoneTwist\":0,\"chinBoneSize\":0}}', '1'),
(9794, 'ZHV82018', 1, 'license:1c68c57fe20f682d648b2c41765c591a2c4a3e8d', 'Alekzander Dumbass', '{\"cash\":60.0,\"crypto\":0,\"bank\":2800.0}', '{\"backstory\":\"placeholder backstory\",\"account\":\"US08QBCore5909872221\",\"birthdate\":\"1111-11-11\",\"firstname\":\"Boka\",\"gender\":0,\"cid\":\"1\",\"phone\":\"1776768663\",\"lastname\":\"Soda\",\"nationality\":\"Bikale\"}', '{\"name\":\"planepilot\",\"onduty\":true,\"payment\":250,\"grade\":{\"name\":\"Pilot\",\"level\":0},\"label\":\"Delivery\",\"isboss\":false}', '{\"grade\":{\"name\":\"none\",\"level\":0},\"label\":\"No Gang Affiliaton\",\"name\":\"none\",\"isboss\":false}', '{\"x\":5306.03076171875,\"y\":-5583.666015625,\"z\":62.9794921875}', '{\"status\":[],\"ishandcuffed\":false,\"jobrep\":{\"hotdog\":0,\"tow\":0,\"taxi\":0,\"trucker\":0},\"walletid\":\"QB-77074880\",\"thirst\":98.5,\"tracker\":false,\"injail\":0,\"armor\":0,\"bloodtype\":\"A+\",\"attachmentcraftingrep\":0,\"dealerrep\":0,\"inside\":{\"apartment\":[]},\"communityservice\":0,\"jailitems\":[],\"phone\":[],\"fingerprint\":\"nj674A02RQU4591\",\"phonedata\":{\"SerialNumber\":42991975,\"InstalledApps\":[]},\"licences\":{\"business\":false,\"weapon\":false,\"driver\":true},\"commandbinds\":[],\"fitbit\":[],\"callsign\":\"NO CALLSIGN\",\"criminalrecord\":{\"hasRecord\":false},\"isdead\":false,\"hunger\":98.5,\"craftingrep\":0,\"stress\":0,\"inlaststand\":false}', '[{\"name\":\"weapon_pistol\",\"amount\":1,\"slot\":1,\"type\":\"weapon\",\"info\":{\"quality\":83.34999999999937,\"serie\":\"87nQz5Gk188tNhO\",\"ammo\":28}},{\"name\":\"rifle_ammo\",\"amount\":1,\"slot\":3,\"type\":\"item\",\"info\":[]},{\"name\":\"weapon_m4\",\"amount\":1,\"slot\":4,\"type\":\"weapon\",\"info\":{\"serie\":\"06EiG5Uy200smXJ\"}},{\"name\":\"police_stormram\",\"amount\":1,\"slot\":5,\"type\":\"item\",\"info\":[]},{\"name\":\"sandwich\",\"amount\":5,\"slot\":6,\"type\":\"item\",\"info\":\"\"},{\"name\":\"water_bottle\",\"amount\":5,\"slot\":7,\"type\":\"item\",\"info\":\"\"},{\"name\":\"pixellaptop\",\"amount\":1,\"slot\":8,\"type\":\"item\",\"info\":[]},{\"name\":\"emerald\",\"amount\":1,\"slot\":9,\"type\":\"item\",\"info\":[]},{\"name\":\"walkstick\",\"amount\":1,\"slot\":10,\"type\":\"item\",\"info\":{\"quality\":95.0499999999998,\"ammo\":11}},{\"name\":\"ifak\",\"amount\":2,\"slot\":11,\"type\":\"item\",\"info\":[]},{\"name\":\"drill\",\"amount\":1,\"slot\":12,\"type\":\"item\",\"info\":[]},{\"name\":\"rentalpapers\",\"amount\":1,\"slot\":13,\"type\":\"item\",\"info\":{\"plate\":\"08TEZ236\",\"citizenid\":\"ZHV82018\",\"model\":\"Shitzu Hakuchou\",\"firstname\":\"Boka\",\"lastname\":\"Soda\"}},{\"name\":\"phone\",\"amount\":1,\"slot\":14,\"type\":\"item\",\"info\":[]},{\"name\":\"lockpick\",\"amount\":1,\"slot\":15,\"type\":\"item\",\"info\":\"\"},{\"name\":\"stone\",\"amount\":12,\"slot\":16,\"type\":\"item\",\"info\":[]},{\"name\":\"goldbar\",\"amount\":1,\"slot\":17,\"type\":\"item\",\"info\":[]},{\"name\":\"drillbit\",\"amount\":1,\"slot\":18,\"type\":\"item\",\"info\":[]},{\"name\":\"handdrill\",\"amount\":1,\"slot\":19,\"type\":\"item\",\"info\":[]},{\"name\":\"surgerypass\",\"amount\":1,\"slot\":20,\"type\":\"item\",\"info\":[]},{\"name\":\"black_usb\",\"amount\":1,\"slot\":21,\"type\":\"item\",\"info\":[]},{\"name\":\"copper\",\"amount\":8,\"slot\":23,\"type\":\"item\",\"info\":[]},{\"name\":\"iron\",\"amount\":2,\"slot\":24,\"type\":\"item\",\"info\":[]}]', '2022-02-21 20:20:08', NULL, '{\"components\":[{\"component_id\":0,\"texture\":0,\"drawable\":0},{\"component_id\":1,\"texture\":0,\"drawable\":0},{\"component_id\":2,\"texture\":0,\"drawable\":0},{\"component_id\":3,\"texture\":0,\"drawable\":0},{\"component_id\":4,\"texture\":0,\"drawable\":0},{\"component_id\":5,\"texture\":0,\"drawable\":0},{\"component_id\":6,\"texture\":0,\"drawable\":0},{\"component_id\":7,\"texture\":0,\"drawable\":0},{\"component_id\":9,\"texture\":0,\"drawable\":0},{\"component_id\":10,\"texture\":0,\"drawable\":0},{\"component_id\":8,\"texture\":0,\"drawable\":2},{\"component_id\":11,\"texture\":0,\"drawable\":74}],\"headBlend\":{\"shapeMix\":0,\"skinMix\":0,\"skinSecond\":0,\"shapeFirst\":0,\"skinFirst\":0,\"shapeSecond\":0},\"hair\":{\"style\":0,\"highlight\":0,\"color\":0},\"headOverlays\":{\"makeUp\":{\"opacity\":0,\"style\":0,\"color\":0},\"sunDamage\":{\"opacity\":0,\"style\":0,\"color\":0},\"ageing\":{\"opacity\":0,\"style\":0,\"color\":0},\"beard\":{\"opacity\":0,\"style\":0,\"color\":0},\"complexion\":{\"opacity\":0,\"style\":0,\"color\":0},\"blemishes\":{\"opacity\":0,\"style\":0,\"color\":0},\"moleAndFreckles\":{\"opacity\":0,\"style\":0,\"color\":0},\"lipstick\":{\"opacity\":0,\"style\":0,\"color\":0},\"eyebrows\":{\"opacity\":0,\"style\":0,\"color\":0},\"blush\":{\"opacity\":0,\"style\":0,\"color\":0},\"bodyBlemishes\":{\"opacity\":0,\"style\":0,\"color\":0},\"chestHair\":{\"opacity\":0,\"style\":0,\"color\":0}},\"eyeColor\":-1,\"faceFeatures\":{\"nosePeakHigh\":0,\"noseBoneHigh\":0,\"lipsThickness\":0,\"jawBoneBackSize\":0,\"noseBoneTwist\":0,\"chinBoneLenght\":0,\"chinBoneLowering\":0,\"nosePeakSize\":0,\"noseWidth\":0,\"chinBoneSize\":0,\"nosePeakLowering\":0,\"jawBoneWidth\":0,\"cheeksWidth\":0,\"eyeBrownHigh\":0,\"cheeksBoneWidth\":0,\"eyeBrownForward\":0,\"eyesOpening\":0,\"neckThickness\":0,\"cheeksBoneHigh\":0,\"chinHole\":0},\"props\":[{\"texture\":-1,\"drawable\":-1,\"prop_id\":0},{\"texture\":-1,\"drawable\":-1,\"prop_id\":1},{\"texture\":-1,\"drawable\":-1,\"prop_id\":2},{\"texture\":-1,\"drawable\":-1,\"prop_id\":6},{\"texture\":-1,\"drawable\":-1,\"prop_id\":7}],\"model\":\"mp_m_freemode_01\"}', '1');

-- --------------------------------------------------------

--
-- Struttura della tabella `playerskins`
--

CREATE TABLE `playerskins` (
  `id` int(11) NOT NULL,
  `citizenid` varchar(255) NOT NULL,
  `model` varchar(255) NOT NULL,
  `skin` text NOT NULL,
  `active` tinyint(4) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struttura della tabella `players_pd_presets`
--

CREATE TABLE `players_pd_presets` (
  `id` int(11) NOT NULL,
  `name` longtext DEFAULT NULL,
  `ped` longtext DEFAULT NULL,
  `components` longtext DEFAULT NULL,
  `props` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struttura della tabella `player_boats`
--

CREATE TABLE `player_boats` (
  `id` int(11) NOT NULL,
  `citizenid` varchar(50) DEFAULT NULL,
  `model` varchar(50) DEFAULT NULL,
  `plate` varchar(50) DEFAULT NULL,
  `boathouse` varchar(50) DEFAULT NULL,
  `fuel` int(11) NOT NULL DEFAULT 100,
  `state` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struttura della tabella `player_contacts`
--

CREATE TABLE `player_contacts` (
  `id` int(11) NOT NULL,
  `citizenid` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `number` varchar(50) DEFAULT NULL,
  `iban` varchar(50) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struttura della tabella `player_crops`
--

CREATE TABLE `player_crops` (
  `id` int(11) NOT NULL,
  `coords` longtext DEFAULT NULL,
  `seed` varchar(100) NOT NULL,
  `water` double NOT NULL,
  `food` double NOT NULL,
  `stage` double NOT NULL,
  `rate` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struttura della tabella `player_houses`
--

CREATE TABLE `player_houses` (
  `id` int(255) NOT NULL,
  `house` varchar(50) NOT NULL,
  `identifier` varchar(50) DEFAULT NULL,
  `citizenid` varchar(50) DEFAULT NULL,
  `keyholders` text DEFAULT NULL,
  `decorations` text DEFAULT NULL,
  `stash` text DEFAULT NULL,
  `outfit` text DEFAULT NULL,
  `logout` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struttura della tabella `player_mails`
--

CREATE TABLE `player_mails` (
  `id` int(11) NOT NULL,
  `citizenid` varchar(50) DEFAULT NULL,
  `sender` varchar(50) DEFAULT NULL,
  `subject` varchar(50) DEFAULT NULL,
  `message` text DEFAULT NULL,
  `read` tinyint(4) DEFAULT 0,
  `mailid` int(11) DEFAULT NULL,
  `date` timestamp NULL DEFAULT current_timestamp(),
  `button` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struttura della tabella `player_outfits`
--

CREATE TABLE `player_outfits` (
  `id` int(11) NOT NULL,
  `citizenid` varchar(50) DEFAULT NULL,
  `name` longtext DEFAULT NULL,
  `ped` longtext DEFAULT NULL,
  `components` longtext DEFAULT NULL,
  `props` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struttura della tabella `player_vehicles`
--

CREATE TABLE `player_vehicles` (
  `id` int(11) NOT NULL,
  `license` varchar(50) DEFAULT NULL,
  `citizenid` varchar(50) DEFAULT NULL,
  `vehicle` varchar(50) DEFAULT NULL,
  `hash` varchar(50) DEFAULT NULL,
  `mods` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `plate` varchar(50) NOT NULL,
  `fakeplate` varchar(50) DEFAULT NULL,
  `garage` varchar(50) DEFAULT NULL,
  `fuel` int(11) DEFAULT 100,
  `engine` float DEFAULT 1000,
  `body` float DEFAULT 1000,
  `state` int(11) DEFAULT 1,
  `depotprice` int(11) NOT NULL DEFAULT 0,
  `drivingdistance` int(50) DEFAULT NULL,
  `status` text DEFAULT NULL,
  `balance` int(11) NOT NULL DEFAULT 0,
  `paymentamount` int(11) NOT NULL DEFAULT 0,
  `paymentsleft` int(11) NOT NULL DEFAULT 0,
  `financetime` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struttura della tabella `player_warns`
--

CREATE TABLE `player_warns` (
  `id` int(11) NOT NULL,
  `senderIdentifier` varchar(50) DEFAULT NULL,
  `targetIdentifier` varchar(50) DEFAULT NULL,
  `reason` text DEFAULT NULL,
  `warnId` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struttura della tabella `promocodes`
--

CREATE TABLE `promocodes` (
  `id` int(255) NOT NULL,
  `type` varchar(50) NOT NULL,
  `item` varchar(255) NOT NULL,
  `amount` int(255) NOT NULL,
  `code` varchar(255) NOT NULL,
  `admin` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struttura della tabella `scenes`
--

CREATE TABLE `scenes` (
  `id` int(11) NOT NULL,
  `creator` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL,
  `text` mediumtext COLLATE utf8mb4_bin DEFAULT NULL,
  `color` mediumtext COLLATE utf8mb4_bin DEFAULT NULL,
  `viewdistance` int(11) DEFAULT NULL,
  `expiration` int(11) DEFAULT NULL,
  `fontsize` decimal(10,1) DEFAULT NULL,
  `fontstyle` int(11) DEFAULT NULL,
  `coords` mediumtext COLLATE utf8mb4_bin DEFAULT NULL,
  `date_creation` datetime DEFAULT NULL,
  `date_deletion` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Struttura della tabella `stashitems`
--

CREATE TABLE `stashitems` (
  `id` int(11) NOT NULL,
  `stash` varchar(255) NOT NULL DEFAULT '[]',
  `items` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dump dei dati per la tabella `stashitems`
--

INSERT INTO `stashitems` (`id`, `stash`, `items`) VALUES
(270, 'Adams_Apple_kinghunter_NQL27025', '[]'),
(269, 'policestash_ZHV82018', '[]');

-- --------------------------------------------------------

--
-- Struttura della tabella `trunkitems`
--

CREATE TABLE `trunkitems` (
  `id` int(11) NOT NULL,
  `plate` varchar(255) NOT NULL DEFAULT '[]',
  `items` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struttura della tabella `user_convictions`
--

CREATE TABLE `user_convictions` (
  `id` int(11) NOT NULL,
  `char_id` int(11) DEFAULT NULL,
  `offense` varchar(255) DEFAULT NULL,
  `count` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struttura della tabella `user_mdt`
--

CREATE TABLE `user_mdt` (
  `id` int(11) NOT NULL,
  `char_id` int(11) DEFAULT NULL,
  `notes` varchar(255) DEFAULT NULL,
  `mugshot_url` varchar(255) DEFAULT NULL,
  `bail` bit(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struttura della tabella `vaults`
--

CREATE TABLE `vaults` (
  `citizenid` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `storagename` varchar(255) NOT NULL,
  `storage_size` int(11) DEFAULT 400000,
  `holders` text DEFAULT NULL,
  `id` int(11) NOT NULL,
  `storage_location` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `vaults`
--

INSERT INTO `vaults` (`citizenid`, `password`, `storagename`, `storage_size`, `holders`, `id`, `storage_location`) VALUES
('NQL27025', '1234', 'kinghunter', 400000, NULL, 1, 'Adams_Apple');

-- --------------------------------------------------------

--
-- Struttura della tabella `vehicle_mdt`
--

CREATE TABLE `vehicle_mdt` (
  `id` int(11) NOT NULL,
  `plate` varchar(255) DEFAULT NULL,
  `stolen` bit(1) DEFAULT b'0',
  `notes` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indici per le tabelle scaricate
--

--
-- Indici per le tabelle `apartments`
--
ALTER TABLE `apartments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `citizenid` (`citizenid`),
  ADD KEY `name` (`name`);

--
-- Indici per le tabelle `bank_accounts`
--
ALTER TABLE `bank_accounts`
  ADD PRIMARY KEY (`record_id`),
  ADD UNIQUE KEY `citizenid` (`citizenid`),
  ADD KEY `buisness` (`buisness`),
  ADD KEY `buisnessid` (`buisnessid`),
  ADD KEY `gangid` (`gangid`);

--
-- Indici per le tabelle `bank_statements`
--
ALTER TABLE `bank_statements`
  ADD PRIMARY KEY (`record_id`),
  ADD KEY `business` (`business`),
  ADD KEY `businessid` (`businessid`),
  ADD KEY `gangid` (`gangid`);

--
-- Indici per le tabelle `bans`
--
ALTER TABLE `bans`
  ADD PRIMARY KEY (`id`),
  ADD KEY `license` (`license`),
  ADD KEY `discord` (`discord`),
  ADD KEY `ip` (`ip`);

--
-- Indici per le tabelle `boost_queue`
--
ALTER TABLE `boost_queue`
  ADD PRIMARY KEY (`identifier`);

--
-- Indici per le tabelle `bropixel_boosting`
--
ALTER TABLE `bropixel_boosting`
  ADD PRIMARY KEY (`#`),
  ADD KEY `citizenid` (`citizenid`);

--
-- Indici per le tabelle `communityservice`
--
ALTER TABLE `communityservice`
  ADD PRIMARY KEY (`citizenid`);

--
-- Indici per le tabelle `crypto`
--
ALTER TABLE `crypto`
  ADD PRIMARY KEY (`crypto`);

--
-- Indici per le tabelle `crypto_transactions`
--
ALTER TABLE `crypto_transactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `citizenid` (`citizenid`);

--
-- Indici per le tabelle `dealers`
--
ALTER TABLE `dealers`
  ADD PRIMARY KEY (`id`);

--
-- Indici per le tabelle `fine_types`
--
ALTER TABLE `fine_types`
  ADD PRIMARY KEY (`id`);

--
-- Indici per le tabelle `gloveboxitems`
--
ALTER TABLE `gloveboxitems`
  ADD PRIMARY KEY (`plate`),
  ADD KEY `id` (`id`);

--
-- Indici per le tabelle `houselocations`
--
ALTER TABLE `houselocations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `name` (`name`);

--
-- Indici per le tabelle `house_plants`
--
ALTER TABLE `house_plants`
  ADD PRIMARY KEY (`id`),
  ADD KEY `building` (`building`),
  ADD KEY `plantid` (`plantid`);

--
-- Indici per le tabelle `lapraces`
--
ALTER TABLE `lapraces`
  ADD PRIMARY KEY (`id`),
  ADD KEY `raceid` (`raceid`);

--
-- Indici per le tabelle `mdt_reports`
--
ALTER TABLE `mdt_reports`
  ADD PRIMARY KEY (`id`);

--
-- Indici per le tabelle `mdt_warrants`
--
ALTER TABLE `mdt_warrants`
  ADD PRIMARY KEY (`id`);

--
-- Indici per le tabelle `occasion_vehicles`
--
ALTER TABLE `occasion_vehicles`
  ADD PRIMARY KEY (`id`),
  ADD KEY `occasionId` (`occasionid`);

--
-- Indici per le tabelle `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `license` (`license`);

--
-- Indici per le tabelle `phone_invoices`
--
ALTER TABLE `phone_invoices`
  ADD PRIMARY KEY (`id`),
  ADD KEY `citizenid` (`citizenid`);

--
-- Indici per le tabelle `phone_messages`
--
ALTER TABLE `phone_messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `citizenid` (`citizenid`),
  ADD KEY `number` (`number`);

--
-- Indici per le tabelle `phone_tweets`
--
ALTER TABLE `phone_tweets`
  ADD PRIMARY KEY (`id`),
  ADD KEY `citizenid` (`citizenid`);

--
-- Indici per le tabelle `players`
--
ALTER TABLE `players`
  ADD PRIMARY KEY (`citizenid`),
  ADD KEY `id` (`id`),
  ADD KEY `last_updated` (`last_updated`),
  ADD KEY `license` (`license`);

--
-- Indici per le tabelle `playerskins`
--
ALTER TABLE `playerskins`
  ADD PRIMARY KEY (`id`),
  ADD KEY `citizenid` (`citizenid`),
  ADD KEY `active` (`active`);

--
-- Indici per le tabelle `players_pd_presets`
--
ALTER TABLE `players_pd_presets`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id_UNIQUE` (`id`);

--
-- Indici per le tabelle `player_boats`
--
ALTER TABLE `player_boats`
  ADD PRIMARY KEY (`id`),
  ADD KEY `citizenid` (`citizenid`);

--
-- Indici per le tabelle `player_contacts`
--
ALTER TABLE `player_contacts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `citizenid` (`citizenid`);

--
-- Indici per le tabelle `player_crops`
--
ALTER TABLE `player_crops`
  ADD PRIMARY KEY (`id`);

--
-- Indici per le tabelle `player_houses`
--
ALTER TABLE `player_houses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `house` (`house`),
  ADD KEY `citizenid` (`citizenid`),
  ADD KEY `identifier` (`identifier`);

--
-- Indici per le tabelle `player_mails`
--
ALTER TABLE `player_mails`
  ADD PRIMARY KEY (`id`),
  ADD KEY `citizenid` (`citizenid`);

--
-- Indici per le tabelle `player_outfits`
--
ALTER TABLE `player_outfits`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id_UNIQUE` (`id`);

--
-- Indici per le tabelle `player_vehicles`
--
ALTER TABLE `player_vehicles`
  ADD PRIMARY KEY (`id`),
  ADD KEY `plate` (`plate`),
  ADD KEY `citizenid` (`citizenid`),
  ADD KEY `license` (`license`);

--
-- Indici per le tabelle `player_warns`
--
ALTER TABLE `player_warns`
  ADD PRIMARY KEY (`id`);

--
-- Indici per le tabelle `promocodes`
--
ALTER TABLE `promocodes`
  ADD PRIMARY KEY (`id`);

--
-- Indici per le tabelle `scenes`
--
ALTER TABLE `scenes`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indici per le tabelle `stashitems`
--
ALTER TABLE `stashitems`
  ADD PRIMARY KEY (`stash`),
  ADD KEY `id` (`id`);

--
-- Indici per le tabelle `trunkitems`
--
ALTER TABLE `trunkitems`
  ADD PRIMARY KEY (`plate`),
  ADD KEY `id` (`id`);

--
-- Indici per le tabelle `user_convictions`
--
ALTER TABLE `user_convictions`
  ADD PRIMARY KEY (`id`);

--
-- Indici per le tabelle `user_mdt`
--
ALTER TABLE `user_mdt`
  ADD PRIMARY KEY (`id`);

--
-- Indici per le tabelle `vaults`
--
ALTER TABLE `vaults`
  ADD PRIMARY KEY (`id`);

--
-- Indici per le tabelle `vehicle_mdt`
--
ALTER TABLE `vehicle_mdt`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT per le tabelle scaricate
--

--
-- AUTO_INCREMENT per la tabella `apartments`
--
ALTER TABLE `apartments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=91;

--
-- AUTO_INCREMENT per la tabella `bank_accounts`
--
ALTER TABLE `bank_accounts`
  MODIFY `record_id` bigint(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT per la tabella `bank_statements`
--
ALTER TABLE `bank_statements`
  MODIFY `record_id` bigint(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=89;

--
-- AUTO_INCREMENT per la tabella `bans`
--
ALTER TABLE `bans`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT per la tabella `bropixel_boosting`
--
ALTER TABLE `bropixel_boosting`
  MODIFY `#` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT per la tabella `crypto_transactions`
--
ALTER TABLE `crypto_transactions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT per la tabella `dealers`
--
ALTER TABLE `dealers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT per la tabella `fine_types`
--
ALTER TABLE `fine_types`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=91;

--
-- AUTO_INCREMENT per la tabella `gloveboxitems`
--
ALTER TABLE `gloveboxitems`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=634;

--
-- AUTO_INCREMENT per la tabella `houselocations`
--
ALTER TABLE `houselocations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT per la tabella `house_plants`
--
ALTER TABLE `house_plants`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT per la tabella `lapraces`
--
ALTER TABLE `lapraces`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT per la tabella `mdt_reports`
--
ALTER TABLE `mdt_reports`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT per la tabella `mdt_warrants`
--
ALTER TABLE `mdt_warrants`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT per la tabella `occasion_vehicles`
--
ALTER TABLE `occasion_vehicles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT per la tabella `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT per la tabella `phone_invoices`
--
ALTER TABLE `phone_invoices`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT per la tabella `phone_messages`
--
ALTER TABLE `phone_messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT per la tabella `phone_tweets`
--
ALTER TABLE `phone_tweets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=132;

--
-- AUTO_INCREMENT per la tabella `players`
--
ALTER TABLE `players`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9854;

--
-- AUTO_INCREMENT per la tabella `playerskins`
--
ALTER TABLE `playerskins`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT per la tabella `players_pd_presets`
--
ALTER TABLE `players_pd_presets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT per la tabella `player_boats`
--
ALTER TABLE `player_boats`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT per la tabella `player_contacts`
--
ALTER TABLE `player_contacts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=72;

--
-- AUTO_INCREMENT per la tabella `player_crops`
--
ALTER TABLE `player_crops`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT per la tabella `player_houses`
--
ALTER TABLE `player_houses`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT per la tabella `player_mails`
--
ALTER TABLE `player_mails`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=655;

--
-- AUTO_INCREMENT per la tabella `player_outfits`
--
ALTER TABLE `player_outfits`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- AUTO_INCREMENT per la tabella `player_vehicles`
--
ALTER TABLE `player_vehicles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=147;

--
-- AUTO_INCREMENT per la tabella `player_warns`
--
ALTER TABLE `player_warns`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT per la tabella `promocodes`
--
ALTER TABLE `promocodes`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT per la tabella `scenes`
--
ALTER TABLE `scenes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT per la tabella `stashitems`
--
ALTER TABLE `stashitems`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=271;

--
-- AUTO_INCREMENT per la tabella `trunkitems`
--
ALTER TABLE `trunkitems`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=188;

--
-- AUTO_INCREMENT per la tabella `user_convictions`
--
ALTER TABLE `user_convictions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT per la tabella `user_mdt`
--
ALTER TABLE `user_mdt`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT per la tabella `vaults`
--
ALTER TABLE `vaults`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT per la tabella `vehicle_mdt`
--
ALTER TABLE `vehicle_mdt`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
