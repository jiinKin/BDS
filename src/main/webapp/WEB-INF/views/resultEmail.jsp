<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기 결과</title>
<link rel="stylesheet" href="css/font.css">
<script type="text/javascript"src="https://code.jquery.com/jquery-3.7.0.js"></script>
<link rel="stylesheet" href="css/searchResult.css">
</head>
<body>


		<div>
			<h1 class="mainTitle"> <a class="a" href="./index.jsp">계발의민족</a></h1>
		</div>
		
	
		<div id="content">
			<h2 class="join_title"><label for="name">찾은 아이디</label></h2>
			<c:choose>
			    <c:when test="${empty resultEmail}">
			        <span class="box int_name">
			            <input type="text" value="일치하는 회원정보가 없습니다." id="user_name"
			                   name="user_name" class="int" maxlength="20" readonly="readonly">
			        </span>
			    </c:when>
			    <c:otherwise>
				     <span class="box int_name">
				     <input type="text" value="${resultEmail}" id="user_name"
				           name="user_name" class="int" maxlength="20" readonly="readonly">
				     </span>
			    </c:otherwise>
			</c:choose>
			<div id="bottomButton">
				<input class="loginButton" type="button" name="find" id="regist" value="로그인하기" onclick="location.href='./loginPage.do'">
				<input class="findPW" type="button" name="cancle" value="비밀번호찾기" onclick="location.href='./moveSearchPW.do'">
			</div>
		</div>
</body>
</html>