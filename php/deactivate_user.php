<?php
session_start(); // Itt kezdődik a session, csak egyszer!

// Ellenőrizzük, hogy az admin be van-e jelentkezve
if (!isset($_SESSION['felhasznalonev']) || $_SESSION['felhasznalonev'] !== 'admin') {
    // Ha nem admin van bejelentkezve, átirányítjuk a bejelentkezési oldalra
    header('Location: bejelentkezes.php');
    exit();
}

if (isset($_GET['id'])) {
    $userId = $_GET['id'];

    // Adatbázis kapcsolat beállítása
    $servername = "localhost";
    $username = "root"; // XAMPP alapértelmezett felhasználó
    $password = ""; // XAMPP alapértelmezett jelszó
    $dbname = "szakdoga";

    // Adatbázis kapcsolódás létrehozása
    $conn = new mysqli($servername, $username, $password, $dbname);

    // Kapcsolódás ellenőrzése
    if ($conn->connect_error) {
        die("Kapcsolódás hiba: " . $conn->connect_error);
    }

    // Ellenőrizzük, hogy létezik-e a felhasználó
    $sql = "SELECT felhasznalonev FROM felhasznalok WHERE id = '$userId'";
    $result = $conn->query($sql);
    if ($result->num_rows > 0) {
        // Frissítjük a letiltva mezőt TRUE értékre
        $updateSql = "UPDATE felhasznalok SET letiltva = TRUE WHERE id = '$userId'";
        if ($conn->query($updateSql) === TRUE) {
            // Sikeres frissítés után visszairányítás
            header("Location: felhasznalok.php");
            exit();
        } else {
            echo "Hiba történt a felhasználó letiltásakor: " . $conn->error;
        }
    } else {
        echo "Nincs ilyen felhasználó.";
    }

    // Adatbázis kapcsolat lezárása
    $conn->close();
} else {
    echo "Nem adtál meg felhasználó ID-t.";
}
?>