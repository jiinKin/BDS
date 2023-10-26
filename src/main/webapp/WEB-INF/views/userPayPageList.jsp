<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="css/header.css">
<link rel="stylesheet" href="css/userPayPageList.css">
<link rel="stylesheet" href="css/font.css">
<title>결제 내역</title>
</head>
<%@ include file="header.jsp" %>
<body>
<div id="sidebar">
	<div>
	<h4>${loginDto.user_name}님<br/></h4>
	<h5>가입일 : <fmt:formatDate value="${loginDto.joindate}"/></h5> 
	</div>
	<ul>
		<li onclick="window.location.href='./myPage.do'">회원정보</li>
		<li onclick="window.location.href='./moveModifyPW.do'">비밀번호수정</li>
        <li onclick="window.location.href='./userPayPageList.do'">결제내역</li>
        <li onclick="window.location.href='./userRentPageList.do'">대출내역</li>
        <li onclick="window.location.href='./userResvePageList.do'">예약내역</li>
	</ul>
</div>	
<div id="maincontent">

	<c:set var="lists" value="${requestScope.lists}" />
	<c:set var="r" value="${requestScope.page}" />
	<c:set var="loginUser" value="${sessionScope.loginDto}" />
	<c:set var="payment" value="${sessionScope.payDto}" />

<h1>${loginUser.user_name}님의 결제내역 입니다.</h1>

<h5> 총 마일리지 : ${userPayList[0].PAY_SUMPOINT} 마일리지</h5>

<table class="table" border="1">
    <tr>
     <th>No.</th>
    	<th>결제번호</th>
        <th>승인번호</th>
        <th>회원번호</th>
        <th>금액</th>
        <th>결제시간</th>
        <th>적립마일리지</th>
        <th>총마일리지</th>
    </tr>
    <c:forEach var="payment" items="${userPayList}" varStatus="status">
        <tr>
           <td>${r.getTotalCount() - (r.getPage() - 1) * r.getCountList() - status.index}</td>
        	<td>${payment.PAY_SEQ}</td>
            <td>${payment.PAY_IMD}</td>
            <td>${payment.USER_SEQ}</td>
            <td>${payment.PAY_PAYMENT}</td>
            <td>${payment.PAY_DATE}</td>
         	<td>${payment.PAY_POINT}</td>
         	<td>${payment.PAY_SUMPOINT}</td>
		     
        </tr>
    </c:forEach>
 
</table>
   <!-- 페이징 -->
   <div class="text-center">
        <ul class="pagination pagination-lg">
            <c:if test="${r.getStartPage() > 1}">
                <li><a href="./userPayPageList.do?page=1">◁◁</a></li>
            </c:if>
    
            <c:if test="${r.getStartPage() > 1}">
                <c:choose>
                    <c:when test="${r.getStartPage() - r.getCountPage() <= 0}">
                        <li><a href="./userPayPageList.do?page=1">◀</a></li>
                    </c:when>
                    <c:otherwise>
                        <li><a href="./userPayPageList.do?page=${r.getStartPage() - r.getCountPage()}">◀</a></li>
                    </c:otherwise>
                </c:choose>
            </c:if>
   			
   	        <c:forEach begin="${r.getStartPage()}" end="${r.getEndPage()}" var="i">
                <li <c:if test="${i == r.getPage()}">class="active"</c:if>>
                    <a href="./userPayPageList.do?page=${i}">${i}</a>
                </li>
            </c:forEach>
   		
   			 <c:if test="${r.getPage() < r.getTotalPage()}">
                <c:choose>
                    <c:when test="${r.getStartPage() + r.getCountPage() > r.getTotalPage()}">
                        <li><a href="./userPayPageList.do?page=${r.getTotalPage()}">▶</a></li>
                    </c:when>
                    <c:otherwise>
                        <li><a href="./userPayPageList.do?page=${r.getStartPage() + r.getCountPage()}">▶</a></li>
                    </c:otherwise>
                </c:choose>
            </c:if>
            
            <c:if test="${r.getEndPage() < r.getTotalPage()}">
                <li><a href="./userPayPageList.do?page=${r.getTotalPage() - r.getTotalPage() % r.getCountList() + 1}">▷▷</a></li>
            </c:if>
   		</ul>
   </div>
  </div> 
</body>
<%@ include file="/WEB-INF/views/footer.jsp" %>
</html>
