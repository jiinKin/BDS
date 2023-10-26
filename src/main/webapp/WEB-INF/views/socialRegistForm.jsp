<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>소셜 간편 가입 페이지</title>
<link rel="stylesheet" href="css/font.css">
<script type="text/javascript"src="https://code.jquery.com/jquery-3.7.0.js"></script>
<link rel="stylesheet" href="css/registForm.css">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>

		<div>
			<h1 class="mainTitle"> <a class="a" href="./index.jsp">계발의민족</a></h1>
		</div>
		
<div id="wrapper">
    <form action="./socialRegist.do" id="frm" name="frm" method="post">

        <!-- content-->
        <div id="content">
	        <div>
				<h2 class="join_title">소셜 간편가입 페이지</h2>
			</div>
             <div>
    <h3 class="join_title">
        <label for="id">아이디(이메일)</label>
    </h3>
    <span class="box int_id">
        <input type="text" id="user_email" name="user_email" class="int" maxlength="20">
    </span>
   		<button id="checkEmailButton" class="checkButton" type="button">이메일 중복 체크</button>
</div>

            <!-- PW1 -->
            <div>
                <h3 class="join_title"><label for="pswd1">비밀번호</label></h3>
                <span class="box int_pass">
                    <input type="password" id="pswd1" name="user_password" class="int" maxlength="20">
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
                    <input type="text" id="user_name" name="user_name" class="int" maxlength="20"
                        value="${socialInfo.user_name}" readonly="readonly">
                </span>
            </div>

             <!-- BIRTH -->
                <div>
                    <h3 class="join_title">
                    <label for="yy">생년월일</label></h3>
                    <div id="bir_wrap">
					<input type="text" id="birthdate" name="user_birth">	
					</div>

            <!-- GENDER -->
            <div>
                <h3 class="join_title"><label for="gender">성별</label></h3>
                <span class="box gender_code">
                    <select id="gender" class="sel" name="user_gender">
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
							maxlength="16" value="${socialInfo.user_phone}">
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
            <input type="hidden" name="naver_key" value="${socialInfo.naver_key}">
            </div>
    </form>
 </div>
<script type="text/javascript">
    <c:if test="${not empty alertMessage}">
        var alertMessage = "<c:out value='${alertMessage}' />";
        alert(alertMessage);
    </c:if>
</script>
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
