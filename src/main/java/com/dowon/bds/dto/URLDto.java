package com.dowon.bds.dto;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

/**
 * 
 * @author 김영진
 * @since 2023-09-12
 * 소셜 API URL을 관리하기 위한 URLDto 추가
 */

public class URLDto {
	
	private SocialDto dto = new SocialDto();
	
	//oAuth접근 URL
	private String naverUrl = "https://nid.naver.com/oauth2.0/authorize?response_type=code";
	private String kakaoUrl = "https://kauth.kakao.com/oauth/authorize?response_type=code";
	
	
	//리다이렉트 URL
	private String naverRedirect = "http://localhost:8099/BookDeliverySystem/naverLogin.do";
	private String naverJoinRedirect = "http://localhost:8099/BookDeliverySystem/naverJoin.do";
	private String naverLinkRedirect = "http://localhost:8099/BookDeliverySystem/naverLink.do";
	private String kakaoRedirect = "http://localhost:8099/BookDeliverySystem/kakaoLogin.do";
	
	//토큰 요청 URL
	private String naverTokenUrl = "https://nid.naver.com/oauth2.0/token?grant_type=authorization_code&";
	private String kakaoTokenUrl = "https://kauth.kakao.com/oauth/token";
	
	//토큰을 이용한 정보를 가져오는 URL
	
	private String NaverInfo ="https://openapi.naver.com/v1/nid/me";
	private String KakaoInfo ="https://kapi.kakao.com/v2/user/me";
	
	public String getNaverUrl() {
		return naverUrl;
	}
	public String getKakaoUrl() {
		return kakaoUrl;
	}
	
	public String getNaverJoinRedirect() throws UnsupportedEncodingException {
		return URLEncoder.encode(naverJoinRedirect,"UTF-8");
	}
	
	public String getNaverLinkRedirect() throws UnsupportedEncodingException {
		return URLEncoder.encode(naverLinkRedirect,"UTF-8");
	}
	
	public String getNaverRedirect() throws UnsupportedEncodingException {
		return URLEncoder.encode(naverRedirect,"UTF-8");
	}
	public String getKakaoRedirect() throws UnsupportedEncodingException {
		return URLEncoder.encode(kakaoRedirect,"UTF-8");
	}
	
	
	public String getNaverTokenUrl(String code, String state) {
		return naverTokenUrl
				+"&client_id="+dto.getNaverClientID()
				+"&client_secret="+dto.getNaverSecretCode()
				+"&redirect_uri="+naverRedirect
				+"&code="+code
				+"&state="+state;
	}
	public String getKakaoTokenUrl() {
		return kakaoTokenUrl;
	}
	public String getNaverInfo() {
		return NaverInfo;
	}
	public String getKakaoInfo() {
		return KakaoInfo;
	}

	


}

