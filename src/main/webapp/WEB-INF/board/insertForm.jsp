<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="member.MemberVO" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>update</title>
</head>
<body>

 <h1>게시판 등록</h1>
 
 <%
// 세션에서 MemberID 값을 가져옵니다.
Object s = session.getAttribute("loginVO");
 String memberID = null;
 if (s != null) {
     // loginVO 클래스로 캐스팅하여 getMember_id() 메서드 호출
     if (s instanceof MemberVO) {
    	 MemberVO login = (MemberVO) s;
         memberID = login.getMember_id();
     }
 }
 %> 	<form id="insertForm" action="board.do" method="post">
    	<input type="hidden" name="action" value="insert">
        
         <label>아이디: </label> <input type="text" id="member_id" name="member_id" value="<%= memberID %>" readonly><br/>
        <label>제목  : </label>   <input type="text" id="btitle" name="btitle" required="required" style="width: 1000px;"><br/>
        <label>내용  : </label>   <input type="text" id="bcontent" name="bcontent" value="${board.bcontent}" style="width: 1000px; height: 500px;" ><br/>
       
        <input type="hidden" id="bdate" name="bdate" value="${board.bdate}">
        <input type="hidden" id="bcount" name="bcount" value="${board.bcount}">
        <input type="hidden" id="bwriter" name="bwriter" value="${board.bwriter}"></br>
        
	        <input type="submit" value="등록" style="margin-left: 950px;">
	        <a href="board.do?action=list" >취소</a>
	    </div>
    </form>
    
    <script type="text/javascript" src="<c:url value='/js/common.js'/>"></script>
    
    <script type="text/javascript">
    
    const rForm = document.getElementById("insertForm");
     
    rForm.addEventListener("submit", e => {
    	//서버에 form data를 전송하지 않는다 
    	e.preventDefault();
    	
    	
    	myFetch("board.do", "insertForm", json => {
    		if(json.status == 0) {
    			//성공
    			alert("게시물 등록을 성공 하였습니다");

    			location = "board.do?action=list";

    		} else {
    			alert(json.statusMessage);
    		}
    	});
    });
    </script> 
</body>
</html>