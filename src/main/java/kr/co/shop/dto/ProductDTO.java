package kr.co.shop.dto;

import lombok.Data;

@Data
public class ProductDTO {
	private String pcode,pimg,dimg,title,writeday;
	private int id, price, halin, su, baeprice, baeday, juk, pansu, review;
	private double star;
	
	private String baeEx;
	private int halinPrice, jukPrice;
	
	private int ystar,gstar,hstar;
	
	// 타임세일 관련
	private int sales;
	private String salesDay;
}
