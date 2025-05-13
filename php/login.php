<?php

// Környezeti beállítások betöltése
require_once("../../common/php/environment.php");

// POST vagy GET metódussal érkező argumentumok lekérése
$args = Util::getArgs();

// Adatbázis objektum létrehozása
$db = new Database();

// SQL lekérdezés a felhasználó ID-jának és jelszavának lekéréséhez felhasználónév alapján
$query = "SELECT `id`, `password`
          FROM `users`
          WHERE username = :username
          LIMIT 1";

// SQL parancs végrehajtása a megadott felhasználónévvel
$result = $db->execute($query, ['username' => $args['username']]);

// Adatbázis kapcsolat lezárása
$db = null;

// Ellenőrizzük, hogy a lekérdezés eredménye null-e (azaz nem találtunk felhasználót)
if (is_null($result)) {
    // Ha nem találtunk felhasználót, hibaüzenetet küldünk
    Util::setError('Hibás felhasználónév!');
}

// Ha találtunk felhasználót, az első (és egyetlen, a LIMIT 1 miatt) eredményt tároljuk
$user = $result[0];

// Ellenőrizzük, hogy a megadott jelszó megegyezik-e a lekérdezett jelszóval
if ($args['password'] !== $user['password']) {
    // Ha a jelszavak nem egyeznek, hibaüzenetet küldünk
    Util::setError('Hibás jelszó!');
}

// Ha a felhasználónév és a jelszó is helyes, visszaadjuk a felhasználó ID-ját
Util::setResponse(['user_id' => $user['id']]);