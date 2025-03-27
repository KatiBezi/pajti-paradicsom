<?php
// Adatbázis-kapcsolat létrehozása
$conn = new mysqli('localhost', 'root', '', 'pajti-paradicsom');

// Adatok fogadása JSON formátumban
$data = json_decode(file_get_contents('php://input'), true);

if ($data) { // Ellenőrizzük, hogy érkezett-e adat
    $errors = array();
    $true = true;

    // Felhasználónév ellenőrzése
    if (empty($data['username'])) {
        $true = false;
        array_push($errors, "A felhasználónév üres!");
    }

    // Telefonszám ellenőrzése
    if (empty($data['phone'])) {
        $true = false;
        array_push($errors, "A telefonszám üres!");
    }

    // Email cím ellenőrzése
    if (empty($data['email'])) {
        $true = false;
        array_push($errors, "Az email cím üres!");
    }

    // Email cím megerősítés ellenőrzése
    if (empty($data['confirmEmail'])) {
        $true = false;
        array_push($errors, "Az email cím megerősítése üres!");
    }

    // Jelszó ellenőrzése
    if (empty($data['password'])) {
        $true = false;
        array_push($errors, "A jelszó üres!");
    }

    // Jelszó megerősítés ellenőrzése
    if (empty($data['confirmPassword'])) {
        $true = false;
        array_push($errors, "A jelszó megerősítése üres!");
    }

    // Email címek egyezésének ellenőrzése
    if ($data['email'] !== $data['confirmEmail']) {
        $true = false;
        array_push($errors, "Az email címek nem egyeznek!");
    }

    // Jelszavak egyezésének ellenőrzése
    if ($data['password'] !== $data['confirmPassword']) {
        $true = false;
        array_push($errors, "A jelszavak nem egyeznek!");
    }

    if ($true) {
        // Adatbázis beszúrás
        $sql = "INSERT INTO users (username, phone, email, password) VALUES (?, ?, ?, ?)";
        $stmt = $conn->prepare($sql);
        $stmt->bind_param("ssss", $data['username'], $data['phone'], $data['email'], $data['password']);

		if ($stmt->execute()) {
			echo json_encode(['success' => true]); // Sikeres regisztráció
		} else {
			echo json_encode(['success' => false, 'error' => $stmt->error]); // Hiba
		}

        $stmt->close();
	}
}

$conn->close();
?>