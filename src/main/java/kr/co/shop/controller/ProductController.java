package kr.co.shop.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import jakarta.servlet.http.HttpServletRequest;
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
	public String content(HttpServletRequest request, Model model) {
		return service.content(request,model);
	}

}
