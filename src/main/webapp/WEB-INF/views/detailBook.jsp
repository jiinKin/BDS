<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<link rel="stylesheet" href="css/font.css">
<link rel="stylesheet" href="css/header.css">
<link rel="stylesheet" href="css/bookDetail.css">
<script type="text/javascript" src="js/userRentResve.js" defer="defer"></script>
<script type="text/javascript" src="js/detailGender.js"></script>
<title>Insert title here</title>
<style type="text/css">
svg > g > g:last-child { pointer-events: none }
#chartContainer {
    display: flex;
}
#detailGenderChart {
    flex: 1;
}
#detailAgeChart {
    flex: 1;
}
</style>
</head>
<%@ include file="header.jsp" %>
<body>
 <div class="container">
        <header>
            <h1>도서 상세 정보</h1>
        </header>
        
        <div class="book-details">
            <img src="${detailBook.book_img}" alt="${detailBook.book_title}" class="book-cover">
            <div class="book-info">
                <h2>${detailBook.book_title}</h2>
                <p><strong>저자:</strong> ${detailBook.book_writer}</p>
                <p><strong>ISBN:</strong> ${detailBook.book_isbn}</p>
                <p><strong>출판사:</strong> ${detailBook.book_publisher}</p>
                <p><strong>출판일:</strong> <fmt:formatDate value="${detailBook.book_published_date}" pattern="yyyy-MM-dd"/></p>
            </div>
               
        </div>
        
       <div id="chartContainer">
    		<div id="detailGenderChart"></div>
    		<div id="detailAgeChart"></div>
		</div>
		
        <div class="book-description">
            <h2>도서 소개</h2>
            <p>${detailBook.book_intro}</p>
        </div>
        
        <div class="book-extra-info">
            <h2>추가 정보</h2>
            <p><strong>도서 인덱스:</strong> ${detailBook.book_index}</p>
            <p><strong>도서 요약:</strong> ${detailBook.book_summary}</p>
        </div>

<c:if test="${not empty sessionScope.loginDto && sessionScope.loginDto.user_auth ne 'A'}">
    <c:if test="${filteredBookSeqList.contains(detailBook.book_seq.toString())}">
        <p style="color: rgb(91,192,222);">해당 도서는 현재 대출중이므로, 예약신청만 가능합니다.</p>
        <input type="button" class="btn btn-info" value="예약신청" onclick="newResve1()">
    </c:if>
    <c:if test="${!filteredBookSeqList.contains(detailBook.book_seq.toString())}">
        <p style="color: rgb(51,122,183);">해당 도서는 현재 대출가능하며, 예약신청은 불가합니다.</p>
        <input type="button" class="btn btn-primary" value="대출신청" onclick="chkAvailability()">
    </c:if>
</c:if>

<c:if test="${empty sessionScope.loginDto}">
	<c:if test="${filteredBookSeqList.contains(detailBook.book_seq.toString())}">
        <p style="color: rgb(91,192,222);">해당 도서는 현재 대출중이므로, 예약신청만 가능합니다.</p>
        <input type="button" class="btn btn-info" value="예약신청" onclick="location.href='./loginPage.do'">
    </c:if>
    <c:if test="${!filteredBookSeqList.contains(detailBook.book_seq.toString())}">
        <p style="color: rgb(51,122,183);">해당 도서는 현재 대출가능하며, 예약신청은 불가합니다.</p>
        <input type="button" class="btn btn-primary" value="대출신청" onclick="location.href='./loginPage.do'">
	</c:if>
</c:if>   
    </div>



<!-- 	<br><div>도서 대출과 예약은 로그인 후 이용하실 수 있습니다.</div><br> -->
<!--     <input type="button" class="btn btn-success" value="로그인" onclick="location.href='./loginPage.do'"> -->
<%-- </c:if> --%>


<!-- 대출 모달 창 -->
<div class="modal fade" id="rentModal" role="dialog" style="color: #263238">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <!-- 모달 제목 -->
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title" id="modalTitle">대출 신청 확인</h4>
            </div>
            <div class="modal-body">
                <!-- 모달 내용 -->
                <p id="modalContent"></p>
            </div>
            <div class="modal-footer text-center">
                <!-- 모달 푸터 -->
                <p id="modalFooter"></p>
            </div>
        </div>
    </div>
</div>

<!-- 예약 모달 창 -->
<div class="modal fade" id="myModal1" role="dialog" style="color: #263238">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <!-- 모달 제목 -->
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title" id="modalTitle">예약 신청 확인</h4>
            </div>
            <div class="modal-body">
                <!-- 모달 내용 -->
                <p id="modalContent2"></p>
            </div>
            <div class="modal-footer text-center">
                <p id="modalFooter2"></p>
            </div>
        </div>
    </div>
</div>

<!-- js에서 사용할 변수 -->
<input type="hidden" id="rentDataSize" value="${rentData.size()}">
<input type="hidden" id="resveDataSize" value="${resveData.size()}">
<input type="hidden" id="filteredBookSeqList" value="${filteredBookSeqList}">
<input type="hidden" id="rentYBookSeqList" value="${rentYBookSeqList}">

<input type="hidden" id="rentDataTitle" value='${rentData[0].BOOK_TITLE}'>
<input type="hidden" id="rentData" value="${rentData}">

<input type="hidden" id="resveDataTitle" value='${resveData[0].BOOK_TITLE}'>
<input type="hidden" id="resveData" value="${resveData}">

<input type="hidden" id="loginDto" value="${loginDto}">
<input type="hidden" id="userName" value="${loginDto.user_name}">
<input type="hidden" id="userEmail" value="${loginDto.user_email}">
<input type="hidden" id="userSeq" value="${loginDto.user_seq}">

<input type="hidden" id="detailBook" value="${detailBook}">
<input type="hidden" id="bookTitle" value="${detailBook.book_title}">
<input type="hidden" id="bookWriter" value="${detailBook.book_writer}">
<input type="hidden" id="bookSeq" value="${detailBook.book_seq}">

<input type="hidden" id="isReservable" value="${rentYBookSeqList.contains(detailBook.book_seq)}">


<!-- <!-- 도서상세페이지 해당도서 관한 통계차트 -->
<script type="text/javascript">
    var book_seq = ${detailBook.book_seq};
</script>
</body>
<%@ include file="footer.jsp" %>
</html>