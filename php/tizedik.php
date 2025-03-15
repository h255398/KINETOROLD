// Ha a 10. fájl értékelésénél járunk
if ($current_file == 10) {
echo '
<!DOCTYPE html>
<html lang="hu">

<head>
    <meta charset="UTF-8">
    <title>Félúton jársz</title>
    <link rel="stylesheet" href="../css2/ertekeles_fajlok.css?v=1.1">
    <style>
        /* Reszponzív és stilizált félúton jársz üzenet */
        #tovabbi-ertekeles {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            font-size: 1.2em;
            margin-top: 50px;
            text-align: center;
        }

        #tovabbi-ertekeles p {
            font-weight: bold;
            margin-bottom: 20px;
        }

        #tovabbi-ertekeles .button-container {
            display: flex;
            gap: 20px;
            justify-content: center;
        }

        #tovabbi-ertekeles .button {
            background-color: #007BFF;
            color: white;
            padding: 12px 20px;
            font-size: 1.1em;
            text-decoration: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        #tovabbi-ertekeles .button:hover {
            background-color: #0056b3;
        }
    </style>
</head>

<body>
    <header>
        <h1>Köszönöm, hogy értékelésével segíti a szakdolgozatomat</h1>
    </header>

    <div id="tovabbi-ertekeles">
        <p>A fájlok felénél jársz, tarts ki!</p>
        <div class="button-container">
            <a href="fajlok_ertekelese.php?projekt_id=' . $projekt_id . '&current_file=11" class="button">Tovább a 11.
                fájlhoz</a>
        </div>
    </div>

</body>

</html>';
exit(); // Ne folytassa a normál fájl értékelést
}