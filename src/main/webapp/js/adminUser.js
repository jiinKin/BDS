$(document).ready(function() {
    $("#userTableButton").click(function() {
        toggleUserTable();
    });

    $("#bookTableButton").click(function() {
        toggleBookTable();
    });

    $("#rentListButton").click(function() {
        // 대출관리 버튼에 대한 동작 추가
        toggleRentTable();
    });

    // 초기에 테이블은 숨겨져 있도록 설정
    hideUserTable();
    hideBookTable();
    hideRentTable();//하은추가
});

function clearTable() {
    $("#userInfoTable").empty(); // 회원 테이블 내용 삭제
    $("#bookInfoTable").empty(); // 도서 테이블 내용 삭제
    $("#bookSearchTable").empty(); // 도서 테이블 내용 삭제
    $("#rentListTable").empty();//하은추가
}

var isUserTableVisible = false;

function toggleUserTable() {
    isUserTableVisible = !isUserTableVisible;
    if (isUserTableVisible) {
        getAllUsers();
        hideBookTable();
        hideBookSearchTable();
        hideRentTable();//하은추가
        $("#userInfoTable").show();
    } else {
        hideUserTable();
    }
}

function getAllUsers() {
	$("#rentListTable").hide();//하은추가
    $("#bookInfoTable").hide();
    $("#userInfoTable").show();
    var userList = $("<table id='userList'>").append(
        $("<tr>").append(
            "<th>회원번호</th>",
            "<th>회원이메일</th>",
            "<th>회원이름</th>",
            "<th>전화번호</th>",
            "<th>회원생일</th>",
            "<th>가입일</th>",
            "<th>성별</th>"
        )
    );

    $.get("./getAllUser.do", function(getAllusers) {
        $.each(getAllusers, function(index, user) {
            userList.append(
                $("<tr>").append(
                    "<td>" + user.user_seq + "</td>",
                    "<td>" + user.user_email + "</td>",
                    "<td>" + user.user_name + "</td>",
                    "<td>" + user.user_phone + "</td>",
                    "<td>" + user.user_birth + "</td>",
                    "<td>" + user.joindate + "</td>",
                    "<td>" + user.user_gender + "</td>"
                )
            );
        });
    });

    $("#userInfoTable").html(userList);
}

function hideUserTable() {
    $("#userInfoTable").empty();
}