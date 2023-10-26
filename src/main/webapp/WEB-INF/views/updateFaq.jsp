<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="css/font.css">
<link rel="stylesheet" href="css/header.css">
<link rel="stylesheet" href="css/updateFaq.css">
<script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<title>FAQ 수정 페이지</title>
</head>
<%@ include file="header.jsp" %>
<body>
<div class="container">
		<h3> ${faq_title}</h3>
		<button style="float: right;" class="btn btn-success" onclick="history.back(-1)">이전</button>
		<br>
		<form action="./updateFaqBoard.do?faq_seq=${faq_seq}" method="post">
			<div class="form-group">
				<label for="id">아이디:</label>
				<div class="form-control" id="id">${loginDto.user_name}</div>
			</div>
			<div class="form-group">
				<label for="comment">제목:</label>
				<textarea class="form-control" id="faq_title" name="faq_title" rows="2" cols="50">${faq_title}</textarea>
			</div>
			<div class="form-group">
				<label for="comment">내용:</label>
				<textarea class="form-control" id="faq_content" name="faq_content" rows="5" cols="50">${faq_content}</textarea>
			</div>
			<button type="submit" class="btn btn-success">완료</button>
		</form>
			
	</div>
			
</body>
<%@ include file="footer.jsp" %>
</html>