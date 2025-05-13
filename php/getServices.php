<?php

declare(strict_types=1);

// Környezeti beállítások betöltése
require_once("../../common/php/environment.php");

// SQL parancs beállítása a szolgáltatások adatainak lekérdezéséhez
$query = "SELECT `id`,
                        `name`,
                        `description`,
                        `img`
                 FROM `services`;";

// Csatlakozás a MySQL szerverhez
$db = new Database();

// SQL parancs végrehajtása
$result = $db->execute($query);

// Adatbázis kapcsolat lezárása
$db = null;

// Válasz beállítása a lekérdezett eredményekkel
Util::setResponse($result);