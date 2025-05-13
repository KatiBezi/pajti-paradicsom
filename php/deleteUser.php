<?php

declare(strict_types=1);

// Környezeti beállítások betöltése
require_once("../../common/php/environment.php");

// POST vagy GET metódussal érkező argumentumok lekérése
$args = Util::getArgs();

// Adatbázis objektum létrehozása
$db = new Database();

// SQL lekérdezés a felhasználó törléséhez az ID alapján
$deleteUserQuery = "DELETE FROM `users`
                                WHERE `id` = ?";
// SQL lekérdezés végrehajtása a megadott felhasználó ID-val
$result = $db->execute($deleteUserQuery, [$args['user_id']]);

// Ellenőrizzük, hogy a törlés sikeres volt-e
if ($result) {
    // Sikeres törlés esetén egy üzenetet küldünk vissza
    Util::setResponse(['success' => true, 'message' => 'Felhasználói fiók és a hozzá tartozó kisállatok törlése sikeresen megtörtént!']);
} else {
    // Sikertelen törlés esetén egy hibaüzenetet állítunk be
    Util::setError("Hiba történt a felhasználói fiók törlése során, vagy a felhasználó nem található!");
}

// Adatbázis kapcsolat lezárása
$db = null;