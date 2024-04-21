<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>
    <script
            src="https://code.jquery.com/jquery-3.5.1.js"
            integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc="
            crossorigin="anonymous"></script>
</head>
<body>

<script>

    $(document).ready(function() {
        refetch();
    });


    let refetch = (page = 0, size = 4) =>{
        $.ajax({
            type: "GET",
            url: "/allservices?page=" + page + "&size=" + size,
            success: function (response) {
                renderTable (response.content, $('#table'));
                generatePaginationButtons(response.totalPages);
            },
            dataType: "json",
            contentType: "application/json"
        })
    }
    function generatePaginationButtons(totalPages) {
        let paginationDiv = $('#pagination');
        paginationDiv.empty();

        for (let i = 0; i < totalPages; i++) {
            let btn = $('<button>').text(i + 1);
            btn.click(function() {
                refetch(i);
            });
            paginationDiv.append(btn);
        }
    }
    function renderTable(services, table) {

        let innerHtml = '<tr>\n' +
            '            <th>id</th>\n' +
            '            <th>Name</th>\n' +
            '            <th>Cost</th>\n' +
            '            <th>Date</th>\n' +
            '        </tr>';
        for (let i = 0; i < services.length; i++) {
            innerHtml += '<tr>' ;
            innerHtml += '  <td>' + services[i]['id'] + '</td>' ;
            innerHtml += '  <td>' + services[i]['name'] + '</td>' ;
            innerHtml += '  <td>' + services[i]['cost'] + '</td>' ;
            innerHtml += '  <td>' + services[i]['date'] + '</td>' ;
            innerHtml += '</tr>';
        }
        table.html(innerHtml);
    }
    function sendService(name, cost, date) {
        let data = {
            "name": name,
            "cost": cost,
            "date": date
        };

        console.log(data)

        $.ajax({
            type: "POST",
            url: "/services",
            data: JSON.stringify(data),
            success: function () {
                refetch();
            },
            dataType: "json",
            contentType: "application/json"

        });
    }
    function searchServices(query, page = 0, size = 4) {
        $.ajax({
            type: "GET",
            url: "/paper/service/search",
            data: {
                q: query,
                size: size,
                page: page
            },
            success: function(response) {
                renderSearchResults(response);
            },
            dataType: "json"
        });
    }

    function renderSearchResults(response) {
        let resultsDiv = $('#searchResults');
        resultsDiv.empty(); // Limpiar los resultados anteriores

        if (!response) {
            console.log('No response', response);
            return;
        }
        console.log(response);
        let services = response.content;
        let tableHtml = '<table><tr><th>ID</th><th>Name</th><th>Cost</th><th>Date</th></tr>';
        for (let i = 0; i < services.length; i++) {
            tableHtml += '<tr>' +
                '<td>' + services[i]['id'] + '</td>' +
                '<td>' + services[i]['name'] + '</td>' +
                '<td>' + services[i]['cost'] + '</td>' +
                '<td>' + services[i]['date'] + '</td>' +
                '</tr>';
        }
        tableHtml += '</table>';
        resultsDiv.append(tableHtml);

        let totalPages = response.totalPages;
        let paginationDiv = $('<div>');
        for (let i = 0; i < totalPages; i++) {
            let btn = $('<button>').text(i + 1);
            btn.click(function () {
                searchServices($('#query').val(), i);
            });
            paginationDiv.append(btn);
        }
        resultsDiv.append(paginationDiv);
    }
        function clearSearchResults() {
            let resultsDiv = $('#searchResults');
            resultsDiv.empty();
            refetch();
        }

</script>

<div class="container">
    <h1>Insert</h1>
    <hr>
    <label><b>Name</b></label>
    <input type="text" id="name" placeholder="Name">
    <label><b>Cost</b></label>
    <input type="text" id="cost" placeholder="Cost">
    <label><b>Time</b></label>
    <input type="text" id="date" placeholder="Time">
    <hr>
    <button class="button" onclick="sendService($('#name').val(),
                               $('#cost').val(), $('#date').val()
                              )">Добавить</button>
</div>

<div class="container">
    <h1>Search</h1>
    <hr>
    <label><b>Query</b></label>
    <input type="text" id="query" placeholder="Search">
    <hr>
    <button class="button" onclick="searchServices($('#query').val())">Buscar</button>
    <button class="button" onclick="clearSearchResults()">Limpiar</button>
</div>

<div id="searchResults">

</div>

<div>
    <table id="table">
        <tr>
            <th>id</th>
            <th>name</th>
            <th>cost</th>
            <th>date</th>
        </tr>
        <#list servicesList as services>
            <tr>
                <td>${services.id}</td>
                <td>${services.name}</td>
                <td>${services.cost}</td>
                <td>${services.date}</td>
            </tr>
        </#list>
    </table>
</div>

    <div id="pagination"></div>
</body>
</html>