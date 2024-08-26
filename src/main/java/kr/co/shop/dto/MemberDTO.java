package kr.co.shop.dto;

import lombok.Data;

@Data
public class MemberDTO {

	private String userid,pwd,email,phone,writeday,name;
	private int id, juk, state;
}
