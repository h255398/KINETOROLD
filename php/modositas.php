<?php
session_start(); // Session indítása

// Ellenőrizzük, hogy a felhasználó be van-e jelentkezve
if (!isset($_SESSION['felhasznalonev'])) {
    header("Location: bejelentkezes.php"); // Ha nem, átirányítjuk a bejelentkezés oldalra
    exit();
}

// Adatbázis kapcsolat beállítása
$servername = "localhost"; // Adatbázis szerver
$username = "root"; // Felhasználónév
$password = ""; // Jelszó
$dbname = "szakdoga"; // Adatbázis neve

// Kapcsolódás az adatbázishoz
$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
    die("Kapcsolódás hiba: " . $conn->connect_error); // Hibaüzenet, ha nem sikerül a kapcsolat
}

// Projekt ID lekérdezése a GET paraméterből
$projektId = $_GET['id'];

// Projekt adatainak lekérdezése
$sqlProject = "SELECT * FROM projektek WHERE id = '$projektId'";
$projectResult = $conn->query($sqlProject);
$project = $projectResult->fetch_assoc();

// Médiafájlok lekérdezése
$sqlMedia = "SELECT * FROM fajlok WHERE projekt_id = '$projektId'";
$mediaResult = $conn->query($sqlMedia);

// Kérdések lekérdezése
$sqlQuestions = "SELECT * FROM kerdesek WHERE projekt_id = '$projektId'";
$questionsResult = $conn->query($sqlQuestions);

// Form kezelés POST kérés esetén
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    // Csak akkor frissítjük az adatokat, ha az új mezők nem üresek
    $nev = !empty($_POST['nev']) ? $_POST['nev'] : $project['nev']; // Projekt neve
    $leiras = !empty($_POST['leiras']) ? $_POST['leiras'] : $project['leiras']; // Projekt leírása

    // Borítókép kezelése
    if (!empty($_FILES['fokep']['name'])) {
        $fokep = $_FILES['fokep']['name']; // Borítókép neve
        move_uploaded_file($_FILES['fokep']['tmp_name'], "C:/xampp/htdocs/szakdolgozat31/feltoltesek/" . $fokep); // Fájl feltöltése
    } else {
        $fokep = $project['fokep']; // Ha nincs új kép, megtartjuk a régit
    }

    // Médiafájlok feltöltése
