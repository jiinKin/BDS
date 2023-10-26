package com.dowon.bds.model.service;

import java.util.List;
import java.util.Map;

import com.dowon.bds.dto.BookDto;
import com.dowon.bds.dto.PagingDto;


/** 
 * @author 박하은
 * @since 2023.09.13
 * 도서 대출관련 메소드를 정의한 Service Interface
 */
public interface IRentService {

	public int bookRent(Map<String, Object>map);
	
	public List<Map<String, Object>> rentCheck(int n);
	
	public List<Map<String, Object>> selectMyBookRent(int n);
	
	public List<Map<String, Object>> selectAdminRent();
	
	public List<Map<String, Object>> selectRentImpossibility();
	
	
	public int rentStatus(int n);
	
	
	public BookDto bookDetail(int n);
	
	public List<BookDto> bookAll();
	
	
	
	public List<String> selectFilteredBookSeqList();
	
	public List<String> rentStatusYBookSeq();
	
	
	
	public int userCountRent(int n);
	
	public List<Map<String, Object>> userRentPageList(Map<String, Object> map);
	
	
	public int allUserCountRent();
	
	public List<Map<String, Object>> allRentPageList(Map<String, Object>map);
	
}
