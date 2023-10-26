//
//
//$(document).ready(function() {
//    $("#userTableButton").click(function() {
//        toggleUserTable();
//    });
//
//    $("#bookTableButton").click(function() {
//        toggleBookTable();
//    });
//
//    $("#rentListButton").click(function() {
//        // 대출관리 버튼에 대한 동작 추가
//        toggleRentTable();
//    });
//
//    // 초기에 테이블은 숨겨져 있도록 설정
//    hideUserTable();
//    hideBookTable();
//    hideBookSearchTable();
//    hideRentTable();//하은추가
//});
//
//var isBookTableVisible = false;
//
//function toggleBookTable() {
//    isBookTableVisible = !isBookTableVisible;
//    if (isBookTableVisible) {
//        getAllBooks();
//        hideUserTable();
//        hideBookSearchTable();
//        hideRentTable();//하은추가
//        $("#bookInfoTable").show();
//    } else {
//        hideBookTable();
//    }
//}
//
//function getAllBooks() {
//	$("#userInfoTable").hide();
//	$("#rentListTable").hide();//하은추가
//	$("#bookInfoTable").show();
//	var bookList = $("<table id='bookList'>").append(
//			$("<tr>").append(
//				"<th>도서번호</th>",
//		        "<th>도서이미지</th>",
//		        "<th>도서제목</th>",
//		        "<th>저자명</th>",
//		        "<th>도서 ISBN</th>",
//		        "<th>출판사</th>",
//		        "<th>출판일</th>"
//			)
//	);		
//    $.get("./getAllBooks.do", function(getAllBooks) { 
//        $.each(getAllBooks, function(index, book) {
//            bookList.append(
//            	$("<tr onclick=\"location.href='./getDetailBook.do?book_seq="+book.book_seq+"'\">").append(
//            	'<td>'+ book.book_seq + '</td>',
//            	'<td> <img src="' + book.book_img + '"> </td>',
//            	'<td>'+ book.book_title + "</td>",
//            	'<td>'+ book.book_writer + '</td>',
//            	'<td>'+ book.book_isbn + '</td>',
//            	'<td>'+ book.book_publisher + '</td>',
//            	'<td>'+ book.book_published_date + '</td>'
//            	)
//            );
//        });
//    });
//    
//    $("#bookInfoTable").html(bookList);
//}
//
//function hideBookTable() {
//    // 도서 정보 테이블을 숨기는 로직
//    $("#bookinfoTable").empty();
//}


//도서 검색 js
$(document).ready(function(){
    $("#search").click(function(){
        $.ajax({
            method: "GET",
            url: "https://dapi.kakao.com/v3/search/book?target=title",
            data: { query: $("#bookName").val() },
            headers: { "Authorization": "KakaoAK deebb5b9fe3604c7cbb30baeb31b856e" }
        })
        .done(function(res){
            var table = $('<table class="book-table" style="width: 1200px">');
            table.append('<thead><tr><th>도서이미지</th><th>도서제목</th><th>도서내용</th><th>저자</th><th>출판사</th><th>도서등록하기</th></tr></thead>');
            var tbody = $('<tbody>');

            for (var i = 0; i <= 4 && i < res.documents.length; i++) {
                var bookData = res.documents[i];
                var contents = bookData.contents.replace(/'/g, "&apos;");
                var sendbookData = {book_title: bookData.title,
							    book_writer: bookData.authors.join(', '),
							    book_img: bookData.thumbnail,
							    book_isbn: bookData.isbn,
							    book_publisher: bookData.publisher,
							    book_intro: contents,
							    book_published_date: bookData.datetime
								};
				var jsonBookData = JSON.stringify(sendbookData);
				var queryString = "data=" + encodeURIComponent(jsonBookData);
                var book = '<tr>';
                book += '<td><img src="' + bookData.thumbnail + '" /></td>';
                book += '<td>' + bookData.title + '</td>';
                book += '<td>' + contents + '</td>';
                book += '<td>' + bookData.authors + '</td>';
                book += '<td>' + bookData.publisher + '</td>';
                book += '<td><button onclick="location.href=\'./registBook.do?' + queryString + '\'">도서 등록하기</button></td>';
               
                book += '</tr>';
                tbody.append(book);
            }
            table.append(tbody);
            $("#bookSearchTable").html(table);
        });
    });
});