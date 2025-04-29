<?php
declare(strict_types=1);

require_once("../../common/php/environment.php");

// Kérés adatainak lekérése
$data = Util::getArgs();

// Adatbázis kapcsolat
$db = new Database();

// Időpont foglaltság ellenőrzése
$checkQuery = "SELECT id 
                 FROM schedule 
                WHERE date = ? AND 
                      time = ? AND 
                      services_id = ?";
               
$existingAppointment = $db->execute($checkQuery, 
    [$data['date'], $data['time'], $data['services_id']]);

if (!is_null($existingAppointment)) {
    Util::setError("Ez az időpont már foglalt. Kérjük válassz másik időpontot!");
}

$insertQuery = $db->preparateInsert('schedule', $data);

$result = $db->execute($insertQuery, array_values($data));

$db = null;

if (!$result["affectedRows"]) {
    Util::setError("Hiba történt az időpont foglalása során!");
}


Util::setResponse($result);