<?php
declare(strict_types=1);

// Környezeti beállítások betöltése
require_once("../../common/php/environment.php");

// Session indítása
session_start();

// Ellenőrizzük, hogy a felhasználó be van-e jelentkezve
if (!isset($_SESSION['user_id'])) {
    Util::setError("Kérjük, jelentkezzen be a felhasználói adatok frissítéséhez!");
    exit; // Kilépés
}

// Beérkező adatok lekérése JSON formátumban
$args = Util::getArgs();

// Ellenőrizzük, hogy a frissítendő adatok meg vannak-e adva
if (empty($args['name']) && empty($args['email']) && empty($args['password'])) {
    Util::setError("Kérjük, adja meg a frissítendő adatokat!");
    exit; // Kilépés
}

// Adatbázis kapcsolat létrehozása
$db = new Database();

// SQL lekérdezés a felhasználói adatok frissítésére
$query = "UPDATE `users` SET ";
$parameters = [];
$updates = [];

// Dinamikusan építjük fel a frissítési lekérdezést
if (!empty($args['name'])) {
    $updates[] = "`name` = ?";
    $parameters[] = $args['name'];
}
if (!empty($args['email'])) {
    $updates[] = "`email` = ?";
    $parameters[] = $args['email'];
}
if (!empty($args['password'])) {
    // Jelszó frissítése 
    $updates[] = "`password` = ?";
    $parameters[] = $args['password'];
}

// A lekérdezés befejezése
$query .= implode(", ", $updates) . " WHERE `id` = ?";
$parameters[] = $_SESSION['user_id'];

// SQL parancs végrehajtása
$result = $db->execute($query, $parameters);

// Ellenőrizzük, hogy a frissítés sikeres volt-e
if ($result) {
    Util::setResponse(['success' => true, 'message' => 'Felhasználói adatok sikeresen frissítve!']);
} else {
    Util::setError("Hiba történt a felhasználói adatok frissítése során!");
}

// Kapcsolat lezárása
$db = null;

