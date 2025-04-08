<?php
$dumpFile = __DIR__ . '/adatbazis/Dump20250407.sql';
$dbName = 'szakdoga';
$user = 'root';
$pass = ''; // alapértelmezetten üres XAMPP-ben

// parancs összeállítása Windows-hoz
$command = "C:\\xampp\\mysql\\bin\\mysql.exe -u {$user} " . ($pass ? "-p{$pass} " : "") . "{$dbName} < \"{$dumpFile}\"";

// shell_exec a parancs futtatására
$output = shell_exec($command);

if ($output === null) {
    echo "✅ Az adatbázis importálása sikeres volt.";
} else {
    echo "⚠️ Hiba történt az adatbázis importálásakor:<br><pre>$output</pre>";
}

?>
