<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>InsertForm</title>
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
<h1> 회원 가입 </h1>
<form id="duplicateForm" action="member.do" method="post">
<label>아이디</label> <input type="button" id="duplicateId" value="중복확인">
<input type="hidden" name="action" value="existUserId">
</form>
<form id="insertForm" action="member.do" method="post">
    	<input type="hidden" name="action" value="insert">
    	
         
        <input type="text" id="member_id" name="member_id" value="${member.member_id}" required="required"> <br/>
        
        <label>비밀번호</label>   <input type="password" id="member_pwd" name="member_pwd" required="required"><br/>
        <label>비밀번호확인</label>   <input type="password" id="member_pwd2" name="member_pwd2" required="required"><br/>
        <label>이름</label>   <input type="text" id="member_name" name="member_name" value="${member.member_name}" required="required"><br/>
        <label>주소</label>    <input type="text" id="member_address" name="member_address" value="${member.member_address}" required="required"><br/>
        <label>번호</label>  <input type="text" id="member_phonenumber" name="member_phonenumber" value="${member.member_phonenumber}" required="required"><br/>
        <label>성별 : </label>  
        	<input type="radio" id="member_gender1" name="member_gender" value="남" ${"남".equals(member.member_gender) ? "checked='checked'" : ""}> <label for="member_gender1" >남자</label>
        	<input type="radio" id="member_gender2" name="member_gender" value="여" ${"여".equals(member.member_gender) ? "checked='checked'" : ""}> <label for="member_gender2" >여자</label> <br/>
        <label>취미 : </label> 
        	<c:forEach var="hobby" items="${hobbyList}">
	        	<input type="checkbox" id="member_hobby_${hobby.hobby_id}" name="hobbies" value="${hobby.hobby_id}" ${member.isCheckedHobbyId(hobby.hobby_id) ? 'checked=checked' : ''}> <label for="member_hobby_${hobby.hobby_id}">${hobby.hobby_name}</label> 
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
     const duplicateForm = document.getElementById("duplicateForm");
     //click 이벤트 핸들러 등록
 	duplicateForm.addEventListener("click", () => {
 		const member_id = document.getElementById("member_id");
 		
 		if (member_id.value == "") {
 			alert("아이디를 입력해주세요");
 			member_id.focus();
 			return;
 		}
 		
		const param = {
				action : "existUserId",
				member_id : member_id.value
			}
 		
 		
		fetch("member.do", {
			method:"POST",
			body:JSON.stringify(param),
			headers : {"Content-type" : "application/json; charset=utf-8"}
		}).then(res => res.json()).then(json => {
			//서버로 부터 받은 결과를 사용해서 처리 루틴 구현  
			console.log("json ", json );
			if (json.existMember == true) {
				alert("해당 아이디는 사용 중 입니다.");
				validUserId = "";
			} else {
				alert("사용가능한 아이디 입니다.");
				validUserId = member_id.value;
			}
		});
 	});
    </script> 
</body>
</html>