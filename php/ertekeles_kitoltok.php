<?php
session_start(); // Session indítása
?>

<!DOCTYPE html>
<html lang="hu"> <!-- A dokumentum magyar nyelvű -->

<head>
    <meta charset="UTF-8"> <!-- Az oldal karakterkódolása UTF-8 -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Reszponzív beállítások a mobil eszközökhöz -->
    <title>Értékelés - Projektértékelő</title> <!-- Az oldal címe -->
    <link rel="stylesheet" href="../css2/ertekeles_kitoltok.css?v=1.4"> <!-- Külső CSS fájl hozzáadása -->
</head>

<body>

    <header>
        <h1>Az értékelés elkezdése előtt:</h1> <!-- Fő cím -->
    </header>

    <div class="container"> <!-- A tartalom konténer -->
        <div class="instructions">Kérjük, töltse ki a kitöltés előtt az alábbiakat:</div>
        <!-- Utasítások a felhasználónak -->

        <?php
        // Ellenőrizzük, hogy a projekt_id paraméter létezik-e a GET kérésben
        $projekt_id = isset($_GET['projekt_id']) ? intval($_GET['projekt_id']) : null;  // Projekt azonosító lekérése
        
        if ($projekt_id === null) {
            echo "Nincs projekt kiválasztva."; // Ha nincs projekt kiválasztva, üzenet jelenik meg
            exit(); // Kilépés a scriptből
        }

        // Kapcsolódás az adatbázishoz
        $servername = "localhost";  // Adatbázis szerver
        $username = "root";  // Felhasználónév
        $password = "";  // Jelszó
        $dbname = "szakdoga";  // Adatbázis neve
        
        // Kapcsolat létrehozása
        $conn = new mysqli($servername, $username, $password, $dbname);
        if ($conn->connect_error) {
            die("Kapcsolódás hiba: " . $conn->connect_error);  // Ha hiba van, kilépés és hibaüzenet
        }

        // Ellenőrizzük, hogy van-e már kitolto_id a session-ben
        if (!isset($_SESSION['kitolto_id_' . $projekt_id])) {
            // Ha nincs, beszúrjuk az új kitöltőt az adatbázisba
            $insertKitolto = $conn->prepare("INSERT INTO kitoltok (projekt_id) VALUES (?)");
            $insertKitolto->bind_param("i", $projekt_id);  // Projekt id hozzárendelése
        
            if (!$insertKitolto->execute()) {
                echo "Hiba a kitoltok beszúrása során: " . $insertKitolto->error; // Hiba esetén üzenet
                exit();
            }

            // Az új kitolto_id lekérése
            $kitolto_id = $conn->insert_id;

            // Mentjük a kitolto_id-t a session-be
            $_SESSION['kitolto_id_' . $projekt_id] = $kitolto_id;

            $insertKitolto->close();
        } else {
            // Ha már létezik, a session-ből vesszük ki
            $kitolto_id = $_SESSION['kitolto_id_' . $projekt_id];
        }

        // Kérdések lekérdezése az adott projekt_id alapján
        $sqlKerdezsek = "SELECT * FROM kerdesek WHERE projekt_id = ?";  // SQL lekérdezés a kérdésekhez
        $stmt = $conn->prepare($sqlKerdezsek);
        $stmt->bind_param("i", $projekt_id);  // Projekt id hozzárendelése
        $stmt->execute();  // Lekérdezés végrehajtása
        $result = $stmt->get_result();  // Eredmény lekérése
        
        // Ellenőrizzük, hogy vannak-e kérdések
        if ($result->num_rows == 0) {
            echo '<p>Itt nincs kérdés.</p>';  // Ha nincsenek kérdések, üzenet megjelenítése
        }

        // Kérdések és válaszok megjelenítése
        echo '<form action="" method="post">';  // Form létrehozása
        
        while ($row = $result->fetch_assoc()) {  // Minden kérdés végigolvasása
            $kerdes = htmlspecialchars($row['kerdes']);  // Kérdés kinyerése
            $required = $row['required'];  // Kötelező kérdés-e (0 vagy 1)
        
            // Kérdés megjelenítése
            echo '<label>' . $kerdes;

            // Ha kötelező, adjunk hozzá egy csillagot
            if ($required == 1) {
                echo ' <span style="color: red;">*</span>';  // Csillag a kötelező kérdésekhez
            }

            echo '</label>';

            // Válasz típus ellenőrzése
            $valasz_tipus = $row['valasz_tipus'];
            if ($valasz_tipus == 'enum') {
                // Legördülő menü
                $lehetseges_valaszok = explode(',', $row['lehetseges_valaszok']);  // Lehetséges válaszok
                echo '<select name="valasz[' . $row['id'] . ']"' . ($required == 1 ? ' required' : '') . '>';
                echo '<option value="">-- Válassz --</option>';
                foreach ($lehetseges_valaszok as $valasz) {
                    echo '<option value="' . htmlspecialchars(trim($valasz)) . '">' . htmlspecialchars(trim($valasz)) . '</option>';
                }
                echo '</select>';
            } elseif ($valasz_tipus == 'text') {
                // Szöveges válasz
                echo '<input type="text" name="valasz[' . $row['id'] . ']"' . ($required == 1 ? ' required' : '') . ' placeholder="Írd be a válaszodat...">';
            } elseif ($valasz_tipus == 'int') {
                // Szám bevitel
                echo '<input type="number" name="valasz[' . $row['id'] . ']"' . ($required == 1 ? ' required' : '') . ' placeholder="Írd be a számot...">';
            } elseif ($valasz_tipus == 'string') {
                // Szöveges válasz, ami lehet hosszabb
                echo '<textarea name="valasz[' . $row['id'] . ']"' . ($required == 1 ? ' required' : '') . ' placeholder="Írd be a válaszodat..."></textarea>';
            }
        }

        // Gombok elhelyezése
        echo '<div class="button-container">';
        echo '<a class="back-button" href="projektek.php">Vissza a projektekhez</a>';  // Vissza link
        echo '<button class="continue-button" type="submit">Tovább</button>';  // Tovább gomb
        echo '</div>';

        echo '</form>';  // Form bezárása
        
        // Adatok session-be mentése a válaszokkal
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            foreach ($_POST['valasz'] as $kerdes_id => $valasz) {  // A válaszok mentése
                // Mentés session-be
                $_SESSION['valaszok_' . $projekt_id][$kerdes_id] = $valasz;
            }

            // Átirányítás a fájlok értékeléséhez
            header("Location: fajlok_ertekelese.php?projekt_id=" . $projekt_id . "&current_file=1");
            exit();  // Kilépés
        }

        // Zárjuk le a kapcsolatot
        $stmt->close();  // A kérdések lekérdezése lezárása
        $conn->close();  // Adatbázis kapcsolat lezárása
        ?>
    </div>

</body>

</html>