package kr.co.shop.mapper;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import kr.co.shop.dto.ProductDTO;

@Mapper
public interface ProductMapper {

	public ArrayList<ProductDTO> list(String pcode,String order);
	public String getDaeName(String code);
	public String getJungName(String code, String daecode);
	public String getSoName(String code, String daejung);
}
