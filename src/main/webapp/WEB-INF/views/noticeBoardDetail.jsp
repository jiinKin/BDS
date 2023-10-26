<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 상세조회</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<link rel='stylesheet' href='css/noticeDetail.css'/>
</head>
<%@ include file="header.jsp" %>
<body>
<div id="noticeContainer" class="container">
	<h1> 제목 : ${dto.notice_title}<input style="float: right; background-color: #ccc; color: #222831;" class="btn" type="button" value="이전" onclick="location.href='./noticeBoardList.do'">
	<c:if test="${loginDto.user_name eq dto.user_name}">
	<input style="float: right;" class="btn btn-danger" type="button" value="삭제" onclick="boardDel()">
	<input style="float: right; background-color: #00ADB5; color: #000;" class="btn" type="button" value="수정"
    onclick="location.href='./updateNoticeView.do?notice_bseq=${dto.notice_bseq}&notice_title=${dto.notice_title}&notice_content=${fn:escapeXml(dto.notice_content)}'">
	</c:if>
	</h1>
	<div>
    작성자<div class="form-control" style="font-size: 20px;"><c:out value="${dto.user_name}" /></div>
    내용<div class="form-control" style="height: 300px; font-size: 20px;"><c:out value="${dto.notice_content}" /></div>
    작성일<div class="form-control" style="font-size: 15px;"><fmt:formatDate value="${dto.notice_regdate}" pattern="yyyy-MM-dd HH:mm:ss" /></div>
</div>
	
</div>
</body>
<%@ include file="footer.jsp" %>

<script type="text/javascript">
	function boardDel(){
		 var result = confirm("선택하신 게시글을 정말 삭제하시겠습니까?");

         if (result === true) {
             alert("게시글이 삭제되었습니다.");
             window.location.href="./noticeDel.do?notice_bseq=${dto.notice_bseq}";
         } else {
             alert("게시글 삭제가 취소되었습니다.");
         }
	}
</script>


</html>