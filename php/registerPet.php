<?php
//EZ KÉSZ
declare(strict_types=1);

require_once("../../common/php/environment.php");

$args = Util::getArgs();

// Alapellenőrzés
if (
    empty($args['user_id']) ||
    empty($args['pet_name']) ||
    empty($args['pet_type']) ||
    empty($args['pet_age']) ||
    empty($args['description'])
) {
    Util::setError("Hiányzó adat a regisztrációhoz.");
}

// Adatbázis kapcsolat
$db = new Database();

$query = "INSERT INTO pets (user_id, name, type, age, description) VALUES (?, ?, ?, ?, ?)";

$result = $db->execute($query, [
    $args['user_id'],
    $args['pet_name'],
    $args['pet_type'],
    $args['pet_age'],
    $args['description']
]);

$db = null;

// SQL parancs az új felhasználó beszúrására
$query = $db->preparateInsert("pets", $args);

// SQL parancs végrehajtása
$result = $db->execute($query, array_values($args));

// Kapcsolat lezárása
$db = null;

// Check result
if (!$result["affectedRows"])
  Util::setError('A kisállat regisztráció nem sikerült!');

// Set response
Util::setResponse($result["lastInsertId" ]);