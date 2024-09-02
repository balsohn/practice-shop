package kr.co.shop.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import kr.co.shop.dto.CateDTO;
import kr.co.shop.dto.DaeDTO;
import kr.co.shop.dto.JungDTO;
import kr.co.shop.dto.SoDTO;
import kr.co.shop.service.MainService;

@Controller
public class MainController {

	@Autowired
	@Qualifier("ms")
	private MainService service;
	
	@RequestMapping("/")
	public String home() {
		return "redirect:/main/index";
	}
	
	@RequestMapping("/main/index")
	public String index() {
		return service.index();
	}
	
	
	@RequestMapping("/main/getDae")
	public @ResponseBody ArrayList<DaeDTO> getDae() {
		return service.getDae();
	}
	
	@RequestMapping("/main/getJung")
	public @ResponseBody ArrayList<JungDTO> getJung() {
		return service.getJung();
	}
	
	@RequestMapping("/main/getSo")
	public @ResponseBody ArrayList<SoDTO> getSo() {
		return service.getSo();
	}
	
	@RequestMapping("/main/daejungso")
	public @ResponseBody ArrayList<CateDTO> daejungso(){
		return service.getCate();
	}
	
	@RequestMapping("/main/cartNum")
	public @ResponseBody String cartNum(HttpServletRequest request, HttpSession session) {
		return service.cartNum(request,session);
	}

}
