<?php
// Ellenőrizzük, hogy a kérés POST módszerrel érkezett-e
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Az űrlap mezőiből származó adatok ellenőrzése és tisztítása
    // htmlspecialchars: megakadályozza a HTML kódok végrehajtását az adatokban
    // trim: eltávolítja a felesleges szóközöket a mezők elejéről és végéről
    $name = htmlspecialchars(trim($_POST['name'])); // Név
    $email = htmlspecialchars(trim($_POST['email'])); // Email cím
    $message = htmlspecialchars(trim($_POST['message'])); // Üzenet

    // Itt lehetne az üzenet küldése (pl. email) vagy adatbázisba mentés
    // Például a mail() függvény használatával:
    // $to = "recipient@example.com"; // Címzett email címe
    // $subject = "Új üzenet a kapcsolatfelvételi űrlapról"; // Tárgy
    // $headers = "From: " . $email; // Fejlécek, például a feladó email címe
    // mail($to, $subject, $message, $headers); // Az email küldése

    // Sikeres üzenetküldés üzenet
    // JavaScript alert() függvény: felugró ablakot jelenít meg a felhasználónak
    // window.location.href: átirányítja a felhasználót az index.html oldalra
    echo "<script>alert('Sikeres üzenetküldés!'); window.location.href='index.html';</script>";
} else {
    // Ha a kérés nem POST módszerrel érkezett, irányítsuk vissza az űrlapra
    header("Location: index.html"); // Átirányítás az index.html oldalra
    exit(); // Megakadályozza a további kód végrehajtását
}
?>
