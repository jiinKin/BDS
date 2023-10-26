<%@page import="com.dowon.bds.dto.AddrDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수거요청지 입력</title>
<link rel="stylesheet" href="css/addr.css" />
<link rel="stylesheet" href="css/font.css">
<link rel="stylesheet" href="css/header.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
</head>
<%@ include file="/WEB-INF/views/header.jsp" %>
<body>
<div class="container">
<c:set var="loginUser" value="${sessionScope.loginDto}"/>
<h1 style="font-family: 'Hanna', fantasy; text-align:  center; 	  padding-top: 50px;">${loginUser.user_name}님의 수거요청지 입력</h1>
<br>
	<form action="./returnAddrCheck.do" method="post"  onsubmit="return validateForm();">
		<table class="table table-bordered form-group">
				<thead>

				</thead>
		
				<tbody>   
	<tr>
						<th class="center-text" style="padding-top: 65px;">배송정보</th>
						<td>
						    <input type="text" id="delivery_name" name="delivery_name" placeholder="수령자" value="${loginUser.user_name}" readonly="readonly"><br>
  							<input type="text" id="delivery_phone" name="delivery_phone" placeholder="연락받을 전화번호" value="${loginUser.user_phone}" readonly="readonly"><br>
							<input type="text" id="sample6_postcode" placeholder="우편번호" name="postcode">
							<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
							<input type="text" id="sample6_address" placeholder="주소" name="address"><br>
							<input type="text" id="sample6_detailAddress" placeholder="상세주소" name="detaddr">
							<input type="text" id="sample6_extraAddress" placeholder="참고항목" name="extaddr">
							<input type="hidden" name="book_seq" value="${bookSeq}"/> 
						</td>
					</tr>
		    </tbody>
	 
	 		<tfoot>
				 	<tr>
						<th colspan="2" style="text-align: center;">
							<button type="submit" class="btn btn-default">수거요청</button>
							<button class="btn" onclick="history.back(-1)">취소</button>
						</th>
				</tr>
			</tfoot>
		</table>
	</form>

</div>
</body>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    function sample6_execDaumPostcode() {
           
        new daum.Postcode({
            oncomplete: function(data) {
                
                 // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
                 // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                 // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                 //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                 // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                     // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                     // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                     // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("sample6_extraAddress").value = extraAddr;
                } else {
                    document.getElementById("sample6_extraAddress").value = '';
                }
                 // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample6_postcode').value = data.zonecode;
                document.getElementById("sample6_address").value = addr;
               // 커서를 상세주소 필드로 이동한다.
                document.getElementById("sample6_detailAddress").focus();
            },

            theme: {
                searchBgColor: "#FFFFFF", //검색창 배경색
                textColor: "#333333", //기본 글자색
                queryTextColor: "#222222", //검색창 글자색
                bgColor: "#4DE9D6"
            }

        }).open();
    }
    function validateForm() {
        var deliveryName = document.getElementById("delivery_name").value;
        var deliveryPhone = document.getElementById("delivery_phone").value;
        var postcode = document.getElementById("sample6_postcode").value;
        var address = document.getElementById("sample6_address").value;
        var detailAddress = document.getElementById("sample6_detailAddress").value;
 
        // 허용되는 문자: 영어, 한글, 숫자, ,, -, #
        var validPattern = /^[a-zA-Z가-힣0-9,#\s-]+$/;
        var numericPattern = /^[0-9]+$/;
     
     

        if (deliveryName === "" || deliveryPhone === "" || postcode === "" || address === "") {
            alert("정보를 입력하세요.");
            return false;
        }
        

        // 주소 필드의 길이 검사 (30자 이하)
        if (!validPattern.test(address)|| address.length > 30) {
            alert("주소는 30자 이하로 입력해야 합니다.");
            return false;
        }


        return true;
    }
</script>


<%@ include file="/WEB-INF/views/footer.jsp" %>
</html>