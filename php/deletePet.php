<?php
declare(strict_types=1);

// Környezeti beállítások betöltése
require_once("../../common/php/environment.php");

// Session indítása
session_start();

// Ellenőrizzük, hogy a felhasználó be van-e jelentkezve
if (!isset($_SESSION['user_id'])) {
    Util::setError("Kérjük, jelentkezzen be a kisállat törléséhez!");
    exit; // Kilépés
}

// Beérkező adatok lekérése JSON formátumban
$args = Util::getArgs();

// Ellenőrizzük, hogy a pet_id meg van-e adva
if (empty($args['pet_id'])) {
    Util::setError("Kérjük, adja meg a törölni kívánt kisállat azonosítóját!");
    exit; // Kilépés
}

// Adatbázis kapcsolat létrehozása
$db = new Database();

// SQL lekérdezés a kisállat törlésére
$query = "DELETE FROM `pets` WHERE `id` = ? AND `user_id` = ?";

// SQL parancs végrehajtása
$result = $db->execute($query, [$args['pet_id'], $_SESSION['user_id']]);

// Ellenőrizzük, hogy a törlés sikeres volt-e
if ($result) {
    // Válasz beállítása
    Util::setResponse(['success' => true, 'message' => 'Kisállat sikeresen törölve!']);
} else {
    Util::setError("Hiba történt a kisállat törlése során, vagy a kisállat nem található!");
}

// Kapcsolat lezárása
$db = null;
?>
