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
 * @since 2023.09.06 게시판 파일업로드를 위한 Dto
 */

@Data
@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class FileBoardDto {

	private int file_seq;
	private String board_type;
	private int board_seq;
	private String origin_fname;
	private String stored_fname;
	private Date file_regdate;
	private String file_delflag;

}
