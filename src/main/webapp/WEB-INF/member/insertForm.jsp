<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>InsertForm</title>
</head>
<body>
<h1> 회원 가입 </h1>
<form id="insertForm" action="member.do" method="post">
    	<input type="hidden" name="action" value="insert">
        <label>아이디 : </label> <input type="text" id="member_id" name="member_id" value="${member.member_id}" required="required"> <br/>
        <label>비밀번호 : </label>   <input type="password" id="member_pwd" name="member_pwd" required="required"><br/>
        <label>비밀번호확인 : </label>   <input type="password" id="member_pwd2" name="member_pwd2" required="required"><br/>
        <label>이름 : </label>   <input type="text" id="member_name" name="member_name" value="${member.member_name}" required="required"><br/>
        <label>주소: </label>    <input type="text" id="member_address" name="member_address" value="${member.member_address}" required="required"><br/>
        <label>번호: </label>  <input type="text" id="member_phonenumber" name="member_phonenumber" value="${member.member_phonenumber}" required="required"><br/>
        <label>성별 : </label>  
        	<input type="radio" id="member_gender1" name="member_gender" value="남" ${"남".equals(member.member_gender) ? "checked='checked'" : ""}> <label for="member_gender1" >남자</label>
        	<input type="radio" id="member_gender2" name="member_gender" value="여" ${"여".equals(member.member_gender) ? "checked='checked'" : ""}> <label for="member_gender2" >여자</label> <br/>
        <label>취미 : </label> <br/>
        	<c:forEach var="hobby" items="${hobbyList}">
	        	<input type="checkbox" id="member_hobby_${hobby.hobby_id}" name="hobbies" value="${hobby.hobby_id}" ${member.isCheckedHobbyId(hobby.hobby_id) ? 'checked=checked' : ''}> <label for="member_hobby_${hobby.hobby_id}">${hobby.hobby_name}</label> <br/>
        	</c:forEach>  
	    <div>
	        <input type="submit" value= "추가">
	        
	        <a href="index.html">취소</a>
	    </div>
    </form>
    
    <script type="text/javascript" src="<c:url value='/js/common.js'/>"></script>
    
    <script type="text/javascript">
    
    const rForm = document.getElementById("insertForm");
    /* document.querySelector('#insertForm) */
     
     rForm.addEventListener("submit", e => {
    	//서버에 form data를 전송하지 않는다 
    	e.preventDefault();
    	
    	if (member_pwd.value != member_pwd2.value) {
        	
    		alert("비밀번호가 잘못되었습니다.")
    		mpassword2.value = "";
    		mpassword2.focus();
    		return;
    	}
    	
    	myFetch("member.do", "insertForm", json => {
    		
    		if(json.status == 0) {
    			//성공
    			alert("회원 가입을 성공 하였습니다"); 
    			 location = "index.html"; 
    			

    		} else {
    			alert(json.statusMessage);
    		}
    	});
    });
    </script> 
</body>
</html>