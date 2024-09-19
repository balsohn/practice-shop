package kr.co.shop.mapper;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

import kr.co.shop.dto.BaesongDTO;
import kr.co.shop.dto.GumaeDTO;
import kr.co.shop.dto.MemberDTO;
import kr.co.shop.dto.ProQnaDTO;
import kr.co.shop.dto.ProductDTO;
import kr.co.shop.dto.ReviewDTO;

@Mapper
public interface ProductMapper {

	public ArrayList<ProductDTO> list(String pcode,String order, int index);
	public String getDaeName(String code);
	public String getJungName(String code, String daecode);
	public String getSoName(String code, String daejung);
	public int getChong(String pcode);
	public ProductDTO content(String pcode);
	public void jjimOk(String pcode, String userid);
	public void jjimDel(String pcode, String userid);
	public int jjimChk(String pcode, String userid);
	public void addCart(String pcode, String userid, int su);
	public boolean isCart(String pcode, String userid);
	public void upCart(String pcode, String userid, int su);
	public String getCartNum(String userid);
	public MemberDTO getMember(String userid);
	public BaesongDTO getBaesong(String userid);
	public void jusoWriteOk(BaesongDTO bdto);
	public ArrayList<BaesongDTO> jusoList(String userid);
	public void gibonInit(String userid);
	public int getJuk(String userid);
	public void chgPhone(String userid,String phone);
	public void jusoDel(String id);
	public BaesongDTO jusoUpdate(String id);
	public void jusoUpdateOk(BaesongDTO bdto);
	public int getBaeId(String userid);
	public int getJumuncode(String jumuncode);
	public void gumaeOk(GumaeDTO gdto);
	public void useJuk(String userid, int useJuk);
	public void cartDel(String userid,String pcode);
	public void suUp(String pcode,int su);
	public ArrayList<GumaeDTO> gumaeView(String jumuncode);
	public ArrayList<HashMap> gumaeView2(String jumuncode);
	public double getStar(String pcode);
	public ArrayList<ReviewDTO> reviewlist(String pcode);
	public void reviewDel(String id);
	public int getRef(String pcode);
	public void questWriteOk(String pcode,String userid, String content, int ref);
	public ArrayList<ProQnaDTO> questAll(String pcode);
	
}
