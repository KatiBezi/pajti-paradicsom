-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Gép: 127.0.0.1
-- Létrehozás ideje: 2025. Máj 13. 15:04
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
(8, 'Bezi Lajos', 'bezilala@gmail.com', 'Hellobello emberek!', '2025-04-15 19:03:10'),
(9, 'HarciMacska', 'HarciMacska@gmail.com', 'ide jön az üzenet', '2025-05-13 11:42:51'),
(10, 'HarciKutya23', 'HarciKutya23@gmail.com', 'Hello Mindenki!', '2025-05-13 11:48:57'),
(11, 'HarciMedve89', 'HarciMedve89@gmail.com', 'Visszatértem!', '2025-05-13 11:58:41');

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
(9, 3, 'Szimba', 'Macska', 7, 'harapós'),
(10, 3, 'Mulan', 'kutya', 8, 'PITBULL fekete fehér'),
(18, 3, 'Liláp', 'kutya', 3, 'német juhász'),
(19, 3, 'Gigi', 'macska', 4, 'szép'),
(23, 4, 'Palacsinti', 'Kutya', 0, 'Dobbermanó'),
(24, 4, 'Mókus', 'Kutya', 0, 'Puli'),
(25, 4, 'Kókusz', 'Kutya', 2, 'keverék hosszú szőrű'),
(26, 4, 'Jónás', 'macska', 3, 'perzsaszerű vadmacska'),
(27, 14, 'Marci', 'Kutya', 5, 'jól szocializált'),
(31, 3, 'Murko', 'nyúl', 5, 'barna'),
(32, 3, 'Hedvig', 'kutya', 1, 'hófehér'),
(34, 3, 'Cili', 'macska', 7, NULL),
(35, 4, 'Pinduri', 'kutya', 2, 'a legszebb a világon'),
(36, 29, 'Lótusz', 'macska', 4, 'bengáli'),
(39, 3, 'Lóri', 'egyéb', 1, 'törpemalac'),
(40, 31, 'Jojó', 'macska', 2, NULL);

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
  `comments` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `schedule`
--

