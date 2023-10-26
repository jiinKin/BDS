package com.dowon.bds;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.dowon.bds.dto.FreeCommentDto;
import com.dowon.bds.dto.UserDto;
import com.dowon.bds.model.service.IFreeCommentService;

import lombok.extern.slf4j.Slf4j;
/**
 * 
 * @author 김수엽
 * @since 2023.09.24
 * 자유게시판 답글관련 컨트롤러
 *
 */
@Controller
@Slf4j
public class FreeCommentController {

	@Autowired
	private IFreeCommentService service;
	
	@RequestMapping(value = "/CommentInsert.do", method = RequestMethod.POST)
	public String Comment(@RequestParam("free_bseq")int free_bseq,HttpSession session, FreeCommentDto fDto,HttpServletResponse resp) throws IOException{
		log.info("FreeCommentController Comment 답글작성");
		UserDto loginDto = (UserDto)session.getAttribute("loginDto");
		fDto.setUser_seq(loginDto.getUser_seq());
		int n = service.CommentInsert(fDto);
		if(loginDto != null && n == 1) {
			return "redirect:/freeBoardDetail.do?free_bseq=" + free_bseq;
		}
		return null;
	}
	@RequestMapping(value = "/CommentDel.do", method = RequestMethod.GET)
	public String CommetDelte(@RequestParam("comment_seq")String comment_seq) {
		log.info("FreeCommentController CommetDelte 답글삭제");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("comment_seq", comment_seq);
		int m = service.CommentDel(map);
		if(m == 1) {
			return "redirect:/freeBoardList.do";
		}else {
			return "freeBoardDetail";
		}
	}
}
