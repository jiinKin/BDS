package com.dowon.bds;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dowon.bds.dto.FaqBoardDto;
import com.dowon.bds.dto.UserDto;
import com.dowon.bds.model.service.IFaqService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class FaqController {
	
	@Autowired
	private IFaqService service;
	
//	@RequestMapping(value = "/main.do", method = RequestMethod.GET)
//	public String home() {
//		log.info("FaqController home 메인화면으로 이동");
//		return "redirect:/index.jsp";
//	}
	
	@RequestMapping(value = "/faqList.do" , method = RequestMethod.GET)
	public String faqList(Model model) {
		log.info("FaqController faqList FAQ 전체조회");
		List<FaqBoardDto> lists = service.faqList();
		model.addAttribute("faqList",lists);
		return "faqMain";
	}
	
	@RequestMapping(value = "/faqInsertView.do", method = RequestMethod.GET)
	public String faqInsertView(HttpSession session) {
		log.info("FaqController faqInsertView FAQ 관리자 새글등록 화면");
		UserDto loginDto = (UserDto)session.getAttribute("loginDto");
		if (loginDto == null || !loginDto.getUser_auth().equals("A")) {
			return "redirect:/loginPage.do";
		}
		   return "faqInsert";
	}
	
	@RequestMapping(value = "/faqInsert.do", method = RequestMethod.POST)
	public String faqInsert (HttpSession session, FaqBoardDto dto) {
		log.info("FaqController faqInsert FAQ 관리자 새글등록 {}",dto);
		UserDto loginDto = (UserDto)session.getAttribute("loginDto");
		dto.setUser_seq(loginDto.getUser_seq());
		int n = service.faqInsert(dto);
		if (n == 1) {
			return "redirect:/faqList.do";
		}
		return "index";
	}
	
	@RequestMapping(value = "/faqBoardDetail.do", method = RequestMethod.GET)
	public String faqBoardDetail(@RequestParam("faq_seq")int faq_seq, Model model, HttpSession session) {
		log.info("FaqController faqBoardDetail FAQ 게시판 상세조회");
		UserDto loginDto = (UserDto)session.getAttribute("loginDto");
		FaqBoardDto dto = service.faqBoardDetail(faq_seq);
		model.addAttribute("dto",dto);
		model.addAttribute("loginDto",loginDto);
		
		return "faqBoardDetail";
	}
	
	@RequestMapping(value = "/faqDel.do" , method = RequestMethod.GET)
	public String faqDel(@RequestParam("faq_seq")int faq_seq) {
		log.info("FaqController faqDel FAQ 글 삭제");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("faq_seq", faq_seq);
		int n = service.faqDel(map);
		if (n == 1) {
			return "redirect:/faqList.do";
		}
		return "faqBoardDetail";
	}
	
	@RequestMapping(value = "/updateFaq.do", method = RequestMethod.GET)
	public String updateFaqView(@RequestParam("faq_seq") int faq_seq, @RequestParam("faq_title")String faq_title, @RequestParam("faq_content") String faq_content, Model model, HttpSession session) {
		log.info("FaqController updateFaqView FAQ게시판 글 수정 페이지로 이동");
		UserDto loginDto = (UserDto)session.getAttribute("loginDto");
		model.addAttribute("faq_seq",faq_seq);
		model.addAttribute("faq_title",faq_title);
		model.addAttribute("faq_content",faq_content);
		model.addAttribute("loginDto",loginDto);
		return "updateFaq";
	}
	
	@RequestMapping(value = "/updateFaqBoard.do", method = RequestMethod.POST)
	public String updateFaq(@RequestParam("faq_seq") int faq_seq, @RequestParam("faq_title")String faq_title, @RequestParam("faq_content") String faq_content) {
		log.info("FaqController updateFaqView FAQ게시판 글 수정");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("faq_seq", faq_seq);
		map.put("faq_title", faq_title);
		map.put("faq_content", faq_content);
		int n = service.updateFaq(map);
		if (n == 1) {
			return "redirect:/faqList.do";
		}
		return "faqBoardDetail";
	}
	
	@RequestMapping(value = "/mainFaqList.do", method = RequestMethod.GET, produces = "application/json")
	@ResponseBody
	public List<FaqBoardDto> mainFaqList(Model model) {
	    List<FaqBoardDto> faqList = service.mainFaqList();// 최근 8개의 FAQ만 가져오기
	    model.addAttribute("faqList", faqList);
	    
	    log.info("Welcome ResveController userRentPageList mainFaqList 출력 : {}", faqList);
	    return faqList;
	}

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

}
