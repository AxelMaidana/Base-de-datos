<?php
    //registrar.php
    include 'bd.php'; 

    $username = $_POST['username'];
    $password = $_POST['password'];

    $sql = "INSERT INTO personas (username, password) VALUES ('$username', '$password')";
    $result = mysqli_query($conn, $sql);

    if ($result) {
        echo'<script type="text/javascript">
        alert("Persona registrada correctamente");
        window.location.href="index.php";
        </script>';

    } else {
        echo "Error al registrar";
        exit;
        
    }
?>