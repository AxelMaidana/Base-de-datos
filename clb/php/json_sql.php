<?php

    include 'bd.php';

    $producto = [
    'nombre' => 'Iphone 14',
    'detalle'=> json_encode([
        'marca' => 'Apple',
        'ram' => '16GB',
        'colores' => ['azul', 'rojo', 'verde'],
    ]),
    ];

    $stmt = $conn->prepare("INSERT INTO productos (nombre, detalle) VALUES (?, ?)");
    $stmt->bind_param("ss", $producto['nombre'], $producto['detalle']);

    if ($stmt->execute()) {
        echo "Producto insertado correctamente";
    } else {
        echo "Error al insertar el producto: " . $stmt->error;
    }
?>