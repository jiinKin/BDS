<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>header</title>
<!-- <link rel="stylesheet" href="css/font.css"> -->
<link rel='stylesheet' href='css/header.css'/>
</head>
<body>

<!-- 헤더 전체 div -->
<div style="height: 20vh;">

<!-- 헤더 첫번째 div -->
	<div class="flex-container" id="header">
		<div class="topLogo" ></div>
		<div>
			<h1 class="mainTitle"> <a class="a" href="./index.jsp">계발의민족</a></h1>
		</div>
		<div class="topLogo" id="loginBtn" style="margin-top: 30px;">
			
			<!--로그인 상태확인 -->
			<c:choose>
				<c:when test="${loginDto == null}">
			    <button class="btn"
				onclick="location.href='./nomalRegistForm.do'">회원가입</button>
					<button class="btn" id="loginButton"
						onclick="location.href='./loginPage.do'">로그인</button>
				</c:when>
				<c:otherwise>
					<span id="rentInfo"> 
						${loginDto.user_name}님&nbsp;&nbsp;
<%-- 						<c:if test="${loginDto.user_auth eq 'U'}"> --%>
<%-- 						대출상태 : <a href="./userRentPageList.do"> ${sessionScope.userStatus.RENT_STATUS} </a>&nbsp;&nbsp; --%>
<%-- 						예약상태 : <a href="./userResvePageList.do"> ${sessionScope.userStatus.RESVE_STATUS} </a> &nbsp;&nbsp; --%>
<%-- 					 	</c:if> --%>


					<c:if test="${loginDto.user_auth eq 'U'}">
					    대출상태 :
					    <c:choose>
					        <c:when test="${sessionScope.userStatus.RENT_STATUS eq 'Y'}">
					            <a href="./userRentPageList.do">대출중</a>
					        </c:when>
					        <c:otherwise>
					            <a href="./userRentPageList.do">조회</a>
					        </c:otherwise>
					    </c:choose>
					    &nbsp;&nbsp;
					    예약상태 :
					    <c:choose>
					        <c:when test="${sessionScope.userStatus.RESVE_STATUS eq 'Y' || sessionScope.userStatus.RESVE_STATUS eq 'R'}">
					            <a href="./userResvePageList.do">예약중</a>
					        </c:when>
					        <c:otherwise>
					            <a href="./userResvePageList.do">조회</a>
					        </c:otherwise>
					    </c:choose>
					</c:if>
					
					
					 </span>
					<c:if test="${loginDto.user_auth eq 'A'}">
					<button class="btn" id="adminbutton" onclick="location.href='./moveAdminPage.do'">
					관리자페이지
					</button>
					<button class="btn" id="headerButton" onclick="location.href='./logout.do'">로그아웃</button>
					</c:if>
					<span>
					<c:if test="${loginDto.user_auth eq 'U'}">
						<button class="btn" id="headerButton" onclick="location.href='./myPage.do'">내 정보</button>
						<button class="btn" id="headerButton" onclick="location.href='./logout.do'">로그아웃</button>
					</c:if>
					</span>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
	
	<!-- 헤더 두번째 div -->

	<nav class="navbar navbar-default">
		<div class="container-fluid">
			<div class="navbar-header"></div>
			<ul class="nav navbar-nav">
				<li><a href="./noticeBoardList.do">공지사항</a></li>
				<li><a href="./userBookList.do">도서목록</a></li>

				<li><a href="./freeBoardList.do">자유게시판</a></li>

				<li><a href="./faqList.do">FAQ</a></li>
			</ul>
		</div>
	</nav>
	
	</div>
</body>
</html>