if (!empty($_FILES['media']['name'][0])) {
    foreach ($_FILES['media']['name'] as $key => $name) {
        $targetPath = "C:/xampp/htdocs/szakdolgozat31/feltoltesek/" . basename($name); // Célmappa
        move_uploaded_file($_FILES['media']['tmp_name'][$key], $targetPath); // Fájl feltöltése
        
        // Fájl típusának meghatározása
        $fileType = ''; // Kezdetben üres string
        if (strpos($name, '.mp4') !== false || strpos($name, '.webm') !== false) {
            $fileType = 'video';
        } elseif (strpos($name, '.jpg') !== false || strpos($name, '.png') !== false) {
            $fileType = 'kep';
        } elseif (strpos($name, '.mp3') !== false || strpos($name, '.wav') !== false) {
            $fileType = 'audio';
        } else {
            $fileType = 'other'; // Egyéb fájlok
        }

        // Új fájl mentése az adatbázisba
        $sqlFile = "INSERT INTO fajlok (fajl_nev, projekt_id, tipus) VALUES ('$name', '$projektId', '$fileType')";
        $conn->query($sqlFile); // Fájl rögzítése
    }
}

    // Meglévő médiafájlok törlése
    if (!empty($_POST['delete_files'])) {
        foreach ($_POST['delete_files'] as $fileId) {
            // Fájl nevének lekérdezése törlés előtt
            $sqlGetFileName = "SELECT fajl_nev FROM fajlok WHERE id = '$fileId'";
            $resultFileName = $conn->query($sqlGetFileName);
            $fileName = $resultFileName->fetch_assoc()['fajl_nev'];

            // Fájl törlése a feltöltések mappából
            $filePath = "C:/xampp/htdocs/szakdolgozat31/feltoltesek/" . $fileName;
            if (file_exists($filePath)) {
                unlink($filePath); // Fájl törlése
            }

            // Fájl törlése az adatbázisból
            $sqlDelete = "DELETE FROM fajlok WHERE id = '$fileId'";
            $conn->query($sqlDelete);
        }
    }
    if (!empty($_POST['new_questions'])) {
        foreach ($_POST['new_questions'] as $newQuestion) {
            if (!empty($newQuestion['kerdes'])) {
                $kerdes = $newQuestion['kerdes'];
                $tipus = $newQuestion['valasz_tipus'];
                $lehetseges_valaszok = !empty($newQuestion['lehetseges_valaszok']) ? $newQuestion['lehetseges_valaszok'] : null;
                $required = isset($newQuestion['required']) ? 1 : 0;

                $stmt = $conn->prepare("INSERT INTO kerdesek (kerdes, valasz_tipus, lehetseges_valaszok, required, projekt_id) VALUES (?, ?, ?, ?, ?)");
                $stmt->bind_param("sssii", $kerdes, $tipus, $lehetseges_valaszok, $required, $projektId);
                $stmt->execute();
                $stmt->close();
            }
        }
    }

    // Kérdések frissítése
    if (!empty($_POST['edit_questions'])) {
        foreach ($_POST['edit_questions'] as $questionId => $questionData) {
            $kerdes = $questionData['kerdes'];
            $tipus = $questionData['valasz_tipus'];
            $lehetseges_valaszok = isset($questionData['lehetseges_valaszok']) ? $questionData['lehetseges_valaszok'] : null;
            $required = isset($questionData['v']) ? 1 : 0;

            $stmt = $conn->prepare("UPDATE kerdesek SET kerdes = ?, valasz_tipus = ?, lehetseges_valaszok = ?, required = ? WHERE id = ?");
            $stmt->bind_param("ssssi", $kerdes, $tipus, $lehetseges_valaszok, $required, $questionId);
            $stmt->execute();
            $stmt->close();
        }
    }
    // Kérdés törlése előtt töröljük a kapcsolódó válaszokat
    if (!empty($_POST['delete_questions'])) {
        foreach ($_POST['delete_questions'] as $questionId) {
            // Töröljük a válaszokat a kerdesekre_valasz táblából
            $stmtDeleteAnswers = $conn->prepare("DELETE FROM kerdesekre_valasz WHERE kerdesek_id = ?");
            $stmtDeleteAnswers->bind_param("i", $questionId);
            $stmtDeleteAnswers->execute();
            
            // Most törölhetjük a kérdést
            $stmtDeleteQuestion = $conn->prepare("DELETE FROM kerdesek WHERE id = ?");
            $stmtDeleteQuestion->bind_param("i", $questionId);
            $stmtDeleteQuestion->execute();
            
            // Bezárjuk az utolsó lekérdezést
            $stmtDeleteQuestion->close();
        }
    }

    // Kérdések törlése
    if (!empty($_POST['delete_questions'])) {
        foreach ($_POST['delete_questions'] as $questionId) {
            $stmt = $conn->prepare("DELETE FROM kerdesek WHERE id = ?");
            $stmt->bind_param("i", $questionId);
            $stmt->execute();
            $stmt->close();
        }
    }

    // Projekt frissítése az adatbázisban
    $kitoltesi_cel = !empty($_POST['kitoltesi_cel']) ? $_POST['kitoltesi_cel'] : $project['kitoltesi_cel']; // Kitöltési cél

    // Projekt frissítése az adatbázisban
    $sqlUpdate = "UPDATE projektek SET nev = '$nev', leiras = '$leiras', fokep = '$fokep', kitoltesi_cel = '$kitoltesi_cel' WHERE id = '$projektId'";
    $conn->query($sqlUpdate);

    // Átirányítás a projekt részletező oldalra
    header("Location: projekt_reszletek.php?id=$projektId");
}
?>

<!DOCTYPE html>
<html lang="hu">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Projekt Módosítása</title>
    <link rel="stylesheet" href="../css2/kezdolap.css?v=1.5"> <!-- Külső CSS fájlok -->
    <link rel="stylesheet" href="../css2/modositas.css?v=1.">
    
