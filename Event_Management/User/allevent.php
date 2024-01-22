<?php
$servername = 'localhost';
$username = 'id21608226_root';
$password = 'Oroyuoiw34!';
$database = 'id21608226_event_mgmt';

// Create connection
$connection = new mysqli($servername, $username, $password, $database);

// Check connection
if ($connection->connect_error) {
    die("Connection failed: " . $connection->connect_error);
}

// Retrieve all events with token = 1 from offline_event table
$sqlOffline = "SELECT * FROM `offline_event` WHERE token = 1";
$resultOffline = mysqli_query($connection, $sqlOffline) or die("Error in Selecting " . mysqli_error($connection));

// Retrieve all events with token = 1 from online_event table
$sqlOnline = "SELECT * FROM `online_event` WHERE token = 1";
$resultOnline = mysqli_query($connection, $sqlOnline) or die("Error in Selecting " . mysqli_error($connection));

$response = array();

// Combine results from both tables
while ($rowOffline = $resultOffline->fetch_assoc()) {
    array_push($response, $rowOffline);
}

while ($rowOnline = $resultOnline->fetch_assoc()) {
    array_push($response, $rowOnline);
}

$connection->close();
header('Content-Type: application/json');
echo json_encode($response);
?>
