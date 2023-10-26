<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>도서 등록 페이지</title>
<link rel="stylesheet" href="css/font.css">
<script src="https://code.jquery.com/jquery-3.7.0.js"></script>
<link href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">
<!-- <link rel="stylesheet" href="css/adminHeader.css"/> -->
<link rel="stylesheet" href="css/addbook.css"/>
<script src="js/addBook.js"></script>
</head>
<%@ include file="/WEB-INF/views/adminHeader.jsp" %>
<body>
    <c:if test="${not empty resultAddBook}">
        <script>
            alert("${resultAddBook}");
        </script>
    </c:if>

   <div class="search-container" style="width: 40%; margin: 0 auto; text-align: center; margin-top: 50px; margin-bottom: 100px;">
   <input class="searching" type="text" id="bookName" style=" margin-right: 0px; width: 100%;" placeholder="등록할 도서명 입력">
   <button type="submit" id="search" style=" margin-left: 0px;"><i class="fa fa-search"></i></button>
   </div>
   <div id="bookSearchTable"></div>
</body>
<%@ include file="footer.jsp" %>
</html>