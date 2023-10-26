package com.dowon.bds.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dowon.bds.dto.AgeDto;
import com.dowon.bds.dto.BookDto;
import com.dowon.bds.dto.GenderDto;
import com.dowon.bds.model.mapper.IStatisticsDao;


import lombok.extern.slf4j.Slf4j;

/**
 * @author 김수엽
 * @since 2023.09.14 성별과 연령별 통계를 위한 ServiceImpl
 */


@Service
@Slf4j
public class StatisticsServiceImpl implements IStatisticsService {

	@Autowired
	private IStatisticsDao dao;
	
	
	@Override
	public List<GenderDto> imgSelect() {
		log.info("imgSelect 실행");
		return dao.imgSelect();
	}


	@Override
	public List<GenderDto> genderStatistics() {
		log.info("StatisticsServiceImpl genderStatistics 실행");
		return dao.genderStatistics();
	}


	@Override
	public List<AgeDto> AgeStatistics() {
		log.info("StatisticsServiceImpl AgeStatistics 실행");
		return dao.AgeStatistics();
	}


	@Override
	public BookDto bookSearch(int book_seq) {
		log.info("StatisticsServiceImpl bookSearch 실행");
		return dao.bookSearch(book_seq);
	}


	@Override
	public List<GenderDto> detailGenderStatistics(int book_seq) {
		log.info("StatisticsServiceImpl detailGenderStatistics 실행");
		return dao.detailGenderStatistics(book_seq);
	}


	@Override
	public List<AgeDto> detailAgeStatistics(int book_seq) {
		log.info("StatisticsServiceImpl detailAgeStatistics 실행");
		return dao.detailAgeStatistics(book_seq);
	}

}
