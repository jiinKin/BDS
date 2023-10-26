package com.dowon.bds.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Data
@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor

/**
 * @author 김수엽
 * @since 2023.09.13 성별 통계를 위한 Dto
 */
public class GenderDto {

	private String user_gender;
	private String loan_percent;
	private String book_img;
	private int loan_count;
	private int book_seq;
	private String book_title;
	private String percent;
	private String book_intro;
}
