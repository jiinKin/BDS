package com.dowon.bds.dto;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

/**
 * @author 김지인
 * @since 2023.09.14  payImd 컬럼타입 수정
 * 
 * @author 김지인
 * @since 2023.09.20  마일리지및 누적 마일리지
 */

@Data
@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class PayDto {

	private int paySeq;  // 결제 고유번호
	private String payImd;  // 결제번호
	private int user_seq; // 회원 고유번호
	private int payPayment; // 결제금액
	private Date payDate; // 결제시간
	private int payPoint; // 결제금액 1% 마일리지 적립
	private int paySumpoint; // 회원 마일리지 총합
	

	
}
