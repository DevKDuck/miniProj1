<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

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


 <h1>게시판 수정</h1>
 	<form id="updateForm" action="board.do" method="post">
    	<input type="hidden" name="action" value="update">
        <label>번호 : </label> <input type="text" id="bno" name="bno" value="${board.bno}" style="width: 50px;" readonly="readonly"> 
         <label style="margin-left: 20px;">아이디: </label> <input type="text" id="member_id" name="member_id" value="${board.member_id}" style="width: 100px;" readonly="readonly"><br/>
        <label>제목 : </label>   <input type="text" id="btitle" name="btitle"  value="${board.btitle}"required="required" ><br/>
        <label>내용 : </label>   <input type="text" id="bcontent" name="bcontent" value="${board.bcontent}" style="height: 500px;" ><br/>
       
        <input type="hidden" id="bdate" name="bdate" value="${board.bdate}">
        <input type="hidden" id="bcount" name="bcount" value="${board.bcount}">
        <input type="hidden" id="bwriter" name="bwriter" value="${board.bwriter}"></br>
        
	        <input type="submit" value="수정">
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