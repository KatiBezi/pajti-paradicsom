<?php

require_once("../../common/php/environment.php");

$args = Util::getArgs();

$db = new Database();

// SQL lekérdezés a felhasználó ID-jának és jelszavának lekéréséhez felhasználónév alapján
$query = "SELECT `id`, `password`
          FROM `users`
          WHERE username = :username
          LIMIT 1";

// SQL parancs végrehajtása a megadott felhasználónévvel
$result = $db->execute($query, ['username' => $args['username']]);

$db = null;

// Ellenőrizzük, hogy a lekérdezés eredménye null-e 
if (is_null($result)) {
    Util::setError('Hibás felhasználónév!');
}

// Ha találtunk felhasználót, az első (és egyetlen, a LIMIT 1 miatt) eredményt tároljuk
$user = $result[0];

// Ellenőrizzük, hogy a megadott jelszó megegyezik-e a lekérdezett jelszóval
if ($args['password'] !== $user['password']) {
    Util::setError('Hibás jelszó!');
}

// Ha a felhasználónév és a jelszó is helyes, visszaadjuk a felhasználó ID-ját
Util::setResponse(['user_id' => $user['id']]);