</head>
<style>

</style>
<body>

<header>
    <h1>Projektértékelő</h1> <!-- Oldal címe -->
    <div class="auth-links">
        <a href="../html/kezdolap.html">Kijelentkezés</a> <!-- Kijelentkezés link -->
    </div>
</header>

<nav>
    <ul>
        <li><a href="projektjeim.php">Projektjeim</a></li> <!-- Link a projektek listájához -->
        <li><a href="ujprojekt.php">Új projekt</a></li> <!-- Link új projekt létrehozásához -->
    </ul>
</nav>

<div class="content">
    <div class="form-container">
        <h2>Projekt Módosítása</h2> <!-- Cím a módosító űrlaphoz -->
        <form method="POST" enctype="multipart/form-data"> <!-- űrlap megnyitása -->
            <label for="nev">Projekt neve:</label> <!-- Név mező -->
            <input type="text" id="nev" name="nev" value="<?php echo htmlspecialchars($project['nev']); ?>" required>

            <label for="leiras">Leírás:</label> <!-- Leírás mező -->
            <textarea id="leiras" name="leiras"><?php echo htmlspecialchars($project['leiras']); ?></textarea>

            <label for="fokep">Borítókép:</label> <!-- Borítókép mező -->
            <input type="file" id="fokep" name="fokep" accept="image/*"><br>
            <small>Ha nem szeretnél új képet feltölteni, csak hagyd üresen.</small><br>

            

            <label>Képek/Videók/Hangfájlok:</label> <!-- Médiafájlok feltöltése -->
            <!-- Média fájlok megjelenítése: -->
            <div class="media-preview">
                <?php 
                $mediaCount = 0; // Számláló a médiafájlok számára
                $videoCount = 0; // Videók számlálója
                $totalVideos = 0; // Összes videó száma
                
                while ($media = $mediaResult->fetch_assoc()):
                    if (strpos($media['fajl_nev'], '.mp4') !== false || strpos($media['fajl_nev'], '.webm') !== false):
                        $totalVideos++; // Összes videó számlálása
                    endif;
                endwhile;
                
                $mediaResult->data_seek(0); // Visszaállítjuk az eredményt a ciklushoz
                while ($media = $mediaResult->fetch_assoc()): 
                    if ($mediaCount < 5): // Csak az első 5 fájl megjelenítése
                        ?>
                        <div class="media-item">
                            <?php if (strpos($media['fajl_nev'], '.jpg') !== false || strpos($media['fajl_nev'], '.png') !== false): ?>
                                <!-- Kép fájl -->
                                <img src="http://localhost/szakdolgozat31/feltoltesek/<?php echo htmlspecialchars($media['fajl_nev']); ?>" alt="<?php echo htmlspecialchars($media['fajl_nev']); ?>">
 <?php elseif (strpos($media['fajl_nev'], '.mp4') !== false || strpos($media['fajl_nev'], '.webm') !== false): ?>
                                <!-- Videó fájl -->
                                <?php if ($videoCount < 3): ?>
                                    <div class="video-container">
                                    <video width="200" controls>
    <source src="http://localhost/szakdolgozat31/feltoltesek/<?php echo htmlspecialchars($media['fajl_nev']); ?>" type="video/<?php echo pathinfo($media['fajl_nev'], PATHINFO_EXTENSION); ?>">
    A böngésződ nem támogatja a videólejátszást.
