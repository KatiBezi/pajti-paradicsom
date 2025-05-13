<?php

declare(strict_types=1);

require_once("../../common/php/environment.php");

$args = Util::getArgs();

$db = new Database();

// SQL lekérdezés a kisállat törlésére az ID alapján
$query = "DELETE FROM `pets`
                 WHERE `id` = ?";

// SQL parancs végrehajtása a megadott kisállat ID-val
$result = $db->execute($query, [$args['pet_id'],]);

// Ellenőrizzük, hogy a törlés sikeres volt-e
if ($result) {
    Util::setResponse(['success' => true, 'message' => 'Kisállat sikeresen törölve!']);
} else {
    Util::setError("Hiba történt a kisállat törlése során, vagy a kisállat nem található!");
}

$db = null;