<?php
// Adatbázis-kapcsolat létrehozása
$conn = new mysqli('localhost', 'root', '', 'pajti-paradicsom');

// Hibakezelés
if ($conn->connect_error) {
    die(json_encode(['success' => false, 'error' => 'Adatbázis kapcsolat hiba: ' . $conn->connect_error]));
}

// Adatok fogadása JSON formátumban
$data = json_decode(file_get_contents('php://input'), true);

if ($data) {
    // Felhasználónév és jelszó ellenőrzése
    $sql = "SELECT * FROM users WHERE username = ? AND password = ?"; // Jelszó ellenőrzés
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("ss", $data['username'], $data['password']);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows > 0) {
        echo json_encode(['success' => true]); // Sikeres bejelentkezés
    } else {
        echo json_encode(['success' => false, 'error' => 'Hibás felhasználónév vagy jelszó!']);
    }

    $stmt->close();
}

$conn->close();
?>