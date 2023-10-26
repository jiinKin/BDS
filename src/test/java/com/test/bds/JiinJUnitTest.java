package com.test.bds;

import static org.junit.Assert.*;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Service;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.dowon.bds.dto.AddrDto;
import com.dowon.bds.dto.FaqBoardDto;
import com.dowon.bds.dto.FreeBoardDto;
import com.dowon.bds.dto.PayDto;
import com.dowon.bds.model.mapper.IAddrDao;
import com.dowon.bds.model.mapper.IFaqBoardDao;
import com.dowon.bds.model.mapper.IPaymentDao;
import com.dowon.bds.model.service.IPaymentService;

import lombok.extern.slf4j.Slf4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/**/*.xml"})
@Slf4j
public class JiinJUnitTest {
//업로드 확인
	@Autowired
	private SqlSessionTemplate sqlSession;
	

	@Autowired
	private ApplicationContext context;
	
	@Autowired
	private IAddrDao dao;
	
	@Autowired
	private IPaymentDao payDao;
	
	@Autowired
	private IFaqBoardDao faqDao;
	
	@Autowired
	private IPaymentService payService;
	
//	@Test
	public void test() {

//		int n = payService.userCountPay(706);
//		System.out.println(n);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("user_seq", 706);
		map.put("first", 1);
		map.put("last", 5);
		List<Map<String, Object>> lists = payService.userPayPageList(map);
		System.out.println("@@@@@@@@@@@"+lists);

	}
	
	//@Test
	public void saveAddress() {
		AddrDto addrDto = new AddrDto(1, 1, "김지인", "0106703355", "12345", "서울시", "야", "몬데", 0);
		log.info("배송지 주소 입력");
		int n = dao.saveAddress(addrDto);
		System.out.println("입력후 SEQ"+addrDto.getDelivery_seq());
		assertEquals("입력후 SEQ"+addrDto.getDelivery_seq(), 1, n, 0);
	}

//	@Test
//	public void saveBookPayment() {
//		
//		Date date = new Date();
//		PayDto payDto = new PayDto(1, "imp_66008769771802", 1, 5000, date);
//		int n = payDao.saveBookPayment(payDto);
//		System.out.println("결제정보" + payDto.getPaySeq());
//		assertNotNull(payDto);
//		
//	}
	
	
//	@Test
	public void faqList() {
		List<FaqBoardDto> lists = faqDao.faqList();
		log.info("JiinJUnitTest faqList{}",lists);
		assertNotNull(lists);
	}
	
    @Test
    public void faqMainList() {
    	List<FaqBoardDto> faqList = faqDao.mainFaqList();
    	log.info("JiinJUnitTest mainFaqList{}",faqList);
    	assertNotNull(faqList);
    }
	

}
