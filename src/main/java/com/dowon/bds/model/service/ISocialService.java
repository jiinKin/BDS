package com.dowon.bds.model.service;

import java.util.Map;

import com.dowon.bds.dto.UserDto;

public interface ISocialService {
	
		// 네이버 key 확인
		public int checkNaverKey(UserDto dto);
		
		// 소셜 회원가입
		public int socialRegist(UserDto dto);
		
		// 소셜회원정보가져오기
		public UserDto getScocialInfo(String naver_key);
}
