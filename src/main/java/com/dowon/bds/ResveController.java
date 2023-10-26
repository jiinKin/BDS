package com.dowon.bds;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dowon.bds.dto.PagingDto;
import com.dowon.bds.dto.ResveDto;
import com.dowon.bds.dto.UserDto;
import com.dowon.bds.model.service.IResveService;
import com.dowon.bds.model.service.IUserService;

import lombok.extern.slf4j.Slf4j;


/** 
 * @author 박하은
 * @since 2023.09.13
 * 도서 예약관련 Controller
 */
@Controller
@Slf4j
public class ResveController {

	@Autowired
	private IResveService resveService;
	
	@Autowired
	private IUserService userService;
	
	
	//예약목록 (페이징처리)
	@GetMapping("/userResvePageList.do")
	public String userResvePageList(@RequestParam(name = "page", defaultValue = "1") int selectPage, Model model, HttpSession session) {
		log.info("Welcome ResveController userResvePageList 회원의 마이페이지-예약조회 부분에 들어갈 페이지 컨트롤러");
		UserDto loginDto = (UserDto) session.getAttribute("loginDto");
		PagingDto resveDto = new PagingDto();
		if(loginDto != null) {
			int user_seq = loginDto.getUser_seq();
			
			resveDto.setTotalCount(resveService.userCountResve(user_seq));
			resveDto.setCountList(5);
			resveDto.setCountPage(5);
			resveDto.setTotalPage(resveDto.getTotalCount());
			resveDto.setPage(selectPage);
			resveDto.setStartPage(selectPage);
			resveDto.setEndPage(resveDto.getCountPage());
			
			log.info("Welcome ResveController userResvePageList 페이징 처리를 위한 총 갯수 확인 : {}",resveDto.getTotalCount());
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("first", resveDto.getPage()*resveDto.getCountList() - (resveDto.getCountList()-1));
			map.put("last", resveDto.getPage()*resveDto.getCountList());
			map.put("user_seq", user_seq);
			
			List<Map<String, Object>> lists = resveService.userResvePageList(map);
			model.addAttribute("userResvePageList",lists);
			model.addAttribute("page",resveDto);
			
			log.info("Welcome ResveController userResvePageList user_seq확인 : {}",user_seq);
			log.info("Welcome ResveController userResvePageList userResveList확인 : {}",lists);
			
			return "userResvePageList";
			} else {
				return "redirect:/loginPage.do";
			}
	}
	
	
    @PostMapping("/resveBook.do")
    @ResponseBody
    public ResponseEntity<String> resveBook(@RequestParam Map<String, Object> request, HttpSession session) {
    	log.info("Welcome ResveController resveBook 예약 신청 처리 Controller {}",request);
    	try {
            int bookSeq = Integer.parseInt((String) request.get("book_seq"));
            int userSeq = Integer.parseInt((String) request.get("user_seq"));
            int result = resveService.resveBook(request);

            if (result > 0) {
            	UserDto loginDto = (UserDto)session.getAttribute("loginDto");
                Map<String, Object> userStatus = userService.getUserStatus(loginDto.getUser_seq());
                session.setAttribute("userStatus",userStatus);
                return ResponseEntity.ok("예약 신청이 완료되었습니다.");
            } else {
                return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                        .body("예약 신청에 실패했습니다. 다시 시도해주세요.");
            }
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("예약 신청에 실패했습니다. 다시 시도해주세요.");
        }
    }
    
    
    @PostMapping("/cancel.do")
    public ResponseEntity<String> cancelReservation(@RequestBody Map<String, Object> params, HttpSession session) {
    	log.info("Welcome ResveController cancelReservation 예약 신청 취소 처리 Controller");
    	try {
            int bookSeq = (int) params.get("book_seq");
            int userSeq = (int) params.get("user_seq");

            int result = resveService.resveCancle(params);
            if (result > 0) {
            	UserDto loginDto = (UserDto)session.getAttribute("loginDto");
                Map<String, Object> userStatus = userService.getUserStatus(loginDto.getUser_seq());
                session.setAttribute("userStatus",userStatus);
                return ResponseEntity.ok("success");
            } else {
                return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                        .body("예약취소에 실패했습니다. 다시 시도해주세요.");
            }
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("예약취소에 실패했습니다. 다시 시도해주세요.");
        }
    }


}
