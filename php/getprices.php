<?php
declare(strict_types=1);

// Include environment
require_once("../../common/php/environment.php");

// Set SQL command
$queries = [
    "prices_panzio" => "SELECT `id`, `services` AS `name`, `price` FROM `prices_panzio`;",
    "prices_kozmetika" => "SELECT `id`, `services` AS `name`, `price` FROM `prices_kozmetika`;",
    "prices_fotozas" => "SELECT `id`, `photo_type` AS `name`, `pictures`, `price` FROM `prices_fotozas`;"
];

// Connect to MySQL server
$db = new Database();

// Execute SQL command
foreach($queries as $k => $v) {
    $result[$k] = $db->execute($v);
}

// Close connection
$db = null;

// Ser response
Util::setResponse($result);