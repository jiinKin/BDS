<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>registBookForm</title>
<link rel='stylesheet' href='./css/registBookForm.css'/>
</head>
<body>

	<div class="form-container">
        <form id="registBookForm" action="./registbutton.do" method="post">

			<div class="book-image">
				<input type="hidden" name="book_img" value="${registBook.book_img}">
				<img src="${registBook.book_img}" alt="도서 이미지">
			</div>
			<!-- 도서 정보 입력란 -->
            <div class="book-info">도서 제목:</div>
            <input type="text" name="book_title" value="${registBook.book_title}">
            
            <div class="book-info">저자:</div>
            <input type="text" name="book_writer" value="${registBook.book_writer}">
            
            <div class="book-info">도서 ISBN:</div>
            <input type="text" name="book_isbn" value="${registBook.book_isbn}">
            
            <div class="book-info">출판사:</div>
            <input type="text" name="book_publisher" value="${registBook.book_publisher}">
            
            <div class="book-info">출판일:</div>
            <input type="text" name="book_published_dateStr" 
            value='<fmt:formatDate pattern="yyyy-MM-dd" value="${registBook.book_published_date}" />'>
            
            <div class="book-info">도서 내용:</div>
            <textarea name="book_intro" rows="5">${registBook.book_intro}</textarea>
            
            <!-- 도서 인덱스 및 도서 요약 입력란 -->
            <div class="book-info">도서 인덱스:</div>
            <input type="text" name="book_index" placeholder="book_index 값을 넣어주세요.">
            
            <div class="book-info">도서 요약:</div>
            <input type="text" name="book_summary" placeholder="book_summary 내용을 넣어주세요.">
            
            <!--등록 폼 버튼 -->
            <div class="btn-container">
                <input type="submit" value="도서 등록하기">
                <input type="submit" value="도서 등록취소" onclick="history.back(-1)">
            </div>
        </form>
		<div id="alert" data-result="${result}"></div>
		<script type="text/javascript" src="js/registBook.js"></script>
	</div>
</body>

</html>
