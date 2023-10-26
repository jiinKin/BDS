$(document).ready(function() {
	
    $("#userTableButton").click(function() {
        toggleUserTable();
    });

    $("#bookTableButton").click(function() {
        toggleBookTable();
    });

    $("#rentListButton").click(function() {
        toggleRentTable();
    });
    
    hideUserTable();
    hideBookTable();
    hideBookSearchTable();
    hideRentTable();
});

var isRentTableVisible = false;

function clearTable() {
    $("#userInfoTable").empty(); // 회원 테이블 내용 삭제
    $("#bookInfoTable").empty(); // 도서 테이블 내용 삭제
    $("#bookSearchTable").empty(); // 도서 테이블 내용 삭제
    $("#rentListTable").empty();
}



function toggleRentTable(){
    isRentTableVisible = !isRentTableVisible;
    if (isRentTableVisible) {
        getAllRent();
        hideUserTable();
        hideBookTable();
        hideBookSearchTable();
        $("#rentListTable").show();
    } else {
        hideRentTable();
    }
}




function getAllRent() {
    $("#userInfoTable").hide();
    $("#bookInfoTable").hide();
    $("#rentListTable").show();
    $.get("./adminRentList.do", function (data) {
	var aPage = data.aPage;
	console.log("apage:", aPage);
      var rentList = data.lists;
      console.log("rentList:", rentList);
			
        var tableHtml = "<table border='1'><tr><th>No.</th><th>사용자 이름</th><th>도서 제목</th><th>대출일</th><th>반납예정일</th><th>대출 상태</th><th>처리</th><th>운송장</th></tr>";
        for (var i = 0; i < rentList.length; i++) {
            var rent = rentList[i];
            tableHtml += "포문테스트!!!";
            tableHtml += "<tr>";
            tableHtml += "<td>" + (aPage.totalCount - (aPage.page - 1) * aPage.countList - i) + "</td>"; // 페이지 번호 계산
            tableHtml += "<td>" + rent.NAME + "</td>";
            tableHtml += "<td>" + rent.BOOK_TITLE + "</td>";
            tableHtml += "<td>" + formatDate(rent.RENT_DATE) + "</td>";
            tableHtml += "<td>" + formatDate(rent.RENT_RETURN_DATE) + "</td>";
            tableHtml += "<td>";
            if (rent.RENT_STATUS == 'Y') {
                tableHtml += "대출중";
            } else if (rent.RENT_STATUS == 'N') {
                tableHtml += "반납완료";
            } else if (rent.RENT_STATUS == 'A') {
                tableHtml += "대출 배송완료";
            } else if (rent.RENT_STATUS == 'B') {
                tableHtml += "반납 배송완료";
            }
            tableHtml += "</td>";
            if (rent.RENT_STATUS == "B") {
                tableHtml += "<td><button onclick='handleActions(" + rent.SEQ + ", " + rent.BOOK_SEQ + ")'>반납확인</button></td>";
            } else {
                tableHtml += "<td></td>"; 
            }

//            tableHtml += "<td><input type='text' id='deliveryNum" + rent.USER_SEQ + "' placeholder='운송장번호 입력' value=''>" +
//                         "<button onclick='updateDelivery(" + rent.USER_SEQ + ", \"" + rent.USER_SEQ + ".delivery_num\")'>입력</button></td>";
			
			tableHtml += "<td style='display: flex; align-items: center;'>";
				tableHtml += "<form id='deliveryForm" + i + "' action='./updateDeliveryNum.do?user_seq=" + rent.USER_SEQ + "' method='post'>";
				tableHtml += "<div class='form-group'>";
				tableHtml += "<input type='text' id='deliveryNum" + i + "' name='delivery_num' placeholder='운송장번호 입력' value=''>";
				tableHtml += "</div>";
				tableHtml += "<button type='button' class='btn btn-success' style='color: #263238' onclick='updateDelivery(" + i + ")'>입력</button>";
				tableHtml += "</form>";
				tableHtml += "</td>";

			
			

           

            tableHtml += "</tr>";
        }

        tableHtml += "</table>";

        var paginationHtml = "<div class='text-center'><ul class='pagination pagination-lg'>";
        if (aPage.startPage > 1) {
            paginationHtml += "<li><a href='./adminRentList.do?page=1'>◁◁</a></li>";
        }
        if (aPage.startPage > 1) {
            if (aPage.startPage - aPage.countPage <= 0) {
                paginationHtml += "<li><a href='./adminRentList.do?page=1'>◀</a></li>";
            } else {
                paginationHtml += "<li><a href='./adminRentList.do?page=" + (aPage.startPage - aPage.countPage) + "'>◀</a></li>";
            }
        }

        for (var i = aPage.startPage; i <= aPage.endPage; i++) {
            paginationHtml += "<li " + (i == aPage.page ? "class='active'" : "") + "><a href='./adminRentList.do?page=" + i + "'>" + i + "</a></li>";
        }

        if (aPage.page < aPage.totalPage) {
            if (aPage.startPage + aPage.countPage > aPage.totalPage) {
                paginationHtml += "<li><a href='./adminRentList.do?page=" + aPage.totalPage + "'>▶</a></li>";
            } else {
                paginationHtml += "<li><a href='./adminRentList.do?page=" + (aPage.startPage + aPage.countPage) + "'>▶</a></li>";
            }
        }

        if (aPage.endPage < aPage.totalPage) {
            paginationHtml += "<li><a href='./adminRentList.do?page=" + (aPage.totalPage - aPage.totalPage % aPage.countList + 1) + "'>▷▷</a></li>";
        }

        paginationHtml += "</ul></div>";

        $("#rentListTable").html(tableHtml + paginationHtml);
    });
}


function formatDate(dateString) {
    var date = new Date(dateString);
    var year = date.getFullYear();
    var month = (date.getMonth() + 1).toString().padStart(2, '0'); // 월은 0부터 시작하므로 1을 더하고 2자리로 포맷
    var day = date.getDate().toString().padStart(2, '0'); // 일자를 2자리로 포맷
    return year + "." + month + "." + day;
}

async function handleActions(rentSeq, bookSeq) {
    try {
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


// 지인 JavaScript 파일에서 운송장 번호 업데이트
function updateDelivery(userSeq, deliveryNum) {
 
    const deliveryNumValue = document.getElementById(`deliveryNum${userSeq}`).value;

    // AJAX를 사용하여 서버에 업데이트 요청을 보냄
    $.ajax({
        url: './updateDeliveryNum.do',
        type: 'POST', // 업데이트 요청의 HTTP
        data: {
            user_seq: userSeq,
            delivery_num: deliveryNumValue // 가져온 운송장 번호 사용
        },
        success: function(response) {
            alert('운송장 번호가 업데이트되었습니다.');
        },
        error: function(error) {
            // 업데이트가 실패한 경우 처리할 내용을 여기에 추가하세요.
            alert('운송장 번호 업데이트 중 오류가 발생했습니다.');
        }
    });
}


function hideRentTable(){
	$("#rentListTable").empty();
}

