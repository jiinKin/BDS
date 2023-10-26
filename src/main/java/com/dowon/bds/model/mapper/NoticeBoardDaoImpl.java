package com.dowon.bds.model.mapper;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dowon.bds.dto.FaqBoardDto;
import com.dowon.bds.dto.NoticeBoardDto;

import lombok.extern.slf4j.Slf4j;

/**
 * 
 * @author 김영진
 * @since 2023.10.03
 * 공지사항 게시판 DaoImpl
 */

@Repository
@Slf4j
public class NoticeBoardDaoImpl implements INoticeBoardDao {
	
	@Autowired
	private SqlSessionTemplate session;
	
	private final String NS ="com.dowon.bds.model.mapper.NoticeBoardDaoImpl.";

	@Override
	public List<NoticeBoardDto> noticeeBoardList() {
		log.info("NoticeBoardDaoImpl noticeeBoardList 공지사항 전체조회");
		return session.selectList(NS+"noticeBoardList");
	}

	@Override
	public int noticeBoardInsert(NoticeBoardDto dto) {
		log.info("NoticeBoardDaoImpl noticeeBoardList 공지사항 새글작성");
		return session.insert(NS+"noticeBoardInsert",dto);
	}

	@Override
	public NoticeBoardDto noticeBoardDetail(int notice_bseq) {
		return session.selectOne(NS+"noticeBoardDetail",notice_bseq);
	}

	@Override
	public int noticeBoardDel(Map<String, Object> map) {
		return session.update(NS+"noticeBoardDel",map);
	}

	@Override
	public int updateBoard(Map<String, Object> map) {
		return session.update(NS+"updateNoticeBoard",map);
	}

	@Override
	public int noticeBoardCount() {
		return session.selectOne(NS+"noticeBoardCount");
	}

	@Override
	public List<NoticeBoardDto> noticeBoardCountList(Map<String, Object> map) {
		return session.selectList(NS+"noticeBoardCountList",map);
	}

	@Override
	public List<NoticeBoardDto> mainNoitceList() {
		return session.selectList(NS+"mainNoitceList");
	}

}
