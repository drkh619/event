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

$cityToStateMapping = [
    'Delhi' => 'Delhi',
    'Hyderabad' => 'Telangana',
    'Bangalore' => 'Karnataka',
    'Kerala' => 'Kerala',
    'Ahmedabad' => 'Gujarat',
    'Mumbai' => 'Maharashtra',
    'Goa' => 'Goa',
    'Kolkata' => 'West Bengal',
    'Chennai' => 'Tamil Nadu',
	'Jaipur' => 'Rajasthan',  // Added 'Jaipur'
    'Pune' => 'Maharashtra',
    // Add more city to state mappings as needed
];

$locationName = $_GET['locationName']; // Assuming the parameter is named locationName

// Check if the provided city name exists in the mapping
if (array_key_exists($locationName, $cityToStateMapping)) {
    $stateName = $cityToStateMapping[$locationName];
    
    // Use the $stateName in your SQL query
    $sql = "SELECT * FROM `offline_event` WHERE state = '$stateName' AND token = 1";

    $result = mysqli_query($connection, $sql) or die("Error in Selecting " . mysqli_error($connection));

    $response = array();
    if ($result->num_rows > 0) {
        while ($row = $result->fetch_assoc()) {
            array_push($response, $row);
        }
    }

    $connection->close();
    header('Content-Type: application/json');
    echo json_encode($response);
} else {
    // Handle the case when an invalid city name is provided
    echo "Invalid city name";
}
?>
