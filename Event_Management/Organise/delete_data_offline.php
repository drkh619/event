<?php
$servername = 'localhost';
$username = 'root';
$password = '';
$database = "evnt_mgmt";

// Create connection
$connection = mysqli_connect($servername, $username, $password, $database);
   
// Check connection
if ($connection->connect_error) {
  die("Connection failed: " . $connection->connect_error);
}
 $id=$_POST['id'];
 
 print($id);
  
 
 
	$connection->query("DELETE  FROM offline_event WHERE id=".$id) ;
 

$result=array("success"=>'Successfully Deleted');
echo json_encode($result);
?>