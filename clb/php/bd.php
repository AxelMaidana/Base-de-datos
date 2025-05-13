<?php 
    //connection database
    $servername = "localhost";
    $username = "root";
    $password = "";
    $dbname = "bases_de_datos_2";

    // Create connection
    $conn = new mysqli($servername, $username, $password, $dbname);
    // Check connection
    if ($conn->connect_error) {
        die("Connection failed: " . $conn->connect_error);
    } else {
        //echo "Connected successfully";
    }
?>