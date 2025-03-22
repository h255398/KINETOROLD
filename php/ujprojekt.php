<?php
session_start(); // Session indítása a fájl elején

// Ellenőrzés, hogy a felhasználó be van-e jelentkezve
if (!isset($_SESSION['felhasznalonev'])) {
    header("Location: bejelentkezes.php");
    exit();
}
?>

<!DOCTYPE html>
<html lang="hu">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Új Projekt - Projektértékelő</title>
    <link rel="stylesheet" href="../css2/kezdolap.css?v=1.1">
    <link rel="stylesheet" href="../css2/reg.css?v=1.1">
    <link rel="stylesheet" href="../css2/ujprojekt.css?v=1.1">
    <style>

    </style>
    <script>
        function addQuestion() {
            const questionContainer = document.createElement('div');
            questionContainer.classList.add('question-container');

            const index = document.querySelectorAll('.question-container').length;

            questionContainer.innerHTML = `
            <label for="question">Kérdés:</label>
            <input type="text" name="questions[${index}][kerdes]" required>
            
            <label for="type">Típus:</label>
            <select name="questions[${index}][valasz_tipus]" required onchange="toggleRequiredField(this)">
                <option value="int">Szám</option>
                <option value="enum">Választásos</option>
                <option value="text">Szöveg</option>
            </select>

            <div class="enum-options" style="display: none;">
                <label for="options">Választék (választásos esetén):</label>
                <input type="text" name="questions[${index}][lehetseges_valaszok]" placeholder="Példa: Igen, Nem">
            </div>

            <label for="required">Kötelező?</label>
            <input type="checkbox" name="questions[${index}][required]" onchange="toggleRequiredField(this)">
            
            <button type="button" class="remove-question" onclick="removeQuestion(this)">Eltávolítás</button>
        `;

            // A típus változása esetén kezeljük a megfelelő mezőt
            questionContainer.querySelector('select[name="questions[' + index + '][valasz_tipus]"]').addEventListener('change', function () {
                const enumOptions = questionContainer.querySelector('.enum-options');
                enumOptions.style.display = this.value === 'enum' ? 'block' : 'none';
            });

            document.getElementById('questions').appendChild(questionContainer);
        }

        function removeQuestion(button) {
            button.parentElement.remove();
        }

        function toggleRequiredField(checkbox) {
            const questionContainer = checkbox.closest('.question-container');
            const requiredCheckbox = questionContainer.querySelector('input[name$="[required]"]');

            if (checkbox.type === 'checkbox') {
                const textField = questionContainer.querySelector('input[type="text"]');
                textField.required = requiredCheckbox.checked;
            }
        }
    </script>


</head>

