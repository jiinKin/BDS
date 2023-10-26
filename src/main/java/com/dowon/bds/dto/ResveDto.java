package com.dowon.bds.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

/**
 * @author 박하은
 * @since 2023.09.06 예약정보 Dto
 */

@Data
@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class ResveDto {
	

	private int resve_seq;
	private int user_seq;
	private int book_seq;
	private int resve_step;
	private String resve_status;
	
	
	
}
