<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

 <h1>
        회원정보 수정양식 
    </h1>
 <form id="updateForm" action="member.do" method="post">
    	<input type="hidden" name="action" value="update">
        <label>아이디 : </label> <input type="text" id="member_id" name="member_id" value="${member.member_id}" readonly="readonly"> <br/>
        <label>비밀번호 : </label>   <input type="password" id="member_pwd" name="member_pwd" required="required"><br/>
        <label>비밀번호확인 : </label>   <input type="password" id="member_pwd2" name="member_pwd2" required="required"><br/>
        <label>이름 : </label>   <input type="text" id="member_name" name="member_name" value="${member.member_name}"><br/>
        <label>주소: </label>    <input type="text" id="member_address" name="member_address" value="${member.member_address}"><br/>
        <label>번호: </label>  <input type="text" id="member_phonenumber" name="member_phonenumber" value="${member.member_phonenumber}"><br/>
        <label>성별 : </label>  <input type="radio" id="member_gender" name="member_gender" value="${member.member_gender}">
    <div>
        <input type="submit" value="수정">
        <a href="member.do?action=view&member_id=${member.member_id}">취소</a>
    </div>
    
    </form>
 
</body>
</html>