<?php
declare(strict_types=1);

// Környezeti beállítások betöltése
require_once("../../common/php/environment.php");
// Beérkező adatok lekérése JSON formátumban
$args = Util::getArgs();


// Adatbázis kapcsolat létrehozása
$db = new Database();

// SQL lekérdezés az email cím ellenőrzésére
$query = "SELECT `id` FROM `users` WHERE `email` = ? LIMIT 1";

// SQL parancs végrehajtása
$result = $db->execute($query, [$args['email']]);

// Ellenőrizzük, hogy az email cím már létezik-e
if (!is_null($result)) {
    Util::setError("Felhasználó már létezik ezen az e-mail címen!");
    exit; // Kilépés
}

// SQL parancs az új felhasználó beszúrására
$query = $db->preparateInsert("users", $args);

// SQL parancs végrehajtása
$result = $db->execute($query, array_values($args));

// Kapcsolat lezárása
$db = null;

// Check result
if (!$result["affectedRows"])
  Util::setError('A regisztráció nem sikerült!');

// Set response
Util::setResponse($result["lastInsertId" ]);