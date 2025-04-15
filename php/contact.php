<?php
declare(strict_types=1);

// Környezeti beállítások betöltése
require_once("../../common/php/environment.php");

// Session indítása
session_start();

// Ellenőrizzük, hogy a felhasználó be van-e jelentkezve (opcionális, ha szükséges)
if (!isset($_SESSION['user_id'])) {
    Util::setError("Kérjük, jelentkezzen be a fiókjába a kapcsolatfelvételi űrlap elküldéséhez!");
    exit; // Kilépés
}

// Ellenőrizzük, hogy a kérés POST módszerrel érkezett-e
if ($_SERVER["REQUEST_METHOD"] === "POST") {
    // Beviteli értékek lekérése és tisztítása
    $name = isset($_POST['name']) ? trim($_POST['name']) : '';
    $email = isset($_POST['email']) ? trim($_POST['email']) : '';
    $message = isset($_POST['message']) ? trim($_POST['message']) : '';

    // Ellenőrzés: minden mező kitöltése kötelező
    if (empty($name) || empty($email) || empty($message)) {
        Util::setError("Minden mezőt ki kell tölteni.");
        exit;
    }

    // Ellenőrzés: érvényes email formátum
    if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
        Util::setError("Érvénytelen email cím formátum.");
        exit;
    }

    // Adatbázis kapcsolat létrehozása
    $db = new Database();

    // SQL parancs előkészítése
    $query = "INSERT INTO `contact` (`name`, `email`, `message`) VALUES (?, ?, ?)";
    
    // SQL parancs végrehajtása
    $result = $db->execute($query, [$name, $email, $message]);

    // Ellenőrizzük, hogy a beszúrás sikeres volt-e
    if ($result) {
        Util::setResponse(['success' => true, 'message' => 'Az üzenet sikeresen elküldve!']);
    } else {
        Util::setError("Hiba történt az üzenet elküldése során!");
    }

    // Kapcsolat lezárása
    $db = null;
} else {
    Util::setError("Érvénytelen kérés módszer.");
}
?>
