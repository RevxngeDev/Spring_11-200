<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <script
            src="https://code.jquery.com/jquery-3.6.0.js"
            integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk="
            crossorigin="anonymous"></script>
    <title>Document</title>
    <style>
        .like-button {
            background-color: #4CAF50; /* Green */
            border: none;
            color: white;
            padding: 10px 20px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 16px;
            margin: 4px 2px;
            cursor: pointer;
            border-radius: 10px;
        }
    </style>
    <script>
        function sendFile() {
            // данные для отправки
            let formData = new FormData();
            // забрал файл из input
            let files = ($('#file'))[0]['files'];
            // добавляю файл в formData
            [].forEach.call(files, function (file, i, files) {
                formData.append("file", file);
            });

            // Obtener descripción
            let description = $('#description').val();
            formData.append("description", description);


            $.ajax({
                type: "POST",
                url: "/files",
                data: formData,
                processData: false,
                contentType: false
            })
                .done(function (response) {
                    let fileUrl = 'http://localhost:8080/files/' + response;
                    $('#photo').append('<img src = "' + fileUrl + '"/>');
                    updateFilesList();
                })
                .fail(function () {
                    alert('Error')
                });
        }
        function updateFilesList() {
            $.ajax({
                type: "GET",
                url: "/files/all",
            })
                .done(function (response) {
                    let filesList = $('#filesList');
                    filesList.empty();
                    response.forEach(function (file) {
                        let fileItem = $('<div>');
                        fileItem.append('<img src="/files/' + file.storageFileName + '" width="100">');
                        fileItem.append('<a href="/files/' + file.storageFileName + '">' + file.originalFileName + '</a> - ' + file.description);
                        let likeButton = $('<button>').addClass('like-button').text('Like').click(function () {
                            likeFile(file.id);
                        });
                        fileItem.append(likeButton);
                        filesList.append(fileItem);
                    });
                })
                .fail(function () {
                    alert('Error')
                });
        }
        function likeFile(fileId) {
            $.ajax({
                type: "POST",
                url: "/files/like/" + fileId,
            })
                .done(function () {
                    alert('¡Le diste "like" al archivo!');
                })
                .fail(function () {
                    alert('Error al dar like al archivo');
                });
        }

        // Cargar la lista de archivos al cargar la página
        $(document).ready(function () {
            updateFilesList();
        });
    </script>
</head>
<body>
<div>
    <input type="file" id="file" name="file" placeholder="Имя файла..."/>
    <input type="hidden" id="file_hidden">
    <br>
    <textarea id="description" placeholder="Descripción..."></textarea>
    <br>
    <button onclick="sendFile()">
        Загрузить файл
    </button>
    <div class="filename"></div>
</div>
<div id="photo">
</div>
<div id="filesList">
</div>
<br>
<a href="/files/listFiles"><button> Ver Archivos </button></a>
</body>
</html>