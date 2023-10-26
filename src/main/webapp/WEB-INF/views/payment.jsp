<%@page import="com.dowon.bds.dto.AddrDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="css/payment.css">
<link rel="stylesheet" href="css/font.css">
<script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript"
	src="https://code.jquery.com/jquery-3.7.0.js"></script>
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
<title>Payment 결제 페이지</title>
<script>
	var merchant_uid = merchant_uid + 1; // DB 에서 마지막 시퀀스를 가지고 왔다가 처리 해야함.
	var payPayment = 5000; // 배송비 5000원 결제되도록 설정
	var IMP = window.IMP;
	IMP.init("imp84153337");
	// User_name 설정
	var User_name = "${sessionScope.loginDto.user_name}";
	
	// 주소 정보를 JavaScript 변수에 할당
	var buyer_email = "${sessionScope.loginDto.user_email}";
	var buyer_tel = "${sessionScope.savedAddress.delivery_phone}";
	var buyer_addr = "${sessionScope.savedAddress.address}"; // 주소 정보 수정
	var buyer_postcode = "${sessionScope.savedAddress.postcode}"; // 우편번호 정보 수정
	
	var bookSeq = parseInt('${bookSeq}');
	var userSeq = parseInt('${sessionScope.loginDto.user_seq}');
	
	async function requestPay() {
	    try {
	        const rsp = await new Promise((resolve, reject) => {
	            IMP.request_pay({
	                pg: "kcp", // 결제사 선택 포트원 사이트 참고
	                pay_method: "card", // 카드결제 선택
	                merchant_uid: merchant_uid,
	                name: "배송비 결제",
	                amount: payPayment,
	                buyer_email: buyer_email,
	                buyer_name: User_name,
	                buyer_tel: buyer_tel,
	                buyer_addr: buyer_addr, // 입력된 배송주소
	                buyer_postcode: buyer_postcode,
	            }, (rsp) => {
	                resolve(rsp);
	            });
	        });
	
	        console.log("rsp : ", rsp);
	
	        if (rsp.success) {
	            var msg = '결제가 완료되었습니다.';
	            msg += '고유ID : ' + rsp.imp_uid;
	            msg += '상점 거래ID : ' + rsp.merchant_uid;
	            msg += '결제 금액 : ' + rsp.paid_amount;
	            msg += '카드 승인번호 : ' + rsp.apply_num;
	            alert(msg);
	
	            // 결제 성공 시에만 서버로의 AJAX 요청을 수행
	            // 결제가 성공한 후에 payment.do 컨트롤러로 요청을 보냅니다.
	            $.ajax({
	                type: "POST",
	                url: "./payment.do?book_seq=" + bookSeq, // payment.do 컨트롤러로 요청"./payment.do?book_seq=" + bookSeq,
	                data: JSON.stringify ({
	                    // imp_uid를 payImd 대신 payImd로 전달
	                             payImd: rsp.imp_uid,
	                             payPayment: payPayment,
	                             book_seq: bookSeq
	                         }), // 결제 정보를 서버로 보냅니다.
	                contentType: "application/json",
	                success: function (data) {
	                    // 이후 처리 (예: 리다이렉션 등)
	                    if (data == "success") {
	                        // payment.do 요청이 성공하면 rentBook 함수 실행
	                        rentBook(userSeq, bookSeq);
	                        window.location.href = "./userRentPageList.do";
	                    } else {
	                        console.log('payment.do 요청 실패');
	                    }
	                    console.log(data);
	                   // alert(data);
	                },
	                error: function (error) {
	                    console.error('payment.do 요청 오류:', error);
	                }
	            });
	        } else {
	            var msg = '결제에 실패하였습니다.';
	            msg += '에러내용 : ' + rsp.error_msg;
	            console.log('결제실패');
	            alert(msg);
	        }
	    } catch (error) {
	        console.error('결제 요청 오류:', error);
	    }
	}
	
	    async function rentBook(userSeq, bookSeq) {
	    	console.log(userSeq, bookSeq);
	        try { const rentBook = await $.ajax({
	            type: "POST",
	            url: "./rentBook.do",
	            data: JSON.stringify({
	                user_seq: userSeq,
	                book_seq: bookSeq
	            }),
	            contentType: "application/json"
	        });
	
	        if (rentBook == "success") {
	        	alert("대출신청이 완료되었습니다.");
	            console.log('대출 요청 성공');
	            window.location.href = "./userRentPageList.do";
	        } else {
	        	 console.log('대출 요청 실패');
	             console.error('대출 요청 실패', rentBook); 
	        }
	
	
	        const reserveBook = await $.ajax({
	            type: "POST",
	            url: "./reserveBook.do",
	            data: JSON.stringify({
	                book_seq: bookSeq
	            }),
	            contentType: "application/json"
	        });
	
	        if (reserveBook == "success") {
	            alert("대출신청이 완료되었습니다\n예약 대출대기 상태가 변경되었습니다.");
	            console.log('예약 요청 성공');
	            window.location.href = "./userRentPageList.do";
	        } else {
	            console.log('예약 요청 실패');
	            
	        }
	            } catch (error) {
	                console.error('예약 요청 오류:', error);
	            }
	        }
	    
</script>


</head>
<%@ include file="header.jsp" %>
<body>
	<div class="container">
	<!-- 세션에서 loginDto 속성을 불러옴 -->
	<c:set var="loginDto" value="${sessionScope.loginDto}" />


	<div style="text-align: center;">
		<h1 class="pay">${sessionScope.loginDto.user_name}님
			배송비 결제페이지</h1>
			<p>마일리지 결제시 5000마일리지가 차감됩니다.</p>
		<button class="button" onclick="requestPay()">결제하기</button>
		<button class="button" onclick="milePay()">마일리지 결제</button>
		<button class="button2"
			onclick="javascript:history.back(-1)">취소</button>
	</div>
	</div>
</body>
<%@ include file="/WEB-INF/views/footer.jsp" %>
</html>