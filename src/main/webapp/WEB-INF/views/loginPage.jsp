<%@page import="com.dowon.bds.dto.SocialDto"%>
<%@page import="com.dowon.bds.dto.URLDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.security.SecureRandom" %>
<%@ page import="java.math.BigInteger" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인페이지</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="css/loginPage.css">
<link rel="stylesheet" href="css/font.css">
</head>
<body>
	<c:if test="${not empty failLogin}">
        <script>
            alert("${failLogin}");
        </script>
    </c:if>
    
    <c:if test="${not empty newPassword}">
    	<script>
    	alert("${newPassword}")
    	</script>
    </c:if>
    
	<%
		URLDto uDto = new URLDto();
		SocialDto dto = new SocialDto();
		SecureRandom random = new SecureRandom();
		String state = new BigInteger(130, random).toString();
	%>
	<div>
		<h1 class="mainTitle"><a class="a" href="./index.jsp">계발의민족</a></h1>
	</div>	
	
	
  <div class="flex-container" id="header">

  <!-- 일반회원 로그인 -->
  <form action="./login.do" method="post">
    <div class="form-group">
      <label for="usr">아이디(이메일)</label>
      <input type="text" class="form-control" id="usr" name="user_email">
    </div>
    <div class="form-group">
      <label for="pwd">비밀번호</label>
      <input type="password" class="form-control" id="pwd" name="user_password">
    </div>
    <input type="submit" class="btn btn-primary" value="로그인"><br>
  </form>
  
  
  <div>
	  <a class="textlink" href="./searchForm.do">이메일 찾기 / 비밀번호 찾기</a>
	  <a class="textlink" href="./nomalRegistForm.do">회원 가입</a>
  </div>
  
  <!-- 네이버 아이디로 로그인  -->
  	<div>
	  <a href="<%=uDto.getNaverUrl()+"&client_id="+dto.getNaverClientID()+"&redirect_uri="+uDto.getNaverRedirect()+"&state="+state%>">
	  <img height="50" src="img/btnG_icon_circle.png"/>
	  <span>네이버 로그인</span>
 	 </a>
  	</div>
  	</div>
 <script type="text/javascript">
    <c:if test="${not empty alertMessage}">
        var alertMessage = "<c:out value='${alertMessage}' />";
        alert(alertMessage);
    </c:if>
</script>
</body>
</html>