<?php
declare(strict_types=1);

require_once("../../common/php/environment.php");


$args = Util::getArgs(); 

$db = new Database();

// Időpont foglaltság ellenőrzése
$checkQuery = "SELECT `id`
               FROM `schedule`
               WHERE `date` = ? AND `time` = ?";

$existingAppointment = $db->execute($checkQuery, [
    $args['date'], 
    $args['time'] 
]);

// Ha létezik már foglalás, hibát dobunk
if (!empty($existingAppointment)) {
    Util::setError("Ez az időpont már foglalt. Kérjük válassz másik időpontot!");
}

// Beszúrás előkészítése 
$insertQuery = $db->preparateInsert('schedule', array_keys($args));  

// SQL végrehajtása 
$result = $db->execute($insertQuery, array_values($args)); 

// Sikeres beszúrás ellenőrzése
if (!$result || empty($result['affectedRows'])) {
    Util::setError("Hiba történt az időpont foglalása során!");
}

// Sikeres válasz visszaküldése
Util::setResponse($result);
