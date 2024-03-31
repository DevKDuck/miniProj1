<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
<h1> Memberlist Page</h1>

    <form id="listForm" action="member.do" method="post">
    	<input type="hidden" id="action" name="action" value="view">
    	<input type="hidden" id="member_id" name= "member_id">
    </form>

<table border="1">
<tr>
<th>회원 아이디</th>
<th>이름</th>
<th>전화번호</th>
<th>성별</th>
</tr>



<c:forEach var="member" items="${list}" >
<tr>
<td onclick="jsView('${member.member_id}')" style="cursor:pointer;">${member.member_id} </td>
	<td>${member.member_name}</td>
	<td>${member.member_phonenumber}</td>
	<td>${member.member_gender}</td>
</tr>
</c:forEach>
</table>


<script>
function jsView(memberid){
	member_id.value = memberid;
	listForm.submit();
}
</script>

</body>
</html>