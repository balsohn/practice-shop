package kr.co.shop.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.web.util.WebUtils;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import kr.co.shop.dto.CateDTO;
import kr.co.shop.dto.DaeDTO;
import kr.co.shop.dto.JungDTO;
import kr.co.shop.dto.SoDTO;
import kr.co.shop.mapper.MainMapper;

@Service
@Qualifier("ms")
public class MainServiceImpl implements MainService {

	@Autowired
	private MainMapper mapper;
	
	@Override
	public String index() {
		return "/main/index";
	}

	@Override
	public ArrayList<DaeDTO> getDae() {
		return mapper.getDae();
	}

	@Override
	public ArrayList<CateDTO> getCate() {
		return mapper.getCate();
	}

	@Override
	public ArrayList<JungDTO> getJung() {
		return mapper.getJung();
	}

	@Override
	public ArrayList<SoDTO> getSo() {
		return mapper.getSo();
	}

	@Override
	public String cartNum(HttpServletRequest request, HttpSession session) {
		
		if(session.getAttribute("userid")==null) {
			Cookie cookie=WebUtils.getCookie(request, "pcode");
			
			if(cookie!=null && !cookie.getValue().isEmpty()) {
				String[] pcodes=cookie.getValue().split("/");
				return pcodes.length+"";				
			} else {
				return "0";
			}
			
		} else {
			String userid=session.getAttribute("userid").toString();
			return mapper.cartNum(userid);
		}
	}
	
	

}
