<?php

declare(strict_types=1);

require_once("../../common/php/environment.php");

$args = Util::getArgs();

$db = new Database();

// SQL lekérdezés 
$query = "UPDATE `pets` 
            SET `name` = ?, 
                `age` = ?,  
                `type` = ? 
            WHERE `id` = ?";

// SQL parancs végrehajtása
$result = $db->execute($query, [
    $args['name'] ?? null, 
    $args['age'] ?? null,  
    $args['type'] ?? null, 
    $args['id'],      
]);

// Ellenőrizzük, hogy történt-e valódi frissítés
if ($result && $db->affectedRows() > 0) {
    Util::setResponse(['success' => true, 'message' => 'Kisállat adatai sikeresen frissítve!']);
} else {
    Util::setError("Hiba történt a kisállat adatainak frissítése során, vagy a kisállat nem található!");
}

// Kapcsolat lezárása
$db = null;
