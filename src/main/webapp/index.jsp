<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>	
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta charset="UTF-8">
<link rel="stylesheet"href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="css/index.css">
<link rel="stylesheet" href="css/font.css">
<link rel="stylesheet" href="css/SerachBar.css">
<link href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick-theme.min.css">
<script type="text/javascript" src="./js/javascript41.js" defer="defer"></script>
<link rel='stylesheet' href='css/slick.css'/>
<link rel='stylesheet' href='./css/index.css'/>
<style type="text/css">
svg > g > g:last-child { pointer-events: none }
</style>
</head>
<%@ include file="/WEB-INF/views/header.jsp" %>
<c:set var="faqList" value="${faqList}"/>
<body>
<div id="body_div" style="height: auto;">

<!-- 슬라이더 첫번째div -->
<div id="slider-div">
    <div><img  src="./img/9.png" ></div>
    <div><img  src="./img/2222.png"></div>
    <div><img  src="./img/7.png"></div>
    <div><img  src="./img/header01.png"></div>
    <div><img  src="./img/header02.png"></div>
    <div><img  src="./img/header03.png"></div>
    <div><img  src="./img/header04.png"></div>
</div>
<!-- 검색창 두번째div -->
<form action="./searchBooks.do" method="get" >
<div class="search-container" style="width: 40%; margin: 0 auto; text-align: center; margin-top: 50px; margin-bottom: 100px;">
  <input type="text" name="keyword" style=" margin-right: 0px; width: 100%;" class="searching" placeholder="도서명 또는 저자를 입력하세요." > 
  <button type="submit"  style=" margin-left: 0px;"><i class="fa fa-search"></i></button>
</div>
</form> 

<div class="flex-container">
<!-- 도서관 이벤트 출력화면 gif-->
	<div>
	<h3>화제의 도서</h3>
	<a href="http://localhost:8099/BookDeliverySystem/getDetailBook.do?book_seq=563"><img id="event" src="./img/yr.gif"></a>
	<a href="http://localhost:8099/BookDeliverySystem/getDetailBook.do?book_seq=562"><img id="event" src="./img/ban.gif"></a>
	</div>
<!-- FAQ 리스트 메인 출력 div-->
	<div style="text-align: center;">
		<h3>FAQ</h3>
        <table class="table" border="1" id="faq-table">
        <c:forEach var="faq" items="${faqList}">
            <tr>
                <td>
                    <h5 class="faq-title">${faq.faq_title}</h5>
                </td>
            </tr>
        </c:forEach>
    </table>

    </div>
	
		<div style="text-align: center;">
			<h3>공지사항</h3>
		        <table class="table" border="1" id="notice_table">
		        <c:forEach var="notice" items="${mainNoticeList}">
		            <tr>
		                <td>
		                    <h5 class="notice_title">${notice.notice_title}</h5>
		                </td>
		            </tr>
		        </c:forEach>
		    </table>
		</div>
	</div>
</div>
</body>
<%@ include file="/WEB-INF/views/footer.jsp" %>
<script>
$(document).ready(function() {
    loadFaqList();// 페이지 로드 시 FAQ 목록을 가져옴
});

function loadFaqList() {
    $.ajax({
        type: "GET",
        url: "./mainFaqList.do", 
        dataType: "json", // JSON 형식의 응답
        success: function(data) {
            // FAQ 목록을 성공적으로 가져왔을 때 처리
            var faqTable = $("#faq-table");
            faqTable.empty(); // 새글이 올라오면 테이블 비우기

            // 데이터를 반복하여 테이블에 추가
            $.each(data, function(index, faq) {
                var row = $("<tr>");
                var cell = $("<td>").append($("<h5>").addClass("faq-title").text(faq.faq_title));
                
                // FAQ 클릭 이벤트 추가
                cell.click(function() {
                // FAQ 상세 정보 페이지로 이동
                window.location.href = "./faqBoardDetail.do?faq_seq=" + faq.faq_seq;
                });
                row.append(cell);
                faqTable.append(row);
            });
        },
        error: function(error) {
            console.error("FAQ 목록을 가져오는 중 오류 발생: " + error);
        }
    });
}
</script>


<!-- 공지사항불러오기 -->
<script>
$(document).ready(function() {
    loadNoticeList();// 페이지 로드 시 FAQ 목록을 가져옴
});

function loadNoticeList() {
    $.ajax({
        type: "GET",
        url: "./mainNoticeList.do", 
        dataType: "json", // JSON 형식의 응답
        success: function(data) {
            // FAQ 목록을 성공적으로 가져왔을 때 처리
            var noticeTable = $("#notice_table");
            noticeTable.empty(); // 새글이 올라오면 테이블 비우기

            // 데이터를 반복하여 테이블에 추가
            $.each(data, function(index, notice) {
                var row = $("<tr>");
                var cell = $("<td>").append($("<h5>").addClass("notice_title").text(notice.notice_title));
                
                // FAQ 클릭 이벤트 추가
                cell.click(function() {
                // FAQ 상세 정보 페이지로 이동
                window.location.href = "./noticeBoardDetail.do?notice_bseq=" + notice.notice_bseq;
                });
                row.append(cell);
                noticeTable.append(row);
            });
        },
        error: function(error) {
            console.error("Notice 목록을 가져오는 중 오류 발생: " + error);
        }
    });
}
</script>
</html>
