<?php

declare(strict_types=1);

require_once("../../common/php/environment.php");

$args = Util::getArgs();

// Lekérdezés: kisállatok neveinek lekérése adott felhasználóhoz
$query = "SELECT 
             `id`, 
             `name` 
          FROM 
             `pets` 
          WHERE 
             `user_id` = ?";


$db = new Database();

$result = $db->execute($query, [$args['user_id']]);

$db = null;

// Eredmény ellenőrzése
if (is_null($result)) {
    Util::setError("Nem található kisállat.");
}

Util::setResponse($result);
