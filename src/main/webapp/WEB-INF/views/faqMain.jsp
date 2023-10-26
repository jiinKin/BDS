<%@page import="com.dowon.bds.dto.UserDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="css/font.css">
<link rel="stylesheet" href="css/header.css">
<link rel="stylesheet" href="css/faq.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<title>FAQ 게시판입니다.</title>
</head>
<%@ include file="header.jsp" %>
<body>
		<div class="container">
			<h1>자주묻는질문</h1>
			
			<c:choose>
		    <c:when test="${loginDto != null && loginDto.user_auth == 'A'}">
		        <input class="btn" type="submit" onclick="location.href='./faqInsertView.do'" value="새글작성">
		        <br>
		        <br>
		        <br>
		    </c:when>
			</c:choose>
			
		    <table class="table" border="1">
				<c:forEach var="faqBoard" items="${faqList}">
				    <tr data-category="${faqBoard.faq_category}">
				        <td>
				            <h5 class="faq-title">
				                ${faqBoard.faq_title}
				           <c:if test="${loginDto != null && loginDto.user_seq == faqBoard.user_seq}">
				            <button class="btn btn-info" style="margin-left: 10px;" onclick="location.href='./faqBoardDetail.do?faq_seq=${faqBoard.faq_seq}'">관리</button>
				           </c:if>
				            </h5>
				            <div class="faq-content">
				                ${faqBoard.faq_content}
				            </div>
				        </td>
				    </tr>
				</c:forEach>
			</table>
		</div>

 		<div class="search-container">
            <form action="#" class="search">
                <div class="form-group row">
                    <div class="col-sm-4">
                        <select class="form-control" name="faq_category" id="faq_category">
                            <option value="">카테고리 전체</option>
                            <option value="1">도서관 이용 일반</option>
                            <option value="2">비치 희망 자료 신청</option>
                            <option value="3">회원가입 관련</option>
                            <option value="4">자료 검색 및 대출</option>
                        </select>
                    </div>
                </div>
            </form>
        </div>
	

</body>
<%@ include file="footer.jsp" %>
</body>
<script>
$(document).ready(function() {
    // FAQ 제목 클릭 이벤트
    $(".faq-title").click(function() {
        var content = $(this).next(".faq-content");
        if (content.css("display") === "none") {
            content.slideDown();
        } else {
            content.slideUp();
        }
    });
    
    // 컨텐츠 카테고리 선택하여 해당 글만 나타내기
    $("#faq_category").change(function() {
        var selectedCategory = $(this).val();
        
        // 모든 FAQ 글 숨기기
        $("tr[data-category]").hide();
        
        // 선택한 카테고리에 해당하는 FAQ 글만 보이기
        if (selectedCategory === "") {
            $("tr[data-category]").show();
        } else {
            $("tr[data-category='" + selectedCategory + "']").show();
        }
    });
});
</script>
</html>
