<?php
//EZ KÉSZ
declare(strict_types=1);

require_once("../../common/php/environment.php");

$args = Util::getArgs();

// Alapellenőrzés
if (
    empty($args['username']) ||
    empty($args['phone']) ||
    empty($args['email']) ||
    empty($args['password']) ||
    empty($args['confirmEmail']) ||
    empty($args['confirmPassword'])
) {
    Util::setError("Hiányzó adat a regisztrációhoz.");
}
if (!filter_var($args['email'], FILTER_VALIDATE_EMAIL)) {
    Util::setError("Érvénytelen e-mail cím.");
}
if ($args['email'] !== $args['confirmEmail']) {
    Util::setError("Az e-mail címek nem egyeznek.");
}

if ($args['password'] !== $args['confirmPassword']) {
    Util::setError("A jelszavak nem egyeznek.");
}

// Adatbázis kapcsolat
$db = new Database();

// Email egyediség ellenőrzése
$query = "SELECT `id` FROM `users` WHERE `email` = ? LIMIT 1";
$result = $db->execute($query, [$args['email']]);

if (!empty($result)) {
    Util::setError("Létező felhasználó email cím.");
}

// Felhasználó beszúrása
$query = "INSERT INTO users (username, phone, email, password) VALUES (?, ?, ?, ?)";
$result = $db->execute($query, [
    $args['username'],
    $args['phone'],
    $args['email'],
    $args['password']
]);

// Kapcsolat lezárása
$db = null;

// Ellenőrzés
if (!$result || empty($result['lastInsertId'])) {
    Util::setError('A felhasználó regisztráció nem sikerült!');
}

// Sikeres válasz
Util::setResponse($result['lastInsertId']);
