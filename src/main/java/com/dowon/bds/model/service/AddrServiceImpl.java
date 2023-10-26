package com.dowon.bds.model.service;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dowon.bds.dto.AddrDto;
import com.dowon.bds.model.mapper.IAddrDao;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class AddrServiceImpl implements IAddrService {
	
	private static final Logger logger = LoggerFactory.getLogger(AddrServiceImpl.class); 
	
	@Autowired
	private IAddrDao dao;
	
	@Autowired
	private SqlSessionTemplate session;


    @Override
    public int saveAddress(AddrDto addrDto) {
    	logger.info("배송지 주소입력 saveAddress");
		return dao.saveAddress(addrDto);
   	
    }

	@Override
	public AddrDto checkAddress(String delivery_seq) {
		log.info("배송지 주소 확인 checkAddress");
		return dao.checkAddress(delivery_seq);
	}

	@Override
	public AddrDto getAddrUserSeq(int user_seq) {
		return dao.getAddrUserSeq(user_seq);
	}

	@Override
	public int deliRentStatus(int user_seq) {
		log.info("AddrServiceImpl deliRentStatus 도서 배송 완료 처리 :{}",user_seq);
		return dao.deliRentStatus(user_seq);
	}

	@Override
	@Transactional
	public int updateDeliveryNum(Map<String, Object> map) {
		log.info("운송장 번호 입력 updateDeliveryNum 운송장번호 업데이트");
		return dao.updateDeliveryNum(map);
	}

	@Override
    @Transactional
	public int saveAddressReturn(AddrDto addrDto) {
		log.info("배송지 주소 입력 saveAddressReturn 회원상태 업데이트");
        int result = 0;
        try {
            // 첫 번째 SQL 실행: 배송지 주소 입력
            result += dao.saveAddress(addrDto);
            // 두 번째 SQL 실행: 대출 상태 업데이트
            result += dao.deliRentStatus(addrDto.getUser_seq());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
	}

	@Override
	public AddrDto findDelivery(int delivery_num) {
		log.info("운송장번호 조회 findDelivery");
		return dao.findDelivery(delivery_num);
	}

}
