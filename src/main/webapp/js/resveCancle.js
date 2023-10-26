function cancelReservation(bookSeq, userSeq) {
    // 예약 취소 요청을 서버에 보냅니다.
    console.log("값 확인 : ",bookSeq, userSeq);
    $.ajax({
        type: "POST",
        url: "./cancel.do",
        contentType: "application/json",
        data: JSON.stringify({
            book_seq: bookSeq,
            user_seq: userSeq
        }),
        success: function(response) {
            if (response == "success") {
                alert("예약이 취소되었습니다.");
                window.location.replace("./userResvePageList.do?user_seq=" + userSeq);
                window.location.reload(true);
            } else {
                alert("예약 취소에 실패했습니다. 다시 시도해주세요.");
            }
        },
        error: function(xhr, status, error) {
            alert("예약 취소 요청에 실패했습니다. 다시 시도해주세요.");
        }
    });
}
