package com.dowon.bds;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.dowon.bds.dto.BookDto;
import com.dowon.bds.dto.PagingDto;
import com.dowon.bds.dto.UserDto;
import com.dowon.bds.model.service.IBookService;
import com.dowon.bds.model.service.IUserService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class AdminController {
	
	@Autowired
	private IUserService userService;
	
	@Autowired
	private IBookService bookService;
	
//	어드민페이지 이동흐름에 관련된 컨트롤러들
	
	@GetMapping(value="/userList.do")
	public String userList(Model model){
		log.info("Welcome userList로 이동");
		List<UserDto> lists = userService.getAllUser();
		model.addAttribute("getAllUsers",lists);
		return "userList";
	}
	
	//페이징처리하기
	@GetMapping(value="/bookMagagement.do")
	public String bookList(@RequestParam(name = "page", defaultValue = "1") int selectPage,Model model) {
		PagingDto pd = new PagingDto();
		
		// 총 게시물의 갯수
	    pd.setTotalCount(bookService.bookCount());

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
	    
	  //게시글 조회
	    Map<String, Object> map = new HashMap<String, Object>();
	    map.put("first", pd.getPage() * pd.getCountList() - (pd.getCountList() - 1));
	    map.put("last", pd.getPage() * pd.getCountList());
	    List<BookDto> BookList = bookService.bookCountList(map);
		model.addAttribute("getAllBooks",BookList);
		model.addAttribute("pd", pd);
		return "bookManagement";
	}
	
	@GetMapping(value="/addBook.do")
	public String addBook() {
		log.info("Welcome addBook으로 이동");
		return "addBook";
	}
	
}
