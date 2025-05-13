<?php

declare(strict_types=1);

require_once("../../common/php/environment.php");

$args = Util::getArgs();

$db = new Database();

$deleteUserQuery = "DELETE FROM `users`
                                WHERE `id` = ?";

$result = $db->execute($deleteUserQuery, [$args['user_id']]);

// Ellenőrizzük, hogy a törlés sikeres volt-e
if ($result) {
    Util::setResponse(['success' => true, 'message' => 'Felhasználói fiók és a hozzá tartozó kisállatok törlése sikeresen megtörtént!']);
} else {
    Util::setError("Hiba történt a felhasználói fiók törlése során, vagy a felhasználó nem található!");
}

$db = null;