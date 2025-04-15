<?php
declare(strict_types=1);

require_once("../../common/php/environment.php");

$args = Util::getArgs();

$db = new Database();

// SQL lekérdezés a kisállat törlésére
$query = "DELETE FROM `pets` WHERE `id` = ? AND `user_id` = ?";

// SQL parancs végrehajtása
$result = $db->execute($query, [$args['pet_id'], $_SESSION['user_id']]);

if ($result) {
    Util::setResponse(['success' => true, 'message' => 'Kisállat sikeresen törölve!']);
} else {
    Util::setError("Hiba történt a kisállat törlése során, vagy a kisállat nem található!");
}

$db = null;

