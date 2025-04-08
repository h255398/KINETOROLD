<?php
session_start();
// ell. hogy admin e
if (!isset($_SESSION['felhasznalonev']) || $_SESSION['felhasznalonev'] !== 'admin') {
    // ha nem admin akkor visszadobni bejelre
    header('Location: bejelentkezes.php');
    exit();
}
if (isset($_GET['id'])) { //ell az id-t
    $userId = $_GET['id'];
    // adatb kapcs
    $servername = "localhost";
    $username = "root";
    $password = "";
    $dbname = "szakdoga";
    // adatb kapcs
    $conn = new mysqli($servername, $username, $password, $dbname);
    // kapcs. ell.
    if ($conn->connect_error) {
        die("Kapcsolódás hiba: " . $conn->connect_error);
    }
    // létezik e a felhaszn.
    $sql = "SELECT felhasznalonev FROM felhasznalok WHERE id = '$userId'";
    $result = $conn->query($sql);
    if ($result->num_rows > 0) {
        // a letiltvat atallitjuk igazra
        $updateSql = "UPDATE felhasznalok SET letiltva = TRUE WHERE id = '$userId'";
        if ($conn->query($updateSql) === TRUE) {
            // felhasznalok php oldal
            header("Location: felhasznalok.php");
            exit();
        } else {
            echo "Hiba történt a felhasználó letiltásakor: " . $conn->error;
        }
    } else {
        echo "Nincs ilyen felhasználó.";
    }
    // adatbkapcs lezárása
    $conn->close();
} else {
    echo "Nem adtál meg felhasználó ID-t.";
}
?>