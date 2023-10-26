package com.dowon.bds;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.dowon.bds.dto.AgeDto;
import com.dowon.bds.dto.GenderDto;
import com.dowon.bds.model.service.IStatisticsService;


import lombok.extern.slf4j.Slf4j;

/**
 * @author 김수엽
 * @since 2023.09.14 구글차트API를 사용하기 위해 DB 통계값을 JSON으로 변환해서 jsp에 전달하기 위한 RestController
 */


@RestController
@Slf4j
public class RestStatisticsController {

		@Autowired
		private IStatisticsService service;
		
		
		@GetMapping("/genderChart.do")
		public List<GenderDto> getGender(){
			List<GenderDto> genderData = service.genderStatistics();
			log.info("Welcome RestStatistics_Controller genderData{} 성별통계",genderData);
			return genderData;
		}
		@GetMapping("/ageChart.do")
		public List<AgeDto> getAge(){
			List<AgeDto> ageData = service.AgeStatistics();
			log.info("Welcome RestStatistics_Controller getAge 연령별통계{}",ageData);
			return ageData;
		}
		
		@GetMapping("/detailGenderChart.do")
		public List<GenderDto> getDetailGender(@RequestParam("book_seq")int book_seq){
			List<GenderDto> detailGender = service.detailGenderStatistics(book_seq);
			log.info("Welcome RestStatistics_Controller getDetailGender 상세도서 성별통계{}",detailGender);
			return detailGender;
		}

		@GetMapping("/detailAgeChart.do")
		public List<AgeDto> getDetailAge(@RequestParam("book_seq")int book_seq){
			List<AgeDto> detailAge = service.detailAgeStatistics(book_seq);
			log.info("Welcome RestStatistics_Controller getDetailAge 상세도서 연령별통계{}",detailAge);
			return detailAge;
		}
		
		
	}
	

