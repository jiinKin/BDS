<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="css/font.css">
<link rel="stylesheet" href="css/header.css">
<link rel='stylesheet' href='css/FreeBoard.css'/>
  <script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<title>자유게시판 새글작성</title>
<%@ include file="header.jsp" %>
</head>
<body>
	<div class="container">
		<h1>새글작성<button style="float: right; background-color: #ccc; color: #000;" class="btn" onclick="location.href='./freeBoardList.do'">이전</button></h1>
		<form action="./freeBoardInsert.do" method="post" onsubmit="return validateForm()">
			<div class="form-group">
				<label for="id">아이디:</label>
				<div class="form-control" id="id">${loginDto.user_name}</div>
			</div>
			<div class="form-group">
				<label for="title">제목:</label>
				<input type="text" class="form-control" id="free_title" name="free_title">
			</div>
			<div class="form-group">
				<label for="comment">내용:</label>
				<textarea class="form-control" id="free_content" name="free_content" rows="15" cols="50"></textarea>
			</div>
			<button style="margin-bottom: 10px; background-color: #00fff5; color: #000;" type="submit" class="btn">완료</button>
		</form>
	</div>
</body>
<script>
    function validateForm() {
        var title = document.getElementById("free_title").value;
        var content = document.getElementById("free_content").value;

        if (title.trim() === "" && content.trim() === "") {
            alert("제목과 내용을 입력하세요.");
            return false;
        }

        if (title.trim() === "") {
            alert("제목을 입력하세요.");
            return false;
        }

        if (content.trim() === "") {
            alert("내용을 입력하세요.");
            return false;
        }

        return true;
    }
</script>
<%@ include file="footer.jsp" %>
</html>