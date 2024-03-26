<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1> Board Page</h1>

 <table border="1">
<tr>
<th>게시물번호</th>
<th>제목</th>
<th>내용</th>
<th>작성자</th>
<th>작성일</th>
<th>읽음 횟수</th>
</tr>

<c:forEach var="board" items="${list}">
<tr>

<td>${board.bno}</td>
	<td>${board.btitle}</td>
	<td>${board.bcontent}</td>
	<td>${board.bwriter}</td>
	<td>${board.bdate}</td>
	
	<td>${board.bcount}</td>

</tr>
</c:forEach>
</table>
</body>
</html>