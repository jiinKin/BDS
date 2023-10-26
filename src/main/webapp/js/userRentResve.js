document.addEventListener("DOMContentLoaded", function() {
    
});
	var isReservable = document.getElementById("isReservable").value;
	var userSeq = document.getElementById("userSeq").value;
	var rentDataSize = document.getElementById("rentDataSize").value;
    var resveDataSize = document.getElementById("resveDataSize").value;
    var filteredBookSeqList = document.getElementById("filteredBookSeqList").value;
    var rentYBookSeqList = document.getElementById("rentYBookSeqList").value;
	var rentDataTitle = document.getElementById("rentDataTitle").value;
	var resveDataTitle = document.getElementById("resveDataTitle").value;
	var rentData = document.getElementById("rentData").value;
	var resveData = document.getElementById("resveData").value;
	var loginDto = document.getElementById("loginDto").value;
	var detailBook = document.getElementById("detailBook").value;
	var userName = document.getElementById("userName").value;
	var userEmail = document.getElementById("userEmail").value;
	var bookTitle = document.getElementById("bookTitle").value;
	var bookWriter = document.getElementById("bookWriter").value;
	var bookSeq = document.getElementById("bookSeq").value;

    
	console.log("isReservable : ",isReservable );
    console.log("userSeq : " , userSeq);
    console.log("filteredBookSeqList : ", filteredBookSeqList);
    console.log("rentYBookSeqList : ", rentYBookSeqList);
	console.log("rentDataSize Type : ",typeof rentDataSize);
	console.log("rentDataTitle : " ,rentDataTitle);
	console.log("resveDataTitle : " ,resveDataTitle);
	console.log("rentData : " ,rentData);
	console.log("resveData : " ,resveData);
	console.log("loginDto : ",loginDto);
	console.log("userName, userEmail : ",userName, userEmail);
	console.log("detailBook :" ,detailBook);
	console.log("bookTitle,bookWriter,bookSeq : " ,bookTitle,bookWriter,bookSeq);
	console.log("bookSeq Type : " ,typeof bookSeq);

function chkAvailability() {
	var modalContent = "";
    var modalFooter = $('<div></div>');
    var button1 = "";
    var button2 = "";
	
    if (rentDataSize == 0 && resveDataSize == 0) {
        modalContent = "<b>회원정보</b><br>이름 : " + userName + "<br>이메일 : " + userEmail + "<br><br><b>도서정보</b><br>도서명 : " + bookTitle + "<br>저자 : " + bookWriter + "<br><br><b>대출신청 확인</b><br>대출신청을 하시겠습니까?"+"<p style='color:blue;'><br><b>대출신청 버튼을 누르면 배송지 입력으로 이동합니다.</b></p>";
        button1 = $('<button type="button" class="btn btn-primary ml-2">대출신청</button>');
        button2 = $('<button type="button" class="btn btn-danger ml-2" data-dismiss="modal">닫기</button>');

        button1.click(function() {
            window.location.href = "./addr.do?book_seq=" + bookSeq;
        });

        modalFooter.append(button1);
        modalFooter.append(button2);
    } else {
        if (resveDataSize > 0) {
            modalContent = "<b>회원정보</b><br>이름 : " + userName + "<br>이메일 : " + userEmail + "<br><br><b>예약정보</b><br>" + userName + "님은 현재<br>" + resveDataTitle + " 도서를 예약중입니다."+"<p style='color:red;'><br><b>대출신청이 불가합니다.</b></p>";
            button1 = $('<button type="button" class="btn btn-warning ml-2">예약조회</button>');
            button2 = $('<button type="button" class="btn btn-danger ml-2" data-dismiss="modal">닫기</button>');
            
            button1.click(function() {
                window.location.href = "./userResvePageList.do?user_seq=" + userSeq;
            });

            modalFooter.append(button1);
            modalFooter.append(button2);
        }
        if (rentDataSize > 0) {
            modalContent = "<b>회원정보</b><br>이름 : " + userName + "<br>이메일 : " + userEmail + "<br><br><b>대출정보</b><br>" + userName + "님은 현재<br>" + rentDataTitle + " 도서를 대출중입니다."+"<p style='color:red;'><br><b>대출신청이 불가합니다.</b></p>";
            button1 = $('<button type="button" class="btn btn-warning ml-2">대출조회</button>');
            button2 = $('<button type="button" class="btn btn-danger ml-2" data-dismiss="modal">닫기</button>');

            button1.click(function() {
                window.location.href = "./userRentPageList.do?user_seq=" + userSeq;
            });

            modalFooter.append(button1);
            modalFooter.append(button2);
        }
    }

    $('#modalContent').html($(modalContent));
    $('#modalFooter').html($(modalFooter));
    $('#rentModal').modal('show');
}


