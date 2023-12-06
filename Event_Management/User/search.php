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

$searchText = $_GET['searchText']; // Assuming the parameter is named searchText

// Search in offline_event table
$sqlOffline = "SELECT * FROM `offline_event` WHERE 
              (state LIKE '%$searchText%' OR event_name LIKE '%$searchText%' OR event_venue LIKE '%$searchText%') AND 
              token = 1"; 

$resultOffline = mysqli_query($connection, $sqlOffline) or die("Error in Selecting " . mysqli_error($connection));

// Search in online_event table
$sqlOnline = "SELECT * FROM `online_event` WHERE 
              (event_name LIKE '%$searchText%' OR event_description LIKE '%$searchText%') AND 
              token = 1"; 

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
