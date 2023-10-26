<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="css/font.css">
<link rel="stylesheet" href="css/header.css">
<link rel='stylesheet' href='css/FreeBoard.css'/>
<script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<title>자유게시판 게시글 상세페이지</title>
<%@ include file="header.jsp" %>
</head>
<body>
	<div id="replyContainer" class="container">
		<h1>제목: ${dto.free_title}<input style="float: right; background-color: #ccc; color: #222831;" class="btn" type="button" value="이전" onclick="location.href='./freeBoardList.do'">
			<c:if test="${loginDto.user_name eq dto.user_name}">
    		<input style="float: right;" class="btn btn-danger" type="button" value="삭제" onclick="boardDel()">
			<input style="float: right;background-color: #00ADB5; color: #000;" class="btn" type="button" value="수정" onclick="location.href='./updateBoard.do?free_bseq='+ ${dto.free_bseq} + '&free_title=' + '${dto.free_title}' + '&free_content=' + '${dto.free_content}'">
			
			</c:if>
		</h1>
		<div>
			작성자<div class="form-control" style="font-size: 20px;">${dto.user_name}</div>
			내용<div class="form-control" style="height: 300px; font-size: 20px;">${dto.free_content}</div>
			작성일<div class="form-control" style="font-size: 15px;"><fmt:formatDate value="${dto.free_regdate}" pattern="yyyy-MM-dd HH:mm:ss"></fmt:formatDate></div>
		</div>
		</div><br>
		<div>
			</div>
			<table class="table" id="commentTable">
				<c:forEach var="comment" items="${CommentAll}">
				<tr>
					<th>${comment.user_name}: ${comment.comment_content}
					<span style="float: right; color: #222831; font-size: 12px;">작성일:${comment.comment_regdate}</span>
					</th>
				<c:if test="${loginDto.user_name == comment.user_name}">
					<td><button class="btn btn-danger" onclick="commentDel(${comment.comment_seq})">삭제</button></td>
				</c:if>
				</tr>
				</c:forEach>
			</table>
			<form id="reply" action="./CommentInsert.do" method="post" onsubmit="return validateComment();">
			    <input type="hidden" name="free_bseq" value="${dto.free_bseq}">
			    <input type="hidden" name="user_seq" value="${loginDto.user_seq}">
			    <div class="form-group">
			        <label for="comment_content">답글:</label>
			        <textarea class="form-control" id="comment_content" name="comment_content"></textarea>
			    </div>
			    <input style="background-color: #00fff5; color: #222831;" class="btn" type="submit" value="답글작성">
			</form>
			
</body>



<%@ include file="footer.jsp" %>
<script type="text/javascript">
	function boardDel(){
		 var result = confirm("선택하신 게시글을 정말 삭제하시겠습니까?");

         if (result === true) {
             alert("게시글이 삭제되었습니다.");
             window.location.href="./freeBoardDel.do?free_bseq=${dto.free_bseq}";
         } else {
             alert("게시글 삭제가 취소되었습니다.");
         }
	}
</script>
<script type="text/javascript">
	function commentDel(comment_seq){
		var result = confirm("선택하신 답글을 정말 삭제하시겠습니까?");
		
		if(result === true){
			alert("답글이 삭제되었습니다.");
			window.location.href="./CommentDel.do?comment_seq="+comment_seq;
		}else{
			alert("답글 삭제가 취소되었습니다.");
		}
	}
</script>
<script>
function validateComment() {
    var loginDto = "${loginDto.user_name}";
    var commentContent = document.getElementById("comment_content").value;
    
    if (loginDto === "null" || loginDto === "") {
        alert("로그인이 필요합니다.");
        window.location.href="./loginPage.do";
        return false; 
    }
    
    if (commentContent.trim() === "") {
        alert("답글을 입력하세요.");
        return false;
    }
    return true;
}
</script>


</html>