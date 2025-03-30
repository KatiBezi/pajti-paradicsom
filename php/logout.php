<?php
session_start();
session_unset();
session_destroy();

// Válasz JSON formátumban
$response = array('success' => true, 'message' => 'Sikeres kijelentkezés!');
echo json_encode($response);
?>