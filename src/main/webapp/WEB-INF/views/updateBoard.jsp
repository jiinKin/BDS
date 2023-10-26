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
<title>글 수정 페이지</title>
</head>
<%@ include file="header.jsp" %>
<body>
<div class="container">
		<h1>제목: ${free_title}</h1><button style="float: right; background-color: #00fff5; color: #000;" class="btn" onclick="history.back(-1)">이전</button><br>
		<form action="./freeBoardUpdate.do?free_bseq=${free_bseq}" method="post" onsubmit="return validateModify()">
			<div class="form-group">
				<label for="id">아이디:</label>
				<div class="form-control" id="id">${loginDto.user_name}</div>
			</div>
			<div class="form-group">
				<label for="comment">내용:</label>
				<textarea class="form-control" id="free_content" name="free_content" rows="5" cols="50">${free_content}</textarea>
			</div>
			<button  type="submit" style="background-color: #00fff5; color: #000;" class="btn">완료</button>
		</form>
			
	</div>
</body>
<script>
    function validateModify() {
        var content = document.getElementById("free_content").value;

        if (content.trim() === "") {
            alert("내용을 입력하세요.");
            return false;
        }
        return true;
    }
</script>
<%@ include file="footer.jsp" %>
</html>