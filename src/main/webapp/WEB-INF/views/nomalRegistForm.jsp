<%@page import="java.math.BigInteger"%>
<%@page import="java.security.SecureRandom"%>
<%@page import="com.dowon.bds.dto.SocialDto"%>
<%@page import="com.dowon.bds.dto.URLDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 페이지</title>
<link rel="stylesheet" href="css/font.css">
<script type="text/javascript"src="https://code.jquery.com/jquery-3.7.0.js"></script>
<link rel="stylesheet" href="css/registForm.css">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

</head>
<body>

<%
		URLDto uDto = new URLDto();
		SocialDto dto = new SocialDto();
		SecureRandom random = new SecureRandom();
		String state = new BigInteger(130, random).toString();
%>


		<div>
			<h1 class="mainTitle"> <a class="a" href="./index.jsp">계발의민족</a></h1>
		</div>
		
		<div id="header">
		<h4>소셜아이디로 회원가입하기</h4>
        <div class="socialJoin">
	 		 <a class="a" href="<%=uDto.getNaverUrl()+"&client_id="+dto.getNaverClientID()+"&redirect_uri="+uDto.getNaverJoinRedirect()+"&state="+state%>">
	  		<img height="50" src="img/btnG_icon_circle.png"/><br>
	 		 <span>네이버 회원가입</span>
 			 </a>
		 </div>
		 </div>
	<!-- wrapper -->
        <div id="wrapper">
		<form action="./nomalRegist.do" id="frm" name="frm" method="post">

            <!-- content-->
            <div id="content">
                <!-- ID -->
                <h2>일반 회원가입하기</h2>
                
 <div>
    <h3 class="join_title">
        <label for="id">아이디(이메일)</label>
    </h3>
    <span class="box int_id">
        <input type="text" id="user_email" name="user_email" class="int" maxlength="24"
        placeholder="ex) dowon@dowon.com">
    </span>
   		<button id="checkEmailButton" class="checkButton" type="button">이메일 중복 체크</button>
</div>

<!-- PW1 -->
<div>
    <h3 class="join_title"><label for="pswd1">비밀번호</label></h3>
    <span class="box int_pass">
        <input type="password" id="pswd1" name="user_password" class="int" maxlength="24"
        placeholder="영어 대,소문자, 숫자, 특수문자 하나 이상 포함,최소 8자 이상">
    </span>
</div>

			<!-- PW2 -->
			<div>
			    <h3 class="join_title"><label for="pswd2">비밀번호 재확인</label></h3>
			    <span class="box int_pass_check">
			        <input type="password" id="pswd2" class="int" maxlength="20">
			    </span>
			</div>

			<!-- NAME -->
			<div>
			    <h3 class="join_title"><label for="name">이름</label></h3>
			    <span class="box int_name">
			        <input type="text" id="user_name" name="user_name" class="int" maxlength="20">
			    </span>
			</div>

                <!-- BIRTH -->
				<div>
					<h3 class="join_title">
						<label for="yy">생년월일</label>
					</h3>
					<div id="bir_wrap">
						<input type="text" id="birthdate" name="user_birth">
					</div>
				</div>
					<!-- GENDER -->
					<div>
						<h3 class="join_title">
							<label for="gender">성별</label>
						</h3>
						<span class="box gender_code"> <select id="gender"
							class="sel" name="user_gender">
								<option>성별</option>
								<option value="M">남자</option>
								<option value="F">여자</option>
						</select>
						</span>
					</div>

					<!-- MOBILE -->
					<div>
					<h3 class="join_title">
						<label for="user_phone">휴대전화</label>
					</h3>
					<span class="box int_phone">
						<input type="tel" id="user_phone" name="user_phone" class="int"
							maxlength="16" placeholder="하이픈빼고(-) 전화번호 입력">
					</span>
					<button id="checkPhone" class="checkPhoneButton" type="button"> 번호 중복 체크 </button>
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
						<button class="joinButton" type="button" id="regist">가입하기</button>
					</div>
			</div>
            <!-- content-->
            
            <input type="hidden" id="formatted_phone" name="formatted_phone">
			</form>
        </div> 
<script src="js/registForm.js"></script>
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
<script>
    flatpickr("#birthdate", {
        dateFormat: "Y-m-d",  // 날짜 형식 설정 (예: 2023-10-01)
        maxDate: new Date(),  // 현재 날짜를 최대 선택 가능 날짜로 설정
    });
</script>
</body>
</html>