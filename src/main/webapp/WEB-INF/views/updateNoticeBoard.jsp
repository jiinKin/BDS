<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 수정 페이지</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="css/header.css">
</head>
<%@ include file="header.jsp" %>
<body>
<div class="container">
	<h1>제목: ${notice_title}</h1><button style="float: right; background-color: #00fff5; color: #000;" class="btn" onclick="history.back(-1)">이전</button><br>
		<form action="./updateNoticeBoard.do?notice_bseq=${notice_bseq}" method="post">
			<div class="form-group">
				<label for="id">아이디:</label>
				<div class="form-control" id="id">${loginDto.user_name}</div>
			</div>
			<div class="form-group">
				<label for="comment">내용:</label>
				<textarea class="form-control" id="notice_content" name="notice_content" rows="5" cols="50">${notice_content}</textarea>
			</div>
			<button type="submit" style="background-color: #00fff5; color: #000;" class="btn">완료</button>
		</form>
</div>
</body>
<%@ include file="footer.jsp" %>
</html>