package com.dowon.bds.model.mapper;

import java.util.Map;

import com.dowon.bds.dto.UserDto;

public interface ISocialDao {
	
	// 네이버 key 확인
	public int checkNaverKey(UserDto dto);
	
	// 소셜 회원가입
	public int socialRegist(UserDto dto);
	
	//
	public UserDto getScocialInfo(String naver_key);
}
