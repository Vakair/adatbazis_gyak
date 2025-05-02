<?php
session_start();


$servername = "localhost";
$username = "root";
$password = "";
$dbname = "konferencia";

$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}


$szekciok_sql = "SELECT SzekcioNeve FROM Szekcio WHERE SzekcioNeve != 'Alapértelmezett'";
$szekciok_result = $conn->query($szekciok_sql);
$szekciok = [];
if ($szekciok_result->num_rows > 0) {
    while ($row = $szekciok_result->fetch_assoc()) {
        $szekciok[] = $row['SzekcioNeve'];
    }
}


$sql = "SELECT Eloadas.EloadasAzonosito, Eloadas.SzekcioNeve, Eloadas.KezdesIdopont, Eloadas.EloadasHossza, Cikk.CikkCim 
        FROM Eloadas 
        LEFT JOIN Cikk ON Eloadas.CikkAzonosito = Cikk.CikkAzonosito 
        WHERE Eloadas.SzekcioNeve = 'Alapértelmezett'";

$result = $conn->query($sql);
$eloadasok = [];
if ($result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $eloadasok[] = $row;
    }
}


if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $eloadasAzonosito = $_POST['eloadasAzonosito'];
    $szekcioNeve = $_POST['szekcioNeve'];
    $kezdesIdopont = $_POST['kezdesIdopont'];
    $eloadasHossza = $_POST['eloadasHossza'];

    $stmt = $conn->prepare("UPDATE Eloadas SET SzekcioNeve = ?, KezdesIdopont = ?, EloadasHossza = ? WHERE EloadasAzonosito = ?");
    $stmt->bind_param("ssii", $szekcioNeve, $kezdesIdopont, $eloadasHossza, $eloadasAzonosito);

    if ($stmt->execute()) {
        echo "A módosítás sikeres.";
    } else {
        echo "Hiba történt a módosítás során: " . $stmt->error;
    }

    $stmt->close();
    $conn->close();
}
?>

<!DOCTYPE html>
<html lang="hu">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Szerkesztés</title>
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
        .form-container {
            margin-bottom: 30px;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .form-container h2 {
            margin-top: 0;
        }
        .form-container form {
            display: flex;
            flex-direction: column;
        }
        .form-container label {
            margin-bottom: 8px;
        }
        .form-container input, .form-container select {
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        .form-container button {
            padding: 10px 20px;
            background-color: #007BFF;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .form-container button:hover {
            background-color: #0056b3;
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
    <h2>Szerkesztés</h2>

    <?php foreach ($eloadasok as $eloadas): ?>
        <div class="form-container">
            <h2>Előadás szerkesztése: <?= htmlspecialchars($eloadas['CikkCim']); ?></h2>
            <form action="szerkesztes.php" method="POST">
                <input type="hidden" name="eloadasAzonosito" value="<?= $eloadas['EloadasAzonosito']; ?>">

                <label for="szekcioNeve">Szekció:</label>
                <select id="szekcioNeve" name="szekcioNeve" required>
                    <?php foreach ($szekciok as $szekcio): ?>
                        <option value="<?= $szekcio; ?>" <?= ($szekcio == $eloadas['SzekcioNeve']) ? 'selected' : ''; ?>><?= $szekcio; ?></option>
                    <?php endforeach; ?>
                </select>

                <label for="kezdesIdopont">Kezdés időpont:</label>
                <input type="datetime-local" id="kezdesIdopont" name="kezdesIdopont" value="<?= htmlspecialchars($eloadas['KezdesIdopont']); ?>" required>

                <label for="eloadasHossza">Előadás hossza (perc):</label>
                <input type="number" id="eloadasHossza" name="eloadasHossza" value="<?= $eloadas['EloadasHossza']; ?>" required>

                <button type="submit">Módosítás</button>
            </form>
        </div>
    <?php endforeach; ?>
</div>
</body>
</html>
