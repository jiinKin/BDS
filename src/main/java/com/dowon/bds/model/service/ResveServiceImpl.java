
package com.dowon.bds.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dowon.bds.dto.ResveDto;
import com.dowon.bds.model.mapper.IResveDao;

import lombok.extern.slf4j.Slf4j;


/** 
 * @author 박하은
 * @since 2023.09.13
 * 도서 예약관련 메소드를 구현한 Service Interface implements 클래스
 */
@Service
@Slf4j
public class ResveServiceImpl implements IResveService {

	@Autowired
	private IResveDao dao;
	
	@Override
	public int rentStandby(int n) {
		log.info("ResveServiceImpl rentStandby 대출대기 상태 업데이트 :{}",n);
		return dao.rentStandby(n);
	}


	@Override
	public int resveBook(Map<String, Object> map) {
		log.info("ResveServiceImpl resveBook 도서 예약신청:{}",map);
		return dao.resveBook(map);
	}


	@Override
	public List<Map<String, Object>> selectStep(int n) {
		log.info("ResveServiceImpl selectStep 예약순번 조회:{}",n);
		return dao.selectStep(n);
	}

	@Override
	public List<Map<String, Object>> userResveStatus(int n) {
		log.info("ResveServiceImpl userResveStatus 회원의 예약/대출대기 상태 판단:{}",n);
		return dao.userResveStatus(n);
	}
	
	@Override
	public int resveCancle(Map<String, Object> map) {
		log.info("ResveServiceImpl resveCancle 회원의 도서 예약신청 취소 :{}",map);
		return dao.resveCancle(map);
	}


	@Override
	public int resveAsRent(int n) {
		log.info("ResveServiceImpl resveAsRent 대출대기 회원 대출신청 완료 상태 업데이트:{}",n);
		return dao.resveAsRent(n);
	}


	@Override
	public int userCountResve(int n) {
		log.info("ResveServiceImpl userCountResve 회원 예약목록 페이징처리를 위한 총 카운트");
		return dao.userCountResve(n);
	}


	@Override
	public List<Map<String, Object>> userResvePageList(Map<String, Object> map) {
		log.info("ResveServiceImpl userResvePageList 회원 예약목록 페이징처리를 위한 조회 리스트 : {}",map);
		return dao.userResvePageList(map);
	}

}
