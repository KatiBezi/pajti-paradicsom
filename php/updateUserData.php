<?php

declare(strict_types=1);


require_once("../../common/php/environment.php");

$args = Util::getArgs();

$db = new Database();

// SQL lekérdezés a felhasználó adatainak frissítéséhez az ID alapján
$query = "UPDATE `users`
          SET `email` = ?,
              `phone` = ?
          WHERE `id` = ? ";

// SQL parancs végrehajtása a megadott adatokkal
$result = $db->execute($query, [
    $args['email'],     // Új e-mail cím
    $args['phone'],     // Új telefonszám
    $args['id'],        // Frissítendő felhasználó ID
]);

// Ellenőrizzük, hogy a frissítés sikeres volt-e és érintett-e legalább egy sort
if ($result && $db->affectedRows() > 0) {
    Util::setResponse(['success' => true, 'message' => 'Felhasználó adatai sikeresen frissítve!']);
} else {
    Util::setError("Hiba történt a felhasználó adatainak frissítése során");
}
// Adatbázis kapcsolat lezárása
$db = null;