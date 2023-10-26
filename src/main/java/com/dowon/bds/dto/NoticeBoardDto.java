package com.dowon.bds.dto;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

/**
 * @author 박하은
 * @since 2023.09.06 공지사항 게시판 Dto
 */

@Data
@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class NoticeBoardDto {

	private int notice_bseq;
	private int user_seq;
	private String notice_title;
	private String notice_content;
	private Date notice_regdate;
	private String notice_delflag;
	private String user_name;

}
