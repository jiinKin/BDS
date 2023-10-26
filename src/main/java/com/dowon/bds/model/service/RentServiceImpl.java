package com.dowon.bds.model.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dowon.bds.dto.BookDto;
import com.dowon.bds.dto.PagingDto;
import com.dowon.bds.model.mapper.IRentDao;

import lombok.extern.slf4j.Slf4j;

/** 
 * @author 박하은
 * @since 2023.09.13
 * 도서 대출관련 메소드를 구현한 Service Interface implements 클래스
 */
@Service
@Slf4j
public class RentServiceImpl implements IRentService {

	@Autowired
	private IRentDao dao;
	
	@Override
	public int bookRent(Map<String, Object> map) {
		log.info("RentServiceImpl bookRent 도서대출 : {}",map);
		return dao.bookRent(map);
	}
	
	@Override
	public List<Map<String, Object>> rentCheck(int n) {
		log.info("RentServiceImpl rentCheck 대출중조회 : {}",n);
		return dao.rentCheck(n);
	}

	@Override
	public List<Map<String, Object>>  selectMyBookRent(int n) {
		log.info("RentServiceImpl selectMyBookRent 회원 대출목록조회 :{}",n);
		return dao.selectMyBookRent(n);
	}

	@Override
	public List<Map<String, Object>> selectAdminRent() {
		log.info("RentServiceImpl selectAdminRent 관리자의 회원 대출목록 조회");
		return dao.selectAdminRent();
	}

	@Override
	public List<Map<String, Object>> selectRentImpossibility() {
		log.info("RentServiceImpl selectRentImpossibility 대출불가 책 조회");
		return dao.selectRentImpossibility();
	}
	

	@Override
	public int rentStatus(int n) {
		log.info("RentServiceImpl rentStatus 관리자의 도서 반납 완료 처리 :{}",n);
		return dao.rentStatus(n);
	}

	@Override
	public BookDto bookDetail(int n) {
		log.info("RentServiceImpl bookDetail test를 위한 책 상세 페이지 :{}",n);
		return dao.bookDetail(n);
	}

	@Override
	public List<BookDto> bookAll() {
		log.info("RentServiceImpl bookAll test를 위한 책 전체 목록");
		return dao.bookAll();
	}

	
	
	@Override
	public List<String> selectFilteredBookSeqList() {
		log.info("RentServiceImpl selectFilteredBookSeqList 대출중,대출대기 도서 SEQ 선별 메소드");
		
	    List<String> filteredBookSeqList = new ArrayList<>();
	    List<Map<String, Object>> rDto = dao.selectRentImpossibility();
	    
	    for (Map<String, Object> map : rDto) {
	        Object rentStatus = map.get("RENT_STATUS");
	        Object resveStatus = map.get("RESVE_STATUS");

	        String rentStatusOrDefault = (rentStatus != null) ? rentStatus.toString() : "";
	        String resveStatusOrDefault = (resveStatus != null) ? resveStatus.toString() : "";
	        
	        if ("Y".equals(rentStatusOrDefault) || "R".equals(resveStatusOrDefault)) {
	        	String bookSeq = map.get("BOOK_SEQ").toString();
	            filteredBookSeqList.add(bookSeq);
	        }
	    }
	    log.info("RentServiceImpl selectFilteredBookSeqList 대출불가 도서 SEQ 값 : {}",filteredBookSeqList);
	    return filteredBookSeqList;
	}

	@Override
	 public List<String> rentStatusYBookSeq() {
		log.info("RentServiceImpl rentStatusYBookSeq 대출중인 책 SEQ 선별 메소드");
		
		List<String> rentYBookSeqList = new ArrayList<>();
        
        List<Map<String, Object>> yList = dao.rentY();
        
        for (Map<String, Object> map : yList) {
        	Object rentStatus = map.get("RENT_STATUS");
        	
        	String rentStatusOrDefault = rentStatus.toString();
        	if("Y".equals(rentStatusOrDefault)) {
        		String bookSeq = map.get("BOOK_SEQ").toString();
        		rentYBookSeqList.add(bookSeq);
        	}
        }
        log.info("RentServiceImpl rentStatusYBookSeq 대출중인 책 SEQ 값 : {}",rentYBookSeqList);
        return rentYBookSeqList;
	}

	
	
	
	
	@Override
	public int userCountRent(int n) {
		log.info("RentServiceImpl userCountRent 회원 대출목록 페이징처리를 위한 총 카운트");
		return dao.userCountRent(n);
	}
	
	@Override
	public List<Map<String, Object>> userRentPageList(Map<String, Object> map) {
		log.info("RentServiceImpl userRentPageList 회원의 대출목록 페이징처리를 위한 조회 리스트 : {}",map);
		return dao.userRentPageList(map);
	}
	
	
	
	
	@Override
	public int allUserCountRent() {
		log.info("RentServiceImpl allUserCountRent 전체회원 대출목록 페이징처리를 위한 총 카운트");
		return dao.allUserCountRent();
	}

	@Override
	public List<Map<String, Object>> allRentPageList(Map<String, Object>map) {
		log.info("RentServiceImpl allRentPageList 전체회원 대출목록 페이징처리를 위한 조회 리스트 : {}",map);
		return dao.allRentPageList(map);
	}
	
	


}
