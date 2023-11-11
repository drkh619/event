<?php
$servername = 'localhost';
$username = 'root';
$password = '';
$database = "evnt_mgmt";

// Create connection
$connection = mysqli_connect($servername, $username, $password, $database);

  if( !empty($_POST["username"])and !empty($_POST["password"]))
{

      $username = $_POST["username"];
    $password = $_POST["password"];
    
               
      
      $username=mysqli_real_escape_string($connection,$username);
       $password=mysqli_real_escape_string($connection,$password);
	   



$username = $_POST['username'];
 $password = $_POST['password'];
 
 
 $sql = "SELECT * FROM  user_table WHERE username = '".$username."' AND password = '".$password."'";
 $result = mysqli_query($connection,$sql);
 $count = mysqli_num_rows($result);
 
if($count == 1){
	$response = array();
	if($result->num_rows > 0){
		while($row = $result->fetch_assoc()){
			array_push($response,$row);
	}}$connection->close();
	echo json_encode($response);
}
else{
	echo json_encode(null);
}}


?>

