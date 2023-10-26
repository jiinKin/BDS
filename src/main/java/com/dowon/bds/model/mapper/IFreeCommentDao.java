package com.dowon.bds.model.mapper;

import java.util.List;
import java.util.Map;

import com.dowon.bds.dto.FreeCommentDto;
/**
 * 
 * @author 김수엽
 * @since 2023.09.24
 * 자유게시판 답글관련 Dao
 *
 */
public interface IFreeCommentDao {
	// 답글작성
	public int CommentInsert(FreeCommentDto fDto);
	
	// 해당게시글의 답글조회
	public List<FreeCommentDto> CommentAllList(int free_bseq);
	
	// 답글 삭제
	public int CommentDel(Map<String, Object>map);
}
