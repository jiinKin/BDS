<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원리스트 페이지</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="css/adminUserList.css"/>
</head>
<%@ include file="/WEB-INF/views/adminHeader.jsp" %>
<body>

	<table id="userList">
    <tr>
        <th>회원번호</th>
        <th>회원이메일</th>
        <th>회원이름</th>
        <th>전화번호</th>
        <th>회원생일</th>
        <th>가입일</th>
        <th>성별</th>
    </tr>
    <c:forEach var="user" items="${getAllUsers}">
        <tr>
            <td>${user.user_seq}</td>
            <td><a href="userDetail.do?user_seq=${user.user_seq}">${user.user_email}</a></td>
            <td><a href="userDetail.do?user_seq=${user.user_seq}">${user.user_name}</a></td>
            <td>${user.user_phone}</td>
            <td>${user.user_birth}</td>
            <td>${user.joindate}</td>
            <td>${user.user_gender}</td>
        </tr>
    </c:forEach>
</table>

</body>
</html>