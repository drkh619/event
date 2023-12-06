<?php
$servername = 'localhost';
$username = 'id21608226_root';
$password = 'Oroyuoiw34!';
$database = 'id21608226_event_mgmt';

// Create connection
$connection = mysqli_connect($servername, $username, $password, $database);

if (!empty($_POST["username"]) and !empty($_POST["email"]) and !empty($_POST["phone"]) and !empty($_POST["password"])) {

    $username = $_POST["username"];
    $email = $_POST["email"];
    $phone = $_POST["phone"];
    $password = $_POST["password"];

    $username = mysqli_real_escape_string($connection, $username);
    $email = mysqli_real_escape_string($connection, $email);
    $phone = mysqli_real_escape_string($connection, $phone);

    // Hash the password
    $hashedPassword = password_hash($password, PASSWORD_DEFAULT);

    $findexist = "SELECT * FROM organiser_table WHERE username='" . $username . "'";
    $resultsearch = mysqli_query($connection, $findexist);

    if (mysqli_num_rows($resultsearch) > 0) {
        $result["error"] = true;
        $result["message"] = "Username already exists. Please try another!";
        echo json_encode($result);
    } else {
        $sql = "INSERT INTO organiser_table (username, email, phone, password) VALUES ('" . $username . "','" . $email . "','" . $phone . "','" . $hashedPassword . "')";

        if (mysqli_query($connection, $sql)) {
            $result["error"] = false;
            $result["message"] = "Registration success";
            echo json_encode($result);
            mysqli_close($connection);
        }
    }
}
?>
