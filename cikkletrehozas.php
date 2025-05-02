<?php
session_start();


if (!isset($_SESSION['loggedin']) || !$_SESSION['loggedin']) {
    header("Location: login.html");
    exit();
}


if (!isset($_SESSION['role']) || !isset($_SESSION['username'])) {
    echo "Hiba: A felhasználó adatai nem elérhetőek.";
    exit();
}


$servername = "localhost";
$username = "root";
$password = "";
$dbname = "konferencia";

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die("Kapcsolódási hiba: " . $conn->connect_error);
}


$error = $success = "";
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $cikkCim = $_POST['cikkCim'];


    if (empty($cikkCim)) {
        $error = "A cikk címe nem lehet üres.";
    } else {

        $felhasznaloAzonosito = $_SESSION['user_id'];


        $stmt = $conn->prepare("INSERT INTO Cikk (CikkCim) VALUES (?)");
        $stmt->bind_param("s", $cikkCim);

        if ($stmt->execute()) {
            $cikkAzonosito = $stmt->insert_id;


            $stmt2 = $conn->prepare("INSERT INTO Szerzoje (FelhasznaloAzonosito, CikkAzonosito) VALUES (?, ?)");
            $stmt2->bind_param("ii", $felhasznaloAzonosito, $cikkAzonosito);

            if ($stmt2->execute()) {

                $alapertelmezettSzekcio = "Alapértelmezett";
                $stmt3 = $conn->prepare("INSERT INTO Eloadas (CikkAzonosito, EloadoAzonosito, SzekcioNeve) VALUES (?, ?, ?)");
                $stmt3->bind_param("iis", $cikkAzonosito, $felhasznaloAzonosito, $alapertelmezettSzekcio);

                if ($stmt3->execute()) {
                    $success = "A cikk és az előadás sikeresen létrejött.";
                } else {
                    $error = "Hiba történt az előadás létrehozása során: " . $stmt3->error;
                }

                $stmt3->close();
            } else {
                $error = "Hiba történt a szerző kapcsolat létrehozása során: " . $stmt2->error;
            }

            $stmt2->close();
        } else {
            $error = "Hiba történt a cikk létrehozása során: " . $stmt->error;
        }

        $stmt->close();
    }
}

$conn->close();
?>

<!DOCTYPE html>
<html lang="hu">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cikk Létrehozása</title>
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
        .form-container label {
            display: block;
            margin-bottom: 8px;
        }
        .form-container input {
            width: 100%;
            padding: 8px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        .form-container button {
            padding: 10px 15px;
            background-color: #007BFF;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .form-container button:hover {
            background-color: #0056b3;
        }
        .message {
            padding: 10px;
            border-radius: 4px;
        }
        .message.success {
            background-color: #28a745;
            color: white;
        }
        .message.error {
            background-color: #dc3545;
            color: white;
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
            <a href="cikkletrehozas.php">Létrehozás</a>
            <a href="logout.php">Kijelentkezés</a>
        <?php endif; ?>
    </div>
</div>

<div class="container">
    <div class="form-container">
        <h2>Kedves <?php echo htmlspecialchars($_SESSION['username']); ?>, hozz létre egy cikket!</h2>

        <?php if ($error): ?>
            <div class="message error"><?php echo $error; ?></div>
        <?php endif; ?>

        <?php if ($success): ?>
            <div class="message success"><?php echo $success; ?></div>
        <?php endif; ?>

        <form method="post" action="">
            <label for="cikkCim">Cikk Címe:</label>
            <input type="text" id="cikkCim" name="cikkCim" required>
            <button type="submit">Létrehozás</button>
        </form>
    </div>
</div>

</body>
</html>
