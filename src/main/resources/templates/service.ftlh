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

    let currentPage = 0;

    let refetch = (page = 0, size = 3) =>{
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
    function searchServices(query, page = 0, size = 3) {
        $.ajax({
            type: "GET",
            url: "/paper/service/search?q=" + query + "&page=" + page + "&size=" + size,
            success: function (response) {
                renderTable(response.content, $('#table')); // assuming response is an object with properties 'content' and 'totalPages'
                generatePaginationButtons(response.totalPages);
            },
            dataType: "json",
            contentType: "application/json"
        });
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
<form onsubmit="event.preventDefault(); searchServices($('#search').val());">
    <input type="text" id="search" name="q" placeholder="Search services">

    <button type="submit">Search</button>
</form>
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