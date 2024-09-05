package kr.co.shop.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.co.shop.dto.BaesongDTO;
import kr.co.shop.dto.GumaeDTO;
import kr.co.shop.dto.ProductDTO;
import kr.co.shop.service.ProductService;

@Controller
@Qualifier("ps")
public class ProductController {

	@Autowired
	private ProductService service;
	
	@RequestMapping("/product/productList")
	public String list(HttpServletRequest request, Model model) {
		return service.list(request,model);
	}
	
	@RequestMapping("/product/productContent")
	public String content(HttpServletRequest request, Model model,
			HttpSession session) {
		return service.content(request,model,session);
	}
	
	@RequestMapping("/product/jjimOk")
	public @ResponseBody String jjimOk(HttpServletRequest request, HttpSession session, HttpServletResponse response) {
		return service.jjimOk(request,session,response);
	}
	
	@RequestMapping("/product/jjimChk")
	public @ResponseBody String jjimChk(HttpServletRequest request,HttpSession session) {
		return service.jjimChk(request,session);
	}
	
	@RequestMapping("/product/addCart")
	public @ResponseBody String addCart(HttpServletRequest request, HttpSession session,
			HttpServletResponse response) {
		return service.addCart(request,session,response);
	}
	
	@RequestMapping("/product/gumae")
	public String gumae(HttpSession session, HttpServletRequest request,Model model, HttpServletResponse response) {
		return service.gumae(session,request,model,response);
	}
	
	@RequestMapping("/product/jusoWrite")
	public String jusoWrite() {
		return "/product/jusoWrite";
	}
	
	@RequestMapping("/product/jusoWriteOk")
	public String jusoWriteOk(BaesongDTO bdto,Model model,HttpSession session) {
		return service.jusoWriteOk(bdto,model,session);
	}
	
	@RequestMapping("/product/jusoList")
	public String jusoList(HttpSession session, Model model) {
		return service.jusoList(session,model);
	}
	
	@RequestMapping("/product/chgPhone")
	public @ResponseBody int chgPhone(HttpServletRequest request,HttpSession session) {
		return service.chgPhone(request,session);
	}
	
	@RequestMapping("/product/jusoDel")
	public String jusoDel(HttpServletRequest request) {
		return service.jusoDel(request);
	}
	
	@RequestMapping("/product/jusoUpdate")
	public String jusoUpdate(HttpServletRequest request, Model model) {
		return service.jusoUpdate(request,model);
	}
	
	@RequestMapping("/product/jusoUpdateOk")
	public String jusoUpdateOk(BaesongDTO bdto, HttpSession session) {
		return service.jusoUpdateOk(bdto,session);
	}
	
	@RequestMapping("/product/gumaeOk")
	public String gumaeOk(GumaeDTO gdto,HttpSession session) {
		return service.gumaeOk(gdto,session);
	}
	
	@RequestMapping("/product/gumaeView")
	public String gumaeView(HttpServletRequest request, Model model) {
		return service.gumaeView(request,model);
	}

}
