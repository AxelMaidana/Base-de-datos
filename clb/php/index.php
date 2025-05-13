<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Consulta SQL Básica</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100">

<div class="flex flex-col items-center justify-center min-h-screen p-6">
    <form action="index.php" method="post" class="bg-white p-6 rounded shadow-md w-full max-w-md">
        <h2 class="text-lg font-bold mb-4">Escribe tu consulta SQL</h2>
        <input type="text" name="consulta" placeholder="Ej: SELECT * FROM persona" required
               class="w-full p-2 border rounded mb-4">
        <button type="submit" class="w-full bg-blue-500 text-white p-2 rounded">Consultar</button>
    </form>

    <?php
    if (isset($_POST['consulta'])) {
        $SQL = $_POST['consulta'];

        echo "<div class='bg-white p-4 mt-6 rounded shadow w-full max-w-7xl'>";
        echo "<p><strong>Consulta ingresada:</strong></p>";
        echo "<p>$SQL</p>";

        include 'bd.php';

        if (isset($_POST['consulta'])) {
            $consulta =  $_POST['consulta'];

            $consulta = $conn->query( $SQL);

                if($consulta && mysqli_num_rows( $consulta) > 0) {
                    while ($fila = mysqli_fetch_array( $consulta)) {
                        echo "<p><strong>Resultado:</strong></p>";
                        echo $fila[2];
                    }
                } else {
                    echo "<p>No se encontraron resultados.</p>";
                }
        }

        echo "</div>";
    }
    ?>
    <button type="button" class="w-full bg-blue-500 text-white p-2 rounded" onclick="location.href='lectorUsuario.php'">Consultar usuarios</button>
</div>

</body>
</html>
