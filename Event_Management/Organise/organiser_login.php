<?php
$servername = 'localhost';
$username = 'id21608226_root';
$password = 'Oroyuoiw34!';
$database = 'id21608226_event_mgmt';

// Create connection
$connection = mysqli_connect($servername, $username, $password, $database);

if (!empty($_POST["username"]) and !empty($_POST["password"])) {

    $username = $_POST["username"];
    $password = $_POST["password"];

    $username = mysqli_real_escape_string($connection, $username);

    $sql = "SELECT * FROM organiser_table WHERE username = '" . $username . "'";
    $result = mysqli_query($connection, $sql);

    if ($result->num_rows > 0) {
        $row = $result->fetch_assoc();
        $hashedPassword = $row['password'];

        // Verify the password
        if (password_verify($password, $hashedPassword)) {
            $response = array();
            array_push($response, $row);
            $connection->close();
            echo json_encode($response);
        } else {
            echo json_encode(null);
        }
    } else {
        echo json_encode(null);
    }
}
?>
