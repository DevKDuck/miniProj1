<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="member.MemberVO" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>update</title>
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
 
  
 %>

  	<form id="insertForm" action="board.do" method="post">
    	<input type="hidden" name="action" value="insert">
        
         <label>아이디: </label> <input type="text" id="member_id" name="member_id" value="<%= memberID %>" readonly="readonly" style="width: 200px;" ><br/>
        <label>제목</label>   <input type="text" id="btitle" name="btitle" required="required"><br/>
        <label>내용</label>   <input type="text" id="bcontent" name="bcontent" value="${board.bcontent}" style="height: 500px;" ><br/>
       
        <input type="hidden" id="bdate" name="bdate" value="${board.bdate}">
        <input type="hidden" id="bcount" name="bcount" value="${board.bcount}">
        <input type="hidden" id="bwriter" name="bwriter" value="${board.bwriter}">
        
	        <input type="submit" value="등록">
	        <a href="board.do?action=list" >취소</a>
	    
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