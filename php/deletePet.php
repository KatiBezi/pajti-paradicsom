<?php

declare(strict_types=1);

// Környezeti beállítások betöltése
require_once("../../common/php/environment.php");

// POST vagy GET metódussal érkező argumentumok lekérése
$args = Util::getArgs();

// Adatbázis objektum létrehozása
$db = new Database();

// SQL lekérdezés a kisállat törlésére az ID alapján
$query = "DELETE FROM `pets`
                 WHERE `id` = ?";

// SQL parancs végrehajtása a megadott kisállat ID-val
$result = $db->execute($query, [$args['pet_id'],]);

// Ellenőrizzük, hogy a törlés sikeres volt-e
if ($result) {
    // Sikeres törlés esetén egy üzenetet küldünk vissza
    Util::setResponse(['success' => true, 'message' => 'Kisállat sikeresen törölve!']);
} else {
    // Sikertelen törlés esetén egy hibaüzenetet állítunk be
    Util::setError("Hiba történt a kisállat törlése során, vagy a kisállat nem található!");
}

// Adatbázis kapcsolat lezárása
$db = null;