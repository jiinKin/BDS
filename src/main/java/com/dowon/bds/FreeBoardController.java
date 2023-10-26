package com.dowon.bds;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.util.WebUtils;

import com.dowon.bds.dto.FreeBoardDto;
import com.dowon.bds.dto.FreeCommentDto;
import com.dowon.bds.dto.PagingDto;
import com.dowon.bds.dto.UserDto;
import com.dowon.bds.model.service.IFreeBoardService;
import com.dowon.bds.model.service.IFreeCommentService;
import com.dowon.bds.model.service.IUserService;

import lombok.extern.slf4j.Slf4j;
/**
 * 
 * @author 김수엽
 * @since 2023.09.24
 * 자유게시판 관련 컨트롤러
 *
 */
@Controller
@Slf4j
public class FreeBoardController {

	@Autowired
	private IFreeBoardService service;
	@Autowired
	private IFreeCommentService service2;

	@RequestMapping(value = "/home.do",method = RequestMethod.GET)
	public String home() {
		log.info("FreeBoardController home 메인화면으로 이동");
		return "redirect:/index.jsp";
	}
	
	// 자유게시판 페이징처리
	@GetMapping(value = "/freeBoardList.do")
	public String FreeBoardPage(@RequestParam(name = "page", defaultValue = "1") int selectPage, Model model) {
	    PagingDto pd = new PagingDto();

	    // 총 게시물의 갯수
	    pd.setTotalCount(service.FreeBoardCount());

	    // 출력될 총 게시글의 갯수
	    pd.setCountList(10);

	    // 화면에 몇개의 페이지그룹
	    pd.setCountPage(5);

	    // 총페이지의 갯수
	    pd.setTotalPage(pd.getTotalCount());

	    // 요청되는페이지
	    pd.setPage(selectPage);

	    // 시작페이지 번호
	    pd.setStartPage(selectPage);

	    // 끝번호
	    pd.setEndPage(pd.getCountPage());

	    // 게시글 조회
	    Map<String, Object> map = new HashMap<String, Object>();
	    map.put("first", pd.getPage() * pd.getCountList() - (pd.getCountList() - 1));
	    map.put("last", pd.getPage() * pd.getCountList());

	    List<FreeBoardDto> lists = service.FreeBoardCountList(map);
	    model.addAttribute("lists", lists);
	    model.addAttribute("pd", pd);
	    System.out.println("확인@@@@@@@@@@@@:"+pd);
	    log.info("Welcome FreeBoardController PageList {}", lists);

	    return "freeBoardMain";
	}

	@RequestMapping(value = "/freeBoardInsertView.do",method = RequestMethod.GET)
	public String freeBoardInsertView(HttpSession session) {
		log.info("FreeBoardController freeBoardInsertView 자유게시판 새글등록 화면 이동");
		UserDto loginDto = (UserDto) session.getAttribute("loginDto");
		if(loginDto == null) {
			return "redirect:/loginPage.do";
		}
		return "freeBoardInsert";
	}

	@RequestMapping(value = "/freeBoardInsert.do", method = RequestMethod.POST)
	public String freeBoardInsert(HttpSession session, FreeBoardDto dto) {
		log.info("FreeBoardController freeBoardInsert 자유게시판 새글등록{}",dto);
		UserDto loginDto = (UserDto) session.getAttribute("loginDto");
	    dto.setUser_seq(loginDto.getUser_seq());
		int n = service.freeBoardInsert(dto);
		if(n == 1) {
			return "redirect:/freeBoardList.do";
		}
		return "index";
	}
	
	
	@RequestMapping(value = "/freeBoardDetail.do",method = RequestMethod.GET)
	public String freeBoardDetail(@RequestParam("free_bseq")int free_bseq,Model model,HttpSession session) {
		log.info("FreeBoardController freeBoardDetail 자유게시판 상세조회");
		UserDto loginDto = (UserDto)session.getAttribute("loginDto");
		List<FreeCommentDto> CommentList = service2.CommentAllList(free_bseq);
		FreeBoardDto dto = service.freeBoardDetail(free_bseq);
		model.addAttribute("dto", dto);
		model.addAttribute("loginDto", loginDto);
		model.addAttribute("CommentAll", CommentList);
		return "freeBoardDetail";
	}
	@RequestMapping(value = "/freeBoardDel.do", method = RequestMethod.GET)
	public String freeBoardDel(@RequestParam("free_bseq")int free_bseq) {
		log.info("FreeBoardController freeBoardDel 자유게시판 게시글삭제");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("free_bseq", free_bseq);
		int n = service.freeBoardDel(map);
		if(n == 1) {
			return "redirect:/freeBoardList.do";
		}else {
			return "freeBoardDetail";
		}
	}
	@RequestMapping(value = "/updateBoard.do", method = RequestMethod.GET)
	public String updateBoardView(@RequestParam("free_bseq")int free_bseq,@RequestParam("free_title")String free_title,@RequestParam("free_content")String free_content, Model model,HttpSession session) {
		log.info("FreeBoardController updateBoard 자유게시판 글 수정 페이지로 이동");
		UserDto loginDto = (UserDto)session.getAttribute("loginDto");
		model.addAttribute("free_bseq",free_bseq);
		model.addAttribute("free_title",free_title);
		model.addAttribute("free_content",free_content);
		model.addAttribute("loginDto", loginDto);
		return "updateBoard";
	}
	@RequestMapping(value = "/freeBoardUpdate.do",method = RequestMethod.POST)
	public String updateBoard(@RequestParam("free_bseq")int free_bseq,@RequestParam("free_content")String free_content) {
		log.info("FreeBoardController updateBoard 자유게시판 글 수정");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("free_bseq", free_bseq);
		map.put("free_content", free_content);
 		 int n = service.updateBoard(map);
 		 if(n == 1) {
 			 return "redirect:/freeBoardList.do";
 		 }else {
 			 return "freeBoardDetail";
 		 }
	}
	
}
