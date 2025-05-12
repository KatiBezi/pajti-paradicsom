<?php
declare(strict_types=1);

// Környezeti változók betöltése
require_once("../../common/php/environment.php");

// Paraméterek lekérése
$args = Util::getArgs();

$query = "SELECT id, name 
			FROM pets 
			WHERE user_id = ?";

// Adatbázis kapcsolat
$db = new Database();

// Lekérdezés futtatása
$result = $db->execute($query, [$args['user_id']]);

// Kapcsolat lezárása
$db = null;

// Eredmény ellenőrzése
if (is_null($result)) {
    Util::setError("Nem található kisállat.");
}

// Válasz visszaküldése
Util::setResponse($result);

