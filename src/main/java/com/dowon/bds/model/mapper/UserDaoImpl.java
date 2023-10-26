package com.dowon.bds.model.mapper;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dowon.bds.dto.UserDto;

import lombok.extern.slf4j.Slf4j;

@Repository
@Slf4j
public class UserDaoImpl implements IUserDao {
	
	private final String NS = "com.dowon.bds.model.mapper.UserDaoImpl.";

	@Autowired
	public SqlSessionTemplate sqlSession;
	
	
	@Override
	public UserDto login(Map<String, Object> map) {
		log.info("UserDaoImpl login 로그인 기능");
		return sqlSession.selectOne(NS+"login",map);
	}


	@Override
	public int nomalRegist(UserDto dto) {
		log.info("UserDaoImpl nomalRegist 일반회원가입");
		return sqlSession.insert(NS+"nomalRegist",dto);
	}


	@Override
	public int checkEmail(String user_email) {
		log.info("UserDaoImpl checkEmail 이메일 중복 체크");
		return sqlSession.selectOne(NS+"checkEmail",user_email);
	}
	
	@Override
	public List<UserDto> getAllUser(){
		log.info("UserDaoImpl getAllUser 모든 회원 리스트 조회");
		return sqlSession.selectList(NS+"getAllUser");
	}


	@Override
	public Map<String, Object> getUserStatus(int user_seq) {
		log.info("UserDaoImpl getUserStatus 유저 도서 대출 및 예약 상태 조회");
		return sqlSession.selectOne(NS+"getUserStatus",user_seq);
	}


	@Override
	public int checkPhone(String user_phone) {
		log.info("UserDaoImpl checkPhone 번호 중복 체크");
		return sqlSession.selectOne(NS+"checkPhone",user_phone);
	}


	@Override
	public String findEmail(Map<String, Object> map) {
		log.info("UserDaoImpl checkPhone 이메일 찾기");
		return sqlSession.selectOne(NS+"findEmail",map);
	}


	@Override
	public int findPW(Map<String, Object> map) {
		log.info("UserDaoImpl checkPhone 임시비밀번호 발급");
		return sqlSession.update(NS+"findPW",map);
	}


	@Override
	public int findPwCheck(UserDto dto) {
		log.info("UserDaoImpl findPwCheck 유효성 체크");
		return sqlSession.selectOne(NS+"findPWCheck",dto);
	}


	@Override
	public int modifyPassword(Map<String, Object> map) {
		log.info("UserDaoImpl modifyPassword 비밀번호업데이트");
		return sqlSession.update(NS+"modifyPW",map);
	}


	@Override
	public int checkPassword(Map<String, Object> map) {
		log.info("UserDaoImpl checkPassword 비밀번호체크");
		return sqlSession.selectOne(NS+"checkPassword",map);
	}


	@Override
	public UserDto getUserDetail(String user_email) {
		log.info("UserDaoImpl getUserDetail 유저상세정보");
		return sqlSession.selectOne(NS+"getUserDetail",user_email);
	}


	@Override
	public int linknaver(Map<String, Object> map) {
		log.info("UserDaoImpl linknaver 네이버연동하기");
		return sqlSession.update(NS+"linkNaver",map);
	}
}
