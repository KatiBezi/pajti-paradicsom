<?php
declare(strict_types=1);

// Környezeti beállítások betöltése
require_once("../../common/php/environment.php");

// Beérkező adatok lekérése JSON formátumban
$args = Util::getArgs();

// Ellenőrzések inicializálása
$errors = [];
$valid = true;

// Felhasználónév ellenőrzése
if (empty($args['username'])) {
    $valid = false;
    $errors[] = "A felhasználónév üres!";
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

// SQL lekérdezés a felhasználónév ellenőrzésére
$query = "SELECT `id`, 
                `username`,
                `password` 
        FROM `users` 
        WHERE `username` = ? 
        LIMIT 1";

// SQL parancs végrehajtása
$result = $db->execute($query, [$args['username']]);

// Ellenőrizzük, hogy a felhasználónév létezik-e
if (empty($result)) {
    Util::setError("Hibás felhasználónév vagy jelszó!");
    exit; // Kilépés
}

// Felhasználó adatainak lekérése
$user = $result[0];

// Jelszó ellenőrzése (hash-elés nélkül)
if ($args['password'] !== $user['password']) {
    Util::setError("Hibás felhasználónév vagy jelszó!");
    exit; // Kilépés
}

// Session indítása
session_start();

// Session változók beállítása
$_SESSION['user_id'] = $user['id'];
$_SESSION['username'] = $user['username'];

// Kapcsolat lezárása
$db = null;

// Válasz beállítása
Util::setResponse(['success' => true, 'user_id' => $user['id'], 'message' => 'Sikeres bejelentkezés!']);

