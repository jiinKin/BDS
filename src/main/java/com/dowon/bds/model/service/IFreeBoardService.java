package com.dowon.bds.model.service;

import java.util.List;
import java.util.Map;

import com.dowon.bds.dto.FreeBoardDto;
/**
 * 
 * @author 김수엽
 * @since 2023.09.24
 * 자유게시판 관련 Service
 *
 */
public interface IFreeBoardService {

	public List<FreeBoardDto> freeBoardList();
	public int freeBoardInsert(FreeBoardDto dto);
	public FreeBoardDto freeBoardDetail(int free_bseq);
	public int freeBoardDel(Map<String, Object>map);
	public int updateBoard(Map<String, Object>map);
	public int FreeBoardCount();
	public List<FreeBoardDto> FreeBoardCountList(Map<String, Object>map);
}
