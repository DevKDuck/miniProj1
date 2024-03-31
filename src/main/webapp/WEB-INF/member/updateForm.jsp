<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>update화면입니다</title>

<style>
body {
            background-color: #f6f6f6;
            font-family: Arial, sans-serif;
        }
           label {
            color: #333; /* 흑색 텍스트 */
            font-size: 18px;
            margin-bottom: 10px; /* 라벨 간격 조정 */
            
        }
              h1 {
            color: coral; /* 코랄색 텍스트 */
            font-size: 36px;
            text-align: center; /* 가운데 정렬 */
            margin-bottom: 30px; /* 헤더 아래 여백 */
        }

        /* 입력 필드 스타일 */
        input[type="text"],
        input[type="password"] {
            width: 100%; /* 너비를 컨테이너 너비에 맞춤 */
            padding: 10px; /* 내부 여백 추가 */
            border: 1px solid #ccc; /* 회색 테두리 */
            border-radius: 5px; /* 둥근 테두리 설정 */
            margin-bottom: 20px; /* 아래쪽 여백 추가 */
            box-sizing: border-box; /* 패딩과 테두리를 요소의 크기에 포함 */
        }

        /* 입력 필드 포커스 시 스타일 */
        input[type="text"]:focus,
        input[type="password"]:focus {
            outline: none; /* 포커스 테두리 제거 */
            border-color: #66afe9; /* 포커스 시 파란색 테두리 */
        }
</style>

</head>
<body>

 <h1>회원정보 수정</h1>
 	<form id="updateForm" action="member.do" method="post">
    	<input type="hidden" name="action" value="update">
        <label>아이디 : </label> <input type="text" id="member_id" name="member_id" value="${member.member_id}" readonly="readonly"> <br/>
        <label>비밀번호 : </label>   <input type="password" id="member_pwd" name="member_pwd" required="required"><br/>
        <label>비밀번호확인 : </label>   <input type="password" id="member_pwd2" name="member_pwd2" required="required"><br/>
        <label>이름 : </label>   <input type="text" id="member_name" name="member_name" value="${member.member_name}"><br/>
        <label>주소: </label>    <input type="text" id="member_address" name="member_address" value="${member.member_address}"><br/>
        <label>번호: </label>  <input type="text" id="member_phonenumber" name="member_phonenumber" value="${member.member_phonenumber}"><br/>
        <label>성별 : </label>  
        	<input type="radio" id="member_gender1" name="member_gender" value="남" ${"남".equals(member.member_gender) ? "checked='checked'" : ""}> <label for="member_gender1" >남자</label>
        	<input type="radio" id="member_gender2" name="member_gender" value="여" ${"여".equals(member.member_gender) ? "checked='checked'" : ""}> <label for="member_gender2" >여자</label> <br/>
        <label>취미 : </label> 
        	<c:forEach var="hobby" items="${hobbyList}">
	        	<input type="checkbox" id="member_hobby_${hobby.hobby_id}" name="hobbies" value="${hobby.hobby_id}" ${member.isCheckedHobbyId(hobby.hobby_id) ? 'checked=checked' : ''}> <label for="member_hobby_${hobby.hobby_id}">${hobby.hobby_name}</label> 
        	</c:forEach>  
	    <div>
	        <input type="submit" value="수정">
	        <a href="member.do?action=view&member_id=${member.member_id}">취소</a>
	    </div>
    </form>
    
    <script type="text/javascript" src="<c:url value='/js/common.js'/>"></script>
    
    <script type="text/javascript">
    
    const rForm = document.getElementById("updateForm");
     
    rForm.addEventListener("submit", e => {
    	//서버에 form data를 전송하지 않는다 
    	e.preventDefault();
    	
    	if (member_pwd.value != member_pwd2.value) {
        	
    		alert("비밀번호가 잘못되었습니다.")
    		mpassword2.value = "";
    		mpassword2.focus();
    		return false;
    	}
    	
    	myFetch("member.do", "updateForm", json => {
    		if(json.status == 0) {
    			//성공
    			alert("회원 정보 수정을 성공 하였습니다");

    			location = "member.do?action=view&member_id=" + member_id.value;

    		} else {
    			alert(json.statusMessage);
    		}
    	});
    });
    </script> 
</body>
</html>