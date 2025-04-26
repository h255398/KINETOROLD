<?php
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "szakdoga";

// kapcsolódás az adatbázishoz
$conn = new mysqli($servername, $username, $password, $dbname);

// ellenőrizzük, hogy a kapcsolat sikerült-e
if ($conn->connect_error) {
    die("Kapcsolódás hiba: " . $conn->connect_error);
}
?>