</video>

                                    </div>
                                    <?php $videoCount++; ?>
                                <?php endif; ?>
                            <?php elseif (strpos($media['fajl_nev'], '.mp3') !== false || strpos($media['fajl_nev'], '.wav') !== false): ?>
                                <!-- Hang fájl -->
                                <audio controls>
                                <img src="../feltoltesek/<?php echo htmlspecialchars($media['fajl_nev']); ?>" alt="<?php echo htmlspecialchars($media['fajl_nev']); ?>">
                                A böngésződ nem támogatja a hang lejátszást.
                                </audio>
                            <?php else: ?>
                                <!-- Egyéb fájl típusok, pl. PDF, dokumentumok -->
                                <p><?php echo htmlspecialchars($media['fajl_nev']); ?></p>
                            <?php endif; ?>
                        </div>
                    <?php 
                    endif;
                    $mediaCount++;
                endwhile; 

                // Ha több mint 2 videó van, megjelenítjük a hátralévő videók számát
                if ($totalVideos > 3):
                ?>
                    <p><strong>Hátralévő videók: <?php echo $totalVideos - 3; ?></strong></p>
                <?php endif; ?>
            </div>

            <button type="button" id="show-all-media">Összes fájl megjelenítése</button> <!-- Gomb az összes fájl megjelenítésére -->
            <div id="all-media" style="display:none;">
                <h3>Összes Médiafájl:</h3>
                <?php
                // Újra lekérdezzük az összes médiafájlt, hogy megjeleníthessük
                $mediaResult->data_seek(0); // Visszaállítjuk az eredményt
                while ($media = $mediaResult->fetch_assoc()):
                ?>
                    <div class="media-item">
                        <?php if (strpos($media['fajl_nev'], '.jpg') !== false || strpos($media['fajl_nev'], '.png') !== false): ?>
                            <img src="http://localhost/szakdolgozat31/feltoltesek/<?php echo htmlspecialchars($media['fajl_nev']); ?>" alt="<?php echo htmlspecialchars($media['fajl_nev']); ?>">
 <?php else: ?>
                            <p><?php echo htmlspecialchars($media['fajl_nev']); ?></p>
                        <?php endif; ?>
                        <input type="checkbox" name="delete_files[]" value="<?php echo $media['id']; ?>"> Törlés <!-- Törlés checkbox -->
                    </div>
                <?php endwhile; ?>
            </div>

            <input type="file" name="media[]" accept="image/*,video/*,audio/*" multiple><br> <!-- Új médiafájlok feltöltése -->
            <small>Több fájl is feltölthető.</small><br> <!-- Információs szöveg -->
            <label for="kitoltesi_cel">Kitöltési cél:</label> <!-- Kitöltési cél mező -->
            <input type="text" id="kitoltesi_cel" class="small-input" name="kitoltesi_cel" value="<?php echo htmlspecialchars($project['kitoltesi_cel']); ?>" required>


            
            <h3>Kérdések Módosítása:</h3>
<div id="questions-wrapper" style="border: 2px solid #ccc; padding: 15px; border-radius: 5px;">
    <div id="questions">
        <?php while ($question = $questionsResult->fetch_assoc()): ?>
            <div class="question-container" style="border: 1px solid #ddd; padding: 10px; margin-bottom: 10px; border-radius: 5px;">
                <label for="edit_questions_<?php echo $question['id']; ?>">Kérdés:</label>
                <input type="text" class="small-input" name="edit_questions[<?php echo $question['id']; ?>][kerdes]" 
                    id="edit_questions_<?php echo $question['id']; ?>" 
                    value="<?php echo htmlspecialchars($question['kerdes']); ?>" required>

                <label for="edit_questions_<?php echo $question['id']; ?>_tipus">Típus:</label>
                <select name="edit_questions[<?php echo $question['id']; ?>][valasz_tipus]" 
                        id="edit_questions_<?php echo $question['id']; ?>_tipus" 
                        onchange="toggleEnumOptions(this)">
                    <option value="int" <?php echo ($question['valasz_tipus'] === 'int') ? 'selected' : ''; ?>>Szám</option>
                    <option value="enum" <?php echo ($question['valasz_tipus'] === 'enum') ? 'selected' : ''; ?>>Választásos</option>
                    <option value="text" <?php echo ($question['valasz_tipus'] === 'text') ? 'selected' : ''; ?>>Szöveg</option>
                </select>

                <div class="enum-options" style="display: <?php echo ($question['valasz_tipus'] === 'enum') ? 'block' : 'none'; ?>;">
                    <label for="edit_questions_<?php echo $question['id']; ?>_enum">Választék (választásos esetén):</label>
                    <input type="text" name="edit_questions[<?php echo $question['id']; ?>][lehetseges_valaszok]" 
                        id="edit_questions_<?php echo $question['id']; ?>_enum" 
                        value="<?php echo htmlspecialchars($question['lehetseges_valaszok'] ?? ''); ?>" 
                        placeholder="Példa: Igen, Nem" class="small-input">
                </div>

                <label for="edit_questions_<?php echo $question['id']; ?>_kotelezo">Kötelező?</label>
                <input type="checkbox" name="edit_questions[<?php echo $question['id']; ?>][required]" 
                    id="edit_questions_<?php echo $question['id']; ?>_kotelezo"
                    <?php echo $question['required'] ? 'checked' : ''; ?>>
                <button type="button" class="remove-button" onclick="removeQuestion(this)">Eltávolítás</button>
                <input type="hidden" name="delete_questions[]" value="<?php echo $question['id']; ?>" class="delete-flag" disabled>
            </div>
        <?php endwhile; ?>
    </div>
