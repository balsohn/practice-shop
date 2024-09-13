package kr.co.shop.dto;

import lombok.Data;

@Data
public class ProQnaDTO {

	private int id,qna,ref;
	private String userid,pcode,content,writeday;
	
	// 상품명 저장
	private String title;
}
