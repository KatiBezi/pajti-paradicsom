<?php

declare(strict_types=1);

// Környezeti beállítások betöltése
require_once("../../common/php/environment.php");

// SQL parancs beállítása
$query = "SELECT `id`,
                 `img`
            FROM `gallery`;";

// Csatlakozás a MySQL szerverhez
$db = new Database();

// SQL parancs végrehajtása
$result = $db->execute($query);

// A lekérdezett eredmények tömbjének véletlenszerű sorrendbe állítása
shuffle($result);

// Kapcsolat lezárása
$db = null;

// Válasz beállítása
Util::setResponse($result);