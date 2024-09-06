package kr.co.shop.service;

import java.util.ArrayList;

import org.springframework.ui.Model;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
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
	public String cartNum(HttpServletRequest request, HttpSession session);
	public String gumaeAll(Model model);
}
