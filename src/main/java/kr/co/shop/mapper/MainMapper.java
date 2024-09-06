package kr.co.shop.mapper;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

import kr.co.shop.dto.CateDTO;
import kr.co.shop.dto.DaeDTO;
import kr.co.shop.dto.JungDTO;
import kr.co.shop.dto.SoDTO;

@Mapper
public interface MainMapper {
	public ArrayList<DaeDTO> getDae();
	public ArrayList<CateDTO> getCate();
	public ArrayList<JungDTO> getJung();
	public ArrayList<SoDTO> getSo();
	public String cartNum(String userid);
	public ArrayList<HashMap> gumaeAll();
}
