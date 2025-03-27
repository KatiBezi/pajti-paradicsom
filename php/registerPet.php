<?php
header('Content-Type: application/json'); // JSON válasz
require 'db_connection.php'; // Adatbázis kapcsolat

// Adatok fogadása
$data = json_decode(file_get_contents('php://input'), true);

// Validáció
if (empty($data['user_id']) || empty($data['name']) || empty($data['type']) || empty($data['age'])) {
    echo json_encode(['success' => false, 'message' => 'Hiányzó adatok']);
    exit;
}

// Adatok kinyerése
$user_id = $data['user_id'];
$name = $data['name'];
$type = $data['type'];
$age = $data['age'];
$description = $data['description'] ?? null; // Opcionális mező

// SQL lekérdezés előkészítése
$stmt = $pdo->prepare("INSERT INTO pets (user_id, name, type, age, description) VALUES (?, ?, ?, ?, ?)");
$stmt->execute([$user_id, $name, $type, $age, $description]);

// Válasz
if ($stmt->rowCount() > 0) {
    echo json_encode(['success' => true, 'message' => 'Kisállat sikeresen regisztrálva']);
} else {
    echo json_encode(['success' => false, 'message' => 'Sikertelen regisztráció']);
}