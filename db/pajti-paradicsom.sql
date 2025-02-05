-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Gép: 127.0.0.1
-- Létrehozás ideje: 2025. Feb 05. 16:37
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
-- Adatbázis: `phpmyadmin`
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
-- Tábla szerkezet ehhez a táblához `prices_fotozas`
--

CREATE TABLE `prices_fotozas` (
  `id` int(11) NOT NULL,
  `photo_type` varchar(100) NOT NULL,
  `pictures` int(11) NOT NULL,
  `price` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- A tábla adatainak kiíratása `prices_fotozas`
--

INSERT INTO `prices_fotozas` (`id`, `photo_type`, `pictures`, `price`) VALUES
(1, 'Szülinapi fotózás', 10, 15000),
(2, 'Gazdis fotózás', 15, 18000),
(3, 'Karácsonyi fotózás', 10, 15000),
(4, 'Kültéri fotózás', 20, 20000),
(5, 'Stúdiós fotózás', 15, 22000),
(6, 'Tematikus fotózás', 12, 16000);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `prices_kozmetika`
--

CREATE TABLE `prices_kozmetika` (
  `id` int(11) NOT NULL,
  `services` varchar(100) NOT NULL,
  `price` int(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- A tábla adatainak kiíratása `prices_kozmetika`
--

INSERT INTO `prices_kozmetika` (`id`, `services`, `price`) VALUES
(1, 'Alapnyírás kutya', 7000),
(2, 'Alapnyírás macska', 6500),
(3, 'Fürdetés és szárítás', 5000),
(4, 'Karomvágás', 2000),
(5, 'Fültisztítás', 1500),
(6, 'Teljes kozmetikai csomag', 12000);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `prices_panzio`
--

CREATE TABLE `prices_panzio` (
  `id` int(11) NOT NULL,
  `services` varchar(50) NOT NULL,
  `price` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- A tábla adatainak kiíratása `prices_panzio`
--

INSERT INTO `prices_panzio` (`id`, `services`, `price`) VALUES
(1, 'Mini', '3500'),
(2, 'Törpe', '4000'),
(3, 'Kistestű', '4500'),
(4, 'Közepes testű', '5500'),
(5, 'Nagy testű', '6500'),
(6, 'Óriás', '8000');

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
  `price` decimal(10,2) NOT NULL,
  `img` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `services`
--

INSERT INTO `services` (`id`, `name`, `description`, `price`, `img`) VALUES
(1, 'Pajti Hotel', 'Kutyusunkat hosszabb távra, jelenlétünk nélkül másra bízni sokszor nehéz döntés, bizalmi kérdés. A Pajti Paradicsom elsődleges célja kutyapanzióiban, hogy a kutyusok a lehető legjobban érezzék magukat, majd a tartózkodást követően a gazdi boldogan vihesse haza kedvencét.', 5000.00, 'foto2.jpg'),
(2, 'Pajti kozmetika', 'Az okosság és intelligencia, illedelmesség, kedvesség, szófogadóság, szeretőképesség már-már minden olyan kvalitás, amivel rendelkezhet négylábú társunk! Mindezek mellett azonban nem szabad megfeledkeznünk szépségükről, ápoltságukról sem – ami nekünk első ránézésére talán csak esztétika, kutyusunknak jóérzés és egészség!', 6000.00, 'foto1.jpg'),
(3, 'Pajti fotózás', 'Nálunk a fotózás nem csak a gép kattintásairól szól, hanem sokkal inkább egy közös alkotásról, egy felejthetetlen élményről, érzékeny lelkű kutyáknak és gazdáiknak. Egy letisztult stílusú, élményorientált fotózáson várunk rád, ahol nincs helye a kényszernek, nincsenek megjátszott Instagram-képek, és nincsenek elvárások sem a gazditól, sem a kutyától.', 8000.00, 'foto.jpg');

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
-- A tábla indexei `prices_fotozas`
--
ALTER TABLE `prices_fotozas`
  ADD PRIMARY KEY (`id`);

--
-- A tábla indexei `prices_kozmetika`
--
ALTER TABLE `prices_kozmetika`
  ADD PRIMARY KEY (`id`);

--
-- A tábla indexei `prices_panzio`
--
ALTER TABLE `prices_panzio`
  ADD PRIMARY KEY (`id`);

--
-- A tábla indexei `schedule`
--
ALTER TABLE `schedule`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `animal_id` (`animal_id`),
  ADD KEY `services_id` (`services_id`);

--
-- A tábla indexei `services`
--
ALTER TABLE `services`
  ADD PRIMARY KEY (`id`);

--
-- A tábla indexei `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- A kiírt táblák AUTO_INCREMENT értéke
--

--
-- AUTO_INCREMENT a táblához `animals`
--
ALTER TABLE `animals`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT a táblához `prices_fotozas`
--
ALTER TABLE `prices_fotozas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT a táblához `prices_kozmetika`
--
ALTER TABLE `prices_kozmetika`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT a táblához `prices_panzio`
--
ALTER TABLE `prices_panzio`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT a táblához `schedule`
--
ALTER TABLE `schedule`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT a táblához `services`
--
ALTER TABLE `services`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT a táblához `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Megkötések a kiírt táblákhoz
--

--
-- Megkötések a táblához `schedule`
--
ALTER TABLE `schedule`
  ADD CONSTRAINT `animal_id` FOREIGN KEY (`animal_id`) REFERENCES `animals` (`id`),
  ADD CONSTRAINT `services_id` FOREIGN KEY (`services_id`) REFERENCES `services` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
