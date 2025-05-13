<?php

declare(strict_types=1);

// Környezeti beállítások betöltése
require_once("../../common/php/environment.php");

// Argumentumok lekérése a kérésből 
$args = Util::getArgs();

// SQL parancs beállítása a felhasználó adatainak lekérdezéséhez ID alapján
$query = "SELECT
                    `id`,
                    `username`,
                    `email`,
                    `phone`
                 FROM
                    `users`
                 WHERE
                    `id` = :user_id";

// Csatlakozás a MySQL szerverhez
$db = new Database();

// SQL parancs végrehajtása a megadott argumentumokkal
$result = $db->execute($query, $args);

// Adatbázis kapcsolat lezárása
$db = null;

// Eredmény ellenőrzése
if (is_null($result)) {
    // Ha a lekérdezés eredménye null, az azt jelenti, hogy a felhasználó nem létezik
    Util::setError("A felhasználó nem létezik!");
}

// Az eredmény egyszerűsítése, mivel csak egy felhasználót várunk (az ID alapján szűrünk)
$result = $result[0];

// Válasz beállítása a lekérdezett felhasználói adatokkal
Util::setResponse($result);