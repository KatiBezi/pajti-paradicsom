<?php

declare(strict_types=1);

require_once("../../common/php/environment.php");

$args = Util::getArgs();

// Alapellenőrzés
if (
    empty($args['user_id']) ||
    empty($args['pet_name']) ||
    empty($args['pet_type']) ||
    empty($args['pet_age'])
) {
    Util::setError("Hiányzó adat a regisztrációhoz.");
}

// Adatbázis kapcsolat
$db = new Database();

// SQL parancs (backtickekkel)
$query = "INSERT INTO `pets` (`user_id`, `name`, `type`, `age`, `description`) 
          VALUES (?, ?, ?, ?, ?)";

// Végrehajtás
$result = $db->execute($query, [
    $args['user_id'],
    $args['pet_name'],
    $args['pet_type'],
    $args['pet_age'],
    $args['description'] ?? null
]);

// Kapcsolat lezárása
$db = null;

// Eredmény ellenőrzése
if (!$result || empty($result['lastInsertId'])) {
    Util::setError("A kisállat regisztráció nem sikerült!");
}

// Válasz
Util::setResponse($result['lastInsertId']);
