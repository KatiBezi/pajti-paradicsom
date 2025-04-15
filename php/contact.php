<?php
// EZ KÉSZ
declare(strict_types=1);

require_once("../../common/php/environment.php");

$args = Util::getArgs(); 

// Alap ellenőrzés: kötelező mezők
$name = isset($args['name']) ? trim($args['name']) : '';
$email = isset($args['email']) ? trim($args['email']) : '';
$message = isset($args['message']) ? trim($args['message']) : '';

if ($name === '' || $email === '' || $message === '') {
    Util::setError("Minden mező kitöltése kötelező!");
    exit;
}

if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
    Util::setError("Érvénytelen e-mail cím.");
    exit;
}

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
Util::setResponse([
    'success' => true,
    'message' => 'Üzenet sikeresen elküldve!',
    'insertedId' => $result["lastInsertId"]
]);


