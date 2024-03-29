<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Board Page</title>
<style>
    table {
        width: 100%;
        border-collapse: collapse;
    }
    th, td {
        padding: 8px;
        text-align: left;
        border-bottom: 1px solid #ddd;
    }
    th {
        background-color: #f2f2f2;
    }
    tr:hover {
        background-color: #f5f5f5;
    }
    .button-container {
        margin-top: 20px;
    }
    .button-container button {
        padding: 10px 20px;
        font-size: 16px; 
        background-color: #f5f5f5;
    }
</style>
</head>
<body>
<h1>Board Page</h1>

<form id="listForm" action="board.do" method="post">
    <input type="hidden" id="action" name="action" value="view">
    <input type="hidden" id="bnoInput" name="bno">
</form>

<table border="1">
<tr>
<th>게시물번호</th>
<th>제목</th>
<th>내용</th>
<th>작성자</th>
</tr>

<c:forEach var="board" items="${list}">
<tr>
    <td onclick="jsView('${board.bno}')" style="cursor:pointer;">${board.bno}</td>
    <td>${board.btitle}</td>
    <td>${board.bcontent}</td>
    <td>${board.bwriter}</td>
</tr>
</c:forEach>
</table>

<script>
function jsView(bno){
    document.getElementById('bnoInput').value = bno;
    document.getElementById('listForm').submit();
}
</script>

</body>
</html>
