package com.dowon.bds.model.mapper;


import java.util.List;
import java.util.Map;

import com.dowon.bds.dto.NoticeBoardDto;
import com.dowon.bds.dto.UserDto;

public interface IUserDao {
	
	//로그인 구현
	public UserDto login(Map<String, Object> map);
	
	//일반회원 가입
	public int nomalRegist(UserDto dto);
	
	//이메일 중복 체크
	public int checkEmail(String user_email);
	
	//전화번호 중복 체크
	public int checkPhone(String user_phone);
	
	//모든회원 리스트 조회
	public List<UserDto> getAllUser();
	
	//회원번호로 도서 및 예약 상태 조회
	public Map<String, Object> getUserStatus(int user_seq);
	
	//이메일 찾기
	public String findEmail(Map<String, Object> map);
	
	//임시비밀번호 발급
	public int findPW(Map<String, Object> map);
	
	//임시비밀번호 발급시 유효성 체크
	public int findPwCheck(UserDto dto);
	
	//비밀번호 수정
	public int modifyPassword(Map<String, Object> map);
	
	//비밀번호 체크
	public int checkPassword(Map<String, Object> map);
	
	//회원 상세조회
	public UserDto getUserDetail(String user_email);
	
	//네이버 연동
	public int linknaver(Map<String, Object> map);
}	
