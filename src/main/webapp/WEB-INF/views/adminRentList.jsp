<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="css/font.css">
<link rel="stylesheet" href="css/adminRentList.css">
<link rel="stylesheet" href="css/adminHeader.css">
<title>Insert title here</title>
<%-- <%@include file="/WEB-INF/views/header.jsp"%> --%>
<%@ include file="/WEB-INF/views/adminHeader.jsp" %>
</head>
<c:set var="lists" value="${requestScope.lists}" />
<c:set var="r" value="${requestScope.aPage}" />
<body>

<div class="container">
    <h1 id="hh">계발의민족 회원 도서 대출 목록</h1>
    <table class="table" border="1">
        <tr>
        	<th>No.</th>
            <th>사용자 이름</th>
            <th>도서 제목</th>
            <th>대출일</th>
            <th>반납예정일</th>
            <th>대출 상태</th>
            <th>처리</th>
            <th>운송장</th>
        </tr>
        <c:forEach var="rent" items="${lists}" varStatus="status">
            <tr>
<%--         	    <td>${rent.BOOK_SEQ}</td> --%>
<%-- 				<td>${status.index + 1}</td> --%>
				<td>${r.getTotalCount() - (r.getPage() - 1) * r.getCountList() - status.index}</td>
                <td>${rent.NAME}</td>
                <td>${rent.BOOK_TITLE}</td>
                <td>
                	<fmt:formatDate value="${rent.RENT_DATE}" pattern="yyyy.MM.dd"/>
                </td>
                <td>
                	<fmt:formatDate value="${rent.RENT_RETURN_DATE}" pattern="yyyy.MM.dd"/>
                </td>
                <td>
                <c:choose>
                        <c:when test="${rent.RENT_STATUS eq 'Y'}">대출중</c:when>
                        <c:when test="${rent.RENT_STATUS eq 'N'}">반납완료</c:when>
                        <c:when test="${rent.RENT_STATUS eq 'A'}">대출 배송완료</c:when>
                        <c:when test="${rent.RENT_STATUS eq 'B'}">반납 배송완료</c:when>
                    </c:choose>
                </td>
                <td>
                    <c:choose>
                        <c:when test="${rent.RENT_STATUS eq 'B'}">
                        <button onclick="handleActions(${rent.SEQ}, ${rent.BOOK_SEQ})" class="btn btn-info" style="color: #263238">반납확인</button>
                        </c:when>
                    </c:choose>
                </td>
<!--                 <td style="display: flex; align-items: center;"> -->
<%--             	    	<input type="text" id="deliveryNum${rent.USER_SEQ}" placeholder="운송장번호 입력" value=""> --%>
<%--   					   <button onclick="updateDelivery(${rent.USER_SEQ}, '${rent.USER_SEQ.delivery_num}')" style="color: #263238">입력</button> --%>

<!--                 </td> -->
				<td style="display: flex; align-items: center;">
				    <form id="deliveryForm${status.index}" action="./updateDeliveryNum.do?user_seq=${rent.USER_SEQ}" method="post">
				        <div class="form-group">
				            <input type="text" id="deliveryNum${status.index}" name="delivery_num" placeholder="운송장번호 입력" value="">
				        </div>
				        <button type="button" class="btn btn-success" style="color: #263238" onclick="updateDelivery(${status.index})">입력</button>
				    </form>
				</td>


                
            </tr>
        </c:forEach>
    </table>
    <!-- 페이지 번호 및 화살표 옮기기 -->
    <div class="text-center">
        <ul class="pagination pagination-lg">
            <c:if test="${r.getStartPage() > 1}">
                <li><a href="./oldAdminRentList.do?page=1">처음</a></li>
            </c:if>
    
            <c:if test="${r.getStartPage() > 1}">
                <c:choose>
                    <c:when test="${r.getStartPage() - r.getCountPage() <= 0}">
                        <li><a href="./oldAdminRentList.do?page=1">이전</a></li>
                    </c:when>
                    <c:otherwise>
                        <li><a href="./oldAdminRentList.do?page=${r.getStartPage() - r.getCountPage()}">이전</a></li>
                    </c:otherwise>
                </c:choose>
            </c:if>
    
            <c:forEach begin="${r.getStartPage()}" end="${r.getEndPage()}" var="i">
                <li <c:if test="${i == r.getPage()}">class="active"</c:if>>
                    <a href="./oldAdminRentList.do?page=${i}">${i}</a>
                </li>
            </c:forEach>
    
            <c:if test="${r.getPage() < r.getTotalPage()}">
                <c:choose>
                    <c:when test="${r.getStartPage() + r.getCountPage() > r.getTotalPage()}">
                        <li><a href="./oldAdminRentList.do?page=${r.getTotalPage()}">다음</a></li>
                    </c:when>
                    <c:otherwise>
                        <li><a href="./oldAdminRentList.do?page=${r.getStartPage() + r.getCountPage()}">다음</a></li>
                    </c:otherwise>
                </c:choose>
            </c:if>
    
            <c:if test="${r.getEndPage() < r.getTotalPage()}">
                <li><a href="./oldAdminRentList.do?page=${r.getTotalPage() - r.getTotalPage() % r.getCountList() + 1}">끝</a></li>
            </c:if>
        </ul>
    </div>
</div> 
</body>
<%@ include file="footer.jsp" %>
<script>
//버튼 클릭 시 두 개의 메소드를 호출하는 함수
async function handleActions(rentSeq, bookSeq) {
    try {
        // 첫 번째 AJAX 요청 (rentSeq 사용)
        const confirmResponse = await $.ajax({
            type: "POST",
            url: "./confirmReturn.do",
            data: { rentSeq: rentSeq }
        });

        if (confirmResponse == "success") {
            alert("반납확인 완료");
        } else {
            alert("반납확인 실패");
        }

        // 두 번째 AJAX 요청 (bookSeq 사용)
        const rentStandbyResponse = await $.ajax({
            type: "POST",
            url: "./rentStandby.do",
            data: { bookSeq: bookSeq }
        });

        if (rentStandbyResponse == "success") {
            alert("해당도서의 예약회원의 상태가 대출대기로 변경되었습니다.");
        } else {
            alert("해당도서는 예약건이 없어 예약상태변경이 진행되지 않습니다.");
        }
        location.reload();
    } catch (error) {
        console.error("오류 발생: " + error);
        alert("요청을 처리하는 동안 오류가 발생했습니다.");
    }
}

</script>
<script type="text/javascript">

function updateDelivery(index) {
    const deliveryNumInput = document.getElementById('deliveryNum'+index).value;
// 	var user_seq = document.getElementById('user_seq').value;
    //     const form = document.getElementById(`deliveryForm${index}`);
	console.log(deliveryNumInput);
    // 운송장 번호 입력 필드에서 값을 가져온다
//     const deliveryNum = deliveryNumInput.value;

    // AJAX를 사용하여 서버에 업데이트 요청을 보냄
    $.ajax({
    	url: './updateDeliveryNum.do', // 업데이트를 수행할 컨트롤러의 URL
        type: 'POST', // POST 방식으로 요청
        data: {
            "delivery_num": deliveryNumInput
        },
        success: function(response) {
        	if(response == "0"){
	            alert('운송장 번호 입력이 실패되었습니다', response);
        	}else{
	            alert('운송장 번호가 업데이트되었습니다.', response);
        	}
        },
        error: function(error) {
            alert('운송장 번호 업데이트 중 오류가 발생했습니다.');
        }
    });
}



</script>

</html>