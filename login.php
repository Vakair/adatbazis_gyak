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

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $email = $_POST['email'];
    $jelszo = $_POST['jelszo'];


    $stmt = $conn->prepare("SELECT Azonosito, Jelszo, Nev, Szerepkor FROM Felhasznalo WHERE Email = ?");

    $stmt->bind_param("s", $email);
    $stmt->execute();
    $stmt->bind_result($user_id, $hashed_password, $username, $role);

    if ($stmt->fetch() && password_verify($jelszo, $hashed_password)) {

        $_SESSION['loggedin'] = true;
        $_SESSION['user_id'] = $user_id;
        $_SESSION['username'] = $username;
        $_SESSION['role'] = $role;


        header("Location: main.php");
        exit;
    } else {
        echo "Invalid email or password.";
    }

    $stmt->close();
}

$conn->close();
?>
