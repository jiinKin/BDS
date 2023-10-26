function sendSMS(){ 
   console.log()
        var user_phone = document.getElementById("user_phone").value;
        // 정규식을 사용하여 패턴 체크
        var pattern = /^01[016789]\d{7,8}$/;

      if(user_phone ==""){
         writenum();
      }else{
         
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
         data: {user_phone:user_phone},
         type: "POST",
         dataType: "json",
         success: function(result) {
            console.log("success 작동함")
         },
         error:function(){
         	console.log("error 작동함")
         }
      })
   }
function failalert(){
   Swal.fire({
      icon: 'error',
      title: '잘못된 형식의 입력값 입니다.',
      customClass: {
         confirmButton: 'btn btn-primary w-xs',
      },
      buttonsStyling: false,
      html:'전화번호는 - 를 제외하고 입력해주세요.'
   })
}

function writenum(){
   Swal.fire({
      icon: 'error',
      title: '입력 후 인증해주세요.',
      customClass: {
         confirmButton: 'btn btn-danger w-xs',
      },
      buttonsStyling: false,
      html:'전화번호는 - 를 제외하고 입력해주세요.'
   })
}