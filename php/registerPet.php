<?php
declare(strict_types=1);

// Környezeti beállítások betöltése
require_once("../..common/php/environment.php");

// Session indítása
session_start();

// Ellenőrizzük, hogy a felhasználó be van-e jelentkezve
if (!isset($_SESSION['user_id'])) {
    Util::setError("Kérjük, jelentkezzen be a kisállat regisztrálásához!");
    exit; // Kilépés
}

// Beérkező adatok lekérése JSON formátumban
$args = Util::getArgs();

// Ellenőrzések inicializálása
$errors = [];
$valid = true;

// Kisállat neve ellenőrzése
if (empty($args['pet_name'])) {
    $valid = false;
    $errors[] = "A kisállat neve üres!";
}

// Kisállat típusa ellenőrzése
if (empty($args['pet_type'])) {
    $valid = false;
    $errors[] = "A kisállat típusa üres!";
}

// Ha vannak hibák, állítsuk be a hibaüzeneteket
if (!$valid) {
    Util::setError(implode(" ", $errors)); // Hibaüzenetek összefűzése
    exit; // Kilépés
}

// Adatbázis kapcsolat létrehozása
$db = new Database();

// SQL lekérdezés a kisállat regisztrálására
$query = "INSERT INTO `pets` (`user_id`, `name`, `type`) VALUES (?, ?, ?)";

// SQL parancs végrehajtása
$result = $db->execute($query, [$_SESSION['user_id'], $args['pet_name'], $args['pet_type']]);

// Ellenőrizzük, hogy a beszúrás sikeres volt-e
if ($result) {
    // Válasz beállítása
    Util::setResponse(['success' => true, 'message' => 'Kisállat sikeresen regisztrálva!']);
} else {
    Util::setError("Hiba történt a kisállat regisztrálása során!");
}

// Kapcsolat lezárása
$db = null;

