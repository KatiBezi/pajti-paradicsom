<?php
declare(strict_types=1);

// Include environment
require_once("../../common/php/environment.php");

// Get data from POST request (assuming JSON format)
$data = json_decode(file_get_contents('php://input'), true);

// Check if data is valid
if (!isset($data['name']) || !isset($data['email']) || !isset($data['message'])) {
    Util::setResponse(['success' => false, 'error' => 'Hiányzó adatok.']);
    exit;
}

// Sanitize data
$name = $data['name'];
$email = $data['email'];
$message = $data['message'];
$submission_date = date('Y-m-d H:i:s'); // Aktuális időpont formázva

// Set SQL command
$query = "INSERT INTO `contact` (`name`, `email`, `message`, `submission_date`) VALUES (?, ?, ?, ?);";

// Connect to MySQL server
$db = new Database();

// Execute SQL command with prepared statement
$result = $db->execute($query, [$name, $email, $message, $submission_date]);

// Close connection
$db = null;

// Set response
if ($result) {
    Util::setResponse(['success' => true]); // Javítás: mindig adjuk vissza a success tulajdonságot
} else {
    Util::setResponse(['success' => false, 'error' => 'Hiba az adatbázisba írás során.']);
}
?>