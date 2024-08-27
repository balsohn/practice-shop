package kr.co.shop.service;

import java.util.ArrayList;

import org.springframework.ui.Model;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.co.shop.dto.ProductDTO;

public interface ProductService {
	public String list(HttpServletRequest request, Model model);

	public String content(HttpServletRequest request, Model model,HttpSession session);

	public String jjimOk(HttpServletRequest request, HttpSession session, HttpServletResponse response);

	public String jjimChk(HttpServletRequest request,HttpSession session);

	public String addCart(HttpServletRequest request, HttpSession session);
}
