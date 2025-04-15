<?php
declare(strict_types=1);

/
require_once("../../common/php/environment.php");


$args = Util::getArgs();

$db = new Database();

// SQL lekérdezés a felhasználói adatok frissítésére
$query = "UPDATE `users` SET ";
$parameters = [];
$updates = [];


if (!empty($args['name'])) {
    $updates[] = "`name` = ?";
    $parameters[] = $args['name'];
}
if (!empty($args['email'])) {
    $updates[] = "`email` = ?";
    $parameters[] = $args['email'];
}
if (!empty($args['password'])) {
    // Jelszó frissítése 
    $updates[] = "`password` = ?";
    $parameters[] = $args['password'];
}

// A lekérdezés befejezése
$query .= implode(", ", $updates) . " WHERE `id` = ?";
$parameters[] = $_SESSION['user_id'];

// SQL parancs végrehajtása
$result = $db->execute($query, $parameters);

// Ellenőrizzük, hogy a frissítés sikeres volt-e
if ($result) {
    Util::setResponse(['success' => true, 'message' => 'Felhasználói adatok sikeresen frissítve!']);
} else {
    Util::setError("Hiba történt a felhasználói adatok frissítése során!");
}

// Kapcsolat lezárása
$db = null;

