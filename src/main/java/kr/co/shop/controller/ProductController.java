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
	public @ResponseBody String addCart(HttpServletRequest request, HttpSession session) {
		return service.addCart(request,session);
	}

}
