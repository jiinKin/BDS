package com.dowon.bds.model.mapper;

import java.util.List;
import java.util.Map;

import com.dowon.bds.dto.FaqBoardDto;
import com.dowon.bds.dto.NoticeBoardDto;

/**
 * 
 * @author 김영진
 * @since 2023.09.29
 * 공지사항 관련
 */

public interface INoticeBoardDao {
	
	// 공지게시판 전체글 조회
	public List<NoticeBoardDto> noticeeBoardList();
	
	// 공지게시판 새글등록
	public int noticeBoardInsert(NoticeBoardDto dto);
		
	// 공지게시판 게시글 상세조회
	public NoticeBoardDto noticeBoardDetail(int notice_bseq);
		
	// 공지게시판 게시글 삭제
	public int noticeBoardDel(Map<String, Object>map);
		
	// 공지게시판 게시글 수정
	public int updateBoard(Map<String, Object>map);
		
	// 공지게시판 페이징
	public int noticeBoardCount();
		
	public List<NoticeBoardDto> noticeBoardCountList(Map<String, Object>map);
	
	//공지사항 메인 출력
	public List<NoticeBoardDto> mainNoitceList();
	

}

