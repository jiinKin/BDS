<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
</head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="css/myPage.css">
<%@ include file="/WEB-INF/views/header.jsp" %>
<body>
<div id="sidebar">
	<div>
	<h4>${loginDto.user_name}님<br/></h4>
	<h5>가입일 : <fmt:formatDate value="${loginDto.joindate}"/></h5> 
	</div>
	<ul>
		<li onclick="window.location.href='checkUserInfo.do'">회원정보수정</li>
		<li onclick="window.location.href='modifyPassword.do'">비밀번호수정</li>
        <li>결제내역</li>
        <li>대출내역</li>
        <li>예약내역</li>
	</ul>
</div>	
	
<div id="maincontent">메인</div>
</body>
<%@ include file="footer.jsp" %>
</html>