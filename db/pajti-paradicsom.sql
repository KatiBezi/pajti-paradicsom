-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Gép: 127.0.0.1
-- Létrehozás ideje: 2025. Máj 12. 16:01
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

--
-- A tábla adatainak kiíratása `contact`
--

INSERT INTO `contact` (`id`, `name`, `email`, `message`, `submission_date`) VALUES
(1, 'Bézi Katalin', 'bezi.katalin@gmail.com', 'Jó napot!', '2025-04-12 11:42:17'),
(2, '', '', '', '2025-04-15 18:27:00'),
(3, '', '', '', '2025-04-15 18:27:27'),
(7, 'Katalin Bzi', 'bezi.katalin@gmail.com', 'Hello', '2025-04-15 18:58:44'),
(8, 'Bezi Lajos', 'bezilala@gmail.com', 'Hellobello emberek!', '2025-04-15 19:03:10');

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

--
-- A tábla adatainak kiíratása `pets`
--

INSERT INTO `pets` (`id`, `user_id`, `name`, `type`, `age`, `description`) VALUES
(9, 3, 'Szimba', 'Macska', 8, 'harapós'),
(10, 3, 'Mulan', 'kutya', 8, 'PITBULL'),
(11, 3, 'Szása', 'Kutya', 5, 'juhász'),
(13, 3, 'Rozi', 'Macska', 14, 'fekete feher'),
(14, 3, 'Hugo', 'kutya', 3, 'fehér'),
(18, 3, 'Lilás', 'kutya', 3, 'német juhász'),
(19, 3, 'Gigi', 'macska', 4, 'szép'),
(21, 3, 'Noni', 'macsska', 5, 'vörös'),
(23, 4, 'Palacsinta', 'Kutya', 0, 'Dobberman'),
(24, 4, 'Mókus', 'Kutya', 0, 'Puli'),
(25, 4, 'Kókusz', 'Kutya', 2, 'keverék hosszú szőrű'),
(26, 4, 'Jónás', 'macska', 3, 'perzsa'),
(27, 14, 'Marci', 'Kutya', 5, 'jól szocializált');

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

--
-- A tábla adatainak kiíratása `schedule`
--

