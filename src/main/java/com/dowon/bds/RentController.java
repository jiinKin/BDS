
package com.dowon.bds;

import java.text.DateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dowon.bds.dto.AddrDto;
import com.dowon.bds.dto.BookDto;
import com.dowon.bds.dto.PagingDto;
import com.dowon.bds.dto.UserDto;
import com.dowon.bds.model.service.IRentService;
import com.dowon.bds.model.service.IResveService;
import com.dowon.bds.model.service.IUserService;

import lombok.extern.slf4j.Slf4j;


/** 
 * @author 박하은
 * @since 2023.09.13
 * 도서 대출관련 Controller
 * 
 * @author 김지인
 * @since 2023.09.15
 * 배송상태확인 버튼 구현
 * 배송지 조회 구현
 */
@Controller
@Slf4j
public class RentController {

	
	@Autowired
	private IRentService rentService;
	
	@Autowired
	private IResveService resveService;
	
	@Autowired
	private IUserService userService;
	
	
	//회원 개인의 대출목록(페이징처리)
	@GetMapping("/userRentPageList.do")
	public String userRentPageList(@RequestParam(name = "page", defaultValue = "1") int selectPage, Model model, HttpSession session) {
		log.info("Welcome ResveController userRentPageList 회원의 마이페이지-대출조회 부분에 들어갈 페이지 컨트롤러");
		UserDto loginDto = (UserDto) session.getAttribute("loginDto");
		PagingDto r = new PagingDto();
		 if (loginDto != null) {
		        int user_seq = loginDto.getUser_seq();
		        
		r.setTotalCount(rentService.userCountRent(user_seq));
		r.setCountList(5);
		r.setCountPage(5);
		r.setTotalPage(r.getTotalCount());
		r.setPage(selectPage);
		r.setStartPage(selectPage);
		r.setEndPage(r.getCountPage());
		
		log.info("Welcome ResveController userRentPageList 페이징 처리를 위한 총 갯수 확인 : {}",r.getTotalCount());
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("first", r.getPage()*r.getCountList() - (r.getCountList()-1));
		map.put("last", r.getPage()*r.getCountList());
		map.put("user_seq", user_seq);
		
		List<Map<String, Object>> lists = rentService.userRentPageList(map);
		model.addAttribute("userRentList",lists);
		model.addAttribute("page",r);
		
		log.info("Welcome ResveController userRentPageList user_seq확인 : {}",user_seq);
		log.info("Welcome ResveController userRentPageList userRentList확인 : {}",lists);
		
		   return "userRentPageList";
		    } else {
		        return "redirect:/loginPage.do";
		    }
	}
	
	

    
    //관리자 ajax 대출관리 페이징
    @GetMapping("/adminRentList.do")
    @ResponseBody
    public Map<String, Object> adminRentList(@RequestParam(name = "page", defaultValue = "1") int selectPage, Model model) {
    	log.info("Welcome ResveController adminRentList 관리자 회원대출목록 페이지 컨트롤러");
    	PagingDto adminPaging = new PagingDto();
    	
    	
    	adminPaging.setTotalCount(rentService.allUserCountRent());
    	adminPaging.setCountList(10);
    	adminPaging.setCountPage(10);
    	adminPaging.setTotalPage(adminPaging.getTotalCount());
    	adminPaging.setPage(selectPage);
    	adminPaging.setStartPage(selectPage);
    	adminPaging.setEndPage(adminPaging.getCountPage());
    	
    	log.info("Welcome ResveController adminRentList 페이징 처리를 위한 총 갯수 확인 : {}",adminPaging.getTotalCount());
    	
    	Map<String, Object> map = new HashMap<String, Object>();
    	map.put("first", adminPaging.getPage()*adminPaging.getCountList() - (adminPaging.getCountList()-1));
    	map.put("last", adminPaging.getPage()*adminPaging.getCountList());
    	
    	List<Map<String, Object>> lists = rentService.allRentPageList(map);
		model.addAttribute("lists",lists);
		model.addAttribute("aPage",adminPaging);
    	
	    log.info("Welcome ResveController userRentPageList adminRentList확인 : {}",lists);
		
        Map<String, Object> response = new HashMap<>();
        response.put("lists", lists);
        response.put("aPage", adminPaging);
        return response;
    }   
	
	
	

	//관리자-회원대출관리 jsp (페이징처리)
	@GetMapping("/oldAdminRentList.do")
	public String oldAdminRentList(@RequestParam(name = "page", defaultValue = "1") int selectPage,Model model) {
		log.info("Welcome RentController adminRentList 관리자페이지-회원도서대출목록 에 들어갈 페이지 컨트롤러");
		
		PagingDto adminPaging = new PagingDto();
    	
    	
    	adminPaging.setTotalCount(rentService.allUserCountRent());
    	adminPaging.setCountList(10);
    	adminPaging.setCountPage(5);
    	adminPaging.setTotalPage(adminPaging.getTotalCount());
    	adminPaging.setPage(selectPage);
    	adminPaging.setStartPage(selectPage);
    	adminPaging.setEndPage(adminPaging.getCountPage());
    	
    	log.info("Welcome RentController adminRentList 페이징 처리를 위한 총 갯수 확인 : {}",adminPaging.getTotalCount());
    	
    	Map<String, Object> map = new HashMap<String, Object>();
    	map.put("first", adminPaging.getPage()*adminPaging.getCountList() - (adminPaging.getCountList()-1));
    	map.put("last", adminPaging.getPage()*adminPaging.getCountList());
    	
    	List<Map<String, Object>> lists = rentService.allRentPageList(map);
		model.addAttribute("lists",lists);
		model.addAttribute("aPage",adminPaging);
    	
	    log.info("Welcome RentController userRentPageList adminRentList확인 : {}",lists);
		
		return "adminRentList";
	}
    

	
	 @PostMapping("/confirmReturn.do")
	 @ResponseBody
	 public String confirmReturn(@RequestParam("rentSeq") int rentSeq, Model model, HttpSession session) {
	     log.info("Welcome RentController confirmReturn 관리자의 도서대출 반납처리 AJAX Controller"); 
		 try {
	         int rowsAffected = rentService.rentStatus(rentSeq);
	            
	         if (rowsAffected > 0) {
	        	 UserDto loginDto = (UserDto)session.getAttribute("loginDto");
	               Map<String, Object> userStatus = userService.getUserStatus(loginDto.getUser_seq());
	               session.setAttribute("userStatus",userStatus);
	              return "success";
	         }else {
	            return "error";
	           }
	        }catch (Exception e) {
	            e.printStackTrace();
	            return "error";
	        }
	    }
	 
	 @PostMapping("/rentStandby.do")
	 @ResponseBody
	 public String rentStandby(@RequestParam("bookSeq") int bookSeq, Model model) {
		 log.info("Welcome RentController rentStandby 예약도서 반납완료시 예약순번 가장 빠른회원 대출대기 상태 업데이트 AJAX Controller");
	     int success = resveService.rentStandby(bookSeq);

	     if (success > 0) {
	         return "success";
	     } else {
	         return "no_reservation"; // 예약이 없을 때
	     }
	 }
	 

	
/*
 * 김지인 
 * 23.09.18 배송지 조회를 위한 컨트롤러 작성
 * 23.09.21 window.open으로 변경하여 삭제
 * 
 */
	

}
