package kr.co.shop.mapper;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import kr.co.shop.dto.ProductDTO;

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
}
