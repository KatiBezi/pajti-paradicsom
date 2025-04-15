<?php
declare(strict_types=1);

// Környezeti beállítások betöltése
require_once("../..common/php/environment.php");

$args = Util::getArgs();

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

