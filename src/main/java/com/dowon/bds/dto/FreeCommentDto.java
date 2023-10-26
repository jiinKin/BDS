package com.dowon.bds.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

/**
 * @author 박하은
 * @since 2023.09.06 자유 게시판 답글을 위한 Dto
 */

@Data
@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class FreeCommentDto {

	private int comment_seq;
	private int free_bseq;
	private int user_seq;
	private String comment_content;
	private String comment_regdate;
	private String comment_delflag;
	private String user_name;
}