<body>

    <header>
        <h1>Projektértékelő</h1>
        <div class="auth-links">
            <a href="../html/kezdolap.html">Kijelentkezés</a>
        </div>
    </header>

    <nav>
        <ul>
            <li><a href="projektjeim.php">Projektjeim</a></li>
            <li><a href="ujprojekt.php">Új projekt</a></li>
        </ul>
    </nav>

    <div class="content">
        <div class="form-container">
            <h2>Új Projekt Létrehozása</h2>
            <form action="ujprojekt.php" method="post" enctype="multipart/form-data">
                <label for="project_name">Projekt neve:</label>
                <input type="text" id="project_name" name="project_name" required>

                <label for="cover_image">Főkép:</label>
                <input type="file" id="cover_image" name="cover_image" accept="image/*" required>

                <!-- Új mező videók feltöltéséhez -->
                <label for="files">Feltöltendő fájlok (Kép vagy Videó):</label>
                <input type="file" id="files" name="files[]" multiple accept="image/*,video/*">

                <label for="project_description">Leírás:</label>
                <textarea id="project_description" name="project_description"></textarea>

                <label for="kitoltesi_cel">Kitöltési cél:</label>
                <input type="number" id="kitoltesi_cel" class="small-input" name="kitoltesi_cel" value="200" required>

                <h3>Kérdések hozzáadása:</h3>
                <div id="questions"></div>
                <button type="button" onclick="addQuestion()">Új kérdés hozzáadása</button>

                <input type="submit" value="Projekt létrehozása">
            </form>

            <?php
            // Kapcsolódás az adatbázishoz
            $servername = "localhost";
            $username = "root";
            $password = "";
            $dbname = "szakdoga";

            // Kapcsolódás az adatbázishoz
            $conn = new mysqli($servername, $username, $password, $dbname);
            if ($conn->connect_error) {
                die("Kapcsolódás hiba: " . $conn->connect_error);
            }
            // Ha POST kérés érkezik
            if ($_SERVER["REQUEST_METHOD"] == "POST") {
                // Projekt adatok
                $projectName = $conn->real_escape_string($_POST['project_name']);
                $projectDescription = $conn->real_escape_string($_POST['project_description']);
                $kitoltesiCel = (int) $_POST['kitoltesi_cel'];

                // Feltöltésre kerülő fájlok kezelése
                $coverImageName = $_FILES['cover_image']['name'];
                $coverImageTmpName = $_FILES['cover_image']['tmp_name'];
                $coverImageTarget = "C:/xampp/htdocs/szakdolgozat31/feltoltesek/" . basename($coverImageName);
                // Ellenőrizzük, hogy a fájl ténylegesen létezik-e
                if (!file_exists($coverImageTmpName)) {
                    die("Hiba: A feltöltött borítókép nem létezik!");
                }

                // Próbáljuk meg átmásolni a borítóképet a feltoltesek mappába
                if (move_uploaded_file($coverImageTmpName, $coverImageTarget)) {
                    echo "A borítókép sikeresen feltöltve!";
                } else {
                    die("Hiba a borítókép feltöltésekor!");
                }

                // Fájlok kezelése (képek és videók)
                $uploadedFiles = [];
                foreach ($_FILES['files']['name'] as $index => $fileName) {
                    $fileTmpName = $_FILES['files']['tmp_name'][$index];
                    $fileType = (strpos($_FILES['files']['type'][$index], 'image') !== false) ? 'kep' : 'video';
                    $targetDir = "C:/xampp/htdocs/szakdolgozat31/feltoltesek/";
                    $fileTarget = $targetDir . basename($fileName);

                    if (move_uploaded_file($fileTmpName, $fileTarget)) {
                        $uploadedFiles[] = ['fileName' => $fileName, 'type' => $fileType];
                    } else {
                        echo "Hiba a fájl feltöltésekor: " . $fileName;
                    }
                }

                // Projekt adatainak mentése
                $felhasznalonev = $_SESSION['felhasznalonev'];
                $sqlUser = "SELECT id FROM felhasznalok WHERE felhasznalonev = '$felhasznalonev'";
                $resultUser = $conn->query($sqlUser);
                $rowUser = $resultUser->fetch_assoc();
                $userId = $rowUser['id'];

                // Projekt adatainak mentése a projektek táblába
                $sqlProject = "INSERT INTO projektek (felhasznalok_id, nev, leiras, fokep, kitoltesi_cel) 
                   VALUES ('$userId', '$projectName', '$projectDescription', '$coverImageName', '$kitoltesiCel')";






                if ($conn->query($sqlProject) === TRUE) {
                    // Projekt sikeresen létrehozva, most a fájlokat mentjük el a 'fajlok' táblába
                    $projectId = $conn->insert_id;  // Az éppen létrehozott projekt ID-ja
            
                    //kerdesek mentese
                    if (!empty($_POST['questions'])) {
                        foreach ($_POST['questions'] as $question) {
                            $kerdes = $conn->real_escape_string($question['kerdes']);
                            $valaszTipus = $conn->real_escape_string($question['valasz_tipus']);
                            $lehetsegesValaszok = isset($question['lehetseges_valaszok']) ? $conn->real_escape_string($question['lehetseges_valaszok']) : NULL;
                            $required = isset($question['required']) ? 1 : 0; // Kötelező kérdés
            
                            $sqlQuestion = "INSERT INTO kerdesek (projekt_id, kerdes, valasz_tipus, lehetseges_valaszok, required) 
                        VALUES ('$projectId', '$kerdes', '$valaszTipus', '$lehetsegesValaszok', '$required')";
                            $conn->query($sqlQuestion);
                        }
                    }
                    //fajlok
                    foreach ($uploadedFiles as $file) {
                        $fileName = $file['fileName'];
                        $fileType = $file['type'];
                        $sqlFile = "INSERT INTO fajlok (projekt_id, fajl_nev, tipus) 
                        VALUES ('$projectId', '$fileName', '$fileType')";
                        $conn->query($sqlFile);
                    }

                    // Sikeres projekt létrehozása
                    echo "<script>alert('Sikeres projekt létrehozás!');</script>";
                    echo "<script>window.location.href = 'projektjeim.php';</script>";
                    exit();
                } else {
                    echo "Hiba történt a projekt létrehozásakor: " . $conn->error;
                }
            }
            ?>
        </div>
    </div>

</body>

</html>