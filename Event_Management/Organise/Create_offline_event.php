<?php
$servername = 'localhost';
$username = 'id21608226_root';
$password = 'Oroyuoiw34!';
$database = 'id21608226_event_mgmt';

$ip_address = "parietal-insanities.000webhostapp.com"; //host
//$ip_address = "192.168.29.104"; //integos
//$ip_address = "192.168.18.52"; //home-ethernet
//$ip_address = "192.168.18.73"; //home-wifi



// // Create connection
$connection = new mysqli($servername, $username, $password,$database);
    
   
// Check connection
if ($connection->connect_error) {
  die("Connection failed: " . $connection->connect_error);
}
 

    $event_name = $_POST['event_name'];
$event_start_date = $_POST['event_start_date'];
$event_end_date = $_POST['event_end_date'];
$event_venue = $_POST['event_venue'];
$event_price = $_POST['event_price'];
$event_capacity = $_POST['event_capacity'];
$event_description = $_POST['event_description'];
$uid = $_POST['uid'];
$visibility = $_POST['visibility']; // Added visibility
$token = $_POST['token']; // Added token
$place = $_POST['place'];
$state = $_POST['state'];
$status = '0';

$file_name1 = $_FILES['event_image']['name'];
$file_tmp = $_FILES['event_image']['tmp_name'];
move_uploaded_file($file_tmp, 'image_uploaded/' . $file_name1);

$file_name2 = "https://" . $ip_address . "/Event_Management/Organise/image_uploaded/" . $file_name1;

$sql = "INSERT INTO `offline_event`(`event_name`, `event_start_date`, `event_end_date`, `event_venue`, `place`, `state` , `event_price`, `event_capacity`, `event_image`, `event_description`, `uid`, `visibility`, `token`, `status`) VALUES 
 ('$event_name', '$event_start_date', '$event_end_date', '$event_venue', '$place', '$state' , '$event_price', '$event_capacity', '$file_name2', '$event_description', '$uid', '$visibility', '$token', '$status')";

if ($connection->query($sql) === TRUE) {
  echo json_encode(array("statusCode" => 200, "msg" => "New record created successfully"));
} else {
  echo json_encode(array("statusCode" => 0, "msg" => $connection->error));
}
?>
