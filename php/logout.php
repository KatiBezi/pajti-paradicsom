<?php
declare(strict_types=1);

// Környezeti beállítások betöltése
require_once("../../common/php/environment.php");

// Session indítása
session_start();

// Ellenőrizzük, hogy a felhasználó be van-e jelentkezve
if (isset($_SESSION['user_id'])) {
    // Session változók törlése
    unset($_SESSION['user_id']);
    unset($_SESSION['username']);
    
    // Session törlése
    session_destroy();

    // Válasz beállítása
    Util::setResponse(['success' => true, 'message' => 'Sikeres kijelentkezés!']);
} else {
    // Ha a felhasználó nincs bejelentkezve
    Util::setError("Nincs bejelentkezve felhasználó!");
}

