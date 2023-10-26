<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지-비밀번호변경</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="css/font.css">
<link rel="stylesheet" href="css/header.css">
<link rel="stylesheet" href="css/myPage.css">
<link rel="stylesheet" href="css/myPageModifyPW.css">
</head>
<%@ include file="/WEB-INF/views/header.jsp" %>
<body>
<div id="sidebar">
	<div>
	<h4>${loginDto.user_name}님<br/></h4>
	<h5>가입일 : <fmt:formatDate value="${loginDto.joindate}"/></h5> 
	</div>
	<ul>
		<li onclick="window.location.href='./myPage.do'">회원정보</li>
		<li onclick="window.location.href='./moveModifyPW.do'">비밀번호수정</li>
        <li onclick="window.location.href='./userPayPageList.do'">결제내역</li>
        <li onclick="window.location.href='./userRentPageList.do'">대출내역</li>
        <li onclick="window.location.href='./userResvePageList.do'">예약내역</li>
	</ul>
</div>	
	
<div id="maincontent" class="password-change-form">

<h2>비밀번호 변경</h2>
<form action="./modifyPassword.do" method="post" id="modifyButton">
<div class="form-group">
    <label for="currentPassword">현재 비밀번호 입력</label>
    <input type="password" id="currentPassword" name="currentPassword" placeholder="현재 비밀번호를 입력해주세요.">
</div>

<div class="form-group">
    <label for="newPassword">새로운 비밀번호</label>
    <input type="password" id="newPassword" name="newPassword" placeholder="변경하실 비밀번호를 입력해주세요.">
</div>

<div class="form-group">
    <label for="confirmPassword">새로운 비밀번호 재입력</label>
    <input type="password" id="confirmPassword" name="confirmPassword" placeholder="변경하실 비밀번호를 재입력해주세요.">
</div>

<div class="form-group">
    <input type="button" value="비밀번호 변경" class="btn-change-password" onclick="changePassword()">
</div>
</form>
</div>

</body>
<script type="text/javascript" src="js/modifyPassword.js"></script>
<%@ include file="footer.jsp" %>
</html>