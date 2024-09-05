package kr.co.shop.dto;

import lombok.Data;

@Data
public class GumaeDTO {

	private int id,baeId,su,useJuk, chongPrice, sudan;
	private int card,halbu,bank,lcard,tong,nbank;
	private int state,isReview;
	private String userid,pcode,jumuncode,writeday;
	
	private int[] sues;
	private String[] pcodes;
}
