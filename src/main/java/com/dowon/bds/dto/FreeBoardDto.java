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
 * @since 2023.09.06 자유 게시판 Dto
 */

@Data
@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class FreeBoardDto {

	private int free_bseq;
	private int user_seq;
	private String free_title;
	private String free_content;
	private Date free_regdate;
	private String free_delflag;
	private String user_name;
}
