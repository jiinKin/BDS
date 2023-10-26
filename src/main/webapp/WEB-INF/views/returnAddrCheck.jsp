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
<title>주소 정보</title>
<link rel="stylesheet" href="css/addrCheck.css" />
<link rel="stylesheet" href="css/font.css">
<link rel="stylesheet" href="css/header.css">
<link rel="stylesheet" href="css/footer.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
</head>
<%@ include file="/WEB-INF/views/header.jsp" %>
<body>


<c:set var="loginUser" value="${sessionScope.loginDto}"/>
<h1 style="font-family: 'Hanna', fantasy; padding-top: 20px;">${sessionScope.loginDto.user_name}님의 수거요청이 완료되었습니다.</h1>
    <div id="container">
        <table>
        <thead>
            <tr>
                <td><strong>이름:</strong></td>
                <td>${sessionScope.saveAddressReturn.delivery_name}</td>
            </tr>
            <tr>
                <td><strong>전화번호:</strong></td>
                <td>${sessionScope.saveAddressReturn.delivery_phone}</td>
            </tr>
            <tr>
                <td><strong>우편번호:</strong></td>
                <td>${sessionScope.saveAddressReturn.postcode}</td>
            </tr>
            <tr>
                <td><strong>주소:</strong></td>
                <td>${sessionScope.saveAddressReturn.address} ${sessionScope.saveAddressReturn.detaddr}</td>
            </tr>
           </thead>
        </table>
        <div class="containerBtn">
			<button class="btn btn-info" onclick="redirectToIndex(${loginDto.user_seq})">확인</button>
		    <button class="btn"  onclick="history.back(-1)">취소</button>
		</div>
    </div>

<script>
    // JavaScript를 사용하여 index.jsp로 이동
    function redirectToIndex(userSeq) {
        var url = './index.jsp?user_seq=' + userSeq;
        location.href = url;
    }
</script>
</body>
<%@ include file="footer.jsp" %>
</html>