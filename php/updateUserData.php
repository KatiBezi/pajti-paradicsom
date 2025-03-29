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

$input = file_get_contents("php://input");
$data = json_decode($input);

if ($data === null && json_last_error() !== JSON_ERROR_NONE) {
    echo json_encode(['success' => false, 'error' => 'Hibás JSON formátum: ' . json_last_error_msg()]);
    exit;
}

if (!isset($data->username) || !isset($data->email) || !isset($data->phone)) {
    echo json_encode(['success' => false, 'error' => 'Hiányzó adatok!']);
    exit;
}

$stmt = $conn->prepare("UPDATE users SET username = ?, email = ?, phone = ? WHERE id = ?");
if (!$stmt) {
    echo json_encode(['success' => false, 'error' => 'Előkészítési hiba: ' . $conn->error]);
    exit;
}

$stmt->bind_param("sssi", $data->username, $data->email, $data->phone, $_SESSION['user_id']);

if ($stmt->execute()) {
    if ($stmt->affected_rows > 0) {
        echo json_encode(['success' => true]);
    } else {
        echo json_encode(['success' => false, 'error' => 'Nincs frissíthető adat!']);
    }

} else {
    echo json_encode(['success' => false, 'error' => 'Végrehajtási hiba: ' . $stmt->error]);
}

$stmt->close();
$conn->close();
?>