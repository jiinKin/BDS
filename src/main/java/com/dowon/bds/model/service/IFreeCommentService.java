package com.dowon.bds.model.service;

import java.util.List;
import java.util.Map;

import com.dowon.bds.dto.FreeCommentDto;
/**
 * 
 * @author 김수엽
 * @since 2023.09.24
 * 자유게시판 관련 ServiceImpl
 *
 */
public interface IFreeCommentService {

	public int CommentInsert(FreeCommentDto fDto);
	public List<FreeCommentDto> CommentAllList(int free_bseq);
	public int CommentDel(Map<String, Object>map);
}
