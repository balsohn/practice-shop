package kr.co.shop.mapper;

import org.apache.ibatis.annotations.Mapper;

import kr.co.shop.dto.MemberDTO;

@Mapper
public interface MemberMapper {
	public String useridChk(String userid);
	public void memberOk(MemberDTO mdto);
}
