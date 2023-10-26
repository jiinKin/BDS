package com.dowon.bds.model.service;

import java.util.List;
import java.util.Map;

import com.dowon.bds.dto.PayDto;

/** 
 * @author 김지인
 * @since 2023.09.14
 *결제 관련 메소드를 정의한 Service Interface
 */
public interface IPaymentService {
	//결제내역 저장
	public void saveBookPayment (PayDto payDto);
	
	//회원의 결제 목록
//	public List<Map<String, Object>> selectMypayList(int n);
	
	//페이징
	public int userCountPay(int n);
	public List<Map<String, Object>> userPayPageList(Map<String, Object> map);
		
	
	
}
