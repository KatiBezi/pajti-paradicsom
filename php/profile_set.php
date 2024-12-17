<?php
declare(strict_types=1);

// Include environment
require_once("./environment.php");

// Get arguments
$args = Util::getArgs();

// Connect to MySQL server
$db = new Database();

// Set SQL command
$query  = $db->preparateUpdate("users", $args, "id");
$query .= "WHERE `id` = :id;";

// Check image exist
if (isset($args['img']) && $args['img']) {

	// Decode image
	$args['img'] = Util::base64Decode($args['img']);
}

// Execute SQL command
$result = $db->execute($query, $args);

// Close connection
$db = null;

// Ser response
Util::setResponse($result);