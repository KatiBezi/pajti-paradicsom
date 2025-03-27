<?php
header('Content-Type: application/json');
require 'db_connection.php';

$user_id = $_GET['user_id'] ?? null;

if (empty($user_id)) {
    echo json_encode(['success' => false, 'error' => 'Hiányzó felhasználói azonosító']);
    exit;
}

$stmt = $pdo->prepare("SELECT username, email, phone FROM users WHERE id = ?");
$stmt->execute([$user_id]);
$user = $stmt->fetch(PDO::FETCH_ASSOC);

if ($user) {
    echo json_encode(['success' => true, 'user' => $user]);
} else {
    echo json_encode(['success' => false, 'error' => 'Felhasználó nem található']);
}