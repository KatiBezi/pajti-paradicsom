<?php
// EZ KÉSZ
declare(strict_types=1);

require_once("../../common/php/environment.php");

$args = Util::getArgs(); 

$db = new Database();

// SQL beszúrás a contact táblába
$query = $db->preparateInsert("contact", $args);
$result = $db->execute($query, array_values($args));

// Kapcsolat lezárása
$db = null;

// Beszúrás eredményének ellenőrzése
if (!$result["affectedRows"]) {
    Util::setError("Az üzenet elküldése nem sikerült!");
}

// Sikeres válasz visszaadása
Util::setResponse($result);