<?php

declare(strict_types=1);

require_once("../../common/php/environment.php");

$query = "SELECT `id`,
                 `img`
            FROM `gallery`;";

$db = new Database();

$result = $db->execute($query);

// A lekérdezett eredmények tömbjének véletlenszerű sorrendbe állítása
shuffle($result);

$db = null;

Util::setResponse($result);