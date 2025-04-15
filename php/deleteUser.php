<?php
declare(strict_types=1);

// Környezeti beállítások betöltése
require_once("../../common/php/environment.php");

// Session indítása
session_start();

// Ellenőrizzük, hogy a felhasználó be van-e jelentkezve
if (!isset($_SESSION['user_id'])) {
    Util::setError("Kérjük, jelentkezzen be a fiókja törléséhez!");
    exit; // Kilépés
}

// Adatbázis kapcsolat létrehozása
$db = new Database();

// SQL lekérdezés a felhasználó törlésére
$query = "DELETE FROM `users` WHERE `id` = ?";

// SQL parancs végrehajtása
$result = $db->execute($query, [$_SESSION['user_id']]);

// Ellenőrizzük, hogy a törlés sikeres volt-e
if ($result) {
    // Session változók törlése
    session_destroy();
    // Válasz beállítása
    Util::setResponse(['success' => true, 'message' => 'Felhasználói fiók sikeresen törölve!']);
} else {
    Util::setError("Hiba történt a felhasználói fiók törlése során!");
}

// Kapcsolat lezárása
$db = null;

