<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="css/font.css">
<link rel="stylesheet" href="css/header.css">
<link rel="stylesheet" href="css/footer.css">
<link rel="stylesheet" href="css/faqInsert.css">
<script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<title>관리자 FAQ 작성 페이지</title>
<%@ include file="header.jsp" %>
</head>
<body>
<div class="container">
		<h3>자주 묻는 질문 작성<button style="float: right; background-color: #ccc; color: #000;" class="btn" onclick="location.href='./faqList.do'">이전</button></h3>
		<form action="./faqInsert.do" method="post" onsubmit="return validateForm()">
			<div class="form-group">
				<label for="user_seq">작성자:</label>
				<div class="form-control" id="user_seq">${loginDto.user_name}</div>
			</div>
			<div class="form-group">
				<label for="title">제목:</label>
				<input type="text" class="form-control" id="faq_title" name="faq_title">
			</div>
			
			  <div class="category_search_wrap">
		                <div class="input_select_wrap2">
		                   <select title="카테고리" name="faq_category" id="faq_category">
				                <option value="">카테고리</option>
				                <option value="1">도서이용일반</option>
				                <option value="2">비치희망도서자료신청</option>
				                <option value="3">회원가입관련</option>
				                <option value="4">자료검색및대출</option>
				            </select>
		                 </div>
		       </div>
			<div class="form-group">
				<textarea class="faq_content" id="faq_content" name="faq_content" rows="10" cols="140"></textarea>
			</div>
			<button style="margin-bottom: 10px; background-color: #00fff5; color: #000;" type="submit" class="btn">완료</button>
		</form>
	</div>

</body>

<script>
    function validateForm() {
        var title = document.getElementById("faq_title").value;
        var content = document.getElementById("faq_content").value;

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