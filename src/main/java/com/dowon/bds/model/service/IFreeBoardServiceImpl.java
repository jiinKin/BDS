package com.dowon.bds.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dowon.bds.dto.FreeBoardDto;
import com.dowon.bds.model.mapper.IFreeBoardDao;

import lombok.extern.slf4j.Slf4j;
/**
 * 
 * @author 김수엽
 * @since 2023.09.24
 * 자유게시판 관련 ServiceImpl
 *
 */
@Service
@Slf4j
public class IFreeBoardServiceImpl implements IFreeBoardService {
	
	@Autowired
	private IFreeBoardDao dao;
	
	
	@Override
	public List<FreeBoardDto> freeBoardList() {
		log.info("IFreeBoardServiceImpl freeBoardList 자유게시판 전체글 조회");
		return dao.freeBoardList();
	}


	@Override
	public int freeBoardInsert(FreeBoardDto dto) {
		log.info("IFreeBoardServiceImpl freeBoardInsert 자유게시판 새글 등록");
		return dao.freeBoardInsert(dto);
	}


	@Override
	public FreeBoardDto freeBoardDetail(int free_bseq) {
		log.info("IFreeBoardServiceImpl freeBoardDetail 자유게시판 게시글 상세조회");
		return dao.freeBoardDetail(free_bseq);
	}


	@Override
	public int freeBoardDel(Map<String, Object> map) {
		log.info("IFreeBoardServiceImpl freeBoardDel 자유게시판 게시글 삭제");
		return dao.freeBoardDel(map);
	}


	@Override
	public int updateBoard(Map<String, Object> map) {
		log.info("IFreeBoardServiceImpl updateBoard 자유게시판 게시글 수정");
		return dao.updateBoard(map);
	}


	@Override
	public int FreeBoardCount() {
		log.info("IFreeBoardServiceImpl FreeBoardCount 자유게시판 전체 게시글 수");
		return dao.FreeBoardCount();
	}


	@Override
	public List<FreeBoardDto> FreeBoardCountList(Map<String, Object> map) {
		log.info("IFreeBoardServiceImpl FreeBoardCount 자유게시판 게시글 페이징리스트{}",map);
		return dao.FreeBoardCountList(map);
	}

}
