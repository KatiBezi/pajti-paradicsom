<?php
declare(strict_types=1);

require_once("../../common/php/environment.php");

// Kérés adatainak lekérése
$args = Util::getArgs(); 

// Adatbázis kapcsolat
$db = new Database();

// Időpont foglaltság ellenőrzése
$checkQuery = "SELECT id
            FROM schedule
            WHERE date = ? AND
                time = ?";

$existingAppointment = $db->execute($checkQuery, [
    $args['date'], 
    $args['time'] 
]);

// Ha létezik már foglalás, hibaüzenet
if (!empty($existingAppointment)) {
    Util::setError("Ez az időpont már foglalt. Kérjük válassz másik időpontot!");
}

// Az INSERT lekérdezés előkészítése a `preparateInsert` metódussal
$insertQuery = $db->preparateInsert('schedule', array_keys($args));  

// Paraméterek: minden értéket átadunk az $args tömbből
$result = $db->execute($insertQuery, array_values($args)); 

// Ellenőrizzük, hogy történt-e sikeres beszúrás
if (!$result || empty($result["affectedRows"])) {
    Util::setError("Hiba történt az időpont foglalása során!");
}

// Sikeres válasz
Util::setResponse($result);