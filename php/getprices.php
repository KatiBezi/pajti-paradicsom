<?php

declare(strict_types=1);

require_once("../../common/php/environment.php");

$query =  "SELECT   `prices`.`id`,
                    `service_id`,
                    `services`.`name` AS `name`,
                    `type`,
                    `price` 
               FROM `prices`
         INNER JOIN `services`
                 ON `services`.`id` = `prices`.`service_id`;";


$db = new Database();

$result = $db->execute($query);

$db = null;

Util::setResponse($result);