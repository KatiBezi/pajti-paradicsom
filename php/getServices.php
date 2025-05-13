<?php

declare(strict_types=1);

require_once("../../common/php/environment.php");

$query = "SELECT `id`,
                        `name`,
                        `description`,
                        `img`
                 FROM `services`;";

$db = new Database();

$result = $db->execute($query);

$db = null;

Util::setResponse($result);