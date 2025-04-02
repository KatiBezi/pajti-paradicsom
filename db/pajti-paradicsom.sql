-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Gép: 127.0.0.1
-- Létrehozás ideje: 2025. Ápr 02. 17:45
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
-- Tábla szerkezet ehhez a táblához `contact`
--

CREATE TABLE `contact` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `submission_date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

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
-- Tábla szerkezet ehhez a táblához `pets`
--

CREATE TABLE `pets` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `type` varchar(50) NOT NULL,
  `age` int(11) NOT NULL,
  `description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
(4, 2, 'Eü nyírás', 4250),
(5, 2, 'Fürdetés', 2000),
(8, 2, 'Fürdetés + Szárítás + Eü Nyírás', 9800),
(9, 2, 'Komplett kozmetikai kezelés (Fésülés, Nyírás)', 12900),
(10, 2, 'Komplett kozmetikai kezelés (Trimmelés)', 14000),
(11, 1, 'Kistestű kutya panzió (0–10 kg)', 4500),
(12, 1, 'Közepes testű kutya panzió (10–25 kg)', 5000),
(13, 1, 'Nagytestű kutya panzió (25+ kg)', 5500),
(14, 1, 'Macska panzió', 4000),
(15, 1, 'Tengerimalac / nyúl panzió', 2500),
(16, 1, 'Nyúl panzió', 2000),
(17, 1, 'Etetés naponta 2x (saját táppal)', 0),
(18, 1, 'Etetés naponta 2x (saját táp nélkül)', 500),
(19, 1, 'Napi séta – 30 perc', 1000),
(20, 1, 'Játékidő / foglalkozás', 800),
(21, 1, 'Gyógyszer beadása', 500),
(22, 1, 'Kamera-hozzáférés élőben (/nap)', 1000),
(23, 1, 'Klimatizált helyiség', 800),
(24, 1, 'Testvérek közös elhelyezése ', 2000),
(25, 1, 'Fotó- vagy videóbeszámoló naponta (/nap)', 1000),
(26, 1, 'Extra játék vagy agility foglalkozás (/alkalom - 30 perc) ', 1500),
(27, 1, 'Relaxációs zene / aromaterápia ideges kutyáknak (/alkalom)', 800),
(28, 1, 'Külön szoba / VIP elhelyezés (+ alap díj)', 2000),
(29, 1, 'Napi többszöri séta (extra séta igény szerint)', 1000),
(30, 2, 'Kistestű kutya teljes kozmetika', 8000),
(31, 2, 'Közepes testű kutya teljes kozmetika', 10000),
(32, 2, 'Nagytestű kutya teljes kozmetika', 12000),
(33, 2, 'Macska fürdetés és fésülés', 0),
(34, 2, 'Kistestű kutya fürdetés', 4000),
(35, 2, 'Közepes testű kutya fürdetés', 5500),
(36, 2, 'Nagytestű kutya fürdetés', 7000),
(37, 2, 'Karomvágás', 1500),
(38, 2, 'Bűzmirigy tisztítás', 1000),
(39, 2, 'Szőrtelenítés (fül, talp)', 1200),
(40, 2, 'Bolhairtás / samponos fürdetés', 2500),
(41, 2, 'Csomómentesítés, bontás', 2500),
(42, 2, 'Szárítás', 2000),
(43, 2, 'Illatosítás', 700),
(44, 2, 'Fogtisztítás ultrahanggal', 6000),
(45, 2, 'Fülmosás és fertőtlenítés', 1500),
(46, 2, 'Macska fürdetés és fésülés', 7000),
(47, 2, 'Szőrszínezés (ideiglenes, kímélő festék)', 3000),
(48, 2, 'Szőrregeneráló pakolás / hidratáló kezelés', 2000),
(49, 3, 'Alap fotózás csomag (30 perc, 10 kép)', 10000),
(50, 3, 'Teljes fotózás (60 perc, 25 kép)', 18000),
(51, 3, 'Kültéri fotózás (+díj)', 2000),
(52, 3, 'Több kisállat egy fotózáson (+díj)', 3000),
(53, 3, 'Fotózás gazdival együtt (+díj)', 4000),
(54, 3, 'Ünnepi témájú fotózás (díszlettel) (+díj)', 1500),
(55, 3, 'Nyomtatott fotó (/db)', 500),
(56, 3, 'Képek átadása pendrive-on', 2000);

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
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `phone` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `password`, `phone`) VALUES
(1, 'Eszti', 'szjuheszti@gmail.com', 'Pajti2025', '306757818');

--
-- Indexek a kiírt táblákhoz
--

--
-- A tábla indexei `contact`
--
ALTER TABLE `contact`
  ADD PRIMARY KEY (`id`);

--
-- A tábla indexei `gallery`
--
ALTER TABLE `gallery`
  ADD PRIMARY KEY (`id`);

--
-- A tábla indexei `pets`
--
ALTER TABLE `pets`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- A tábla indexei `prices`
--
ALTER TABLE `prices`
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
-- AUTO_INCREMENT a táblához `contact`
--
ALTER TABLE `contact`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT a táblához `gallery`
--
ALTER TABLE `gallery`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT a táblához `pets`
--
ALTER TABLE `pets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT a táblához `prices`
--
ALTER TABLE `prices`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=57;

--
-- AUTO_INCREMENT a táblához `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Megkötések a kiírt táblákhoz
--

--
-- Megkötések a táblához `pets`
--
ALTER TABLE `pets`
  ADD CONSTRAINT `pets_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
