<?php
declare(strict_types=1);

// Include environment
require_once("../../common/php/environment.php");

// Set SQL command
$queries = [
    "prices_panzio" => "SELECT `id`, `services` AS `name`, `price` FROM `panzio`;",
    "prices_kozmetika" => "SELECT `id`, `services` AS `name`, `price` FROM `kozmetika`;",
    "prices_fotozas" => "SELECT `id`, `photo_type` AS `name`, `pictures`, `price` FROM `fotozas`;"
];

// Connect to MySQL server
$db = new Database();

// Execute SQL command
$result = $db->execute($query);

// Close connection
$db = null;

// Ser response
Util::setResponse($result);


$queries = [
    
];
