<?php
session_start();


$servername = "localhost";
$username = "root";
$password = "";
$dbname = "konferencia";

$conn = new mysqli($servername, $username, $password, $dbname);


if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}


$sql = "SELECT Szekcio.SzekcioNeve, Szekcio.KezdesIdopont AS SzekcioKezdes, 
        Eloadas.EloadasAzonosito, Eloadas.KezdesIdopont AS EloadasKezdes, 
        Cikk.CikkCim, Felhasznalo.Nev AS EloadoNev
        FROM Szekcio
        LEFT JOIN Eloadas ON Szekcio.SzekcioNeve = Eloadas.SzekcioNeve
        LEFT JOIN Cikk ON Eloadas.CikkAzonosito = Cikk.CikkAzonosito
        LEFT JOIN Felhasznalo ON Eloadas.EloadoAzonosito = Felhasznalo.Azonosito
        ORDER BY Szekcio.KezdesIdopont, Eloadas.KezdesIdopont";
$result = $conn->query($sql);

$szekciok = [];
if ($result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {

        if ($row['SzekcioNeve'] == "Alapértelmezett") {
            continue;
        }

        $szekciok[$row['SzekcioNeve']]['KezdesIdopont'] = $row['SzekcioKezdes'];
        $szekciok[$row['SzekcioNeve']]['Eloadasok'][] = [
            'KezdesIdopont' => $row['EloadasKezdes'],
            'CikkCim' => $row['CikkCim'],
            'EloadoNev' => $row['EloadoNev']
        ];
    }
}

?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Main Page</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            margin: 0;
            padding: 0;
        }
        .header {
            background-color: #007BFF;
            color: white;
            padding: 10px 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .header a {
            color: white;
            text-decoration: none;
            margin-left: 15px;
        }
        .container {
            padding: 20px;
        }
        .session {
            margin-bottom: 30px;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .session h3 {
            margin: 0;
        }
        .presentation {
            margin-top: 10px;
            padding: 10px;
            background-color: #f9f9f9;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
    </style>
</head>
<body>
<div class="header">
    <a href="main.php">
        <h1>Konferencia</h1>
    </a>
    <div>
        <?php if (!isset($_SESSION['loggedin']) || !$_SESSION['loggedin']): ?>
            <a href="register.html">Regisztráció</a>
            <a href="login.html">Bejelentkezés</a>
        <?php else: ?>

            <?php if (isset($_SESSION['role']) && $_SESSION['role'] === 'admin'): ?>
                <a href="szerkesztes.php">Szerkesztés</a>
            <?php endif; ?>

            <a href="cikkletrehozas.php">Létrehozás</a>
            <a href="logout.php">Kijelentkezés</a>
        <?php endif; ?>
    </div>
</div>


<div class="container">
    <?php foreach ($szekciok as $szekcioNeve => $data): ?>
        <div class="session">
            <h3>Szekció: <?= htmlspecialchars($szekcioNeve); ?></h3>
            <p>Kezdési idő: <?= htmlspecialchars($data['KezdesIdopont']); ?></p>
            <?php if (!empty($data['Eloadasok'])): ?>
                <?php foreach ($data['Eloadasok'] as $eloadas): ?>
                    <div class="presentation">
                        <p><strong>Cím:</strong> <?= htmlspecialchars($eloadas['CikkCim']); ?></p>
                        <p><strong>Kezdési idő:</strong> <?= htmlspecialchars($eloadas['KezdesIdopont']); ?></p>
                        <p><strong>Előadó:</strong> <?= htmlspecialchars($eloadas['EloadoNev']); ?></p>
                    </div>
                <?php endforeach; ?>
            <?php else: ?>
                <p>Nincs előadás ebben a szekcióban.</p>
            <?php endif; ?>
        </div>
    <?php endforeach; ?>
</div>
</body>
</html>
