package com.dowon.bds.model.mapper;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dowon.bds.dto.AgeDto;
import com.dowon.bds.dto.BookDto;
import com.dowon.bds.dto.GenderDto;


import lombok.extern.slf4j.Slf4j;

/**
 * @author 김수엽
 * @since 2023.09.14 성별과 연령별 통계를 위한 DAOImpl
 */

@Repository
@Slf4j
public class StatisticsDaoImpl implements IStatisticsDao {

	private final static String NS ="com.dowon.bds.model.mapper.StatisticsDaoImpl.";
	@Autowired
	private SqlSessionTemplate session;
	
	@Override
	public List<GenderDto> imgSelect() {
		log.info("ImgDaoImpl imgSelect top5책 이미지");
		return session.selectList(NS+"imgSelect");
	}

	@Override
	public List<GenderDto> genderStatistics() {
		log.info("StatisticsDaoImpl genderStatistics 성별통계");
		return session.selectList(NS+"genderStatistics");
	}

	@Override
	public List<AgeDto> AgeStatistics() {
		log.info("StatisticsDaoImpl AgeStatistics 연령별통계");
		return session.selectList(NS+"AgeStatistics");
	}

	@Override
	public BookDto bookSearch(int book_seq) {
		log.info("StatisticsDaoImpl bookSearch 책정보가져오기");
		return session.selectOne(NS+"bookSearch",book_seq);
	}

	@Override
	public List<GenderDto> detailGenderStatistics(int book_seq) {
		log.info("StatisticsDaoImpl detailGenderStatistics 상세페이지 성별통계");
		return session.selectList(NS+"detailGenderStatistics",book_seq);
	}

	@Override
	public List<AgeDto> detailAgeStatistics(int book_seq) {
		log.info("StatisticsDaoImpl detailAgeStatistics 상세페이지 연령별통계");
		return session.selectList(NS+"detailAgeStatistics",book_seq);
	}

}
