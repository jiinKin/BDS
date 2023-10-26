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
<link rel="stylesheet" href="css/userRentPageList.css">
<title>Insert title here</title>
<%@ include file="header.jsp" %>
</head>
<c:set var="lists" value="${requestScope.lists}" />
<c:set var="r" value="${requestScope.page}" />
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
    <h1>${loginUser.user_name}님의 대출 도서 목록 입니다</h1>
    <button class="btn" id="refreshButton" style="float: right; background-color: #00fff5; color: #393E46">대출내역 갱신</button>
    <script>
        // 페이지 새로고침 버튼을 클릭할 때 페이지를 새로고침합니다.
        document.getElementById("refreshButton").addEventListener("click", function() {
            location.reload();
        });
    </script>

    <table class="table" border="1">
        <tr>
            <th>No.</th>
            <th>대출일</th>
            <th>반납예정일</th>
            <th>도서 제목</th>
            <th>대출 상태</th>
            <th>반납 신청</th>
            <th>배송 조회</th>
        </tr>
        <c:forEach var="rent" items="${userRentList}" varStatus="status">
            <tr>
                <td>${r.getTotalCount() - (r.getPage() - 1) * r.getCountList() - status.index}</td>
                <td>
                    <fmt:formatDate value="${rent.RENT_DATE}" pattern="yyyy.MM.dd"/>
                </td>
                <td>
                    <fmt:formatDate value="${rent.RENT_RETURN_DATE}" pattern="yyyy.MM.dd"/>
                </td>
                <td>${rent.BOOK_TITLE}</td>
                <td>
                    <c:choose>
                        <c:when test="${rent.RENT_STATUS eq 'Y'}">대출중</c:when>
                        <c:when test="${rent.RENT_STATUS eq 'N'}">반납완료</c:when>
                        <c:when test="${rent.RENT_STATUS eq 'A'}">대출 배송완료</c:when>
                        <c:when test="${rent.RENT_STATUS eq 'B'}">반납 배송완료</c:when>
                    </c:choose>
                </td>
                <td>
                    <c:choose>
                        <c:when test="${rent.RENT_STATUS eq 'Y'}">
                            <button class="btn" style="float: center; background-color: #00fff5; color: #393E46" onclick="location.href='./returnAddr.do?user_seq=${loginDto.user_seq}&book_seq=${rent.BOOK_SEQ}'" style="color: #393E46">수거요청</button>
                        </c:when>
                        <c:otherwise></c:otherwise>
                    </c:choose>
                </td>
                <td>
                    <!-- @김지인2 @since 23.09.23 - 배송조회시 운송장 번호 입력값으로 조회하도록 변경 -->
                    <button class="btn" style="float: center; background-color: #00fff5; color: #393E46" onclick="openTrackerForm()" style="color: #393E46">배송조회</button>
                </td>
            </tr>
        </c:forEach>
    </table>
    
    <!-- 페이지 번호 및 화살표 옮기기 -->
    <div class="text-center">
        <ul class="pagination pagination-lg">
            <c:if test="${r.getStartPage() > 1}">
                <li><a href="./userRentPageList.do?page=1">처음</a></li>
            </c:if>
    
            <c:if test="${r.getStartPage() > 1}">
                <c:choose>
                    <c:when test="${r.getStartPage() - r.getCountPage() <= 0}">
                        <li><a href="./userRentPageList.do?page=1">이전</a></li>
                    </c:when>
                    <c:otherwise>
                        <li><a href="./userRentPageList.do?page=${r.getStartPage() - r.getCountPage()}">이전</a></li>
                    </c:otherwise>
                </c:choose>
            </c:if>
    
            <c:forEach begin="${r.getStartPage()}" end="${r.getEndPage()}" var="i">
                <li <c:if test="${i == r.getPage()}">class="active"</c:if>>
                    <a href="./userRentPageList.do?page=${i}">${i}</a>
                </li>
            </c:forEach>
    
            <c:if test="${r.getPage() < r.getTotalPage()}">
                <c:choose>
                    <c:when test="${r.getStartPage() + r.getCountPage() > r.getTotalPage()}">
                        <li><a href="./userRentPageList.do?page=${r.getTotalPage()}">다음</a></li>
                    </c:when>
                    <c:otherwise>
                        <li><a href="./userRentPageList.do?page=${r.getStartPage() + r.getCountPage()}">다음</a></li>
                    </c:otherwise>
                </c:choose>
            </c:if>
    
            <c:if test="${r.getEndPage() < r.getTotalPage()}">
                <li><a href="./userRentPageList.do?page=${r.getTotalPage() - r.getTotalPage() % r.getCountList() + 1}">끝</a></li>
            </c:if>
        </ul>
    </div>
</div>
<!-- </div> -->
</body>
<%@ include file="footer.jsp" %>
<script>
    function openTrackerForm() {
        // const delivery_num = "${addrDto.delivery_num}";
        // const t_invoice = encodeURIComponent(delivery_num);
        // t_code 만료로 변경 XY805DoMvmIV6tcSteEDvA
        window.open("http://info.sweettracker.co.kr/tracking/5?t_key=XY805DoMvmIV6tcSteEDvA&t_code=04&t_invoice=578914961436", "_blank", "width=600,height=800")
    }
</script>
</html>
