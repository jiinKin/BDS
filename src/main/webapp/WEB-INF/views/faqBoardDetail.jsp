<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="css/font.css">
<link rel="stylesheet" href="css/header.css">
<link rel="stylesheet" href="css/freeBoardDetail.css">
<title>FAQ 삭제를 위한 상세 페이지</title>
<%@ include file="header.jsp" %>
</head>
<body>
	<div class="container">
		<h3>${dto.faq_title}<input style="float: right; background-color: #ccc; color: #000;" class="btn" type="button" value="이전" onclick="location.href='./faqList.do'">
			<c:if test="${loginDto.user_seq eq dto.user_seq}">
    		<input style="float: right;" class="btn btn-danger" type="button" value="삭제" onclick="faqDel()">
			<input style="float: right; background-color: #00ADB5; color: #000;" class="btn" type="button" value="수정" onclick="location.href='./updateFaq.do?faq_seq=${dto.faq_seq}&faq_title=${dto.faq_title}&faq_content=${dto.faq_content}'">
			</c:if>
		</h3>
		<div>
		    <br>
			<div class="form-control" style="height: 200px; font-size: 15px;">${dto.faq_content}</div>
		</div><br>
		</div>

</body>
<%@ include file="footer.jsp" %>
<script type="text/javascript">
	function faqDel(){
		 var result = confirm("선택하신 FAQ를 정말 삭제하시겠습니까?");

         if (result === true) {
             alert(" FAQ가 삭제되었습니다.");
             window.location.href = "./faqDel.do?faq_seq=" + ${dto.faq_seq};
         } else {
             alert(" FAQ 삭제가 취소되었습니다.");
         }
	}
</script>
</html>