INSERT INTO `schedule` (`id`, `date`, `time`, `animal_id`, `services_id`, `comments`) VALUES
(1, '2025-05-09', '13:00:00', 10, 11, '0'),
(2, '2025-05-01', '12:00:00', 10, 13, '0'),
(11, '2025-05-08', '14:00:00', 18, 16, '0'),
(12, '2025-05-28', '15:00:00', 18, 32, '0'),
(16, '2025-05-29', '12:00:00', 9, 11, '0'),
(21, '2025-05-14', '10:00:00', 18, 17, '0'),
(22, '2025-05-15', '09:00:00', 10, 12, '0'),
(23, '2025-05-16', '11:00:00', 10, 30, '0'),
(25, '2025-05-14', '11:00:00', 10, 9, '0'),
(26, '2025-05-13', '16:00:00', 9, 5, '0'),
(27, '2025-05-12', '10:00:00', 10, 5, '0'),
(32, '2025-05-13', '09:00:00', 9, 4, '0'),
(35, '2025-05-23', '12:00:00', 19, 9, '0'),
(37, '2025-05-13', '11:00:00', 10, 5, '0'),
(40, '2025-05-08', '09:00:00', 18, 9, '0'),
(43, '2025-05-13', '13:00:00', 10, 10, '0'),
(49, '2025-06-04', '10:00:00', 24, 34, 'félős nagyon'),
(51, '2025-05-30', '14:00:00', 19, 10, '');

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
(1, 'Pajti Hotel', 'A Pajti Hotel tökéletes választás, ha hosszabb vagy rövidebb időre szeretné biztonságban és kényelemben tudni kedvencét. Legyen szó akár nyaralásról, üzleti útról vagy bármilyen más elfoglaltságról, ahol nem tudja magával vinni kutyáját, mi szeretettel és odafigyeléssel gondoskodunk róla. \r\nHotelünkben a kutyák tágas, jól felszerelt boxokban vagy külön szobákban kerülnek elhelyezésre, ahol elegendő helyük van a mozgásra és pihenésre. A napi többszöri séták és a rendszeres játék biztosítják, hogy kedvence ne unatkozzon és jól érezze magát.\r\nSzakképzett gondozóink folyamatosan felügyelik a kutyákat, biztosítva számukra a megfelelő táplálást, ivóvizet és szükség esetén a gyógyszerelést. A hotel területén állatorvosi felügyelet is rendelkezésre áll, így vészhelyzet esetén azonnal szakszerű ellátást tudunk nyújtani.\r\nA Pajti Hotel nem csupán egy megőrzőhely, hanem egy olyan hely, ahol a kutyák jól érzik magukat. A gazdik nyugodtak lehetnek, hiszen tudják, hogy kedvencük a legjobb kezekben van, amíg ők távol vannak.\r\nFontos tudnivalók:\r\nA kutyák csak érvényes oltásokkal és féreghajtással vehetők fel.\r\nA helyek korlátozott száma miatt javasoljuk a mielőbbi időpontfoglalást.\r\nA részletes házirendet és árakat a weboldalunkon vagy telefonon találja.\r\nBízunk benne, hogy a Pajti Hotel lesz kedvence második otthona!', 'foto2.jpg'),
(2, 'Pajti kozmetika', 'Szívélyesen üdvözöljük Önt és négylábú társát a Pajti Paradicsom kutyakozmetikában, Makó városának szeretetteljes és gondoskodó oázisában! Mi itt, a Pajti Paradicsomban, nem csupán egy kutyakozmetika vagyunk, hanem egy olyan hely, ahol a kutyák kényelme, egészsége és jólléte a legfontosabb. Tudjuk, hogy kedvence az Ön számára családtag, éppen ezért olyan odaadással és szakértelemmel bánunk vele, mintha a sajátunk lenne.\r\nA Pajti Paradicsom csapata szakképzett és tapasztalt kutyakozmetikusokból áll, akik nem csupán a szőrzetápolás mesterei, hanem igazi állatbarátok is. Munkánk során a türelem, a szeretet és a nyugodt légkör megteremtése a legfontosabb, hogy kedvence a lehető legjobban érezze magát a kozmetikázás ideje alatt. Tisztában vagyunk azzal, hogy minden kutya egyedi személyiség, ezért a kezeléseket mindig az ő igényeihez és temperamentumához igazítjuk. Legyen szó egy félénk kölyökről, egy idősödő matuzsálemről vagy egy energikus fiatalról, nálunk mindenki a megérdemelt figyelmet és törődést kapja.\r\nSzolgáltatásaink széles skáláját kínáljuk, hogy kedvence mindig a legjobb formájában tündökölhessen.\r\nA Pajti Paradicsomban a legmodernebb eszközökkel és a legmagasabb minőségű, kutyabarát kozmetikumokkal dolgozunk. A higiéniára kiemelt figyelmet fordítunk, a szalonunk mindig tiszta és rendezett, hogy kedvence a lehető legbiztonságosabban és legkényelmesebben érezze magát.\r\nHiszünk abban, hogy a kozmetikázás nem csupán a külső megjelenésről szól, hanem hozzájárul kedvence egészségéhez és jóllétéhez is. A rendszeres szőrzetápolás segít megelőzni a bőrproblémákat, csökkenti a szőrhullást, és javítja a kutya közérzetét.\r\nSzeretettel várjuk Önt és kedvencét a Pajti Paradicsomban, ahol a kutyák a paradicsomban érzik magukat! Forduljon hozzánk bizalommal, és kérjen időpontot még ma!\r\n', 'foto1.jpg'),
(3, 'Pajti fotózás', 'Miért válassza a Pajti fotózást?\r\nSzakértelem és tapasztalat: Tapasztalt állatfotósaink türelmesen és szeretettel közelítenek a kutyákhoz, legyen szó akár egy energikus kölyökről, egy félénk mentett állatról vagy egy idősödő matuzsálemről. Tudjuk, hogyan hozzuk ki a legjobbat minden modellből.\r\nKényelmes és stresszmentes környezet: A fotózás nyugodt és barátságos környezetben zajlik, ahol kedvence biztonságban és kényelemben érzi magát. Kerüljük a felesleges stresszt, hogy a képeken a valódi énje tükröződjön.\r\nEgyedi stílus és kreativitás: Nem sablonfotókat készítünk. Minden fotózás egyedi, tükrözi kedvence személyiségét és az Önök kapcsolatát. Legyen szó játékos portrékról, akciódús pillanatképekről vagy meghitt családi fotókról, mi megvalósítjuk az elképzeléseit.\r\nMinőségi végeredmény: A fotózás során készült legjobb képek professzionális utómunkán esnek át, hogy a végeredmény lenyűgöző és időtálló legyen. Különböző formátumokban (digitális, nyomtatott) és csomagokban kínáljuk a képeket, hogy mindenki megtalálja a számára legmegfelelőbbet.\r\nSzolgáltatásaink:\r\nPortréfotózás: Kedvence egyedi portréja, amely kiemeli szépségét és személyiségét.\r\nAkciófotózás: Játék közben, futás közben vagy más aktív pillanatokban készült képek.\r\nCsaládi fotózás: Közös fotók Önnel és családjával.\r\nTematikus fotózás: Ünnepi vagy évszaki témákhoz kapcsolódó fotók (pl. karácsonyi, szülinapi).\r\nFotókönyv készítése: A legjobb képekből gyönyörű fotókönyv összeállítása.\r\nAjándékozzon örök emléket!\r\nA Pajti fotózás tökéletes ajándék lehet bármilyen alkalomra. Lepje meg magát vagy szeretteit egyedi és személyes emlékekkel!\r\nKeressen minket bizalommal, és kérjen időpontot!', 'foto.jpg');

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
(3, 'bezik', 'bezi.katalin@gmail.com', 'Abcd123#', '+36302456782'),
(4, 'Kis István', 'kispista@gmail.com', 'Abcd123#', '+36203698743'),
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
(28, 'Madaras Etelka', 'etelka@gmail.com', 'Abcd123#', '+36202456780'),
(29, 'Ririke', 'ririke2@gmail.com', 'Abcd123#', '+3625785693'),
(30, 'Gizike', 'gizike@gmail.com', 'Abcd123#', '+36529669693'),
(31, 'HarciKutya23', 'HarciKutya23@gmail.com', 'Abcd123#', '+369635897458'),
(32, 'HarciMacska45', 'HarciMacska45@gmail.com', 'Abcd123#', '+365248963251'),
(33, 'Eperlekvar', 'eperlekvar234@gmail.com', 'Abcd123#', '+362056897855'),
(34, 'Ilona78', 'ilona78@gmail.com', 'Abcd123#', '+3653897456');

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
  ADD KEY `user_id` (`user_id`),
  ADD KEY `idx_user_id` (`user_id`);

--
-- A tábla indexei `prices`
--
ALTER TABLE `prices`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_service_id` (`service_id`);

--
-- A tábla indexei `schedule`
--
ALTER TABLE `schedule`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_animal_id` (`animal_id`);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT a táblához `gallery`
--
ALTER TABLE `gallery`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT a táblához `pets`
--
ALTER TABLE `pets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT a táblához `prices`
--
ALTER TABLE `prices`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=57;

--
-- AUTO_INCREMENT a táblához `schedule`
--
ALTER TABLE `schedule`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;

--
-- AUTO_INCREMENT a táblához `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- Megkötések a kiírt táblákhoz
--

--
-- Megkötések a táblához `pets`
--
ALTER TABLE `pets`
  ADD CONSTRAINT `pets_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Megkötések a táblához `schedule`
--
ALTER TABLE `schedule`
  ADD CONSTRAINT `fk_animal` FOREIGN KEY (`animal_id`) REFERENCES `pets` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
