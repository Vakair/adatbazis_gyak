-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Gép: 127.0.0.1
-- Létrehozás ideje: 2024. Dec 01. 23:24
-- Kiszolgáló verziója: 10.4.32-MariaDB
-- PHP verzió: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Adatbázis: `konferencia`
--

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `cikk`
--

CREATE TABLE `cikk` (
  `CikkAzonosito` int(11) NOT NULL,
  `CikkCim` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

--
-- A tábla adatainak kiíratása `cikk`
--

INSERT INTO `cikk` (`CikkAzonosito`, `CikkCim`) VALUES
(1, 'Cikkproba'),
(18, 'PróbaAdminElotti'),
(19, 'PróbaAdminElotti'),
(20, 'PróbaAdminElotti'),
(21, 'Kaszinók'),
(22, 'Általánosiskolai Fizika'),
(23, 'Középiskolás Fizika'),
(24, 'Ady Endre'),
(25, 'Petőfi Sándor'),
(26, 'Jókai Mór'),
(27, 'Japán'),
(28, 'Labdarúgás'),
(29, 'Kosárlabda'),
(30, 'Röplabda');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `eloadas`
--

CREATE TABLE `eloadas` (
  `EloadasAzonosito` int(11) NOT NULL,
  `KezdesIdopont` datetime NOT NULL,
  `EloadasHossza` int(11) NOT NULL,
  `EloadoAzonosito` int(11) NOT NULL,
  `SzekcioNeve` varchar(100) NOT NULL,
  `CikkAzonosito` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

--
-- A tábla adatainak kiíratása `eloadas`
--

INSERT INTO `eloadas` (`EloadasAzonosito`, `KezdesIdopont`, `EloadasHossza`, `EloadoAzonosito`, `SzekcioNeve`, `CikkAzonosito`) VALUES
(11, '2024-01-01 14:49:50', 60, 1, 'Teszt', 1),
(15, '2083-12-12 12:00:00', 60, 1, 'Teszt', 18),
(16, '2092-12-12 12:00:00', 60, 1, 'Teszt', 19),
(17, '0000-00-00 00:00:00', 0, 1, 'Alapértelmezett', 20),
(18, '2024-12-13 14:30:00', 60, 3, 'Szerencsejáték', 21),
(19, '2025-01-05 13:00:00', 60, 10, 'Ázsia', 27),
(20, '2024-12-24 22:32:42', 60, 12, 'Sport', 28),
(21, '2024-12-24 23:35:00', 60, 13, 'Sport', 30),
(22, '2024-12-25 10:32:42', 60, 39, 'Sport', 29),
(23, '2024-12-04 11:00:00', 60, 25, 'Irodalom', 24),
(24, '2024-12-04 12:00:00', 60, 27, 'Irodalom', 25),
(25, '2024-12-04 13:00:00', 60, 52, 'Irodalom', 26),
(26, '2024-12-27 10:00:00', 60, 34, 'Fizika 1', 22),
(27, '2024-12-27 10:00:00', 60, 35, 'Fizika 1', 23);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `felhasznalo`
--

CREATE TABLE `felhasznalo` (
  `Azonosito` int(11) NOT NULL,
  `Jelszo` varchar(255) NOT NULL,
  `Elotag` varchar(10) DEFAULT NULL,
  `Nev` varchar(100) NOT NULL,
  `Szerepkor` enum('admin','szerzo') NOT NULL,
  `Email` varchar(100) NOT NULL,
  `Intezet` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

--
-- A tábla adatainak kiíratása `felhasznalo`
--

INSERT INTO `felhasznalo` (`Azonosito`, `Jelszo`, `Elotag`, `Nev`, `Szerepkor`, `Email`, `Intezet`) VALUES
(1, '$2y$10$wtiu5K5JwCihmobZZDkw8ua2XstoM7Tl.ilzV8VrhCtLNRGxQ/vIG', 'Dr.', 'Tóth István', 'szerzo', 'tothistvan@gmail.com', 'SZTE'),
(3, '$2y$10$DOXkQtkWtUfohWJx.dONn.7WP53v8J66yVgI2ly8WwY1jcfSWt2xG', '', 'ADMIN', 'admin', 'admin@gmail.com', 'ADMIN'),
(4, '$2y$10$KhgdiUxLjjJBUQcZSnRjw.GRnN09aZNqcSbL6CMSniRYoihFyxpy.', 'Prof.', 'Christy Rodriguez', 'szerzo', 'mariagoodman@gmail.com', 'Erickson Inc'),
(5, '$2y$10$tWYoFe32REpNIXfD.b2Pq.OoSZMzbvtBi7GUXoGT9uI2nJXP.1Lda', 'Ms', 'Lisa Vasquez', 'szerzo', 'meadowsrachel@yahoo.com', 'Cox-Wilson'),
(6, '$2y$10$On6IxZ6l56WoBtgvO6rdeelYxQffKn3r3008BzenVZWx1X7gpibB2', 'Ms.', 'Jeff Brown', 'szerzo', 'dannystewart@hood.net', 'Adams-Mendoza'),
(7, '$2y$10$5DQI9MlIa9IKQCdoitPpNuH63BtETOwizMnljVbnJeDmgpDb9qLK6', 'Mr.', 'Jill Morris', 'szerzo', 'peter50@campbell.biz', 'Lane-Poole'),
(8, '$2y$10$05q3hsLwxaE./hmCsOVacOlJY/WYnABtL2yF2EEDmS3YUqibt4R7W', 'Ms.', 'Brian Lopez', 'szerzo', 'sarahvazquez@nielsen.org', 'Ramirez PLC'),
(9, '$2y$10$urW.upF9HklTaYH2PT2sV.Hr0KZr4FfCmvS3VX5BZ5gBK2dDkxU7q', '', 'Michael Foster', 'szerzo', 'morganclark@arnold.com', 'Mcgrath-Herrera'),
(10, '$2y$10$3v1i48i/bZvlRawwdyFTZu30XNnSk0to/4pKNrx3S08B6wtd2ONxO', '', 'Amanda Willis', 'szerzo', 'tdavis@yahoo.com', 'Flynn, Werner and Blair'),
(11, '$2y$10$ELtNo73U.zlnlpQnD21yhuWFC.n6YAjmTGpUx3Ngl5Mhq2GWnFrUa', 'Mrs.', 'David Farrell', 'szerzo', 'swilliams@eaton.biz', 'Jackson, Gilbert and Williams'),
(12, '$2y$10$8eXeRtiproxgIUCrW1Yz1Ox6cKCqQbj5qIoiOaNS9o6N01/2ZeZ6u', 'Mrs.', 'Jason Morris', 'szerzo', 'janetjacobs@cochran-anderson.biz', 'Erickson Inc'),
(13, '$2y$10$jfZcWYqYqMcK06DSetLa/u3jwqQjLaNGCSAtVuZmYQ3vViiGBcP1y', '', 'William Marquez', 'szerzo', 'turnerrebecca@kelly.info', 'Brown, Fleming and Guerra'),
(14, '$2y$10$gbJ5fWxOWwDvl/sLWJKV4eS.ppGHT4fkejSVs8pY8zTA6eZu3Nlku', 'Prof.', 'Jon Dunn', 'szerzo', 'jamiemorton@king-diaz.com', 'Boyd, Lyons and Dorsey'),
(15, '$2y$10$bYIsN9jlunRqFS2B6Ow5JutnUKdgrdAkd5JASUeYoSCeMBztpgao.', 'Mr. ', 'Adam Johnson', 'szerzo', 'brian15@irwin.com', 'Fuller Inc'),
(16, '$2y$10$iXDNOt6HgVjrShxVRp3PCex7enmJHs.fyWn.Nr4ZSiFhFySbyBKjO', 'Dr.', 'Kenneth Torres', 'szerzo', 'kenneth84@hotmail.com', 'Avila, Scott and Smith'),
(17, '$2y$10$tf0UJGtRuj.NPnXum4B0DucL7hj0U26rfL.Ob1YBAev8oTO2nj5EO', 'Dr.', 'Amber Davis', 'szerzo', 'kennethcochran@newman.net', 'Freeman, Schneider and Goodwin'),
(18, '$2y$10$CUgsGd2CrkUW16XQ18CkrOAonURPb1517aOzw2AHpw3zMdn0h26ja', 'Mrs.', 'Patrick Rush', 'szerzo', 'kelleytanner@nguyen.info', 'Coleman-Harris'),
(19, '$2y$10$xq1VPDMmQMjkev7ZU7rEPeB7GZPTIdx.kYHMbZ1h.6AYqxzp599RO', 'Mrs.', 'John Mckay', 'szerzo', 'mscott@gmail.com', 'Guerra PLC'),
(20, '$2y$10$yZmdnOEQv3x52fJaACwzsedd7qjyI/Vva2ozNE.625LOtdYwF5RS2', 'Prof.', 'Jim Lloyd', 'szerzo', 'seanhall@gmail.com', 'Hamilton-Davidson'),
(21, '$2y$10$/TkrDOGElnRF0e1MWltW0eCCo8.6iVxEUPJoLbpVeE0vrQwVt4/AW', 'Mr.', 'Deanna Douglas', 'szerzo', 'michael27@hotmail.com', 'Ramirez PLC'),
(22, '$2y$10$BWXUaDbbRcwKJJOV4JWMVeXyDAtqzSFZqpM09ZOgmqgv1B5wk3TXi', 'Prof.', 'Emily Hernandez', 'szerzo', 'osingleton@hotmail.com', 'Zavala-Carroll'),
(23, '$2y$10$kxvJa7GBUnNVcWLSEvKzuOiVuVF6xdDZ0Oh.7PNsiOo4EIn/br9kq', 'Prof.', 'Natasha Mcdonald', 'szerzo', 'jenniferruiz@gmail.com', 'White-Ibarra'),
(24, '$2y$10$PKLrloidMShlJ/mpGFbiFu0c9pSogsAR342RKAg6KGwoyLGUSFIli', 'Prof.', 'Donald Sanders', 'szerzo', 'isaacrobinson@jones-callahan.com', 'George, Solis and Hicks'),
(25, '$2y$10$8LUHu75vVYzO/KqMh17jw.lM2GZEtH5lr0GO4wZIa3ZpklNalPCQ.', '', 'Tiffany Barrera', 'szerzo', 'carrollkristen@love.com', 'Martin LLC'),
(26, '$2y$10$sL3CQAyDmBwZoSJNIZYMIeu2UbcWiX0SMi3hmOJx0jagGe2B8T/5S', '', 'Christine Bryant', 'szerzo', 'george34@smith.com', 'Sherman-Martinez'),
(27, '$2y$10$9p3S0dsKzf07gksZvmXq9u1kyVJ.YZml.ubtEmPUssSlh7L7bcXwi', 'Ms.', 'Luis Reid', 'szerzo', 'zacharyrodriguez@nichols.com', 'Hubbard-Freeman'),
(28, '$2y$10$y6jiDcEnq3E.MNJl09Dw9Oj5VVL5qsFh86XXBI.xZfa62/JujPMzm', 'Ms.', ' Rachel Davis', 'szerzo', 'brian33@hotmail.com', 'Jones-Banks'),
(29, '$2y$10$.pLAIKfT5G2FFxHL7xaK3OICP.LZvXH1Oesl0iVBswPuYX3Ejw1v6', 'Dr.', 'Kelly Guerrero', 'szerzo', 'gscott@yahoo.com', 'Aguirre, Long and Turner'),
(30, '$2y$10$kveRAGo5YhW/IEQ6m8sYsuJsK5pyvA1KYlYd2KOqdnXkgPlj5Gzny', 'Dr.', 'Austin Newman', 'szerzo', 'qpeterson@hotmail.com', 'Nelson PLC'),
(31, '$2y$10$3vPHhc/twU7eMGjlD8a7kuNQvpdeR.cJOhbsEE8Lcwwn.zuSf3t1u', 'Dr.', 'Lisa Ford', 'szerzo', 'summersjoshua@stevens-bailey.com', 'Ryan, Rivera and Powell'),
(32, '$2y$10$MPj1PK0LGYq8Pe2oMZ.yBuCsLD/uvwAk3fqvMgDL9q6NCLIz4om1y', 'Dr.', 'Stephanie Morales', 'szerzo', 'beardmaureen@gmail.com', 'Wilson Inc'),
(33, '$2y$10$2MJGITF9CDvJ7nn/8bRQouLo4mTA9bNtJOtZtPjbphX01ZdmYRnn2', '', 'Evelyn Shelton', 'szerzo', 'zjones@bailey.com', 'Williams, Diaz and Mitchell'),
(34, '$2y$10$8LCKpHRigJhpW/pKqhFjoe.xwa8ZyTUiyad5rD3OCG.DO1xk63PyC', '', 'Matthew Bentley DDS', 'szerzo', 'jamesshaw@gmail.com', 'Simmons, Allen and Williams'),
(35, '$2y$10$7jESNGaQ6H3CnAFzjgvxLeqWya797ZkWfDMpn6sxg64QRwaUDZ0qm', '', 'Joyce Smith', 'szerzo', 'umeyer@yahoo.com', 'Morris Inc'),
(36, '$2y$10$YtpNUtLX.LmLlR8H2KIXauvOVwXYPT112HvxiX4n2VvT93N.yMmU.', '', 'Leah Ibarra', 'szerzo', 'robertsbonnie@herring-wilson.biz', 'Jones and Sons'),
(37, '$2y$10$lcWpH0ch/TT727Ibc1XgiOpDeTrQhPZy5JfpYD6zJt/mXmZtVLSE6', '', 'Jasmine Murphy', 'szerzo', 'joycewilson@hayes.com', 'McKinley-Jenkins'),
(38, '$2y$10$IveV6sCiw2BcWBzRHsqGueQ0xzUQsZymSXQ1TOL3fT/y.DKLYhC0.', 'Prof.', 'Teresa Cooper', 'szerzo', 'kimberlylewis@rodriguez-wright.biz', 'Thomas-Taylor'),
(39, '$2y$10$AYgBoRdbZgg6Wd9bbhHg.eyh58JH88Yfa8jMp2t4kYbE3B8VbW1be', 'Mrs.', 'Catherine Brooks', 'szerzo', 'tylerjohnson@smith-jones.com', 'Chapman-Hyatt'),
(40, '$2y$10$ZFbFo/.FWyNMe5rNbDWpmeJ5gQZFZ/.U6XVxorYrOrgKHbJKONQde', 'Ms.', 'Michael Taylor', 'szerzo', 'stephaniemartin@campbell.com', 'Banks-Swanson'),
(41, '$2y$10$Zhnkh67hpgsY8qj9ddYrduElHHo.0q1uB79ZUxFd/mDN9I01eTu36', 'Dr.', 'Oscar Mitchell', 'szerzo', 'melissa27@coleman.com', 'Stevens-Garcia'),
(42, '$2y$10$yacD0ynfJYEesSNtrOaCyOqw9ZzGLxDgrp6DWLusogqNw//nTKVZe', 'Prof.', 'Kimberly Cox', 'szerzo', 'danny95@powell.com', 'Griffin-Williams'),
(43, '$2y$10$bnf.uppbFaBMrni/28nO3u2aFzWaq16RfN25SH5dUuzsfqz3xB3aC', 'Prof.', 'Charles Scott', 'szerzo', 'brian79@harris.com', 'Weber-Hale'),
(44, '$2y$10$tQUY.joOc4ghJG2SKr3y3OsHXU7eyIpJ/M5NZ16Nu19EaoAQ5D0H.', 'Ms', 'Jennifer Turner', 'szerzo', 'david82@johnson.com', 'Taylor, Gonzalez and Young'),
(45, '$2y$10$y4K0VwIqNkvmaRgfgzCZs.ve1P/nOoQkIKJqfFoGv7Lcnh40NOT6u', 'Dr.', 'George Brown', 'szerzo', 'andrew46@wilson.org', 'Hayes-Henry'),
(46, '$2y$10$42hlS6XlHbh1heg9G2rncuB.qC9Hfc.YDegyKx6otbpUIb./GnDsG', 'Dr.', 'Samuel Carter', 'szerzo', 'ellenmorris@williams.com', 'Young, Mills and Rivera'),
(47, '$2y$10$0RcBYhZcO7nbkDLp/aR9NOX/kJsiQ56XfPB5ZiKoKSfeNchH4sdTe', 'Dr.', 'Sarah Adams', 'szerzo', 'robertwalters@lambert.com', 'Stevens and Daniels'),
(48, '$2y$10$UFcKYrztDf5DY3MrD4FcrOu5s27FlcJfedDb6EwSlc1wrExw7cjU2', 'Dr.', 'Gloria Mitchell', 'szerzo', 'rachelbrown@johnson.com', 'Ryan Group'),
(49, '$2y$10$BFLWh3kLFyPjw/3p61euXOX.H3UGZoIEjNxSDj0DU4MhUyRIbWqha', 'Dr.', 'Joseph King', 'szerzo', 'marciatravis@martin.net', 'Bennett-Hart'),
(50, '$2y$10$MXeQk6gjZvYfXcg3hpyEq.zDuzKug7035fEXwOyJn7/pI1QjDwbuC', 'Mr.', 'Brian Moore', 'szerzo', 'lisa28@baker.com', 'Harris-Peters'),
(51, '$2y$10$mziNEsa.YSxokIa8mjegy.pTFfwsdVcNgXkwA3K1c8KXV/RB/qog2', 'Mr.', 'Ethan Brooks', 'szerzo', 'ethanbrooks@brown.com', 'Morgan-Grant'),
(52, '$2y$10$x4QgGa4LV7X/zgoQVO7ix.sJLUu2bK7IeGBloZdbk976c8AlHK.VC', 'Ms.', 'Olivia Lewis', 'szerzo', 'olivialewis@taylor.com', 'Stewart-Bennett'),
(53, '$2y$10$ViMHlkfQqrfO0lAebRK4V.5VQujoR9ySAJghYW4KyYTWhntAMAI02', 'Ms.', 'Ava Walker', 'szerzo', 'avawalker@johnson.net', 'Baker-Richards');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `szekcio`
--

CREATE TABLE `szekcio` (
  `SzekcioNeve` varchar(100) NOT NULL,
  `KezdesIdopont` datetime NOT NULL,
  `ElnokAzonosito` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

--
-- A tábla adatainak kiíratása `szekcio`
--

INSERT INTO `szekcio` (`SzekcioNeve`, `KezdesIdopont`, `ElnokAzonosito`) VALUES
('Alapértelmezett', '2052-01-01 18:40:53', NULL),
('Általános Fizika', '2024-12-25 21:22:11', 3),
('Ázsia', '2025-01-05 12:00:03', 5),
('Fizika 1', '2024-12-26 21:22:11', 3),
('ForeX', '2025-12-03 21:39:03', 9),
('Földrajz', '2024-12-12 21:25:54', 6),
('Geológia', '2024-12-12 21:25:54', 5),
('Geopolitika', '2024-12-12 21:27:06', 7),
('Hosszútávú befektetések', '2026-12-02 21:39:03', 25),
('Hulladékfeldolgozás', '2024-12-02 09:00:06', 24),
('Húsipar', '2024-12-10 13:27:06', 40),
('Informatika', '2024-12-08 21:39:03', 33),
('Irodalom', '2024-12-04 10:00:03', 6),
('Kereszténység', '2026-01-01 21:39:03', 48),
('Közel-Kelet', '2024-12-05 14:00:06', 13),
('Kriptovaluták', '2025-12-02 21:39:03', 11),
('Latin', '2025-01-01 10:39:03', 20),
('Művészetek', '2024-12-13 21:24:27', 4),
('Művészettörténet', '2024-12-13 21:24:25', 4),
('Nyelvtan', '2024-12-04 14:00:03', 6),
('Nyugat', '2024-12-09 20:00:06', 29),
('Ókori Egyiptom', '2024-12-01 21:39:03', 40),
('Részvények', '2025-12-01 21:39:03', 29),
('Rövidtávú befektetések', '2026-12-01 21:39:03', 43),
('Sport', '2024-12-24 21:00:03', 10),
('Szerencsejáték', '2024-12-13 13:13:03', 13),
('Társadalomtudomány', '2024-12-11 21:27:06', 50),
('Teszt', '2025-01-01 13:37:05', 1),
('Videojátékok', '2025-12-07 21:39:03', 37);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `szerzoje`
--

CREATE TABLE `szerzoje` (
  `FelhasznaloAzonosito` int(11) NOT NULL,
  `CikkAzonosito` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

--
-- A tábla adatainak kiíratása `szerzoje`
--

INSERT INTO `szerzoje` (`FelhasznaloAzonosito`, `CikkAzonosito`) VALUES
(1, 1),
(1, 18),
(1, 19),
(1, 20),
(3, 21),
(10, 27),
(12, 28),
(13, 30),
(25, 24),
(27, 25),
(34, 22),
(35, 23),
(39, 29),
(52, 26);

--
-- Indexek a kiírt táblákhoz
--

--
-- A tábla indexei `cikk`
--
ALTER TABLE `cikk`
  ADD PRIMARY KEY (`CikkAzonosito`);

--
-- A tábla indexei `eloadas`
--
ALTER TABLE `eloadas`
  ADD PRIMARY KEY (`EloadasAzonosito`),
  ADD KEY `EloadoAzonosito` (`EloadoAzonosito`),
  ADD KEY `SzekcioNeve` (`SzekcioNeve`),
  ADD KEY `CikkAzonosito` (`CikkAzonosito`);

--
-- A tábla indexei `felhasznalo`
--
ALTER TABLE `felhasznalo`
  ADD PRIMARY KEY (`Azonosito`),
  ADD UNIQUE KEY `Email` (`Email`);

--
-- A tábla indexei `szekcio`
--
ALTER TABLE `szekcio`
  ADD PRIMARY KEY (`SzekcioNeve`),
  ADD KEY `ElnokAzonosito` (`ElnokAzonosito`);

--
-- A tábla indexei `szerzoje`
--
ALTER TABLE `szerzoje`
  ADD PRIMARY KEY (`FelhasznaloAzonosito`,`CikkAzonosito`),
  ADD KEY `CikkAzonosito` (`CikkAzonosito`);

--
-- A kiírt táblák AUTO_INCREMENT értéke
--

--
-- AUTO_INCREMENT a táblához `cikk`
--
ALTER TABLE `cikk`
  MODIFY `CikkAzonosito` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT a táblához `eloadas`
--
ALTER TABLE `eloadas`
  MODIFY `EloadasAzonosito` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT a táblához `felhasznalo`
--
ALTER TABLE `felhasznalo`
  MODIFY `Azonosito` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=54;

--
-- Megkötések a kiírt táblákhoz
--

--
-- Megkötések a táblához `eloadas`
--
ALTER TABLE `eloadas`
  ADD CONSTRAINT `eloadas_ibfk_1` FOREIGN KEY (`EloadoAzonosito`) REFERENCES `felhasznalo` (`Azonosito`),
  ADD CONSTRAINT `eloadas_ibfk_2` FOREIGN KEY (`SzekcioNeve`) REFERENCES `szekcio` (`SzekcioNeve`),
  ADD CONSTRAINT `eloadas_ibfk_3` FOREIGN KEY (`CikkAzonosito`) REFERENCES `cikk` (`CikkAzonosito`);

--
-- Megkötések a táblához `szekcio`
--
ALTER TABLE `szekcio`
  ADD CONSTRAINT `szekcio_ibfk_1` FOREIGN KEY (`ElnokAzonosito`) REFERENCES `felhasznalo` (`Azonosito`);

--
-- Megkötések a táblához `szerzoje`
--
ALTER TABLE `szerzoje`
  ADD CONSTRAINT `szerzoje_ibfk_1` FOREIGN KEY (`FelhasznaloAzonosito`) REFERENCES `felhasznalo` (`Azonosito`),
  ADD CONSTRAINT `szerzoje_ibfk_2` FOREIGN KEY (`CikkAzonosito`) REFERENCES `cikk` (`CikkAzonosito`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
