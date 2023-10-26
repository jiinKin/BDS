package com.dowon.bds.model.service;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.dowon.bds.dto.BookDto;
import com.dowon.bds.model.mapper.IBookDao;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class BookServiceImpl implements IBookService {
	
	
	@Autowired
	public IBookDao dao;

	@Override
	public List<BookDto> getAllBook() {
		log.info("BookServiceImpl getAllBook 모든 도서 리스트 가져오기 : ");
		return dao.getAllBook();
	}

	@Override
	public BookDto detailBook(int seq) {
		log.info("BookServiceImpl detailBook 도서 상세보기 ");
		return dao.detailBook(seq);
	}
	
	@Transactional
	@Override
	public int registBook(BookDto dto) {
		log.info("BookServiceImpl registBook 도서 등록하기 ");
		log.info("BookServiceImpl Transaction 처리중 ");
		log.info("isbn 값 테스트 : {} ",dto.getBook_isbn());
		if(dao.checkIsbn(dto.getBook_isbn())>0) {
			return -1;
		}
		int result = dao.registBook(dto);
		
		if(result < 1) {
			
		}
		
        return result;
	}

	@Override
	public List<BookDto> searchBooks(String keyword) {
		log.info("BookServiceImpl searchBooks 도서 검색하기");
		return dao.searchBooks(keyword);
	}

	@Override
	public int updateBook(Map<String, Object>map) {
		log.info("BookServiceImpl searchBooks 도서 수정하기");
		return dao.updateBook(map);
	}

	@Override
	public int checkIsbn(String isbn) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int bookCount() {
		log.info("BookServiceImpl bookCount 도서 총 갯수");
		return dao.bookCount();
	}

	@Override
	public List<BookDto> bookCountList(Map<String, Object> map) {
		log.info("BookServiceImpl bookCountList 도서 카운트리스트");
		return dao.bookCountList(map);
	}

	@Override
	public int searchBookCount(String keyword) {
		log.info("BookServiceImpl searchBookCount 도서 검색 총 갯수");
		return dao.searchBookCount(keyword);
	}

	@Override
	public List<BookDto> searchBookList(Map<String, Object> map) {
		log.info("BookServiceImpl searchBookCount 도서 검색 카운트");
		return dao.searchBookList(map);
	}
	


}
