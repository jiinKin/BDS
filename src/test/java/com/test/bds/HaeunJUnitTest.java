package com.test.bds;

import static org.junit.Assert.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.dowon.bds.dto.ResveDto;
import com.dowon.bds.model.mapper.IRentDao;
import com.dowon.bds.model.service.IRentService;
import com.dowon.bds.model.service.IResveService;



/** 
 * @author 박하은
 * @since 2023.09.13
 * 단위테스트를 위한 JUnit 클래스
 */

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/**/*.xml"})
public class HaeunJUnitTest {

	@Autowired
	private ApplicationContext context;

	@Autowired
	private IRentService service;
	
//	@Autowired
//	private IResveService service;

	@Autowired
	private IRentDao dao;
	
	@Before
	public void test() {
		SqlSessionTemplate session = context.getBean("sqlSessionTemplate",SqlSessionTemplate.class);
		assertNotNull(session);
	}
	
	
	@Test
	public void bookTest() {
		
		
		int n = service.allUserCountRent();
		System.out.println(n);
		
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("first", 1);
		map.put("last", 10);
		List<Map<String, Object>> lists = service.allRentPageList(map);
		assertNotNull(lists);
		System.out.println(lists);
		
		
//		int n = service.userCountResve(701);
//		System.out.println(n);
//		
//		
//		Map<String, Object> map = new HashMap<String, Object>();
//		map.put("first", 1);
//		map.put("last", 10);
//		map.put("user_seq", 701);
//		List<Map<String, Object>> lists = service.userResvePageList(map);
//		System.out.println(lists);
		
		
//		int n = service.userCountRent(1);
//		System.out.println(n);
		
//		Map<String, Object> map = new HashMap<String, Object>();
//		map.put("first", 1);
//		map.put("last", 5);
//		map.put("user_seq", 1);
//		List<Map<String, Object>> lists = service.userRentPageList(map);
//		assertNotNull(lists);
//		System.out.println(lists);
		
		
		
		
//		int n = service.allUserCountRent();
//		System.out.println(n);
		
//		Map<String, Object> map = new HashMap<String, Object>();
//		map.put("first", 1);
//		map.put("last", 5);
//		List<Map<String, Object>> lists = service.RentPageList(map);
//		assertNotNull(lists);
//		System.out.println(lists);
		
//		int n = service.resveAsRent(3);
//		System.out.println(n);
		
		
		
//		Map<String, Object>map = new HashMap<String, Object>();
//		map.put("book_seq", 440);
//		map.put("user_seq", 17);
//		int m = service.stepUpdate(map);
//		System.out.println(m);
		
		
		
//		Map<String, Object>map = new HashMap<String, Object>();
//		map.put("book_seq", 440);
//		map.put("user_seq", 17);
//		int n = service.resveCancle(map);
		
		
		
		
//		boolean isc = service.cancelAndStepUpdate(43, 2);
//		System.out.println(isc);
		
//		List<ResveDto> lists = service.selectStep(1);
//		System.out.println(lists);
		
		
//		Map<String, Object> params = new HashMap<>();
//        params.put("book_seq", 34);
//        params.put("user_seq", 1);
//        int bookSeq = 34;
//        int userSeq = 1;
//        
//        // cancelReservationAndStepMinus 메소드 호출
//        service.cancelReservationAndStepMinus(params, bookSeq, userSeq);
//        
//        System.out.println("params : "+params);
//        System.out.println("bookSeq : "+bookSeq);
//        System.out.println("userSeq : "+userSeq);
		
//		List<String> lists =service.rentStatusYBookSeq();
//		assertNotNull(lists);
//		System.out.println(lists);
		
		
//		List<Map<String, Object>> lists = dao.rentY();
//		assertNotNull(lists);
//		System.out.println(lists);
		
		//rent
//		Map<String, Object> map = new HashMap<String, Object>();
//		map.put("user_seq", "37");
//		map.put("book_seq", "101");
//		int n = service.bookRent(map);
//		assertEquals(1, n);
		
		//현재 대출중인책 있는지 체크
//		List<Map<String, Object>> lists = service.rentCheck(7);
//		assertNotNull(lists);
//		System.out.println("@@@@@@@@@@@@@@@@"+lists);
		
		//회원이 자기꺼조회
//		List<RentDto> lists = service.selectMyBookRent(37);
//		assertNotNull(lists);
		
		//관리자가 회원들꺼조회
//		List<RentDto> lists = service.selectAdminRent();
//		assertNotNull(lists);
		
		//대출불가한책들
//		List<Map<String, Object>> lists = service.selectRentImpossibility();
//		assertNotNull(lists);
//		System.out.println("@@@@@@2"+lists);
		
		
		//관리자가 반납완료처리
//		int n = service.rentStatus(21);
//		assertEquals(1, n);
		
		
		
		//예약걸려있는 대출완료된책의 1빠예약을 대출대기만들기
//		int n = service.rentStandby(1);
//		assertEquals(0, n);
		
		//순번밀기
//		int n = service.stepMinus(440);
//		assertNotEquals(0, n);
		
		
		//예약하기
//		Map<String, Object> map = new HashMap<String, Object>();
//		map.put("user_seq", 16);
//		map.put("book_seq", 440);
//		int n = service.resveBook(map);
//		assertEquals(1, n);
		
		
		//예약취소
//		Map<String, Object> map = new HashMap<String, Object>();
//		map.put("user_seq", 11);
//		map.put("book_seq", 100);
//		int n = service.resveCancle(map);
//		assertEquals(1, n);
		
		
		//순번조회
//		List<Map<String, Object>> lists = service.selectStep(7);
//		assertNotNull(lists);
//		System.out.println("@@@@@@@@@@@"+lists);
		
		
		//특정회원 예약판단
//		List<ResveDto> lists = service.userResveStatus(15);
//		assertNotNull(lists);
		
		
		//책상세보기
//		BookDto dto = service.bookDetail(1);
//		assertNotEquals(1, dto);
//		System.out.println(dto);
		
		//책전체조회
//		List<BookDto> lists = service.bookAll();
//		assertNotNull(lists);
//		System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@"+lists);
		
		
//		List<String> a = service.selectFilteredBookSeqList();
//		System.out.println("zzzzzzzzzzzzzzzzz"+a);
//		assertNotNull(a);
		
		
	}

}
