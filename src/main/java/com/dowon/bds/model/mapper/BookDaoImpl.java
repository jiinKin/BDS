package com.dowon.bds.model.mapper;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dowon.bds.dto.BookDto;

import lombok.extern.slf4j.Slf4j;

@Repository
@Slf4j
public class BookDaoImpl implements IBookDao {
	
	private final String NS = "com.dowon.bds.model.mapper.BookDaoImpl.";
	
	@Autowired
	public SqlSessionTemplate sqlSession;
	
	@Override
	public List<BookDto> getAllBook() {
		return sqlSession.selectList(NS+"getAllBooks");
	}

	@Override
	public BookDto detailBook(int seq) {
		return sqlSession.selectOne(NS+"getDetailBook",seq);
	}

	@Override
	public int registBook(BookDto dto) {
		return sqlSession.insert(NS+"registBook",dto);
	}

	@Override
	public int checkIsbn(String isbn) {
		return sqlSession.selectOne(NS+"checkIsbn",isbn);
	}

	@Override
	public List<BookDto> searchBooks(String keyword) {
		return sqlSession.selectList(NS+"searchBooks",keyword);
	}

	@Override
	public int updateBook(Map<String, Object>map) {
		return sqlSession.update(NS+"updateBook",map);
	}

	@Override
	public int bookCount() {
		return sqlSession.selectOne(NS+"bookCount");
	}

	@Override
	public List<BookDto> bookCountList(Map<String, Object> map) {
		return sqlSession.selectList(NS+"bookCountList",map);
	}

	@Override
	public int searchBookCount(String keyword) {
		return sqlSession.selectOne(NS+"searchBookCount",keyword);
	}

	@Override
	public List<BookDto> searchBookList(Map<String, Object> map) {
		return sqlSession.selectList(NS+"searchBookList",map);
	}

}
