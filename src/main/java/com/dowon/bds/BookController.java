package com.dowon.bds;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dowon.bds.dto.BookDto;
import com.dowon.bds.dto.NoticeBoardDto;
import com.dowon.bds.dto.PagingDto;
import com.dowon.bds.dto.UserDto;
import com.dowon.bds.model.service.IBookService;
import com.dowon.bds.model.service.IRentService;
import com.dowon.bds.model.service.IResveService;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.extern.slf4j.Slf4j;

/**
 * 
 * @author 김영진
 * @since 2023-09-18 도서관리(등록,검색)을 위한 컨트롤러
 */

@Controller
@Slf4j
public class BookController {
	
	@Autowired
	public IBookService service;
	
	//2023.09.18 박하은- 도서 상세페이지에서 대출/예약 기능을 위한 서비스 메소드 선언
	@Autowired
	private IRentService rentService;
	
	@Autowired
	private IResveService resveService;

	@GetMapping(value="/userBookList.do")
	public String userBookList(@RequestParam(name = "page", defaultValue = "1") int selectPage,Model model){
		log.info("사용자 userBookList 모든책정보 가져오기");
		
		PagingDto pd = new PagingDto();
		
		// 총 게시물의 갯수
	    pd.setTotalCount(service.bookCount());

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
	    
	    List<BookDto> userBookList = service.bookCountList(map);
//		List<BookDto> userBookList = service.getAllBook();
		model.addAttribute("pd", pd);
		model.addAttribute("userBookList",userBookList);
		return "userBookList";
	}
	
	//도서상세보기
	/** 
	 * @author 박하은
	 * @since 2023.09.20
	 * 도서 상세페이지에 대출/예약관련 기능 메소드 추가
	 */
	@RequestMapping(value="/getDetailBook.do", method = RequestMethod.GET)
	public String detailBook(@RequestParam("book_seq")int seq, Model model, HttpSession session) {
		log.info("Welcome BookController detailBook 도서 상세페이지 컨트롤러");
		log.info("Welcome BookController detailBook book_seq확인 : {}",seq);
		BookDto dto = service.detailBook(seq);
		UserDto loginDto = (UserDto) session.getAttribute("loginDto");
		
		if (loginDto == null) {

		} else {
			int userSeq = loginDto.getUser_seq();
			
			List<Map<String, Object>> rentData = rentService.rentCheck(userSeq);
			List<Map<String, Object>> resveData = resveService.userResveStatus(userSeq);
			
			model.addAttribute("loginDto", loginDto);
			model.addAttribute("rentData", rentData);
			model.addAttribute("resveData", resveData);
		}
		List<String> filteredBookSeqList = rentService.selectFilteredBookSeqList();
		List<String> rentYBookSeqList = rentService.rentStatusYBookSeq();
		model.addAttribute("filteredBookSeqList", filteredBookSeqList);
		model.addAttribute("rentYBookSeqList", rentYBookSeqList);
		
		model.addAttribute("detailBook",dto);
		return "detailBook";
		
	}
	
	//어드민도서상세보기
	@GetMapping(value="/getAdminDetailBook.do")
	public String adminDetailBook(@RequestParam("book_seq")int seq, Model model) {
		log.info("Welcome BookController adminDetailBook 어드민 도서 상세페이지");
		BookDto dto = service.detailBook(seq);
		model.addAttribute("detailBook",dto);
		return "adminDetailBook";
	}
	


	//도서등록컨트롤러(GET)
	@GetMapping(value="/registBook.do")
	public String registbookForm(@RequestParam("data")String jsonBookData, Model model) throws JsonMappingException, JsonProcessingException, ParseException {
			log.info("Welcome registbookForm를 통해 JSON으로 값 전달 받고 등록상세에 데이터 전달");
			log.info("jsonBookData: {}", jsonBookData); // 추가: JSON 데이터 확인
			ObjectMapper objectMapper = new ObjectMapper();
			BookDto	bookInfo = objectMapper.readValue(jsonBookData, BookDto.class);
			
			//ISBN 13자리만 가져오기
			String[] isbn = bookInfo.getBook_isbn().split(" ");
			String realIsbn = isbn[isbn.length-1];
			
			bookInfo.setBook_isbn(realIsbn);
			model.addAttribute("registBook",bookInfo);
		return "registBook";
	}
	
