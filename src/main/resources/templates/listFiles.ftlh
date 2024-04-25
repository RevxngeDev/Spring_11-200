<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Lista de archivos</title>
</head>
<body>
<h1>Lista de Archivos</h1>
<table>
    <thead>
    <tr>
        <th>Nombre</th>
        <th>Descripción</th>
        <th>Imagen</th>
        <th>Likes</th>
    </tr>
    </thead>
    <tbody>
    <#list files as file>
        <tr>
            <td>${file.originalFileName}</td>
            <td>${file.description}</td>
            <td><img src="/files/${file.storageFileName}" width="100"></td>
            <td>${file.likes!"No disponible"}</td>
        </tr>
    </#list>
    </tbody>
</table>
<a href="/files/upload"><button>Subir Archivo</button></a>
</body>
</html>