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
	public void cartDel(String pcode, String userid);
	public void chgSu(String userid,String pcode,int su);
	public ArrayList<ProductDTO> jjimList(String userid);
	public void addCart(String userid, String pcode);
	public boolean isCart(String userid, String pcode);
	public void jjimDel(String userid, String pcode);
}
