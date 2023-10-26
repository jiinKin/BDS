package com.dowon.bds.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dowon.bds.dto.FaqBoardDto;
import com.dowon.bds.dto.NoticeBoardDto;
import com.dowon.bds.model.mapper.INoticeBoardDao;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class NoticeServiceImpl implements INoticeService {

	@Autowired
	INoticeBoardDao dao;
	
	@Override
	public List<NoticeBoardDto> noticeeBoardList() {
		log.info("NoticeServiceImpl noticeeBoardList 공지사항 전체글 조회");
		return dao.noticeeBoardList();
	}

	@Override
	public int noticeBoardInsert(NoticeBoardDto dto) {
		log.info("NoticeServiceImpl noticeBoardInsert 공지사항 새글 작성");
		return dao.noticeBoardInsert(dto);
	}

	@Override
	public NoticeBoardDto noticeBoardDetail(int notice_bseq) {
		log.info("NoticeServiceImpl noticeBoardInsert 공지사항 상세조회");
		return dao.noticeBoardDetail(notice_bseq);
	}

	@Override
	public int noticeBoardDel(Map<String, Object> map) {
		log.info("NoticeServiceImpl noticeBoardInsert 공지사항 삭제");
		return dao.noticeBoardDel(map);
	}

	@Override
	public int updateBoard(Map<String, Object> map) {
		log.info("NoticeServiceImpl noticeBoardInsert 공지사항 수정");
		return dao.updateBoard(map);
	}

	@Override
	public int noticeBoardCount() {
		log.info("NoticeServiceImpl FreeBoardCount 공지사항 전체 게시글 수");
		return dao.noticeBoardCount();
	}

	@Override
	public List<NoticeBoardDto> noticeBoardCountList(Map<String, Object> map) {
		log.info("NoticeServiceImpl FreeBoardCount 공지사항 게시글 페이징리스트{}",map);
		return dao.noticeBoardCountList(map);
	}

	@Override
	public List<NoticeBoardDto> mainNoitceList() {
		log.info("NoticeServiceImpl mainNoitceList 공지사항 메인노출{}");
		return dao.mainNoitceList();
	}
	
	

}
