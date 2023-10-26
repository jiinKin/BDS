<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기</title>
<link rel="stylesheet" href="css/font.css">
<script type="text/javascript"src="https://code.jquery.com/jquery-3.7.0.js"></script>
<link rel="stylesheet" href="css/searchID.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>

<c:if test="${not empty newPassword}">
    	<script>
    	alert("${failPassword}")
    	</script>
    </c:if>


		<div>
			<h1 class="mainTitle"> <a class="a" href="./index.jsp">계발의민족</a></h1>
		</div>

			<div id="content">
			<button class="searchButton" id="idSearchButton" onclick="location.href='./moveSearchID.do'">아이디 찾기</button>
			<button class="searchButton" id="passwordSearchButton" onclick="location.href='./moveSearchPW.do'">비밀번호 찾기</button>
		<form action="./findPW.do" id="frm" name="frm" method="post">
			    
			    <h3 class="join_title"><label for="email">이메일</label></h3>
			    <span class="box int_name">
			        <input type="text" id="user_email" name="user_email" class="int" maxlength="20">
			    </span>
			
					<!-- MOBILE -->
					<div>
					<h3 class="join_title">
						<label for="user_phone">휴대전화</label>
					</h3>
					<span class="box int_phone">
						<input type="tel" id="user_phone" name="user_phone" class="int"
							maxlength="16" placeholder="하이픈빼고(-) 전화번호 입력">
					</span>
					<button id="afterCheckPhone" class="checkPhoneButton" type="button" onclick="sendSMS()">인증문자 보내기</button>
					</div>
					<h3 class="join_title"></h3>
					<!-- 사용자로부터 인증번호 입력 -->
					<div>
					<span class="box int_id">
						<input type="text" id="userInputCode" class="int"
							placeholder="인증번호 입력">
					</span>
					<button class="checkButton" type="button" onclick="verifyCode()">인증 확인</button>
					</div>
					
					<!-- JOIN BTN-->
					<div class="btn_area">
						<input class="joinButton" type="button" name="find" id="regist" value="임시비밀번호발급">
						<input class="cancleButton" type="button" name="cancle" value="취소" onclick="history.back()">
					</div>
            <input type="hidden" id="formatted_phone" name="formatted_phone">
			</form>
			</div>
</body>
<script src="js/searchPW.js"></script>
</html>