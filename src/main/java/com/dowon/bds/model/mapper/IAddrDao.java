package com.dowon.bds.model.mapper;
/** 
 * @author 김지인
 * @since 2023.09.14
 * 배송지 입력을 위한 메소드를 정의한 DAO Interface
 */

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.dowon.bds.dto.AddrDto;

@Mapper
public interface IAddrDao {
	
	public int saveAddress(AddrDto addrDto);
	
	public int saveAddressReturn(AddrDto addrDto);
	
	public AddrDto checkAddress(String delivery_seq);
	
	public AddrDto getAddrUserSeq(int user_seq);
	
	/**
	 * 관리자 대출도서 목록에 있는 글 중  delivery_num 수정
	 * @param map delivery_seq, delivery_num
	 * @return 성공한 row의 갯수를 판단하여 성공 true/ 실패 false
	 */
	public int updateDeliveryNum(Map<String, Object> map);

	
	public int deliRentStatus(int user_seq);
	
	public AddrDto findDelivery(int delivery_num);

}
