package com.dowon.bds.dto;

/**
 * 
 * @author 김영진
 * @since 2023-09-12 
 * 소셜 API ClientID, SecretCode를 담기 위한 SocialDto 추가
 */

public class SocialDto {
	
	//네이버
	private String naverClientID="iOcdeciN8Vte66vXq7XO";
	private String naverSecretCode="COmhGznXxf";
	
	
	//카카오
	private String kakaoClientID="38c0e4ee3eee5b8e734a41d76b696b8a";
	private String kakaoSecretCode="UYDF8t33BOQYC0zY8Yzx50jjmH5DNpOh";
	
	
	
	public String getNaverClientID() {
		return naverClientID;
	}
	public String getNaverSecretCode() {
		return naverSecretCode;
	}
	public String getKakaoClientID() {
		return kakaoClientID;
	}
	public String getKakaoSecretCode() {
		return kakaoSecretCode;
	}
	
	
}
