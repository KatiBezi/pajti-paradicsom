<?php
declare(strict_types=1);

require_once("../../common/php/environment.php");

// Kérés adatainak lekérése
$data = Util::getArgs();

// Alternatív mezőnevek kezelése
$services_id = $data['services_id'] ?? $data['serviceId'] ?? $data['subServiceId'] ?? null;
$animal_id = $data['animal_id'] ?? $data['petId'] ?? null;
$date = $data['date'] ?? $data['appointmentDate'] ?? null;
$time = $data['time'] ?? $data['appointmentTime'] ?? null;

// Kötelező mezők ellenőrzése
if (!$services_id) Util::setError("Hiányzó szolgáltatás azonosító!");
if (!$animal_id) Util::setError("Hiányzó állat azonosító!");
if (!$date) Util::setError("Hiányzó dátum!");
if (!$time) Util::setError("Hiányzó időpont!");


// Adatbázis kapcsolat
$db = new Database();

// Időpont foglaltság ellenőrzése
$checkQuery = "SELECT id FROM schedule 
               WHERE date = ? 
               AND time = ? 
               AND services_id = ?";
               
$checkParams = [$date, $time, $services_id];
$existingAppointment = $db->execute($checkQuery, $checkParams);

if (!empty($existingAppointment)) {
    Util::setError("Ez az időpont már foglalt. Kérjük válassz másik időpontot!");
}

// Komment kezelése (ha NULL nem engedélyezett)
$comments = isset($data['comments']) && $data['comments'] !== null ? $data['comments'] : '';

// Új időpont rögzítése
$insertQuery = "INSERT INTO schedule 
                (date, time, animal_id, services_id, comments) 
                VALUES (?, ?, ?, ?, ?)";

$insertParams = [
    $date,
    $time,
    $animal_id,
    $services_id,
    $comments
];

$result = $db->execute($insertQuery, $insertParams);

if ($result === false) {
    Util::setError("Hiba történt az időpont foglalása során!");
}
$appointmentId = $db->execute("SELECT LAST_INSERT_ID() as id")[0]['id'];

$response = [
    'success' => true,
    'message' => 'Sikeres időpontfoglalás!',
    'appointmentId' => $appointmentId,
    'date' => $date,
    'time' => $time
];

$db = null;
Util::setResponse($response);
?>