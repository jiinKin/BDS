package com.dowon.bds.model.mapper;

import java.util.List;

import com.dowon.bds.dto.AgeDto;
import com.dowon.bds.dto.BookDto;
import com.dowon.bds.dto.GenderDto;

/**
 * @author 김수엽
 * @since 2023.09.14 성별과 연령별 통계를 위한 DAO
 */

public interface IStatisticsDao {

	// 대출현황 TOP2 도서 이미지 (메인페이지에 띄워짐) 
		public List<GenderDto> imgSelect();
		
		// 대출현황 성별 통계 백분율
		public List<GenderDto> genderStatistics();
		// 대출현황 연령별 통계 백분율
		public List<AgeDto> AgeStatistics();
		
		//BOOK_SEQ값으로 책 정보를 가져오는 DAO
		public BookDto bookSearch(int book_seq);
		
		// 상세도서페이지 해당 책 성별 통계
		public List<GenderDto> detailGenderStatistics(int book_seq);
		
		// 상세도서페이지 해당 책 연령별 통계
		public List<AgeDto> detailAgeStatistics(int book_seq);
	
}
