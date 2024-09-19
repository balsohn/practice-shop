package kr.co.shop.dto;

import lombok.Data;

@Data
public class ReviewDTO {

	private int id,star;
	private String content, oneLine, userid,pcode,writeday;
	
	private String user;
}
