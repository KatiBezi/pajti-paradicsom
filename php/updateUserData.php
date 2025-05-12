<?php
//EZ KÉSZ

declare(strict_types=1);

require_once("../../common/php/environment.php");

$args = Util::getArgs();

$db = new Database();

$query = "UPDATE `users` SET `email` = ?, `phone` = ? WHERE `id` = ? ";

$result = $db->execute($query, [
    $args['email'],
    $args['phone'],
    $args['id'],   // Felhasználó ID
]);

// Ellenőrizzük
if ($result && $db->affectedRows() > 0) {
    Util::setResponse(['success' => true, 'message' => 'Felhasználó adatai sikeresen frissítve!']);
} else {
    Util::setError("Hiba történt a felhasználó adatainak frissítése során");
}
// Kapcsolat lezárása
$db = null;
