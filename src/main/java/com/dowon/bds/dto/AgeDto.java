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
 * @since 2023.09.13 연령별통계를 위한 Dto
 */
public class AgeDto {

	private int book_seq;
	private String book_title;
	private String age_group;
	private String percent;
	
}
