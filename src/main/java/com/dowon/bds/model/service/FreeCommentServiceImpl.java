package com.dowon.bds.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dowon.bds.dto.FreeCommentDto;
import com.dowon.bds.model.mapper.IFreeCommentDao;

import lombok.extern.slf4j.Slf4j;
/**
 * 
 * @author 김수엽
 * @since 2023.09.24
 * 자유게시판 답글관련 ServiceImpl 
 *
 */
@Service
@Slf4j
public class FreeCommentServiceImpl implements IFreeCommentService {

	@Autowired
	private IFreeCommentDao dao;
	
	@Override
	public int CommentInsert(FreeCommentDto fDto) {
		log.info("FreeCommentServiceImpl CommentInsert 자유게시판 답글 작성");
		return dao.CommentInsert(fDto);
	}

	@Override
	public List<FreeCommentDto> CommentAllList(int free_bseq) {
		log.info("FreeCommentServiceImpl CommentAllList 해당게시글의 답글 조회");
		return dao.CommentAllList(free_bseq);
	}

	@Override
	public int CommentDel(Map<String, Object> map) {
		log.info("FreeCommentServiceImpl CommentDel 답글 삭제");
		return dao.CommentDel(map);
	}

}
