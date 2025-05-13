<?php

declare(strict_types=1);

require_once("../../common/php/environment.php");

$args = Util::getArgs();

// SQL lekérdezés: kisállatok és jövőbeli időpontjaik lekérdezése
$query = "
            SELECT
                `p`.`id` AS `pet_id`,
                `p`.`name`,
                `p`.`type`,
                `p`.`age`,
                `p`.`description`,
                `s`.`id` AS `schedule_id`,
                `s`.`date`,
                `s`.`time`
            FROM
                `pets` AS `p`
            LEFT JOIN
                `schedule` AS `s`
                ON `p`.`id` = `s`.`animal_id`
                AND (
                    `s`.`date` > CURRENT_DATE()
                    OR (`s`.`date` = CURRENT_DATE() AND `s`.`time` > CURRENT_TIME())
                )
            WHERE
                `p`.`user_id` = :user_id
            ORDER BY
                `p`.`id`,
                `s`.`date`,
                `s`.`time`;
            ";

$db = new Database();

$result = $db->execute($query, $args);

$db = null;

// Hibaellenőrzés: ha a lekérdezés sikertelen volt
if (is_null($result)) {
    Util::setError("Hiba történt a kisállatok adatainak lekérésekor.");
}

// Változók inicializálása a kisállatok és időpontjaik összegyűjtéséhez
$petsWithSchedule = [];
$currentPetId = null;
$currentPet = null;

// A lekérdezett sorokat sorban feldolgozzuk
foreach ($result as $row) {
    // Új kisállat kezdődik, ha az ID változik
    if ($row['pet_id'] !== $currentPetId) {
        // Előző kisállat hozzáadása a tömbhöz, ha van
        if ($currentPet !== null) {
            $petsWithSchedule[] = $currentPet;
        }
        // Új kisállat adatainak rögzítése
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
    
    // Ha van időpontja a kisállatnak, akkor azt hozzáadjuk
    if ($row['schedule_id'] !== null) {
        $currentPet['appointments'][] = [
            'date' => $row['date'],
            'time' => $row['time']
        ];
    }
}

// Az utolsó kisállat hozzáadása a listához
if ($currentPet !== null) {
    $petsWithSchedule[] = $currentPet;
}

// Válasz visszaküldése JSON formátumban
Util::setResponse($petsWithSchedule);
