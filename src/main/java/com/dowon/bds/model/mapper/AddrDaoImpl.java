package com.dowon.bds.model.mapper;
/** 
 * @author 김지인
 * @since 2023.09.19
 * 도서 배송관련 메소드를 구현한 DAO Interface implements 클래스
 */
import java.util.Map;

/** 
 * @author 김지인
 * @since 2023.09.14
 * 배송지 입력 메소드를 구현한 DAO Interface implements 클래스
 */


import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dowon.bds.dto.AddrDto;

import lombok.extern.slf4j.Slf4j;

@Repository
@Slf4j
public class AddrDaoImpl implements IAddrDao {

	private final String NS = "com.dowon.bds.model.mapper.AddrDaoImpl.";
	
	@Autowired
	private SqlSessionTemplate session;

	@Override
	public int saveAddress(AddrDto addrDto) {
		return session.insert(NS+"saveAddress", addrDto);
		}

	@Override
	public AddrDto checkAddress(String delivery_seq) {
		 return session.selectOne(NS + "checkAddress", delivery_seq);
	}

	@Override
	public AddrDto getAddrUserSeq(int user_seq) {
		return session.selectOne(NS + "getAddrUserSeq", user_seq);
	}

	@Override
	public int updateDeliveryNum(Map<String, Object> map) {
		log.info("updateDeliveryNum 운송장번호 등록");
		return session.update(NS+"updateDeliveryNum",map);

	}

	@Override
	public int deliRentStatus(int user_seq) {
		return session.update(NS+"deliRentStatus",user_seq);
	}

	@Override
	public int saveAddressReturn(AddrDto addrDto) {
		return session.insert(NS+"saveAddressReturn", addrDto);
	}

	@Override
	public AddrDto findDelivery(int delivery_num) {
		 return session.selectOne(NS + "findDelivery", delivery_num);
	}




}
