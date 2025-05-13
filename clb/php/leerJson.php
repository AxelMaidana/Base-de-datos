<?php
   include 'bd.php';

   $sql = "SELECT * FROM productos";
   $result = $conn -> query($sql);

   while ($row = $result -> fetch_assoc()) {
         $detalle = json_decode($row['detalle'], true);
         
         // Convertir el array de colores a una cadena separada por comas
         $colores = implode($detalle['colores']);
         
         // Imprimir los detalles del producto
         echo "<pre>.htmlspecialchars"($row['nombre'] . " " . $detalle['marca'] . " " . $detalle['ram'] . " Colores: " . $colores . "<br>")."</pre>";
   }
?>
