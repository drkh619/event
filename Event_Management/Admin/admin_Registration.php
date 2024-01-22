<?php
$servername = 'localhost';
$username = 'id21608226_root';
$password = 'Oroyuoiw34!';
$database = 'id21608226_event_mgmt';

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

      

 
 

$findexist="select * from admin where username='".$username."'";


        $resultsearch=mysqli_query($connection,$findexist);

//echo "New Username: " . $username;
//echo "New Email: " . $email;
        
  
    if(mysqli_num_rows($resultsearch)>0)
    {
          while($row=mysqli_fetch_array($resultsearch))
          {
             
			    $result["error"] = true;
              $result["message"] = "username Already exist try another!";

              echo json_encode($result);
              
          }}
  
else{

    $sql = "INSERT INTO admin (username,email,phone,password) VALUES ('".$username."','".$email."','".$phone."','".$password."')";


    if ( mysqli_query($connection, $sql) ) {
        $result["error"] = false;
        $result["message"] = "Registration success";

        echo json_encode($result);
        mysqli_close($connection);

    }
	
	}
	
}
?>