package com.dowon.bds.model.service;

import java.util.List;
import java.util.Map;

import com.dowon.bds.dto.BookDto;


public interface IBookService {
	
	//도서목록 조회
		public List<BookDto> getAllBook();
		
		//도서상세 조회
		public BookDto detailBook(int seq);
		
		//도서 등록
		public int registBook(BookDto dto);
		
		//도서 중복체크
		public int checkIsbn(String isbn);
		
		//도서 검색
		public List<BookDto> searchBooks(String keyword);
		
		//도서수정
		public int updateBook(Map<String, Object>map);
		
		//도서목록 페이징
		public int bookCount();
			
		public List<BookDto> bookCountList(Map<String, Object>map);
		
		//도서검색결과 페이징
		public int searchBookCount(String keyword);
		
		public List<BookDto> searchBookList(Map<String, Object>map);
}
