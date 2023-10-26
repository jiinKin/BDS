package com.dowon.bds;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dowon.bds.dto.UserDto;
import com.dowon.bds.model.service.ISocialService;
import com.dowon.bds.model.service.IUserService;


/**
 * 
 * @author 김영진
 * @since 2023-09-13 일반회원가입 / 소셜회원가입 컨트롤러
 */

@Controller
public class RegistController {
	
	@Autowired
	private IUserService service;
	
	@Autowired
	private ISocialService socialService;
	
	private Logger log = LoggerFactory.getLogger(this.getClass());
	
	//일반회원가입 폼 이동
	@RequestMapping(value="/nomalRegistForm.do", method = RequestMethod.GET)
	public String nomalRegistForm() {
		log.info("RegistController >> 일반회원가입폼 이동 ");
		return "nomalRegistForm";
	}
	
	//일반회원가입 처리 컨트롤러
	@RequestMapping(value="/nomalRegist.do", method = RequestMethod.POST)
	public String nomalRegist(UserDto dto, Model model){
		log.info("nomalRegistForm >> nomalRegist ");
		log.info("일반회원가입 내용{}",dto);
		int n = service.nomalRegist(dto);
		if( n == 1) {
			return "loginPage";
		}else {
			return "test";
		}
	}
	
	
	//소셜회원가입 컨트롤러
	@RequestMapping(value="/socialRegist.do", method = RequestMethod.POST)
	public String socialRegist(UserDto dto, Model model) {
		log.info("socialRegist >> 소셜회원가입");
		log.info("socialRegist.do dto 값 체크",dto.getNaver_key());
		int n = socialService.socialRegist(dto);
		log.info("test :  {} ",n);
		return "redirect:/index.jsp";
	}
	
//	//이메일 중복 체크 컨트롤러
//	@ResponseBody
//	@RequestMapping(value="/checkEmail.do", method = RequestMethod.POST)
//	public int checkEmail(@RequestParam String email) {
//		int cnt = service.checkEmail(email);
//		return cnt;
//		
//	}
	
}
