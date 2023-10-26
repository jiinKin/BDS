package com.dowon.bds.model.service;

import java.util.List;

import com.dowon.bds.dto.AgeDto;
import com.dowon.bds.dto.BookDto;
import com.dowon.bds.dto.GenderDto;

/**
 * @author 김수엽
 * @since 2023.09.14 성별과 연령별 통계를 위한 Service
 */

public interface IStatisticsService {

	public List<GenderDto> imgSelect();
	public List<GenderDto> genderStatistics();
	public List<AgeDto> AgeStatistics();
	public BookDto bookSearch(int book_seq);
	public List<GenderDto> detailGenderStatistics(int book_seq);
	public List<AgeDto> detailAgeStatistics(int book_seq);
}
