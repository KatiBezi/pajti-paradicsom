<?php
declare(strict_types=1);

require_once("../../common/php/environment.php");

$args = Util::getArgs();

$query = "
    SELECT
        p.id AS pet_id,
        p.name,
        p.type,
        p.age,
        p.description,
        s.id AS schedule_id,
        s.date,
        s.time
    FROM
        pets p
    LEFT JOIN
        schedule s ON p.id = s.animal_id AND (s.date > CURRENT_DATE() OR (s.date = CURRENT_DATE() AND s.time > CURRENT_TIME()))
    WHERE
        p.user_id = :user_id
    ORDER BY
        p.id, s.date, s.time;
";

$db = new Database();

$result = $db->execute($query, $args);

$db = null;

if (is_null($result)) {
    Util::setError("Hiba történt a kisállatok adatainak lekérésekor.");
}

$petsWithSchedule = [];
$currentPetId = null;
$currentPet = null;

foreach ($result as $row) {
    if ($row['pet_id'] !== $currentPetId) {
        if ($currentPet !== null) {
            $petsWithSchedule[] = $currentPet;
        }
        $currentPet = [
            'id' => $row['pet_id'],
            'name' => $row['name'],
            'type' => $row['type'],
            'age' => $row['age'],
            'description' => $row['description'],
            'appointments' => []
        ];
        $currentPetId = $row['pet_id'];
    }
    
    // Csak akkor adjuk hozzá az időpontot, ha van schedule_id
    if ($row['schedule_id'] !== null) {
        $currentPet['appointments'][] = [
            'date' => $row['date'],
            'time' => $row['time']
        ];
    }
}

if ($currentPet !== null) {
    $petsWithSchedule[] = $currentPet;
}

Util::setResponse($petsWithSchedule);