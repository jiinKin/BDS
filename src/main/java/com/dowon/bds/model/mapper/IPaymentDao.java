package com.dowon.bds.model.mapper;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import com.dowon.bds.dto.PayDto;

/** 
 * @author 김지인
 * @since 2023.09.13
 * 결제관련 메소드를 정의한 DAO Interface
 */


@Mapper
public interface IPaymentDao {

	//결제및 결제 정보 저장
	public int saveBookPayment(PayDto payDto);
	
	//user_seq 기준으로 현재 충전 마일리지 합산 값
	Integer selectSumPoint(Integer user_seq);
	
	//특정 회원의 결제 내역 확인
//	public List<Map<String, Object>> selectMypayList(int n);
	
	//특정 회원의 결제 내역 확인 페이징
	public int userCountPay(int n);
	public List<Map<String, Object>> userPayPageList(Map<String, Object> map);
	
}
