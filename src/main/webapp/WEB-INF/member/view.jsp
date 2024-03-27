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
<h1> view </h1>
 <label>아이디 : ${view.member_id}</label> <br/>
 <label>비번  : ${view.member_pwd}</label> <br/>
 <label>이름  : ${view.member_name}</label> <br/>
 <label>주소  : ${view.member_address}</label> <br/>
 <label>번호  : ${view.member_phonenumber}</label> <br/>
 <label>성별  : ${view.member_gender}</label> <br/>
 
 
 <form id="viewForm" action="member.do" method="post">
 		<input type="hidden" id="action" name="action" value="">
    	<input type="hidden" id="member_id" name= "member_id" value= "${view.member_id}">
    	<input type="button" value="삭제" onclick="jsDelete()">
		<input type="button" value="수정" onclick="jsUpdateForm()">
 </form> 
<script>
/* const member_id = document.getElementById("member_id") */
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
					location = "member.do?action=list";
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