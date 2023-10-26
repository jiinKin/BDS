$(document).ready(function(){
    $("#search").click(function(){
        $.ajax({
            method: "GET",
            url: "https://dapi.kakao.com/v3/search/book?target=title",
            data: { query: $("#bookName").val() },
            headers: { "Authorization": "KakaoAK deebb5b9fe3604c7cbb30baeb31b856e" }
        })
        .done(function(res){
            var table = $('<table class="book-table">');
            table.append('<thead><tr><th>도서 이미지</th><th>도서 제목</th><th>도서 내용</th><th>저자</th><th>출판사</th><th>도서 등록</th></tr></thead>');
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
                book += '<td><button onclick="location.href=\'./registBook.do?' + queryString + '\'">등록</button></td>';
               
                book += '</tr>';
                tbody.append(book);
            }
            table.append(tbody);
            $("#bookSearchTable").html(table);
        });
    });
});