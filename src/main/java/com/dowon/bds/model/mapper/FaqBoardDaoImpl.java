package com.dowon.bds.model.mapper;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dowon.bds.dto.FaqBoardDto;

import lombok.extern.slf4j.Slf4j;

@Repository
@Slf4j
public class FaqBoardDaoImpl implements IFaqBoardDao {
	
	private final String NS ="com.dowon.bds.model.mapper.FaqBoardDaoImpl.";
	
	@Autowired
	private SqlSessionTemplate session;
	
	@Override
	public List<FaqBoardDto> faqList() {
		log.info("FaqBoardDaoImpl faqList FAQ게시판 조회");
		return session.selectList(NS+"faqList");
	}

	@Override
	public int faqInsert(FaqBoardDto dto) {
		log.info("FaqBoardDaoImpl faqInsert 새글 등록");
		return session.insert(NS+"faqInsert",dto);
	}

	@Override
	public FaqBoardDto faqBoardDetail(int faq_category) {
		log.info("FaqBoardDaoImpl faqBoardDetail 목록글 조회");
		return (FaqBoardDto)session.selectList(NS+"faqBoardDetail",faq_category).get(0);
	}

	@Override
	public int faqDel(Map<String, Object> map) {
		log.info("FaqBoardDaoImpl faqDel FAQ 게시글 삭제");
		return session.update(NS+"faqDel",map);
	}

	@Override
	public int updateFaq(Map<String, Object> map) {
		log.info("FaqBoardDaoImpl updateFaq FAQ 내용 수정");
		return session.update(NS+"updateFaq", map);
	}

	@Override
	public List<FaqBoardDto> mainFaqList() {
		log.info("FaqBoardDaoImpl mainFaqList FAQ게시판 메인 출력");
		return session.selectList(NS+"mainFaqList");
	}

}
