-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Gép: 127.0.0.1
-- Létrehozás ideje: 2025. Már 18. 02:05
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
-- Adatbázis: `pajti-paradicsom`
--

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `animals`
--

CREATE TABLE `animals` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `date_of_birth` date NOT NULL,
  `owner_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `gallery`
--

CREATE TABLE `gallery` (
  `id` int(11) NOT NULL,
  `img` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `gallery`
--

INSERT INTO `gallery` (`id`, `img`) VALUES
(4, 'dog1.jpg'),
(5, 'dog2.jpg'),
(6, 'dog3.jpg'),
(7, 'dog4.jpg'),
(8, 'dog5.jpg'),
(9, 'dog6.jpg');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `prices`
--

CREATE TABLE `prices` (
  `id` int(11) NOT NULL,
  `service_id` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `price` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `prices`
--

INSERT INTO `prices` (`id`, `service_id`, `type`, `price`) VALUES
(1, 3, 'Gazdi fotózás', 2500),
(2, 3, 'Szülinapi fotózás', 1000),
(3, 3, 'Pajti fotózás', 2500),
(4, 2, 'Eü nyírás', 4250),
(5, 2, 'Fürdetés', 2000),
(6, 1, 'Pajti Napközi', 2500),
(7, 1, 'Pajti Panzió', 10000),
(8, 2, 'Fürdetés + Szárítás + Eü Nyírás', 9800),
(9, 2, 'Komplett kozmetikai kezelés (Fésülés, Nyírás)', 12900),
(10, 2, 'Komplett kozmetikai kezelés (Trimmelés)', 14000);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `schedule`
--

CREATE TABLE `schedule` (
  `id` int(11) NOT NULL,
  `date` date NOT NULL,
  `time` time NOT NULL,
  `animal_id` int(11) NOT NULL,
  `services_id` int(11) NOT NULL,
  `comments` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `services`
--

CREATE TABLE `services` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `img` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `services`
--

INSERT INTO `services` (`id`, `name`, `description`, `img`) VALUES
(1, 'Pajti Hotel', 'Kutyusunkat hosszabb távra, jelenlétünk nélkül másra bízni sokszor nehéz döntés, bizalmi kérdés. A Pajti Paradicsom elsődleges célja kutyapanzióiban, hogy a kutyusok a lehető legjobban érezzék magukat, majd a tartózkodást követően a gazdi boldogan vihesse haza kedvencét.', 'foto2.jpg'),
(2, 'Pajti kozmetika', 'Az okosság és intelligencia, illedelmesség, kedvesség, szófogadóság, szeretőképesség már-már minden olyan kvalitás, amivel rendelkezhet négylábú társunk! Mindezek mellett azonban nem szabad megfeledkeznünk szépségükről, ápoltságukról sem – ami nekünk első ránézésére talán csak esztétika, kutyusunknak jóérzés és egészség!', 'foto1.jpg'),
(3, 'Pajti fotózás', 'Nálunk a fotózás nem csak a gép kattintásairól szól, hanem sokkal inkább egy közös alkotásról, egy felejthetetlen élményről, érzékeny lelkű kutyáknak és gazdáiknak. Egy letisztult stílusú, élményorientált fotózáson várunk rád, ahol nincs helye a kényszernek, nincsenek megjátszott Instagram-képek, és nincsenek elvárások sem a gazditól, sem a kutyától.', 'foto.jpg');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone_number` varchar(20) NOT NULL,
  `cim` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexek a kiírt táblákhoz
--

--
-- A tábla indexei `animals`
--
ALTER TABLE `animals`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `owner_id` (`owner_id`);

--
-- A tábla indexei `gallery`
--
ALTER TABLE `gallery`
  ADD PRIMARY KEY (`id`);

--
-- A tábla indexei `prices`
--
ALTER TABLE `prices`
  ADD PRIMARY KEY (`id`);

--
-- A kiírt táblák AUTO_INCREMENT értéke
--

--
-- AUTO_INCREMENT a táblához `gallery`
--
ALTER TABLE `gallery`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT a táblához `prices`
--
ALTER TABLE `prices`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
