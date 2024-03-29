<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1> view </h1>
 <label>번호 : ${view.bno}</label> <br/>
 <label>제목  : ${view.btitle}</label> <br/>
 <label>내용  : ${view.bcontent}</label> <br/>
 <label>아이디  : ${view.member_id}</label> <br/>
 <label>날짜  : ${view.bdate}</label> <br/>
 <label>본 횟수  : ${view.bcount}</label> <br/>
 <label>작성자  : ${view.bwriter}</label> <br/>
 
 
 <form id="viewForm" action="board.do" method="post">
 		<input type="hidden" id="action" name="action" value="">
    	<input type="hidden" id="bnoInput" name= "bno" value= "${view.bno}">
    	<input type="button" value="삭제" onclick="jsDelete()">
		<input type="button" value="수정" onclick="jsUpdateForm()">
 </form> 
<script>

function jsDelete() {
	if (confirm("정말로 삭제하시겠습니까?")) {
		 const bno = document.getElementById("bnoInput").value;
		
	    	//fetch를 사용하여 회원 가입을 함
	    	//전송자료 구성 
	    	const param = {
				 action : 'delete'
				,bno : bno
	    	} 
		    	
			fetch("board.do", {
				method:"POST",
				body:JSON.stringify(param),
				headers : {"Content-type" : "application/json; charset=utf-8"}
			}).then(res => res.json()).then(json => {
				//서버로 부터 받은 결과를 사용해서 처리 루틴 구현  
				console.log("json ", json );
				if(json.status == 0) {
					//성공
					alert("회원정보를 삭제 하였습니다");
					location = "board.do?action=list";
				} else {
					alert(json.statusMessage);
				}
			});
	}	
}
function jsUpdateForm() {
	if (confirm("정말로 수정하시겠습니까?")) {
		//서버의 URL을 설정한다 
		document.getElementById("action").value = "updateForm";
        document.getElementById("viewForm").submit();
	}	
}
</script>


</body>
</html>