<?php
session_start();
header('Content-Type: application/json');

if (!isset($_SESSION['user_id'])) {
    echo json_encode(['success' => false, 'error' => 'Nincs bejelentkezve!']);
    exit;
}

if (!isset($_GET['id'])) {
    echo json_encode(['success' => false, 'error' => 'Hiányzó kisállat azonosító!']);
    exit;
}

$petId = $_GET['id'];

$conn = new mysqli('localhost', 'root', '', 'pajti-paradicsom');
if ($conn->connect_error) {
    echo json_encode(['success' => false, 'error' => 'Adatbázis hiba: ' . $conn->connect_error]);
    exit;
}

$stmt = $conn->prepare("DELETE FROM pets WHERE id = ? AND user_id = ?");
$stmt->bind_param("ii", $petId, $_SESSION['user_id']);

if ($stmt->execute()) {
    if ($stmt->affected_rows > 0) {
        echo json_encode(['success' => true]);
    } else {
        echo json_encode(['success' => false, 'error' => 'A kisállat nem található, vagy nem a felhasználóhoz tartozik!']);
    }
} else {
    echo json_encode(['success' => false, 'error' => 'Adatbázis hiba: ' . $stmt->error]);
}

$stmt->close();
$conn->close();
?>