</div>
<button type="button" onclick="addQuestion()">Új kérdés hozzáadása</button>
<input type="submit" value="Mentés">
<input type="button" value="Vissza" class="back-button" onclick="window.location.href='projektjeim.php';">
    </div>
</div>

<script>
function addQuestion() {
    const questionsDiv = document.getElementById("questions");
    const questionContainer = document.createElement('div');
    questionContainer.classList.add('question-container');

    // Helyes referencia a stílusokhoz
    questionContainer.style.border = "1px solid #ddd";
    questionContainer.style.padding = "10px";
    questionContainer.style.marginBottom = "10px";
    questionContainer.style.borderRadius = "5px";
    
    const index = document.querySelectorAll('.question-container').length;
    
    questionContainer.innerHTML = `
        <label for="new_questions[${index}][kerdes]">Kérdés:</label>
        <input type="text" name="new_questions[${index}][kerdes]" required>
        
        <label for="new_questions[${index}][valasz_tipus]">Típus:</label>
        <select name="new_questions[${index}][valasz_tipus]" onchange="toggleEnumOptions(this)">
            <option value="int">Szám</option>
            <option value="enum">Választásos</option>
            <option value="text">Szöveg</option>
        </select>
        
        <div class="enum-options" style="display: none;">
            <label for="new_questions[${index}][lehetseges_valaszok]">Választék (enum esetén):</label>
            <input type="text" name="new_questions[${index}][lehetseges_valaszok]" placeholder="Példa: Igen, Nem">
        </div>

        <!-- Kötelező-e mező -->
        <label for="new_questions[${index}][required]">Kötelező?</label>
        <input type="checkbox" name="new_questions[${index}][required]">
        
        <button type="button" class="remove-button" onclick="removeQuestion(this)">Eltávolítás</button>
    `;
    
    // Kérdés hozzáadása a DOM-ba
    questionsDiv.appendChild(questionContainer);
}


function removeQuestion(button) {
    const container = button.closest('.question-container');
    const deleteFlag = container.querySelector('.delete-flag');
    if (deleteFlag) {
        deleteFlag.disabled = false;
        container.style.display = 'none';
    } else {
        container.remove();
    }
}

function toggleEnumOptions(select) {
    const enumOptions = select.closest('.question-container').querySelector('.enum-options');
    enumOptions.style.display = select.value === 'enum' ? 'block' : 'none';
}
// Új ablak megnyitása az összes médiafájl megjelenítéséhez
document.getElementById('show-all-media').onclick = function() {
    // Új ablakot nyitunk a médiafájlok megjelenítéséhez
    window.open('torlendok.php?id=<?php echo $projektId; ?>', 'MediaWindow', 'width=800,height=600');
};


function refreshMedia() {
    // AJAX kérés küldése
    var xhr = new XMLHttpRequest();
    xhr.open('GET', 'frissit_media.php?id=<?php echo htmlspecialchars($_GET['id']); ?>', true);
    xhr.onreadystatechange = function () {
        if (xhr.readyState == 4 && xhr.status == 200) {
            // A válasz (új HTML tartalom) frissíti a képek div-jét
            document.querySelector('.media-preview').innerHTML = xhr.responseText;
        }
    };
    xhr.send();
}
</script>

</body>
</html>
