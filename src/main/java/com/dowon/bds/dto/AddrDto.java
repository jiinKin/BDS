package com.dowon.bds.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

/**
 * @author 김지인
 * @since 2023.09.14 배송테이블 수정으로 배송DTO 수정
 */

@Data
@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor

public class AddrDto {

	private int delivery_seq;
	private int user_seq;
	private String delivery_name;
	private String delivery_phone;
	private String postcode;
	private String address;
	private String detaddr;
	private String extaddr;
	private int delivery_num;
	
}
