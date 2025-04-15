<?php
declare(strict_types=1);

// Környezeti beállítások betöltése
require_once("../..common/php/environment.php");

// Session indítása
session_start();

// Ellenőrizzük, hogy a felhasználó be van-e jelentkezve
if (!isset($_SESSION['user_id'])) {
    Util::setError("Kérjük, jelentkezzen be a kisállat adatainak frissítéséhez!");
    exit; // Kilépés
}

// Beérkező adatok lekérése JSON formátumban
$args = Util::getArgs();

// Ellenőrizzük, hogy a pet_id és a frissítendő adatok meg vannak-e adva
if (empty($args['pet_id']) || empty($args['name']) || empty($args['age']) || empty($args['type'])) {
    Util::setError("Kérjük, adja meg a kisállat azonosítóját és a frissítendő adatokat!");
    exit; // Kilépés
}

// Adatbázis kapcsolat létrehozása
$db = new Database();

// SQL lekérdezés a kisállat adatainak frissítésére
$query = "UPDATE `pets` SET `name` = ?, `age` = ?, `type` = ? WHERE `id` = ? AND `user_id` = ?";

// SQL parancs végrehajtása
$result = $db->execute($query, [$args['name'], $args['age'], $args['type'], $args['pet_id'], $_SESSION['user_id']]);

// Ellenőrizzük, hogy a frissítés sikeres volt-e
if ($result) {
    // Válasz beállítása
    Util::setResponse(['success' => true, 'message' => 'Kisállat adatai sikeresen frissítve!']);
} else {
    Util::setError("Hiba történt a kisállat adatainak frissítése során, vagy a kisállat nem található!");
}

// Kapcsolat lezárása
$db = null;

