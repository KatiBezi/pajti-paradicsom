<?php
declare(strict_types=1);

// Környezeti beállítások betöltése
require_once("../../common/php/environment.php");
// Beérkező adatok lekérése JSON formátumban
$args = Util::getArgs();

// Ellenőrzések inicializálása
$errors = [];
$valid = true;

// Email cím ellenőrzése
if (empty($args['email'])) {
    $valid = false;
    $errors[] = "Az email cím üres!";
}

// Jelszó ellenőrzése
if (empty($args['password'])) {
    $valid = false;
    $errors[] = "A jelszó üres!";
}

// Ha vannak hibák, állítsuk be a hibaüzeneteket
if (!$valid) {
    Util::setError(implode(" ", $errors)); // Hibaüzenetek összefűzése
    exit; // Kilépés
}

// Adatbázis kapcsolat létrehozása
$db = new Database();

// SQL lekérdezés az email cím ellenőrzésére
$query = "SELECT `id` FROM `users` WHERE `email` = ? LIMIT 1";

// SQL parancs végrehajtása
$result = $db->execute($query, [$args['email']]);

// Ellenőrizzük, hogy az email cím már létezik-e
if (!empty($result)) {
    Util::setError("Felhasználó már létezik ezen az e-mail címen!");
    exit; // Kilépés
}

// SQL parancs az új felhasználó beszúrására
$query = $db->preparateInsert("users", $args);

// SQL parancs végrehajtása
$result = $db->execute($query, array_values($args));

// Kapcsolat lezárása
$db = null;

// Válasz beállítása
if ($result) {
    Util::setResponse(['success' => true, 'message' => 'Sikeres regisztráció!']);
} else {
    Util::setError("Hiba a regisztráció során!");
}

