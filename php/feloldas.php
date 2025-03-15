<?php
session_start();

if (!isset($_SESSION['felhasznalonev']) || $_SESSION['felhasznalonev'] !== 'admin') {
    header('Location: bejelentkezes.php');
    exit();
}

if (isset($_GET['id'])) {
    $userId = $_GET['id'];

    $servername = "localhost";
    $username = "root";
    $password = "";
    $dbname = "szakdoga";

    $conn = new mysqli($servername, $username, $password, $dbname);

    if ($conn->connect_error) {
        die("Kapcsolódás hiba: " . $conn->connect_error);
    }

    $sql = "UPDATE felhasznalok SET letiltva = FALSE WHERE id = '$userId'";
    if ($conn->query($sql) === TRUE) {
        header("Location: felhasznalok.php");
        exit();
    } else {
        echo "Hiba történt a feloldás során: " . $conn->error;
    }

    $conn->close();
} else {
    echo "Nem adtál meg felhasználó ID-t.";
}
?>