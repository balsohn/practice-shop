package kr.co.shop.service;

import java.util.ArrayList;

import jakarta.servlet.http.HttpServletRequest;
import kr.co.shop.dto.CateDTO;
import kr.co.shop.dto.DaeDTO;
import kr.co.shop.dto.JungDTO;
import kr.co.shop.dto.SoDTO;

public interface MainService {
	public String index();
	public ArrayList<DaeDTO> getDae();
	public ArrayList<CateDTO> getCate();
	public ArrayList<JungDTO> getJung();
	public ArrayList<SoDTO> getSo();
}
