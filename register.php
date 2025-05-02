<?php



$servername = "localhost";
$username = "root";
$password = "";
$dbname = "konferencia";

$conn = new mysqli($servername, $username, $password, $dbname);


if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $elotag = $_POST['elotag'];
    $nev = $_POST['nev'];
    $szerepkor = 'szerzo';
    $email = $_POST['email'];
    $jelszo = password_hash($_POST['jelszo'], PASSWORD_BCRYPT);
    $intezet = $_POST['intezmeny'];

    $stmt = $conn->prepare("INSERT INTO Felhasznalo (Elotag, Nev, Szerepkor, Email, Jelszo, Intezet) VALUES (?, ?, ?, ?, ?, ?)");
    $stmt->bind_param("ssssss", $elotag, $nev, $szerepkor, $email, $jelszo, $intezet);

    if ($stmt->execute()) {
        echo "Registration successful!";
    } else {
        echo "Error: " . $stmt->error;
    }

    $stmt->close();
    $conn->close();
}
?>