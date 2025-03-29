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
    $sql = "SELECT id, username FROM users WHERE username = ? AND password = ?"; // Jelszó ellenőrzés
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("ss", $data['username'], $data['password']);
    $stmt->execute();
    $result = $stmt->get_result();

 
if ($result->num_rows > 0) {
    $user = $result->fetch_assoc();

    // Session indítása
    session_start();

    // Session változók beállítása
    $_SESSION['user_id'] = $user['id'];
    $_SESSION['username'] = $user['username'];

    // Ide kell beilleszteni a kódrészletet
    $response = array('success' => true, 'user_id' => $user['id']);

    echo json_encode($response); // Sikeres bejelentkezés
} else {
    echo json_encode(['success' => false, 'error' => 'Hibás felhasználónév vagy jelszó!']);
}

    $stmt->close();
}

$conn->close();
?>