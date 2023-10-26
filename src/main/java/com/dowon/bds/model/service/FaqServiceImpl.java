package com.dowon.bds.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dowon.bds.dto.FaqBoardDto;
import com.dowon.bds.model.mapper.IFaqBoardDao;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class FaqServiceImpl implements IFaqService {

	@Autowired IFaqBoardDao dao;
	
	@Override
	public List<FaqBoardDto> faqList() {
		log.info("FaqServiceImpl faqList FAQ 전체글 조회");
		return dao.faqList();
	}

	@Override
	public int faqInsert(FaqBoardDto dto) {
		log.info("FaqServiceImpl faqInsert FAQ 새글 등록");
		return dao.faqInsert(dto);
	}

	@Override
	public FaqBoardDto faqBoardDetail(int faq_category) {
		log.info("FaqServiceImpl faqBoardDetail FAQ 수정할 글조회");
		return dao.faqBoardDetail(faq_category);
	}

	@Override
	public int faqDel(Map<String, Object> map) {
		log.info("FaqServiceImpl faqDel FAQ 글삭제");
		return dao.faqDel(map);
	}

	@Override
	public int updateFaq(Map<String, Object> map) {
		log.info("FaqServiceImpl updateFaq FAQ 글수정");
		return dao.updateFaq(map);
	}

	@Override
	public List<FaqBoardDto> mainFaqList() {
		log.info("FaqServiceImpl mainFaqList FAQ게시글 메인에 출력");
		return dao.mainFaqList();
	}


}
