<?php
//Ez KÉSZ
declare(strict_types=1);

require_once("../../common/php/environment.php");

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


$db = new Database();

$result = $db->execute($query);

$db = null;

Util::setResponse($result);