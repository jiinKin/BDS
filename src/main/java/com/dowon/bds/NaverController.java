package com.dowon.bds;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.codehaus.jackson.JsonNode;
import org.codehaus.jackson.map.ObjectMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.dowon.bds.dto.URLDto;
import com.dowon.bds.dto.UserDto;
import com.dowon.bds.model.service.ISocialService;
import com.dowon.bds.model.service.IUserService;

import lombok.extern.slf4j.Slf4j;

/**
 * 
 * @author 김영진
 * @since 2023.09.12 네이버 로그인 컨트롤러
 */

@Controller
@Slf4j
public class NaverController {
	
	private UserDto dto;
	private URLDto uDto = new URLDto();

	@Autowired
	private ISocialService service;
	
	@Autowired
	private IUserService userService;
	
	// Response 받은 값을 JSON으로 바꾸기 위함
	private ObjectMapper objmapper = new ObjectMapper();
	
	@RequestMapping(value="/naverLogin.do")
	public String naverCallBack(String code, String state, HttpSession session, Model model) {
	
		log.info("naverLogin.do 실행");
		String tokenUrl = uDto.getNaverTokenUrl(code, state);
		try {
			// 위에 설정 한 url에 대한 값을 url로 new 해준다
			URL url = new URL(tokenUrl);
			// 설정한 URL을 연결 시켜준다
			HttpURLConnection con = (HttpURLConnection) url.openConnection();

			// 설정 한 url을 GET방식으로 실행시킨다.
			con.setRequestMethod("GET");

			// 실행된 responsecode를 가져온다
			int responseCode = con.getResponseCode();
			log.info("응답 받은 코드 : {}",responseCode);
			
			BufferedReader br;
			if (responseCode == 200) { // 정상 호출
				// 응답 데이터를 읽어와 BufferdReader에 담아준다
				br = new BufferedReader(new InputStreamReader(con.getInputStream()));
			} else { // 에러 발생
				// 응답 데이터를 읽어와 BufferdReader에 담아준다
				br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
			}
			String inputLine;
			StringBuilder res = new StringBuilder();
			//버퍼 리더에 담긴 값을 한줄 씩 읽어 스트링 빌더에 append 하여 긴 문자열로 만들어 줌
			while ((inputLine = br.readLine()) != null) {
				res.append(inputLine);
			}
			 br.close();
			 //응답 코드가 200일 때 
			 if (responseCode == 200) {
				 //String builder에 담긴 값을 JSON형태로 파싱 해준다.
		    	 JsonNode jnode = objmapper.readTree(res.toString());
		    	 //JSON형태로 받아온 값 중에서 accessToken을 추출한다
		    	 String accToken = jnode.get("access_token").asText();
		    	 String refreshToken = jnode.get("refresh_token").asText();
		    	 //추출한 AccessToken을 이용해 로그인 정보를 가져온다.
		    	 JsonNode info = getInfo(accToken);
		    	 if(info!=null) {
		    		 log.info("전달 받은 회원 정보 :{} ",info);
		    		 //값을 추출하기
		    		 String user_email = info.path("response").path("email").asText();
		    		 String user_name = info.path("response").path("name").asText();
		    		 String user_phone = info.path("response").path("mobile").asText();
		    		 String user_gender = info.path("response").path("gender").asText();
		    		 String user_birth = info.path("response").path("birthyear").asText()+"-"
		    				 		+info.path("response").path("birthday").asText();
		    		 String naver_key = info.path("response").path("id").asText();
		    		 
		    		 log.info("추출한 값 : Email : {} / name : {}  / mobile : {} / gender {} / birth {} / nakey_key {}"
		    				 		,user_email,user_name,user_phone,user_gender,user_birth, naver_key);
		    		 // dto에 집어넣기 여기서 다 담아 줘야 함
		    		 dto = new UserDto(user_email, user_name, user_phone, user_gender, user_birth, naver_key);
		    		 // email로 해당 email이 존재하는지 확인하기
		    		 log.info("naver : {}",naver_key);
		    		 log.info("dto : {}",dto);
		    		 int n = service.checkNaverKey(dto); 
		    		 
		    		 UserDto loginDto = service.getScocialInfo(dto.getNaver_key());
		    		 
		    		 //여기를 response/id 값을 담아 와서 DB에 해당 값이 있는지 비교.
		    		 //있으면  로그인 성공 및 세션에 정보 담아주기
		    		 //없으면 회원가입 페이지로 이동
		    		 
		    		 if(n == 1) {
		    			log.info("Welcome 소셜 로그인 성공");
		    			log.info("네이버 로그인 정보 :{} ",dto);
		    			log.info("getScocialInfo값 체크 : {}",loginDto);
		    			session.setAttribute("loginDto", loginDto);
		    			return "redirect:/index.jsp";
		    		 }else {
		    			log.info("Welcome 소셜 로그인 실패");
		    			log.info("Welcome ====> 회원가입으로 이동");
		    			model.addAttribute("alertMessage", "일치하는 정보가 없습니다. 소셜 회원가입을 진행해주세요.");
		    			model.addAttribute("socialInfo",dto);
		    			return "socialRegistForm";
		    		 }
		    	 }
		      }
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "";
	}
	
	@RequestMapping(value="/naverJoin.do")
	public String naverJoin(String code, String state, HttpSession session, Model model) {
	
		log.info("naverLogin.do 실행");
		String tokenUrl = uDto.getNaverTokenUrl(code, state);
		try {
			// 위에 설정 한 url에 대한 값을 url로 new 해준다
			URL url = new URL(tokenUrl);
			// 설정한 URL을 연결 시켜준다
			HttpURLConnection con = (HttpURLConnection) url.openConnection();

			// 설정 한 url을 GET방식으로 실행시킨다.
			con.setRequestMethod("GET");

			// 실행된 responsecode를 가져온다
			int responseCode = con.getResponseCode();
			log.info("응답 받은 코드 : {}",responseCode);
			
			BufferedReader br;
			if (responseCode == 200) { // 정상 호출
				// 응답 데이터를 읽어와 BufferdReader에 담아준다
				br = new BufferedReader(new InputStreamReader(con.getInputStream()));
			} else { // 에러 발생
				// 응답 데이터를 읽어와 BufferdReader에 담아준다
				br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
			}
			String inputLine;
			StringBuilder res = new StringBuilder();
			//버퍼 리더에 담긴 값을 한줄 씩 읽어 스트링 빌더에 append 하여 긴 문자열로 만들어 줌
			while ((inputLine = br.readLine()) != null) {
				res.append(inputLine);
			}
			 br.close();
			 //응답 코드가 200일 때 
			 if (responseCode == 200) {
				 //String builder에 담긴 값을 JSON형태로 파싱 해준다.
		    	 JsonNode jnode = objmapper.readTree(res.toString());
		    	 //JSON형태로 받아온 값 중에서 accessToken을 추출한다
		    	 String accToken = jnode.get("access_token").asText();
		    	 String refreshToken = jnode.get("refresh_token").asText();
		    	 //추출한 AccessToken을 이용해 로그인 정보를 가져온다.
		    	 JsonNode info = getInfo(accToken);
		    	 if(info!=null) {
		    		 log.info("전달 받은 회원 정보 :{} ",info);
		    		 //값을 추출하기
		    		 String user_email = info.path("response").path("email").asText();
		    		 String user_name = info.path("response").path("name").asText();
		    		 String beforePhone = info.path("response").path("mobile").asText();
		    		 String user_phone = beforePhone.replaceAll("-", "");
		    		 String user_gender = info.path("response").path("gender").asText();
		    		 String user_birth = info.path("response").path("birthyear").asText()+"-"
		    				 		+info.path("response").path("birthday").asText();
		    		 String naver_key = info.path("response").path("id").asText();
		    		 
		    		 log.info("추출한 값 : Email : {} / name : {}  / mobile : {} / gender {} / birth {} / nakey_key {}"
		    				 		,user_email,user_name,user_phone,user_gender,user_birth, naver_key);
		    		 // dto에 집어넣기 여기서 다 담아 줘야 함
		    		 dto = new UserDto(user_email, user_name, user_phone, user_gender, user_birth, naver_key);
		    		 // email로 해당 email이 존재하는지 확인하기
		    		 log.info("naver : {}",naver_key);
		    		 log.info("dto : {}",dto);
		    		 
		    		 int n = service.checkNaverKey(dto); 
		    		 
		    		 
		    		 //여기를 response/id 값을 담아 와서 DB에 해당 값이 있는지 비교.
		    		 //있으면  로그인 성공 및 세션에 정보 담아주기
		    		 //없으면 회원가입 페이지로 이동
		    		 
		    		 if(n == 1) {
		    			log.info("Welcome 소셜 회원가입 중복 있음");
		    			model.addAttribute("alertMessage", "이미 가입된 회원입니다.");
		    			return "loginPage";
		    			
		    		 }else { //수정해야함 231001
		    			log.info("Welcome 소셜 회원가입 중복 없음");
		    			log.info("Welcome ====> 회원가입으로 이동");
		    			model.addAttribute("socialInfo",dto);
		    			log.info("체크체크: {}",dto);
		    			model.addAttribute("alertMessage","조회된 회원이 없습니다. 간편 회원가입 페이지로 이동합니다.");
		    			return "socialRegistForm";
		    		 }
		    	 }
		      }
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "";
	}
	
	//네이버 연동하기
	@RequestMapping(value="/naverLink.do")
	public String naverLink(String code, String state, HttpSession session, Model model) {
	
		log.info("naverLogin.do 실행");
		String tokenUrl = uDto.getNaverTokenUrl(code, state);
		try {
			// 위에 설정 한 url에 대한 값을 url로 new 해준다
			URL url = new URL(tokenUrl);
			// 설정한 URL을 연결 시켜준다
			HttpURLConnection con = (HttpURLConnection) url.openConnection();

			// 설정 한 url을 GET방식으로 실행시킨다.
			con.setRequestMethod("GET");

			// 실행된 responsecode를 가져온다
			int responseCode = con.getResponseCode();
			log.info("응답 받은 코드 : {}",responseCode);
			
			BufferedReader br;
			if (responseCode == 200) { // 정상 호출
				// 응답 데이터를 읽어와 BufferdReader에 담아준다
				br = new BufferedReader(new InputStreamReader(con.getInputStream()));
			} else { // 에러 발생
				// 응답 데이터를 읽어와 BufferdReader에 담아준다
				br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
			}
			String inputLine;
			StringBuilder res = new StringBuilder();
			//버퍼 리더에 담긴 값을 한줄 씩 읽어 스트링 빌더에 append 하여 긴 문자열로 만들어 줌
			while ((inputLine = br.readLine()) != null) {
				res.append(inputLine);
			}
			 br.close();
			 //응답 코드가 200일 때 
			 if (responseCode == 200) {
				 //String builder에 담긴 값을 JSON형태로 파싱 해준다.
		    	 JsonNode jnode = objmapper.readTree(res.toString());
		    	 //JSON형태로 받아온 값 중에서 accessToken을 추출한다
		    	 String accToken = jnode.get("access_token").asText();
		    	 String refreshToken = jnode.get("refresh_token").asText();
		    	 //추출한 AccessToken을 이용해 로그인 정보를 가져온다.
		    	 JsonNode info = getInfo(accToken);
		    	 if(info!=null) {
		    		 log.info("전달 받은 회원 정보 :{} ",info);
		    		 //값을 추출하기
		    		
		    		 String naver_key = info.path("response").path("id").asText();
		    		 
		    		 log.info("추출한 값 : nakey_key {}"
		    				 		, naver_key);
		    		 // dto에 집어넣기 여기서 다 담아 줘야 함
		    		 dto = new UserDto(naver_key);
		    		 
		    		 UserDto user = (UserDto)session.getAttribute("loginDto");
		    		 Map<String, Object> map = new HashMap<String, Object>();
		    		 map.put("naver_key", dto.getNaver_key());
		    		 map.put("user_seq", user.getUser_seq());
		    		 
		    		 int n = userService.linknaver(map);
		    	
		    		 if(n == 1) {
		    			log.info("Welcome 소셜 연동 성공");
		    			log.info("네이버 로그인 정보 :{} ",dto);
//		    			session.setAttribute("loginDto", user);
		    			model.addAttribute("successLink","네이버 소셜 연동 성공");
		    			return "alert";
		    		 }else {
		    			log.info("Welcome 소셜 연동 실패");
		    			log.info("Welcome ====> 회원가입으로 이동");
//		    			model.addAttribute("socialInfo",dto);
		    			model.addAttribute("failLink","네이버 소셜 연동 실패");
		    			return "alert";
		    		 }
		    	 }
		      }
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "";
	}
	
	
	
	
	public JsonNode getInfo(String accessToken) {
		log.info("WelCome NaverController >> getInfo");
		try {
			URL url = new URL(uDto.getNaverInfo());
			HttpURLConnection conn = (HttpURLConnection)url.openConnection();
			conn.setRequestMethod("GET");
			conn.setRequestProperty("Authorization", "Bearer " + accessToken);
			
            int responseCode = conn.getResponseCode();

            if (responseCode == HttpURLConnection.HTTP_OK) {
                // API 응답 읽기
                BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
                String inputLine;
                StringBuilder response = new StringBuilder();

                while ((inputLine = br.readLine()) != null) {
                    response.append(inputLine);
                }
                br.close();
                // JSON 응답 파싱
                JsonNode info = objmapper.readTree(response.toString());
                return info;
            } else {
                System.out.println("Error: Response code " + responseCode);
                return null;
            }
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
}
