<?php
declare(strict_types=1);

// Include environment
require_once("../../common/php/environment.php");

// Get arguments
$args = Util::getArgs();

// Set SQL command
$query ="SELECT id, name, type, age, description FROM pets WHERE user_id = :user_id";

// Connect to MySQL server
$db = new Database();

// Execute SQL command
$result = $db->execute($query, $args);

// Close connection
$db = null;

// Check result
if (is_null($result))
	Util::setError("A kisállat nem létezik!");

// Ser response
Util::setResponse($result);