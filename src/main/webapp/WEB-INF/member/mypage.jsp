<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>나의페이지</title>
    <style>
        
        
        body {
            background-color: #f6f6f6;
            font-family: Arial, sans-serif;
        }
           label {
            color: #333; /* 흑색 텍스트 */
            font-size: 30px;
            margin-bottom: 10px; /* 라벨 간격 조정 */
           
            
        }
        
        .container {
            text-align: center; /* 가운데 정렬 */
            margin-bottom: 20px; /* 아래쪽 여백 */
        }
              h1 {
            color: coral; /* 코랄색 텍스트 */
            font-size: 36px;
            text-align: center; /* 가운데 정렬 */
            margin-bottom: 30px; /* 헤더 아래 여백 */
        }
    </style>
</head>
<body>
    <br>
    <h1>
       나의페이지
    </h1>
    <br>
    <br>
   <div class="container">
     <br> <label>아이디 : ${loginVO.member_id}</label> <br/>
      <br><label>이름 : ${loginVO.member_name}</label><br/>
      <br><label>주소: ${loginVO.member_address}</label><br/>
      <br><label>번호: ${loginVO.member_phonenumber}</label><br/>
      <br><label>성별: ${loginVO.member_gender}</label><br/>
      <br><label>취미: ${loginVO.hobby_name}</label><br/>
      
<!-- 두개의 폼을 하나로 합치는 방법 , js를 사용하여 처리  -->
<br><br>
<form id="viewForm" method="post" action="member.do">
	<input type="hidden" id="action" name="action" value="">
	<input type="hidden" id="member_id" name="member_id" value="${loginVO.member_id}">
	<input type="button" value="삭제" onclick="jsDelete()">
	<input type="button" value="수정" onclick="jsUpdateForm()">
</form>   
</div>
 <script>

function jsDelete() {
	if (confirm("정말로 삭제하시겠습니까?")) {
		 const member_id = document.getElementById("member_id");
	    	//fetch를 사용하여 회원 가입을 함
	    	//전송자료 구성 
	    	const param = {
				 action : 'delete'
				,member_id : member_id.value
	    	} 
		    	
			fetch("member.do", {
				method:"POST",
				body:JSON.stringify(param),
				headers : {"Content-type" : "application/json; charset=utf-8"}
			}).then(res => res.json()).then(json => {
				//서버로 부터 받은 결과를 사용해서 처리 루틴 구현  
				console.log("json ", json );
				if(json.status == 0) {
					//성공
					alert("회원정보를 삭제 하였습니다");
					location = "member.do?action=logout";
				} else {
					alert(json.statusMessage);
				}
			});
	}	
}
function jsUpdateForm() {
	if (confirm("정말로 수정하시겠습니까?")) {
		//서버의 URL을 설정한다 
		action.value = "updateForm";
	
		//서버의 URL로 전송한다 
		viewForm.submit();
	}	
}

</script>

</body>
</html>

