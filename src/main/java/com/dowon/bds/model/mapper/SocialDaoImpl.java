package com.dowon.bds.model.mapper;

import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dowon.bds.dto.UserDto;

import lombok.extern.slf4j.Slf4j;

@Repository
@Slf4j
public class SocialDaoImpl implements ISocialDao {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	private String NS = "com.dowon.bds.model.mapper.SocialDaoImpl.";
	
	@Override
	public int checkNaverKey(UserDto dto) {
		return sqlSession.selectOne(NS+"checkNaverKey",dto);
	}

	@Override
	public int socialRegist(UserDto dto) {
		return sqlSession.insert(NS+"naverJoin",dto);
	}

	@Override
	public UserDto getScocialInfo(String naver_key) {
		return sqlSession.selectOne(NS+"getScocialInfo",naver_key);
	}
	
	

}
