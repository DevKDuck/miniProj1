<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Board Page</title>
<style>
		body {
            background-color: #f6f6f6;
            font-family: Arial, sans-serif;
            }
        
        
        h1 {
            color: coral; /* 코랄색 텍스트 */
            font-size: 36px;
            text-align: center; /* 가운데 정렬 */
            margin-bottom: 30px; /* 헤더 아래 여백 */
        }
    table {
        width: 100%;
        border-collapse: collapse;
    }
    th, td {
        padding: 20px;
        text-align: left;
        border-bottom: 1px solid #ccc;
    }
    th {
        background-color: white;
    }
    tr:hover {
        background-color: coral;
    }
    .button-container {
        margin-top: 20px;
    }
    .button-container button {
        padding: 10px 20px;
        font-size: 16px; 
        background-color: lightcoral;
    }
</style>
</head>
<body>
<h1>게시판</h1>

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

<form id="insertForm" action="board.do" method="post">
<input type="hidden" name="action" value="insertForm">
<input type = "submit" value="등록">
</form>
<a href= "main.jsp">메인으로 돌아가기</a>

<script type="text/javascript" src="<c:url value='/js/common.js'/>"></script>
    
    <script type="text/javascript">
    
    const rForm = document.getElementById("insertForm");
     
    rForm.addEventListener("submit", e => {
    	//서버에 form data를 전송하지 않는다 
    	e.preventDefault();
    	
    	var isLoggedIn = <%= session.getAttribute("loginVO") != null %>;
       
        
    	if (isLoggedIn == false){
    		alert("로그인을 해주세요.")
    		return false
    	}else{
    		rForm.submit();
    	}
    	
  
    });
    </script> 


<script>
function jsView(bno){
    document.getElementById('bnoInput').value = bno;
    document.getElementById('listForm').submit();
}
</script>

</body>
</html>
