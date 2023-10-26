function sendSMS(){ 
   console.log("sendSMS function called")
        var user_phone = document.getElementById("user_phone").value;
        
        // 정규식을 사용하여 패턴 체크
        var pattern = /^01[016789]\d{7,8}$/;

      if(user_phone ==""){
         writenum();
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
   alert("번호를 잘못 입력했어요");
}

function writenum(){
   alert("값을 입력하세요");
}

var checkStatus = false;

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
	var user_phone = document.getElementById("user_phone").value;
	var formatted_phone = user_phone.replace(/(\d{3})(\d{4})(\d{4})/, '$1-$2-$3');
    var email = document.getElementById("user_email").value;
    document.getElementById("formatted_phone").value = formatted_phone;
   
    if (checkStatus) {
        console.log("checkStatus true");
        document.getElementById("frm").submit();
    }else if(email.trim() === ""){
		console.log("이메일을 입력하세요.")
		alert("이메일을 입력하세요.");
     }
     else if (!checkStatus) {
        console.log("checkStatus false");
        alert("휴대폰 인증을 진행해 주세요.");
    }
});

