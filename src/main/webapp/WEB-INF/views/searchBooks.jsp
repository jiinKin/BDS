<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>책 검색결과 페이지</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="css/font.css">
<link rel="stylesheet" href="css/header.css">
<link rel="stylesheet" href="css/bookList.css"/>
</head>
<c:set var="lists" value="${requestScope.searchResults}" />
<c:set var="pd" value="${requestScope.pd}" />
<%@ include file="header.jsp" %>
<body>

    <h1>도서 검색 결과</h1>
    
       <table id="bookList">
		<tr>
            <th>도서번호</th>
            <th>도서이미지</th>
            <th>도서제목</th>
            <th>저자명</th>
            <th>도서 ISBN</th>
            <th>출판사</th>
            <th>출판일</th>
        </tr>
            <c:forEach var="book" items="${searchResults}" varStatus="status" >
                <tr>
					<td>${pd.getTotalCount() - (pd.getPage() - 1) * pd.getCountList() - status.index}</td>
	                <td><a href='./getDetailBook.do?book_seq=${book.book_seq}'><img src="${book.book_img}" alt="도서 이미지"></a></td>
	                <td><a href='./getDetailBook.do?book_seq=${book.book_seq}'>${book.book_title}</a></td>
	                <td>${book.book_writer}</td>
	                <td>${book.book_isbn}</td>
	                <td>${book.book_publisher}</td>
	                <td><fmt:formatDate pattern="yyyy-MM-dd" value="${book.book_published_date}"/></td>
            	</tr>
            </c:forEach>
    </table>

<div class="text-center">
        <ul class="pagination pagination-lg">
            <c:if test="${pd.getStartPage() > 1}">
                <li><a href="./searchBooks.do?page=1">첫페이지</a></li>
            </c:if>
    
            <c:if test="${pd.getStartPage() > 1}">
                <c:choose>
                    <c:when test="${pd.getStartPage() - pd.getCountPage() <= 0}">
                        <li><a href="./searchBooks.do?page=1">이전</a></li>
                    </c:when>
                    <c:otherwise>
                        <li><a href="./searchBooks.do?page=${pd.getStartPage() - pd.getCountPage()}&keyword=${keyword}">이전</a></li>
                    </c:otherwise>
                </c:choose>
            </c:if>
    
            <c:forEach begin="${pd.getStartPage()}" end="${pd.getEndPage()}" var="i">
                <li <c:if test="${i == pd.getPage()}">class="active"</c:if>>
                    <a href="./searchBooks.do?page=${i}&keyword=${keyword}">${i}</a>
                </li>
            </c:forEach>
    
            <c:if test="${pd.getPage() < pd.getTotalPage()}">
                <c:choose>
                    <c:when test="${pd.getStartPage() + pd.getCountPage() > pd.getTotalPage()}">
                        <li><a href="./searchBooks.do?page=${pd.getTotalPage()}&keyword=${keyword}">다음</a></li>
                    </c:when>
                    <c:otherwise>
                        <li><a href="./searchBooks.do?page=${pd.getStartPage() + pd.getCountPage()}&keyword=${keyword}">다음</a></li>
                    </c:otherwise>
                </c:choose>
            </c:if>
    
            <c:if test="${pd.getEndPage() < pd.getTotalPage()}">
                <li><a href="./searchBooks.do?page=${pd.getTotalPage() - pd.getTotalPage() % pd.getCountList() + 1}&keyword=${keyword}">끝페이지</a></li>
            </c:if>
        </ul>
    </div>
    
</body>
</html>