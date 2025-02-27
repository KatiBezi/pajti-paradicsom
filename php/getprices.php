<?php
declare(strict_types=1);

// Include environment
require_once("../../common/php/environment.php");

// Set SQL command
$queries = [
    "prices_panzio" => "SELECT  `id`, 
                                `services` AS `name`, 
                                `price` 
                           FROM `prices`
                     INNER JOIN `services`
                             ON `services`.`id` = `prices`.`service_id`
                          WHERE `services` = 1;",
    "prices_kozmetika" => "SELECT `id`, 
                                  `services` AS `name`, 
                                  `price` 
                             FROM `prices`
                       INNER JOIN `services`
                               ON `services`.`id` = `prices`.`service_id`
                            WHERE `services` = 2;",
    "prices_fotozas" => "SELECT   `id`, 
                                  `services` AS `name`,
                                  `photo_type` AS `type`,
                                  `price` 
                             FROM `prices`
                       INNER JOIN `services`
                               ON `services`.`id` = `prices`.`service_id`
                            WHERE `services` = 3;"
];

$query =  "SELECT   `prices`.`id`,
                    `service_id`,
                    `services`.`name` AS `name`,
                    `type`,
                    `price` 
               FROM `prices`
         INNER JOIN `services`
                 ON `services`.`id` = `prices`.`service_id`;";

// Connect to MySQL server
$db = new Database();

// Execute SQL command
//foreach($queries as $k => $v) {
//    $result[$k] = $db->execute($v);
//}

$result = $db->execute($query);

// Close connection
$db = null;

// Ser response
Util::setResponse($result);