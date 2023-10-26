package com.dowon.bds.model.mapper;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dowon.bds.dto.FreeBoardDto;

import lombok.extern.slf4j.Slf4j;
/**
 * 
 * @author 김수엽
 * @since 2023.09.24
 * 자유게시판 관련 DaoImpl
 *
 */
@Repository
@Slf4j
public class IFreeBoardDaoImpl implements IFreeBoardDao {

	private final String NS = "com.dowon.bds.model.mapper.IFreeBoardDaoImpl.";
	
	@Autowired
	private SqlSessionTemplate session;
	
	@Override
	public List<FreeBoardDto> freeBoardList() {
		log.info("IFreeBoardDaoImpl freeBoardList 자유게시판 전체글 조회");
		return session.selectList(NS+"freeBoardList");
	}

	@Override
	public int freeBoardInsert(FreeBoardDto dto) {
		log.info("IFreeBoardDaoImpl freeBoardInsert 자유게시판 새글 등록");
		return session.insert(NS+"freeBoardInsert",dto);
	}

	@Override
	public FreeBoardDto freeBoardDetail(int free_bseq) {
		log.info("IFreeBoardDaoImpl freeBoardDetail 자유게시판 게시글 상세조회");
		return (FreeBoardDto)session.selectList(NS+"freeBoardDetail",free_bseq).get(0);
	}

	@Override
	public int freeBoardDel(Map<String, Object> map) {
		log.info("IFreeBoardDaoImpl freeBoardDel 자유게시판 게시글 삭제");
		return session.update(NS+"freeBoardDel",map);
	}

	@Override
	public int updateBoard(Map<String, Object> map) {
		log.info("IFreeBoardDaoImpl updateBoard 자유게시판 게시글 수정");
		return session.update(NS+"updateBoard",map);
	}

	@Override
	public int FreeBoardCount() {
		log.info("IFreeBoardDaoImpl FreeBoardCount 자유게시판 전체게시글 수");
		return session.selectOne(NS+"FreeBoardCount");
	}

	@Override
	public List<FreeBoardDto> FreeBoardCountList(Map<String, Object> map) {
		log.info("IFreeBoardDaoImpl FreeBoardCountList 자유게시판 페이징 리스트");
		return session.selectList(NS+"FreeBoardCountList",map);
	}

}
