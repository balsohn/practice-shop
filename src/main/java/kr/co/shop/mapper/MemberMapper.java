package kr.co.shop.mapper;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

import kr.co.shop.dto.MemberDTO;
import kr.co.shop.dto.ProductDTO;

@Mapper
public interface MemberMapper {
	public String useridChk(String userid);
	public void memberOk(MemberDTO mdto);
	public HashMap getProduct(String pcode);
	public ArrayList<HashMap> cartView(String userid);
}
