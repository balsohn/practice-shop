package kr.co.shop.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import jakarta.servlet.http.HttpServletRequest;
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
	
	

}
