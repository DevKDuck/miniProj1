<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    
    <!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>horizontal-menu</title>
    <link rel="stylesheet" href="../style/reset.css">
    <style>
    * {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}
a,
a:active,
a:visited {
    text-decoration: none;
    color: inherit;
}
a:hover {
    color: inherit;
    text-decoration: underline;
}
li {
    list-style-type: none;
}
          .lnb>ul {display: flex;
            justify-content: center;
            text-align: center;
        }
        .lnb li { margin-right:2px; }
        .lnb a {display: block;
                width: 200px; height: 40px; text-align: center; line-height: 40px; background-color: coral;
                color: white;
        }
        .subMenu { display: none; position: absolute;}
        .lnb>ul>li:hover .subMenu {display: block;}
        .lnb>ul>li:hover>a{ background-color: lightcoral; }
        .subMenu a:hover { background-color: orangered;}



Resources
 
    </style>

 <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>miniProject1</title>
    <style>
    body {
            background-color: #f6f6f6;
            font-family: Arial, sans-serif;
        }
        h1 {
            text-align: center;
            color: coral;
        }
    </style>

</head>


<body>

<h1> miniProject1 </h1>
    <header>   
    <div class="lnb">
            <ul>
                <li><a href="#">회사소개</a>
                    <ul class="subMenu">
                        <li><a href="introduction.html">회사소개</a></li>
                    </ul>
                </li>
                   <li id="signupMenu" style="display: none;"><a href="#">회원가입</a>
                    <ul class="subMenu">
                        <li><a href="member.do?action=insertForm">회원가입</a></li>
                    </ul>
                </li>
                
                   <li id="mypageMenu" style="display: none;"><a href="#">마이페이지</a>
                    <ul class="subMenu">
                        <li><a href="member.do?action=mypage">마이페이지</a></li>
                    </ul>
                </li>
                
                 <li id="memberManagementMenu" style="display: none;"><a href="#">회원관리</a>
                    <ul class="subMenu">
                        <li><a href="member.do?action=list">회원관리</a></li>
                    </ul>
                </li>
                
                
       
                
                <li><a href="#">게시판</a>
                    <ul class="subMenu">
                    <li><a href="board.do?action=list">게시판</a></li>

                </ul>
                </li>
                
                
                 <li id="loginMenu" style="display: none;"><a href="#">로그인</a>
                    <ul class="subMenu">
                        <li><a href="member.do?action=loginForm">로그인</a></li>
                    </ul>
                </li>
                
                 <li id="logoutMenu" style="display: none;"><a href="#">로그아웃</a>
                    <ul class="subMenu">
                        <li><a href="member.do?action=logout">로그아웃</a></li>
                    </ul>
                </li>
               
            </ul>
        </div>
 
    </header>


    

    
      <script>
        // 로그인 여부에 따라 회원가입과 마이페이지 메뉴를 표시 또는 숨깁니다.
        /* const isLoggedIn = false; */ // 로그인 여부에 따라 true 또는 false로 설정
        var isLoggedIn = <%= session.getAttribute("loginVO") != null %>;
        var loginIDisBituser = <%= session.getAttribute("managerID") != null%>;
        
        
        const signupMenu = document.getElementById('signupMenu');
        const mypageMenu = document.getElementById('mypageMenu');
        const memberManagementMenu = document.getElementById('memberManagementMenu');
        const loginMenu = document.getElementById('loginMenu');
        const logoutMenu = document.getElementById('logoutMenu');
        
        
        if (isLoggedIn) {
        	logoutMenu.style.display = 'block';
        	if (loginIDisBituser){
        		memberManagementMenu.style.display = 'block';	
        	}else{
        		mypageMenu.style.display = 'block';	
        	}
            
        } else {
            signupMenu.style.display = 'block';
            loginMenu.style.display = 'block';
        }
        
    </script>
</body>
</html>