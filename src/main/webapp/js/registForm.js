var checkDuplication = false;

// 유효성 검사 함수
function validateForm() {
    var email = document.getElementById("user_email").value;
    var password = document.getElementById("pswd1").value;
    var confirmPassword = document.getElementById("pswd2").value;
    var name = document.getElementById("user_name").value;
    var gender = document.getElementById("gender").value;

    // 이메일 유효성 검사 (간단한 형식 체크)
    var emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!email.match(emailPattern)) {
        alert("올바른 이메일 주소를 입력하세요.");
        return false;
    }

    // 비밀번호 유효성 검사 (예: 최소 8자 이상)
    var passwordRegex = /^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#$%^&*()_+{}\[\]:;<>,.?~\\/-]).{8,}$/;
    if (!passwordRegex.test(password)) {
   	 	alert("비밀번호는 영어 대문자, 소문자, 숫자, 특수문자를 각각 하나 이상 포함하여 최소 8자 이상이어야 합니다.");
   		return false;
}

    // 비밀번호 재확인 일치 여부 검사
    if (password !== confirmPassword) {
        alert("비밀번호가 일치하지 않습니다.");
        return false;
    }

    // 이름이 비어있는지 검사
    if (name.trim() === "") {
        alert("이름을 입력하세요.");
        return false;
    }
    
    if (gender === "성별") {
        alert("성별을 선택하세요.");
        return false;
    }

    // 모든 유효성 검사를 통과하면 true 반환
    return true;
}


//전화번호 중복 체크
document.getElementById('checkPhone').addEventListener('click', function() {
    var phoneNum = document.getElementById('user_phone').value;
    var formatted_phone = phoneNum.replace(/(\d{3})(\d{4})(\d{4})/, '$1-$2-$3');
    if (phoneNum.trim() === "") {
        alert("전화번호를 입력하세요.");
        return;
    }
    $.ajax({
        url: "./checkPhone.do",
        data : {
				user_phone:formatted_phone
				},
        type: "POST",
        success: function(response) {
            if (response == 1) {
                // 중복된 번호인 경우
                alert("중복된 전화번호입니다.");
            } else if (response == 0) {
                // 중복되지 않은 번호인 경우
                checkDuplication = true;
                alert("사용 가능한 번호입니다.");
            } else {
                // 예상치 못한 응답인 경우에 대한 처리
                alert("번호 중복 체크 중 오류가 발생했습니다.");
            }
        },
        error: function() {
            // 서버 요청 실패 시에 대한 처리
            alert("번호 중복 체크 중 오류가 발생했습니다.");
        }
    });
});

//전화번호 유효성 검사 후 올바르면 coolsms에 문자 발송 요청
function sendSMS(){ 
   console.log("sendSMS function called")
        var user_phone = document.getElementById("user_phone").value;
        
        // 정규식을 사용하여 패턴 체크
        var pattern = /^01[016789]\d{7,8}$/;

      if(user_phone ==""){
         writenum();
      }else if(checkDuplication == false){
		beforeCheck();
		}
      else{
        if(pattern.test(user_phone)) {
            isc = true;
        } else {
            isc = false;
        }

        if(isc==true){
         confirmSMS(user_phone);
      }else{
         failalert();
         document.getElementById("user_phone").value="";
      }
   }
}

function confirmSMS(user_phone){
   $.ajax({
         url: "./sendPhoneSMS.do",
         data : {user_phone:user_phone},
         method : "POST",
         success: function (response) {
           if(response === "success"){
			 alert("SMS가 성공적으로 전송되었습니다.");
		}else{
			alert("SMS 전송에 실패했습니다.(ajax success)");
		}
			
        },
        error: function (error) {
            alert("SMS 전송에 실패했습니다.");
        }
    });
}

function beforeCheck(){
	alert("번호중복체크부터해주세요");
}

function failalert(){
   alert("잘못입력했어요");
}

function writenum(){
   alert("값을 입력하세요");
}

var checkStatus = false;
var checkEmail = false;

function handleResponse(response) {
    if (response === "success") {
        // 인증이 성공한 경우
        alert("인증이 성공적으로 완료되었습니다.");
        checkStatus = true;
    } else if (response === "error") {
        // 인증이 실패한 경우
        alert("인증이 실패하였습니다. 다시 시도해주세요.");
    } else {
        // 그 외의 경우 (예를 들어, 서버에서 다른 응답을 보낸 경우)
        alert("서버 오류 또는 잘못된 응답입니다.");
    }
}

function verifyCode() {
    var userInputCode = document.getElementById("userInputCode").value;
    
    // AJAX를 사용하여 userInputCode를 서버로 전송하고 결과를 받음
    $.ajax({
        url: "./checkSMS.do",
        method: "POST",
        data: { userInputCode: userInputCode },
        success: function (response) {
			console.log("verifyCode의 success MSG");
         	handleResponse(response);
        },
        error: function () {
			console.log("verifyCode의 error MSG");
            alert("인증번호 확인 중 오류가 발생했습니다.");
        }
    });
}



document.getElementById('regist').addEventListener('click', function(){
    if (checkStatus && validateForm() && checkEmail) {
        console.log("checkStatus true");
        var userInputPhone = document.getElementById('user_phone').value;
        var formattedPhoneNumber = userInputPhone.replace(/(\d{3})(\d{4})(\d{4})/, '$1-$2-$3');
        document.getElementById('user_phone').value = formattedPhoneNumber;    
        document.getElementById("frm").submit();
        alert("가입 완료 되었어요.");
    } else if (!checkStatus) {
        console.log("checkStatus false");
        alert("휴대폰 인증을 진행해 주세요.");
    } else if (!validateForm()) {
        console.log("validateForm false");
        alert("유효성 검사를 통과하지 못함");
    } else if (!checkEmail) {
        console.log("checkEmail false");
        alert("이메일 중복 체크를 진행해 주세요.");
    } else {
        console.log("checkStatus false, validateForm false, checkEmail false");
        alert("유효성 검사, 휴대폰 인증, 이메일 중복 체크를 진행해 주세요.");
    }
});

//이메일 중복 체크
document.getElementById('checkEmailButton').addEventListener('click', function() {
    var email = document.getElementById('user_email').value;
    
    if (email.trim() === "") {
        alert("이메일을 입력하세요.");
        return;
    }
    $.ajax({
        url: "./checkEmail.do",
        data : {
				user_email:email
				},
        type: "POST",
        success: function(response) {
            if (response == 1) {
                // 중복된 이메일인 경우
                alert("중복된 이메일 주소입니다.");
            } else if (response == 0) {
                // 중복되지 않은 이메일인 경우
                checkEmail = true;
                alert("사용 가능한 이메일 주소입니다.");
            } else {
                // 예상치 못한 응답인 경우에 대한 처리
                alert("이메일 중복 체크 중 오류가 발생했습니다.");
            }
        },
        error: function() {
            // 서버 요청 실패 시에 대한 처리
            alert("이메일 중복 체크 중 오류가 발생했습니다.");
        }
    });
});

