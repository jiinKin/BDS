package com.dowon.bds.model.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dowon.bds.dto.UserDto;
import com.dowon.bds.model.mapper.ISocialDao;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class SocialServiceImpl implements ISocialService {

	
	@Autowired
	private ISocialDao dao;

	@Override
	public int checkNaverKey(UserDto dto) {
		log.info("SocialServiceImpl checkNaverKey 네이버 키 확인 : {}",dto);
		return dao.checkNaverKey(dto);
	}

	@Override
	public int socialRegist(UserDto dto) {
		log.info("SocialServiceImpl socialRegist 소셜회원가입 : {}",dto);
		return dao.socialRegist(dto);
	}

	@Override
	public UserDto getScocialInfo(String naver_key) {
		log.info("SocialServiceImpl getScocialInfo 소셜회원정보가져오기 : {}",naver_key);
		return dao.getScocialInfo(naver_key);
	}

}
