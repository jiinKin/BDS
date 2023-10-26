<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="css/font.css">
<link rel="stylesheet" href="css/header.css">
<link rel="stylesheet" href="css/userResvePageList.css">
<script type="text/javascript" src="js/resveCancle.js"></script>
<title>Insert title here</title>
<%@ include file="header.jsp" %>
</head>
<c:set var="lists" value="${requestScope.lists}" />
<c:set var="resveDto" value="${requestScope.page}" />
<body>
<div id="sidebar">
	<div>
	<h4>${loginDto.user_name}님<br/></h4>
	<h5>가입일 : <fmt:formatDate value="${loginDto.joindate}"/></h5> 
	</div>
	<ul>
		<li onclick="window.location.href='./myPage.do'">회원정보</li>
		<li onclick="window.location.href='./moveModifyPW.do'">비밀번호수정</li>
        <li onclick="window.location.href='userPayPageList.do'">결제내역</li>
        <li onclick="window.location.href='./userRentPageList.do'">대출내역</li>
        <li onclick="window.location.href='./userResvePageList.do'">예약내역</li>
	</ul>
</div>	
<div id="maincontent">
<!-- <div class="container"> -->
<c:set var="loginUser" value="${sessionScope.loginDto}" />
		<h1>${loginUser.user_name}님의 예약 도서 목록 입니다</h1>
		<button class="btn" id="refreshButton" style="float: right; background-color: #00fff5; color: #393E46">예약내역 갱신</button>
		    <script>
        // 페이지 새로고침 버튼을 클릭할 때 페이지를 새로고침합니다.
        document.getElementById("refreshButton").addEventListener("click", function() {
            location.reload();
        });
    </script>
    <table class="table" border="1">
    <tr>
        <th>No.</th>
        <th>도서명</th>
        <th>예약상태</th>
        <th>예약순번</th>
        <th>예약취소</th>
        <th>대출신청</th>
    </tr>
    <c:forEach var="resve" items="${userResvePageList}"  varStatus="status">
        <tr>
        	<td>${resveDto.getTotalCount() - (resveDto.getPage() - 1) * resveDto.getCountList() - status.index}</td>
            <td>${resve.BOOK_TITLE}</td>
            <td>
			    <c:choose>
			        <c:when test="${resve.RESVE_STATUS eq 'Y'}">예약중</c:when>
			        <c:when test="${resve.RESVE_STATUS eq 'R'}">대출대기</c:when>
			        <c:when test="${resve.RESVE_STATUS eq 'N'}">예약취소</c:when>
			        <c:when test="${resve.RESVE_STATUS eq 'C'}">자동취소</c:when>
			        <c:when test="${resve.RESVE_STATUS eq 'S'}">대출진행완료</c:when>
			    </c:choose>
			</td>
            <td>
            	<c:choose>
            		<c:when test="${resve.RESVE_STATUS eq 'R'}">대출가능</c:when>
            		<c:when test="${resve.RESVE_STATUS eq 'S'}">&nbsp;</c:when>
            		<c:when test="${resve.RESVE_STEP eq 0}">&nbsp;</c:when>
            		<c:otherwise>${resve.RESVE_STEP}</c:otherwise>
            	</c:choose>
            
            </td>
            <td>
			    <c:choose>
			        <c:when test="${resve.RESVE_STATUS eq 'Y'}">
			        <button class="btn" style="background-color: #00fff5; color: #393E46" onclick="cancelReservation(${resve.BOOK_SEQ}, ${loginUser.user_seq})">예약취소</button>
			        </c:when>
			        <c:otherwise></c:otherwise>
			    </c:choose>
			</td>
			
			<td>
			    <c:choose>
			        <c:when test="${resve.RESVE_STATUS eq 'R'}">
			        <button class="btn" style="background-color: #00fff5; color: #393E46" onclick="location.href = './addr.do?book_seq=' + ${resve.BOOK_SEQ}" style="color: #263238">대출신청</button>
			        </c:when>
			        <c:otherwise></c:otherwise>
			    </c:choose>
			</td>
        </tr>
    </c:forEach>
</table>
    <!-- 페이지 번호 및 화살표 옮기기 -->
    <div class="text-center">
        <ul class="pagination pagination-lg">
            <c:if test="${resveDto.getStartPage() > 1}">
                <li><a href="./userResvePageList.do?page=1">처음</a></li>
            </c:if>
    
            <c:if test="${resveDto.getStartPage() > 1}">
                <c:choose>
                    <c:when test="${resveDto.getStartPage() - resveDto.getCountPage() <= 0}">
                        <li><a href="./userResvePageList.do?page=1">이전</a></li>
                    </c:when>
                    <c:otherwise>
                        <li><a href="./userResvePageList.do?page=${resveDto.getStartPage() - resveDto.getCountPage()}">이전</a></li>
                    </c:otherwise>
                </c:choose>
            </c:if>
    
            <c:forEach begin="${resveDto.getStartPage()}" end="${resveDto.getEndPage()}" var="i">
                <li <c:if test="${i == resveDto.getPage()}">class="active"</c:if>>
                    <a href="./userResvePageList.do?page=${i}">${i}</a>
                </li>
            </c:forEach>
    
            <c:if test="${resveDto.getPage() < resveDto.getTotalPage()}">
                <c:choose>
                    <c:when test="${resveDto.getStartPage() + resveDto.getCountPage() > resveDto.getTotalPage()}">
                        <li><a href="./userResvePageList.do?page=${resveDto.getTotalPage()}">다음</a></li>
                    </c:when>
                    <c:otherwise>
                        <li><a href="./userResvePageList.do?page=${resveDto.getStartPage() + resveDto.getCountPage()}">다음</a></li>
                    </c:otherwise>
                </c:choose>
            </c:if>
    
            <c:if test="${resveDto.getEndPage() < resveDto.getTotalPage()}">
                <li><a href="./userResvePageList.do?page=${resveDto.getTotalPage() - resveDto.getTotalPage() % resveDto.getCountList() + 1}">끝</a></li>
            </c:if>
        </ul>
    </div>


<!-- </div> -->
</div>
</body>
<%@ include file="footer.jsp" %>
</html>