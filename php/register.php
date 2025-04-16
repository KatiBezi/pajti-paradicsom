<?php
declare(strict_types=1);

require_once("../../common/php/environment.php");

$args = Util::getArgs();

// Alapellenőrzés a felhasználói regisztrációhoz szükséges adatokra
if (
    empty($args['username']) ||
    empty($args['phone']) ||
    empty($args['email']) ||
    empty($args['password']) ||
    empty($args['confirmEmail']) ||
    empty($args['confirmPassword'])
) {
    Util::setError("Hiányzó adat a regisztrációhoz.");
    exit;
}
// E-mail címek egyezésének ellenőrzése
if ($args['email'] !== $args['confirmEmail']) {
    Util::setError("Az e-mail címek nem egyeznek.");
    exit;
}

// Jelszavak egyezésének ellenőrzése
if ($args['password'] !== $args['confirmPassword']) {
    Util::setError("A jelszavak nem egyeznek.");
    exit;
}


// Adatbázis kapcsolat létrehozása
$db = new Database();

// Ellenőrizzük, hogy létezik-e már felhasználó ezzel az e-mail címmel
$query = "SELECT `id`
          FROM `users`
          WHERE `email` = ? LIMIT 1";

$result = $db->execute($query, [$args['email']]);

if (!is_null($result)) {
    Util::setError("Felhasználó már létezik ezen az e-mail címen!");
    exit;
}


// Adatok előkészítése a beszúráshoz
$args = [
    'username' => $args['username'],
    'phone' => $args['phone'],
    'email' => $args['email'],
    'password' => $args['password']
];

$query = $db->preparateInsert("users", $args);

$result = $db->execute($query, array_values($args));

$db = null;

if (!$result["affectedRows"])
    Util::setError('A regisztráció nem sikerült!');

Util::setResponse($result["lastInsertId"]);
?>