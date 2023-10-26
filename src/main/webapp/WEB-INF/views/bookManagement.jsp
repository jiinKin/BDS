<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 도서 리스트</title>
<link rel="stylesheet" href="css/font.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="css/adminHeader.css"/>
<link rel="stylesheet" href="css/bookList.css"/>
</head>
<c:set var="lists" value="${requestScope.userBookList}" />
<c:set var="pd" value="${requestScope.pd}" />
<%@ include file="/WEB-INF/views/adminHeader.jsp" %>
<body>
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
        <c:forEach var="book" items="${getAllBooks}" varStatus="status">
            <tr>
				<td>${pd.getTotalCount() - (pd.getPage() - 1) * pd.getCountList() - status.index}</td>
                <td><a href='./getAdminDetailBook.do?book_seq=${book.book_seq}'><img src="${book.book_img}"></a></td>
     		    <td><a href='./getAdminDetailBook.do?book_seq=${book.book_seq}'>${book.book_title}</a></td>
                <td>${book.book_writer}</td>
                <td>${book.book_isbn}</td>
                <td>${book.book_publisher}</td>
                <td><fmt:formatDate pattern="yyyy-MM-dd" value="${book.book_published_date}"/></td>
            </tr>
        </c:forEach>
    </table>

<!-- 페이징처리 -->

    <div class="text-center">
        <ul class="pagination pagination-lg">
            <c:if test="${pd.getStartPage() > 1}">
                <li><a href="./bookMagagement.do?page=1">첫페이지</a></li>
            </c:if>
    
            <c:if test="${pd.getStartPage() > 1}">
                <c:choose>
                    <c:when test="${pd.getStartPage() - pd.getCountPage() <= 0}">
                        <li><a href="./bookMagagement.do?page=1">이전</a></li>
                    </c:when>
                    <c:otherwise>
                        <li><a href="./bookMagagement.do?page=${pd.getStartPage() - pd.getCountPage()}">이전</a></li>
                    </c:otherwise>
                </c:choose>
            </c:if>
    
            <c:forEach begin="${pd.getStartPage()}" end="${pd.getEndPage()}" var="i">
                <li <c:if test="${i == pd.getPage()}">class="active"</c:if>>
                    <a href="./bookMagagement.do?page=${i}">${i}</a>
                </li>
            </c:forEach>
    
            <c:if test="${pd.getPage() < pd.getTotalPage()}">
                <c:choose>
                    <c:when test="${pd.getStartPage() + pd.getCountPage() > pd.getTotalPage()}">
                        <li><a href="./bookMagagement.do?page=${pd.getTotalPage()}">다음</a></li>
                    </c:when>
                    <c:otherwise>
                        <li><a href="./bookMagagement.do?page=${pd.getStartPage() + pd.getCountPage()}">다음</a></li>
                    </c:otherwise>
                </c:choose>
            </c:if>
    
            <c:if test="${pd.getEndPage() < pd.getTotalPage()}">
                <li><a href="./bookMagagement.do?page=${pd.getTotalPage() - pd.getTotalPage() % pd.getCountList() + 1}">끝페이지</a></li>
            </c:if>
        </ul>
    </div>	  
    
</body>
<%@ include file="footer.jsp" %>
</html>