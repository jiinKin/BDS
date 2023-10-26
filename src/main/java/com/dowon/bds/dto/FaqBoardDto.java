package com.dowon.bds.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

/**
 * @author 김지인
 * @since 2023.09.24 FAQ 게시판 Dto 수정
 */

@Data
@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class FaqBoardDto {

	private int faq_seq;
	private int user_seq;
	private String faq_category;
	private String faq_title;
	private String faq_content;
	private String faq_delflag;

}