	@PostMapping(value = "/registbutton.do")
	public String registBook(@ModelAttribute BookDto dto, Model model) {
		
		try {
	        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
	        Date parsedDate = dateFormat.parse(dto.getBook_published_dateStr()); // 이 때, dto에서 book_published_dateStr 필드를 추가해주세요.
	        dto.setBook_published_date(parsedDate);
	    } catch (ParseException e) {
	        e.printStackTrace();
	    }

	    int n = service.registBook(dto);
	    if(n==1) {
	    	log.info("Welcome registBook 도서 등록 성공");
	    	model.addAttribute("resultAddBook", "도서 등록 성공!");
	    	return "adminPage";
	    }else {
	    	log.info("Welcome registBook 도서 등록 실패");
	    	model.addAttribute("resultAddBook", "도서 등록 실패ㅜㅜ");
	    	return "addBook";
	    }
	}
	
	//도서 검색 컨트롤러
	@GetMapping(value="/searchBooks.do")
	public String searchBooks(@RequestParam("keyword")String keyword, @RequestParam(name = "page", defaultValue = "1") int selectPage, Model model){
		
		PagingDto pd = new PagingDto();
		
		// 총 게시물의 갯수
	    pd.setTotalCount(service.searchBookCount(keyword));
	    
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
	    map.put("book_title", keyword);
	    map.put("book_writer", keyword);
	    map.put("first", pd.getPage() * pd.getCountList() - (pd.getCountList() - 1));
	    map.put("last", pd.getPage() * pd.getCountList());
		
//		List<BookDto> lists = service.searchBooks(keyword);
	    List<BookDto> lists = service.searchBookList(map);
		log.info("map 값 확인하기 (도서검색결과 페이징 쿼리 :{}",map);
		model.addAttribute("pd", pd);
		model.addAttribute("searchResults",lists);
		model.addAttribute("keyword",keyword);
		log.info("값체킄ㅋㅋㅋㅋㅋㅋㅋㅋ:{}",lists);
		return "searchBooks";
	}
	
	//도서 수정 컨트롤러
	@GetMapping(value="/updateBookForm.do")
	public String updateBookForm(@RequestParam("book_seq") int book_seq, Model model) {
		log.info(" updateBookForm 도서 수정페이지 이동 ");
		log.info(" book_seq의 값 : {}",book_seq);
		BookDto bookInfo = service.detailBook(book_seq);
		model.addAttribute("updateBook",bookInfo);
		return "updateBook";
	}
	
	@PostMapping(value="/updateBook.do")
	public String updateBook(@RequestParam("book_title") String title,
            @RequestParam("book_writer") String writer,
            @RequestParam("book_isbn") String isbn,
            @RequestParam("book_publisher") String publisher,
            @RequestParam("book_intro") String intro,
            @RequestParam("book_index") String index,
            @RequestParam("book_summary") String summary,
            @RequestParam("book_seq") int book_seq
			) {
		
		log.info("FreeBoardController updateBoard 도서 수정");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("book_title", title);
		map.put("book_writer", writer);
		map.put("book_isbn", isbn);
		map.put("book_publisher", publisher);
		map.put("book_intro", intro);
		map.put("book_index", index);
		map.put("book_summary", summary);
		
		
		log.info("map값 확인 : {} ",map);
		
		int n = service.updateBook(map);
	
	    if (n == 1) {
	        return "redirect:/getAdminDetailBook.do?book_seq="+book_seq;
	    }
	    return "redirect:/updateBookForm.do";
	}
}





