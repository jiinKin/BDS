<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>어드민 페이지 헤더</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="css/adminHeader.css"/>
</head>
<body>

	<div class="flex-container" id="header">
		<div class="topLogo"></div>
		
		<div>
			 <h1 class="mainTitle"><a class="a" href="./moveAdminPage.do">계발의민족</a></h1>
		</div>
		
		<div class="topLogo" id="loginBtn" style="margin-top: 30px;">
			<span class="inline-elements">${loginDto.user_name} 님 환영합니다.</span>
			<button class="btn btn-info inline-elements" onclick="location.href='./logout.do'">로그아웃</button>  
		</div>
	</div>

<!-- 		<div> -->
<!-- 			<h1 class="mainTitle"> -->
<!-- 			계발의민족 관리자 페이지</h1> -->
<!-- 		</div> -->
		
		
		
		
<!-- 		어드민페이지 메뉴바 -->
<nav class="navbar navbar-default">
    <div class="container-fluid">
      <div class="navbar-header"></div>
      <ul class="nav navbar-nav">
        <li class="menu-item">
          <a href="#">도서관리</a>
          <div class="submenu">
            <ul>
              <li><a href="./bookMagagement.do">도서 리스트</a></li>
              <li><a href="./addBook.do">도서 등록</a></li>
            </ul>
          </div>
        </li>
        <li><a href="./freeBoardList.do">자유게시판</a></li>
        <li><a href="./faqList.do">FAQ</a></li>
        <li><a href="./oldAdminRentList.do">회원 대출 관리</a></li>
      </ul>
    </div>
  </nav>
  
  

</body>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="js/adminHeader.js"></script>

</html>