INSERT INTO `schedule` (`id`, `date`, `time`, `animal_id`, `services_id`, `comments`) VALUES
(1, '2025-05-09', '13:00:00', 10, 11, 0),
(2, '2025-05-01', '12:00:00', 10, 13, 0),
(3, '2025-05-09', '13:00:00', 10, 4, 0),
(4, '2025-04-19', '11:00:00', 10, 50, 0),
(5, '2025-05-15', '12:00:00', 11, 14, 0),
(6, '2025-05-22', '09:00:00', 11, 8, 0),
(7, '2025-05-12', '09:00:00', 9, 11, 0),
(8, '2025-05-30', '14:00:00', 13, 8, 0),
(9, '2025-05-30', '13:00:00', 11, 13, 0),
(10, '2025-05-24', '13:00:00', 14, 30, 0),
(11, '2025-05-08', '14:00:00', 18, 16, 0),
(12, '2025-05-28', '15:00:00', 18, 32, 0),
(13, '2025-05-29', '09:00:00', 21, 56, 0),
(14, '2025-05-12', '15:00:00', 13, 11, 0),
(15, '2025-05-12', '17:00:00', 9, 11, 0),
(16, '2025-05-29', '12:00:00', 9, 11, 0),
(17, '2025-05-12', '10:00:00', 9, 16, 0),
(18, '2025-05-27', '12:00:00', 14, 36, 0),
(19, '2025-05-24', '11:00:00', 11, 11, 0),
(20, '2025-05-23', '09:00:00', 14, 23, 0),
(21, '2025-05-14', '10:00:00', 18, 17, 0),
(22, '2025-05-15', '09:00:00', 10, 12, 0),
(23, '2025-05-16', '11:00:00', 10, 30, 0),
(24, '2025-05-06', '11:00:00', 13, 12, 0),
(25, '2025-05-14', '11:00:00', 10, 9, 0),
(26, '2025-05-13', '16:00:00', 9, 5, 0),
(27, '2025-05-12', '10:00:00', 10, 5, 0),
(28, '2025-05-12', '13:00:00', 11, 50, 0),
(29, '2025-05-13', '09:00:00', 9, 10, 0),
(30, '2025-05-06', '11:00:00', 11, 4, 0),
(31, '2025-05-08', '11:00:00', 10, 10, 0),
(32, '2025-05-13', '09:00:00', 9, 4, 0),
(33, '2025-05-12', '10:00:00', 11, 9, 0),
(34, '2025-05-15', '13:00:00', 11, 5, 0),
(35, '2025-05-23', '12:00:00', 19, 9, 0),
(36, '2025-05-09', '11:00:00', 10, 5, 0),
(37, '2025-05-13', '11:00:00', 10, 5, 0),
(38, '2025-05-16', '16:00:00', 9, 50, 0),
(39, '2025-05-21', '12:00:00', 11, 9, 0),
(40, '2025-05-08', '09:00:00', 18, 9, 0),
(41, '2025-05-12', '14:00:00', 11, 5, 0),
(42, '2025-05-12', '11:00:00', 10, 8, 0),
(43, '2025-05-13', '13:00:00', 10, 10, 0),
(44, '2025-05-22', '10:00:00', 14, 9, 0),
(45, '2025-05-13', '10:00:00', 13, 8, 0);

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
(1, 'Eszti', 'szjuheszti@gmail.com', 'Pajti2025', '306757818'),
(3, 'bezik', 'bezi.katalin@gmail.com', 'Abcd123#', '+36202456783'),
(4, 'Kis István', 'kispista@gmail.com', 'Abcd123#', '+36203698741'),
(5, 'Nagy Cecília', 'nagy.cili@gmail.com', 'Abcd123#', '+36542874562'),
(6, 'Kimér Őrs', 'kimerors@gmail.com', 'Abcd123#', '+36526894371'),
(7, 'Kovács Aladár', 'kovacsaladar@gmail.com', 'Abcd123#', '+36857412369'),
(11, 'Katona Gina', 'katona.gina@gmail.com', 'Abcd123#', '+36549876320'),
(13, 'Kiss Péter', 'kisspeter@gmail.com', 'Abcd123#', '+36623596781'),
(14, 'Magyar Oleg', 'magyar.oleg@gmail.com', 'Abcd123#', '+36202456780'),
(15, 'Magyar Jázmin', 'magyar.jazmin@gmail.com', 'Abcd123#', '+36202456784'),
(16, 'Magyar Amadeus', 'magyar.amadeus@gmail.com', 'Abcd123#', '+36202456787'),
(17, 'Nagy Sándor', 'saci@gmail.com', 'Abcd123#', '+36203658945'),
(18, 'Mekk Elek', 'mekkelek@gmail.com', 'Abcd123#', '+36253698741'),
(19, 'Lakatos Olivia', 'olivia@gmail.com', 'Abcd123#', '+36205896733'),
(20, 'Szondi Ilona', 'icuka@gmail.com', 'Abcd123#', '+36306895733'),
(21, 'Ikaf Lajos', 'ikaf@gmail.com', 'Abcd123#', '+36502937486'),
(22, 'Karimás Frigyes', 'frici@gmail.com', 'Abcd123#', '+36609872546'),
(23, 'eros_pista', 'eros_pista@gmail.com', 'Abcd123#', '+3620569833333'),
(24, 'ÉdesAnna', 'edesanna@gmail.com', 'Abcd123#', '+36552121444'),
(25, 'JoJoShiva', 'jojo@gmail.com', 'Abcd123#', '+36805566999'),
(27, 'bezikati', 'bezikata@gmail.com', 'Abcd123#', '+36202456780'),
(28, 'Madaras Etelka', 'etelka@gmail.com', 'Abcd123#', '+36202456780');

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
-- A tábla indexei `schedule`
--
ALTER TABLE `schedule`
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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT a táblához `gallery`
--
ALTER TABLE `gallery`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT a táblához `pets`
--
ALTER TABLE `pets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT a táblához `prices`
--
ALTER TABLE `prices`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=57;

--
-- AUTO_INCREMENT a táblához `schedule`
--
ALTER TABLE `schedule`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT a táblához `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- Megkötések a kiírt táblákhoz
--

--
-- Megkötések a táblához `pets`
--
ALTER TABLE `pets`
  ADD CONSTRAINT `pets_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
