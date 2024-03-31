<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="member.MemberVO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

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


  
<h1> view </h1>
 <%
// 세션에서 MemberID 값을 가져옵니다.
Object s = session.getAttribute("loginVO");
 String memberID = "1";
 if (s != null) {
     // loginVO 클래스로 캐스팅하여 getMember_id() 메서드 호출
     if (s instanceof MemberVO) {
    	 MemberVO login = (MemberVO) s;
         memberID = "1";
     }
 } 
 %> 
 <br>
 <br>
 <div class="container">
 <br><label>번호 : ${view.bno}</label> <br/>
 <br><label>제목  : ${view.btitle}</label> <br/>
 <br><label>내용  : ${view.bcontent}</label> <br/>
 <br><label>아이디  : ${view.member_id}</label> <br/>
 <br><label>날짜  : ${view.bdate}</label> <br/>
 <br><label>본 횟수  : ${view.bcount}</label> <br/>
 <br><label>작성자  : ${view.bwriter}</label> <br/>
 <br><br>
 <form id="viewForm" action="board.do" method="post">
    <input type="hidden" id="action" name="action" value="">
    <input type="hidden" id="bnoInput" name= "bno" value= "${view.bno}">
    
    <!-- 이부분 자료형때문인지 해결해야됨 -->
    <c:if test="${view.member_id eq '1' or view.member_id eq 'bituser'}">
        <input type="button" value="삭제" onclick="jsDelete()">
        <input type="button" value="수정" onclick="jsUpdateForm()">
     </c:if> </br>
<br><br>
    <a href="board.do?action=list" >게시판 돌아가기</a>
 
</form>
</div>
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
					alert("게시물을 삭제 하였습니다");
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