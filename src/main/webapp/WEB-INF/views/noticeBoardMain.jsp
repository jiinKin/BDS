<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 전체 리스트</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="css/font.css">
<link rel="stylesheet" href="css/header.css">
<link rel="stylesheet" href="css/notice.css">
<script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
</head>
<c:set var="lists" value="${requestScope.lists}" />
<c:set var="pd" value="${requestScope.pd}" />
<%@ include file="header.jsp" %>
<body>
<div class="container">
<h1>공지사항</h1>
	<c:choose>
		<c:when test="${loginDto != null && loginDto.user_auth == 'A'}">
			<input class="btn" type="submit" onclick="location.href='./noticeBoardInsertForm.do'"
				value="새글작성">
		</c:when>
	</c:choose>
	<table class="table" border="1">
	<tr>
            <th>번호</th>
            <th>제목</th>
            <th>작성자</th>
            <th>작성일</th>
    </tr>
		<c:forEach var="noticeBoard" items="${lists}" varStatus="status">
		<tr>
<%--         <td><c:out value="${noticeBoard.notice_bseq}"/></td> --%>
        <td>${pd.getTotalCount() - (pd.getPage() - 1) * pd.getCountList() - status.index}</td>
		<td><a href="./noticeBoardDetail.do?notice_bseq=${noticeBoard.notice_bseq}">${noticeBoard.notice_title}</a></td>
		<td>${noticeBoard.user_name}</td>
		<td><fmt:formatDate value="${noticeBoard.notice_regdate}" pattern="yyyy-MM-dd"/> </td>
		 </tr>
        </c:forEach>
</table>

<!-- 페이징처리 -->

    <div class="text-center">
        <ul class="pagination pagination-lg">
            <c:if test="${pd.getStartPage() > 1}">
                <li><a href="./noticeBoardList.do?page=1">첫페이지</a></li>
            </c:if>
    
            <c:if test="${pd.getStartPage() > 1}">
                <c:choose>
                    <c:when test="${pd.getStartPage() - pd.getCountPage() <= 0}">
                        <li><a href="./noticeBoardList.do?page=1">이전</a></li>
                    </c:when>
                    <c:otherwise>
                        <li><a href="./noticeBoardList.do?page=${pd.getStartPage() - pd.getCountPage()}">이전</a></li>
                    </c:otherwise>
                </c:choose>
            </c:if>
    
            <c:forEach begin="${pd.getStartPage()}" end="${pd.getEndPage()}" var="i">
                <li <c:if test="${i == pd.getPage()}">class="active"</c:if>>
                    <a href="./noticeBoardList.do?page=${i}">${i}</a>
                </li>
            </c:forEach>
    
            <c:if test="${pd.getPage() < pd.getTotalPage()}">
                <c:choose>
                    <c:when test="${pd.getStartPage() + pd.getCountPage() > pd.getTotalPage()}">
                        <li><a href="./noticeBoardList.do?page=${pd.getTotalPage()}">다음</a></li>
                    </c:when>
                    <c:otherwise>
                        <li><a href="./noticeBoardList.do?page=${pd.getStartPage() + pd.getCountPage()}">다음</a></li>
                    </c:otherwise>
                </c:choose>
            </c:if>
    
            <c:if test="${pd.getEndPage() < pd.getTotalPage()}">
                <li><a href="./noticeBoardList.do?page=${pd.getTotalPage() - pd.getTotalPage() % pd.getCountList() + 1}">끝페이지</a></li>
            </c:if>
        </ul>
    </div>
</div>
</body>
<%@ include file="footer.jsp" %>
</html>