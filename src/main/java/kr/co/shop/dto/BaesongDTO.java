package kr.co.shop.dto;

import lombok.Data;

@Data
public class BaesongDTO {
	private int id,gibon,req;
	private String userid,zip,juso,jusoEtc,phone,name;
	
	// 배송방법 문자처리
	private String breq;
	
	// 배송지 처음입력 or 추가입력
	private String tt;
}
