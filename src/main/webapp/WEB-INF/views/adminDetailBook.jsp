<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>도서 상세 정보</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="css/bookDetail.css">
<link rel="stylesheet" href="css/font.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
</head>
<%@ include file="/WEB-INF/views/adminHeader.jsp" %>
<body>
    <div class="container">
        <header>
            <h1>도서 상세 정보</h1>
        </header>
        
        <div class="book-details">
            <img src="${detailBook.book_img}" alt="${detailBook.book_title}" class="book-cover">
            <div class="book-info">
                <h2>${detailBook.book_title}</h2>
                <p><strong>저자:</strong> ${detailBook.book_writer}</p>
                <p><strong>ISBN:</strong> ${detailBook.book_isbn}</p>
                <p><strong>출판사:</strong> ${detailBook.book_publisher}</p>
                <p><strong>출판일:</strong> <fmt:formatDate value="${detailBook.book_published_date}" pattern="yyyy-MM-dd"/></p>
            </div>
        </div>
        
        <div class="book-description">
            <h2>도서 소개</h2>
            <p>${detailBook.book_intro}</p>
        </div>
        
        <div class="book-extra-info">
            <h2>추가 정보</h2>
            <p><strong>도서 인덱스:</strong> ${detailBook.book_index}</p>
            <p><strong>도서 요약:</strong> ${detailBook.book_summary}</p>
        </div>
        
        <button class="btn-edit" onclick="location.href='./updateBookForm.do?book_seq=${detailBook.book_seq}'">도서 수정</button>
    </div>
</body>
<%@ include file="footer.jsp" %>
</html>