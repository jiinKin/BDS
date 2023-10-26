<%@page import="com.dowon.bds.dto.UserDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="css/font.css">
<link rel="stylesheet" href="css/header.css">

<link rel='stylesheet' href='css/FreeBoard.css'/>
  <script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>


<title>자유게시판</title>
</head>
<c:set var="lists" value="${requestScope.lists}" />
<c:set var="pd" value="${requestScope.pd}" />
<%@ include file="header.jsp" %>
<body>
<div class="container">
	<h1>자유게시판</h1>
	<input style="float: right;background-color: #00fff5; color: #000;" class="btn" type="submit" onclick="location.href='./freeBoardInsertView.do'" value="새글작성">
    <table class="table" border="1">
        <tr>
            <th>번호</th>
            <th>제목</th>
            <th>작성자</th>
            <th>작성일</th>
        </tr>
        <c:forEach var="freeBoard" items="${lists}" varStatus="status">
            <tr>
<%--                 <td>${freeBoard.free_bseq}</td> --%>
				<td>${pd.getTotalCount() - (pd.getPage() - 1) * pd.getCountList() - status.index}</td>
                <td><a class="a" href="./freeBoardDetail.do?free_bseq=${freeBoard.free_bseq}">${freeBoard.free_title}</a></td>
                <td>${freeBoard.user_name}</td>
                <td><fmt:formatDate value="${freeBoard.free_regdate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
            </tr>
        </c:forEach>
    </table>
    
    <div class="text-center">
        <ul class="pagination pagination-lg">
            <c:if test="${pd.getStartPage() > 1}">
                <li><a href="./freeBoardList.do?page=1">첫페이지</a></li>
            </c:if>
    
            <c:if test="${pd.getStartPage() > 1}">
                <c:choose>
                    <c:when test="${pd.getStartPage() - pd.getCountPage() <= 0}">
                        <li><a href="./freeBoardList.do?page=1">이전</a></li>
                    </c:when>
                    <c:otherwise>
                        <li><a href="./freeBoardList.do?page=${pd.getStartPage() - pd.getCountPage()}">이전</a></li>
                    </c:otherwise>
                </c:choose>
            </c:if>
    
            <c:forEach begin="${pd.getStartPage()}" end="${pd.getEndPage()}" var="i">
                <li <c:if test="${i == pd.getPage()}">class="active"</c:if>>
                    <a href="./freeBoardList.do?page=${i}">${i}</a>
                </li>
            </c:forEach>
    
            <c:if test="${pd.getPage() < pd.getTotalPage()}">
                <c:choose>
                    <c:when test="${pd.getStartPage() + pd.getCountPage() > pd.getTotalPage()}">
                        <li><a href="./freeBoardList.do?page=${pd.getTotalPage()}">다음</a></li>
                    </c:when>
                    <c:otherwise>
                        <li><a href="./freeBoardList.do?page=${pd.getStartPage() + pd.getCountPage()}">다음</a></li>
                    </c:otherwise>
                </c:choose>
            </c:if>
    
            <c:if test="${pd.getEndPage() < pd.getTotalPage()}">
                <li><a href="./freeBoardList.do?page=${pd.getTotalPage() - pd.getTotalPage() % pd.getCountList() + 1}">끝페이지</a></li>
            </c:if>
        </ul>
    </div>
</div>
    
    
</body>
<%@ include file="footer.jsp" %>
</html>