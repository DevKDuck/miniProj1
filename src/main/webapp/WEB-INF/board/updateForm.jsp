<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>update</title>
</head>
<body>


 <h1>게시판 수정</h1>
 	<form id="updateForm" action="board.do" method="post">
    	<input type="hidden" name="action" value="update">
        <label>번호 : </label> <input type="text" id="bno" name="bno" value="${board.bno}" readonly="readonly">  <label style="margin-left: 20px;">아이디: </label> <input type="text" id="member_id" name="member_id" value="${board.member_id}" readonly="readonly"><br/>
        <label>제목 : </label>   <input type="text" id="btitle" name="btitle" required="required" style="width: 1000px;"><br/>
        <label>내용 : </label>   <input type="text" id="bcontent" name="bcontent" value="${board.bcontent}" style="width: 1000px; height: 500px;" ><br/>
       
        <input type="hidden" id="bdate" name="bdate" value="${board.bdate}">
        <input type="hidden" id="bcount" name="bcount" value="${board.bcount}">
        <input type="hidden" id="bwriter" name="bwriter" value="${board.bwriter}"></br>
        
	        <input type="submit" value="수정" style="margin-left: 950px;">
	        <a href="board.do?action=view&bno=${board.bno}" >취소</a>
	    </div>
    </form>
    
    <script type="text/javascript" src="<c:url value='/js/common.js'/>"></script>
    
    <script type="text/javascript">
    
    const rForm = document.getElementById("updateForm");
     
    rForm.addEventListener("submit", e => {
    	//서버에 form data를 전송하지 않는다 
    	e.preventDefault();
    	
    	
    	myFetch("board.do", "updateForm", json => {
    		if(json.status == 0) {
    			//성공
    			alert("회원 정보 수정을 성공 하였습니다");

    			location = "board.do?action=view&bno=" + bno.value;

    		} else {
    			alert(json.statusMessage);
    		}
    	});
    });
    </script> 
</body>
</html>