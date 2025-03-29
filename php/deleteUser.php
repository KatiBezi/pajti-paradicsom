<?php
// Adatbázis-kapcsolat létrehozása
$conn = new mysqli('localhost', 'root', '', 'pajti-paradicsom');

// Hibakezelés
if ($conn->connect_error) {
    die(json_encode(['success' => false, 'error' => 'Adatbázis kapcsolat hiba: ' . $conn->connect_error]));
}

// Adatok fogadása JSON formátumban
$data = json_decode(file_get_contents('php://input'), true);

if ($data && isset($data['user_id'])) {
    $userId = $data['user_id'];

    // Kisállatok törlése
    $deletePetsSql = "DELETE FROM pets WHERE user_id = ?";
    $deletePetsStmt = $conn->prepare($deletePetsSql);
    $deletePetsStmt->bind_param("i", $userId);

    if ($deletePetsStmt->execute()) {
        // Kisállatok sikeresen törölve, folytatjuk a felhasználó törlésével

        // Felhasználó törlése
        $deleteUserSql = "DELETE FROM users WHERE id = ?";
        $deleteUserStmt = $conn->prepare($deleteUserSql);
        $deleteUserStmt->bind_param("i", $userId);

        if ($deleteUserStmt->execute()) {
            echo json_encode(['success' => true]); // Sikeres törlés
        } else {
            echo json_encode(['success' => false, 'error' => 'Hiba történt a felhasználó törlése során: ' . $deleteUserStmt->error]);
        }

        $deleteUserStmt->close();
    } else {
        echo json_encode(['success' => false, 'error' => 'Hiba történt a kisállatok törlése során: ' . $deletePetsStmt->error]);
    }

    $deletePetsStmt->close();
} else {
    echo json_encode(['success' => false, 'error' => 'Hiányzó felhasználói azonosító.']);
}

$conn->close();
?>