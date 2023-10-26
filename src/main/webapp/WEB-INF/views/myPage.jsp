<%@page import="java.math.BigInteger"%>
<%@page import="java.security.SecureRandom"%>
<%@page import="com.dowon.bds.dto.SocialDto"%>
<%@page import="com.dowon.bds.dto.URLDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="css/font.css">
<link rel="stylesheet" href="css/myPage.css">
<link rel="stylesheet" href="css/header.css">
</head>
<%@ include file="/WEB-INF/views/header.jsp" %>
<body>
<%
		URLDto uDto = new URLDto();
		SocialDto dto = new SocialDto();
		SecureRandom random = new SecureRandom();
		String state = new BigInteger(130, random).toString();
	%>

<div id="sidebar">
	<div>
		<h3> 마이페이지 </h3>
	</div>
	<ul>
		<li onclick="window.location.href='./myPage.do'">회원정보</li>
		<li onclick="window.location.href='./moveModifyPW.do'">비밀번호수정</li>
        <li onclick="window.location.href='./userPayPageList.do'">결제내역</li>
        <li onclick="window.location.href='./userRentPageList.do'">대출내역</li>
        <li onclick="window.location.href='./userResvePageList.do'">예약내역</li>
	</ul>
</div>	
	
<div id="maincontent">

<div class="user-details">
    <h3>회원 정보</h3>
    <div class="detail-row">
        <div class="label-container">
            회원 번호
        </div>
        <div class="value-container">
            ${userInfo.user_seq}
        </div>
    </div>

    <div class="detail-row">
        <div class="label-container">
            이름
        </div>
        <div class="value-container">
            ${userInfo.user_name}
        </div>
    </div>

    <div class="detail-row">
        <div class="label-container">
            가입일
        </div>
        <div class="value-container">
            <fmt:formatDate value="${userInfo.joindate}" pattern="yyyy-MM-dd" />
        </div>
    </div>

    <div class="detail-row">
        <div class="label-container">
            이메일
        </div>
        <div class="value-container">
            ${userInfo.user_email}
        </div>
    </div>

    <div class="detail-row">
        <div class="label-container">
            전화번호
        </div>
        <div class="value-container">
            ${userInfo.user_phone}
        </div>
    </div>

    <div class="detail-row">
        <div class="label-container">
            생년월일
        </div>
        <div class="value-container">
            ${userInfo.user_birth}
        </div>
    </div>

    <div class="detail-row">
        <div class="label-container">
            성별
        </div>
        <div class="value-container">
            ${userInfo.user_gender}
        </div>
    </div>
    <div>
	  <a href="<%=uDto.getNaverUrl()+"&client_id="+dto.getNaverClientID()+"&redirect_uri="+uDto.getNaverLinkRedirect()+"&state="+state%>">
	  <img height="50" src="img/btnG_icon_circle.png"/>
	  <span>네이버 연동하기</span>
 	 </a>
  	</div>
</div>
</div>



</body>
<%@ include file="footer.jsp" %>
</html>