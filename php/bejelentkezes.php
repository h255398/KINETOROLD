<!DOCTYPE html>
<html lang="hu">

<head>
    <!-- Az oldal karakterkészletének és meta adatok beállítása -->
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Az oldal címe, ami a böngésző fülön jelenik meg -->
    <title>Bejelentkezés - Projektértékelő</title>
    <!-- Külső CSS fájlok csatolása -->
    <link rel="stylesheet" href="../css2/kezdolap.css?v=1.2">
    <link rel="stylesheet" href="../css2/reg.css?v=1.1">
</head>

<body>

    <header>
        <!-- Oldal főcím (fejléc) és autentikációs linkek (pl. regisztráció, bejelentkezés) -->
        <h1>Projektértékelő</h1>
        <div class="auth-links">
            <!-- Navigációs linkek a regisztráció és bejelentkezés oldalra -->
            <a href="regisztracio.php">Regisztráció</a>
            <a href="bejelentkezes.php">Bejelentkezés</a>
        </div>
    </header>

    <!-- Navigációs menü, ami más oldalakra mutató linkeket tartalmaz -->
    <nav>
        <ul>
            <li><a href="../html/kezdolap.html">Kezdőlap</a></li>
            <li><a href="projektek.php">Projektek</a></li>
        </ul>
    </nav>

    <!-- A bejelentkezési űrlap fő tartalma, ami középre igazított dobozban jelenik meg -->
    <div class="content">
        <div class="form-container">
            <h2>Bejelentkezés</h2>
            <!-- A bejelentkezési űrlap, amely a POST metódust használja az adatok küldésére -->
            <form action="" method="post">
                <!-- Felhasználónév beviteli mező -->
                <label for="username">Felhasználónév:</label>
                <input type="text" id="username" name="username" required>

                <!-- Jelszó beviteli mező -->
                <label for="password">Jelszó:</label>
                <input type="password" id="password" name="password" required>

                <!-- Bejelentkezési gomb -->
                <input type="submit" value="Bejelentkezem">
            </form>
        </div>
    </div>

    <!-- PHP kód a bejelentkezési folyamat kezelésére -->
    <?php
    // Ellenőrizzük, hogy a kérés POST metódussal történt-e
    if ($_SERVER["REQUEST_METHOD"] == "POST") {
        // Adatbázis kapcsolat beállításai
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

        // Felhasználónév és jelszó bevitel az adatbázisból
        $felhasznalonev = $conn->real_escape_string($_POST['username']);
        $jelszo = $_POST['password'];

        // SQL lekérdezés a felhasználó és a jelszó ellenőrzésére
        $sql = "SELECT id, jelszo, admin, letiltva FROM felhasznalok WHERE felhasznalonev = '$felhasznalonev'";
        $result = $conn->query($sql);

        // Ha van találat a felhasználónévre
        if ($result->num_rows > 0) {
            $row = $result->fetch_assoc();

            // Ellenőrizzük, hogy a felhasználó le van-e tiltva
            if ($row['letiltva'] == 1) {
                // Ha le van tiltva, üzenet megjelenítése
                echo "<script>alert('Sajnáljuk, de a felhasználód le van tiltva. Nem tudsz bejelentkezni.');</script>";
            } else {
                // Ellenőrizzük a jelszót a titkosított formában tárolt értékkel
                if (password_verify($jelszo, $row['jelszo'])) {
                    // Sikeres bejelentkezés esetén session indítása
                    session_start();
                    $_SESSION['felhasznalo_id'] = $row['id']; // Felhasználó azonosítójának tárolása a session-ben
                    $_SESSION['felhasznalonev'] = $felhasznalonev; // Felhasználónév tárolása a session-ben
    
                    // Admin felhasználó esetén átirányítás admin oldalra
                    if ($felhasznalonev == 'admin' && $jelszo == 'admin') {
                        echo "<script>alert('Sikeres bejelentkezés admin felhasználóként!');</script>";
                        echo "<script>window.location.href = 'osszesprojekt.php';</script>";
                        exit();
                    } else {
                        // Normál felhasználó esetén átirányítás a projektek oldalára
                        echo "<script>alert('Sikeres bejelentkezés!');</script>";
                        echo "<script>window.location.href = 'projektjeim.php';</script>";
                        exit();
                    }
                } else {
                    // Hibás jelszó esetén üzenet megjelenítése
                    echo "<script>alert('Hibás jelszó.');</script>";
                }
            }
        } else {
            // Ha nincs ilyen felhasználónév az adatbázisban
            echo "<script>alert('Nincs ilyen felhasználó.');</script>";
        }

        // Adatbázis kapcsolat bezárása
        $conn->close();
    }
    ?>

</body>

</html>