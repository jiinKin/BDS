<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 새글 작성</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="css/header.css">
<link rel="stylesheet" href="css/footer.css">
<link rel="stylesheet" href="css/noticeInsert.css">
</head>
<%@ include file="header.jsp" %>
<body>
<div class="container">
	<h1>새글작성<button style="float: right; background-color: #ccc; color: #000;" class="btn"
 		onclick="location.href='./noticeBoardList.do'">이전</button></h1>
<form action="./noticeBoardInsert.do" method="post" onsubmit="return validateForm()">
			<div class="form-group">
				<label for="id">아이디:</label>
				<div class="form-control" id="id">${loginDto.user_name}</div>
			</div>
			<div class="form-group">
				<label for="title">제목:</label>
				<input type="text" class="form-control" id="notice_title" name="notice_title">
			</div>
			<div class="form-group">
				<label for="comment">내용:</label>
				<textarea class="form-control" id="notice_content" name="notice_content" rows="15" cols="50"></textarea>
			</div>
			<button style="margin-bottom: 10px; background-color: #00fff5; color: #000;" type="submit" class="btn">완료</button>
		</form>
	</div>
</body>
<%@ include file="footer.jsp" %>
</html>