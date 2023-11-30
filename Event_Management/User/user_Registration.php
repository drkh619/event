<?php
$servername = "localhost";
$username = "root";
$password = "";
$database = "evnt_mgmt";

// Create connection
$connection = mysqli_connect($servername, $username, $password, $database);


  if( !empty($_POST["username"])and !empty($_POST["email"])and !empty($_POST["phone"])and !empty($_POST["password"]))
{

      $username = $_POST["username"];
    $email= $_POST["email"];
    $phone= $_POST["phone"];
    $password = $_POST["password"];
    
               
      
      $username=mysqli_real_escape_string($connection,$username);
     $email=mysqli_real_escape_string($connection,$email);
      $phone=mysqli_real_escape_string($connection,$phone);
       $password=mysqli_real_escape_string($connection,$password);

      

 
 

$findexist="select * from user_table where username='".$username."'";


        $resultsearch=mysqli_query($connection,$findexist);
        
  
    if(mysqli_num_rows($resultsearch)>0)
    {
          while($row=mysqli_fetch_array($resultsearch))
          {
             
			    $result["error"] = true;
              $result["message"] = "username Already exist try another!";

              echo json_encode($result);
              
          }}
  
else{

    $sql = "INSERT INTO user_table (username,email,phone,password) VALUES ('".$username."','".$email."','".$phone."','".$password."')";


    if ( mysqli_query($connection, $sql) ) {
        $result["error"] = false;
        $result["message"] = "Registration success";

        echo json_encode($result);
        mysqli_close($connection);

    }
	
	}
}
?>