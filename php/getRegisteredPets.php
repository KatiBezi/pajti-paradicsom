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

$stmt = $conn->prepare("SELECT id, name, type, age, description FROM pets WHERE user_id = ?");
$stmt->bind_param("i", $_SESSION['user_id']);
$stmt->execute();
$result = $stmt->get_result();

$pets = [];
while ($row = $result->fetch_assoc()) {
    $pets[] = $row;
}

echo json_encode(['success' => true, 'pets' => $pets]);

$stmt->close();
$conn->close();
?>