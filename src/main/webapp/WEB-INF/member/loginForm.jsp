<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>로그인화면</title>
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
<c:if test="${not empty param.err}">
<script>
	alert("아이디 또는 비밀번호가 잘못되었습니다");
</script>	
</c:if>
<body>
    <h1>
        로그인 화면 
    </h1>
    <form id="rForm" action="member.do" method="post" >
    	<input type="hidden" name="action" value="login">
        <label>아이디 : </label> <input type="text" id="member_id" name="member_id" required="required" value="${param.member_id}"><br/>
        <label>비밀번호 : </label>   <input type="password" id="member_pwd" name="member_pwd" required="required"><br/>
        <input type="checkbox" id="autologin" name="autologin" value="updateAutologinValue(this)"> <label for="autologin">자동로그인</label>
        
        <script> 
        function(){
        	function updateAutologinValue(autologin) {
                if (autologin.checked) {
                	autologin.value = "Y";
                } else {
                	autologin.value = "N";
                }
            }
        }</script>  
            
    <div>
        <input type="submit" value="로그인" >
        <a href="index.html">취소</a>
    </div>
    
    </form>
    
<script type="text/javascript" src="<c:url value='/js/common.js'/>"></script>
    
<script type="text/javascript">

    const rForm = document.getElementById("rForm");
    
    rForm.addEventListener("submit", e => {
	
    	//서버에 form data를 전송하지 않는다 
    	e.preventDefault();
    	rForm.submit();
		
    });

    </script>
    
</body>
</html>







