<?php
$servername = 'localhost';
$username = 'id21608226_root';
$password = 'Oroyuoiw34!';
$database = 'id21608226_event_mgmt';

$connection = new mysqli($servername, $username, $password,$database);
    

if ($connection->connect_error) {
  die("Connection failed: " . $connection->connect_error);
}

            $connection->set_charset("utf8");
            
            
				$id = $_POST['id'];
				$event_name = $_POST["event_name"];
				$event_end_date= $_POST["event_end_date"];
				$event_capacity = $_POST["event_capacity"];
				$event_description = $_POST["event_description"];


	$connection->query("UPDATE offline_event SET event_name='".$event_name."',event_end_date='".$event_end_date."',event_capacity='".$event_capacity."',event_description='".$event_description."' WHERE id=".$id);


	



    	
	$result = array();
	$result['msg'] = "Successfully Edited..";
	echo json_encode($result);

?>



