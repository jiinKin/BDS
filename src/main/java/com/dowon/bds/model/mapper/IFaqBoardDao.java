package com.dowon.bds.model.mapper;

import java.util.List;
import java.util.Map;

import com.dowon.bds.dto.FaqBoardDto;

public interface IFaqBoardDao {

	//FAQ 전체글 조회
	public List<FaqBoardDto> faqList();
	
	//FAQ 새글 등록
	public int faqInsert(FaqBoardDto dto);
	
	//FAQ 목록조회
	public FaqBoardDto faqBoardDetail(int faq_category);
	
	//FAQ 게시글 삭제
	public int faqDel(Map<String, Object>map);
	
	//FAQ 게시글 수정
	public int updateFaq(Map<String, Object>map);
	
	//FAQ 메인 출력
	public List<FaqBoardDto> mainFaqList();
	
}
