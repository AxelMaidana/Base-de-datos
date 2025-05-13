<?php
$archivo = '../json/usuario.json';
$json_data = file_get_contents($archivo);

if ($json_data == false) {
    echo "Error al leer el archivo JSON.";
    exit; 
}

$usuarios = json_decode($json_data, true);

if(json_last_error() !== JSON_ERROR_NONE) {
    die(json_last_error_msg());
}

$nuevo_usuario = array(
    "id" => 6,
    "nombre" => "Pepe",
    "apellido" => "Perez",
    "telefono" => "123456789",
    "activo" => true,
    "direccion" => array(
        "calle" => "Calle Falsa",
        "numero" => 123,
    )
);

// Validar que el ID no esté duplicado
$id_existente = false;
foreach ($usuarios as $usuario) {
    if ($usuario['id'] == $nuevo_usuario['id']) {
        $id_existente = true;
        break;
    }
}

if (!$id_existente) {
    $usuarios[] = $nuevo_usuario;
    $json_data = json_encode($usuarios, JSON_PRETTY_PRINT / JSON_UNESCAPED_UNICODE); 
    file_put_contents($archivo, $json_data);
    echo "<p>Nuevo usuario agregado exitosamente = {$nuevo_usuario['nombre']}</p>";
} else {
    echo "<p style='color:red;'>Error: Ya existe un usuario con el ID {$nuevo_usuario['id']}.</p>";
}

echo "<pre>".htmlspecialchars($json_data)."</pre>"; 

?>