//예약
function newResve1() {

	var modalContent = "";
    var modalFooter = $('<div></div>');
    var button1 = "";
    var button2 = "";
    
    if(rentDataSize == 0 && resveDataSize == 0){
        modalContent = "<b>회원정보</b><br>이름 : " + userName + "<br>이메일 : " + userEmail + "<br><br><b>도서정보</b><br>도서명 : " + bookTitle + "<br>저자 : " + bookWriter + "<br><br><b>예약신청 확인</b><br>예약신청을 하시겠습니까?"+"<p style='color:blue;'><br><b>예약신청 버튼을 누르면 신청이 완료됩니다.</b></p>";
        button1 = $('<button type="button" class="btn btn-primary ml-2">예약신청</button>');
        button2 = $('<button type="button" class="btn btn-danger ml-2" data-dismiss="modal">닫기</button>');
		console.log(typeof bookSeq);
		console.log(typeof userSeq);
        // 예약 넣는 아작스
        button1.click(function () {
            $.ajax({
                type: "POST",
                url: "./resveBook.do",
//                contentType: "application/json", // 요청 본문의 Content-Type을 JSON으로 설정
			    data: {
			        "book_seq": bookSeq,
			        "user_seq": userSeq
			    },
                success: function (response) {
					alert("예약신청이 완료되었습니다.");
                    window.location.href = "./userResvePageList.do?user_seq=" + userSeq;
                },
                error: function (error) {
                    alert("예약신청에 실패했습니다. 다시 시도해주세요.");
                }
            });
        });

        modalFooter.append(button1);
        modalFooter.append(button2);
        console.log("modalContent: ", modalContent);
        console.log("modalFooter: ", modalFooter);
        
    } else {
		if(rentDataSize == 0 && resveDataSize > 0){
	 	  console.log("test2");
       modalContent = "<b>회원정보</b><br>이름 : " + userName + "<br>이메일 : " + userEmail + "<br><br><b>예약정보</b><br>" + userName + "님은 현재<br>" + resveDataTitle + " 도서를 예약중입니다."+"<p style='color:red;'><br><b>예약신청이 불가합니다.</b></p>";
        button1 = $('<button type="button" class="btn btn-warning ml-2" data-dismiss="modal">예약조회</button>');
        button2 = $('<button type="button" class="btn btn-danger ml-2" data-dismiss="modal">닫기</button>');

        button1.click(function() {
            window.location.href = "./userResvePageList.do?user_seq=" + userSeq;
        });
        
        modalFooter.append(button1);
        modalFooter.append(button2);
        console.log("modalContent: ", modalContent);
        console.log("modalFooter: ", modalFooter);
    } 
    
    	if(resveDataSize == 0 && rentDataSize > 0){
			console.log("test3");
       modalContent = "<b>회원정보</b><br>이름 : " + userName + "<br>이메일 : " + userEmail + "<br><br><b>대출정보</b><br>" + userName + "님은 현재<br>" + rentDataTitle + " 도서를 대출중입니다."+"<p style='color:red;'><br><b>예약신청이 불가합니다.</b></p>";
        button1 = $('<button type="button" class="btn btn-warning ml-2" data-dismiss="modal">대출조회</button>');
        button2 = $('<button type="button" class="btn btn-danger ml-2" data-dismiss="modal">닫기</button>');

        button1.click(function() {
            window.location.href = "./userRentPageList.do?user_seq=" + userSeq;
        });

        modalFooter.append(button1);
        modalFooter.append(button2);
        console.log("modalContent: ", modalContent);
        console.log("modalFooter: ", modalFooter);
    }
}
    $('#modalContent2').html($(modalContent));
    $('#modalFooter2').html($(modalFooter));
    console.log("모달열림");
    $('#myModal1').modal('show');
}


 