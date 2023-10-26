package com.dowon.bds.model.service;
/** 
 * @author 김지인
 * @since 2023.09.19
 * 도서 결제관련 메소드를 구현한 Service Interface implements 클래스
 */
import java.util.List;
import java.util.Map;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dowon.bds.dto.PayDto;
import com.dowon.bds.model.mapper.IPaymentDao;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class PaymentServiceImpl implements IPaymentService {

	@Autowired
	public IPaymentDao dao;
	
	 // 현재 saveBookPayment 테이블에  아이디의 결제내역 가져오기
	
	@Override
	@Transactional
	public void saveBookPayment(PayDto payDto) {
//		System.out.println(payDto.toString());
		log.info("PaymentServiceImpl saveBookPayment 결제 실행 : {}",payDto);


		// 현재 Sumpoint 컬럼에 user_seq 아이디의 총합 포인트 가져오기
        Integer sumPoint = dao.selectSumPoint(payDto.getUser_seq());

     // 현재 합산 포인트가 없다면(처음 충전시)
        if (sumPoint == null || sumPoint == 0) {
            payDto.setPaySumpoint(payDto.getPayPoint());
        } else { // 현재 포인트가 존재한다면 합산포인트 + 지금 충전한 포인트
            payDto.setPaySumpoint(sumPoint+payDto.getPayPoint());
        }
        
      // 갱신된 sumPoint저장
        System.out.println(payDto.toString());
        dao.saveBookPayment(payDto);
        
	}
	

//	@Override
//	public List<Map<String, Object>> selectMypayList(int n) {
//		log.info("PaymentServiceImpl selectMypayList 회원결제리스트 : {}", n);
//		return dao.selectMypayList(n);
//	}


	@Override
	public int userCountPay(int n) {
		return dao.userCountPay(n);
	}


	@Override
	public List<Map<String, Object>> userPayPageList(Map<String, Object> map) {
		return dao.userPayPageList(map);
	}

}
