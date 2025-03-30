<?php
session_start();
header('Content-Type: application/json');

if (!isset($_SESSION['user_id'])) {
    echo json_encode(['success' => false, 'error' => 'Nincs bejelentkezve!']);
    exit;
}

$conn = new mysqli('localhost', 'root', '', 'pajti-paradicsom');
if ($conn->connect_error) {
    echo json_encode(['success' => false, 'error' => 'Adatbázis hiba: ' . $conn->connect_error]);
    exit;
}

$stmt = $conn->prepare("SELECT username, email, phone FROM users WHERE id = ?");
$stmt->bind_param("i", $_SESSION['user_id']);
$stmt->execute();
$result = $stmt->get_result();

if ($result->num_rows > 0) {
    $user = $result->fetch_assoc();
    echo json_encode(['success' => true, 'user' => $user]);
} else {
    echo json_encode(['success' => false, 'error' => 'Felhasználó nem található!']);
}

$stmt->close();
$conn->close();
?>

