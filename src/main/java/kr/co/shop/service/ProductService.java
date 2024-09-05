package kr.co.shop.service;

import java.util.ArrayList;

import org.springframework.ui.Model;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.co.shop.dto.BaesongDTO;
import kr.co.shop.dto.GumaeDTO;
import kr.co.shop.dto.ProductDTO;

public interface ProductService {
	public String list(HttpServletRequest request, Model model);
	public String content(HttpServletRequest request, Model model,HttpSession session);
	public String jjimOk(HttpServletRequest request, HttpSession session, HttpServletResponse response);
	public String jjimChk(HttpServletRequest request,HttpSession session);
	public String addCart(HttpServletRequest request, HttpSession session, HttpServletResponse response);
	public String gumae(HttpSession session, HttpServletRequest request,Model model,HttpServletResponse response);
	public String jusoWriteOk(BaesongDTO bdto, Model model,HttpSession session);
	public String jusoList(HttpSession session, Model model);
	public int chgPhone(HttpServletRequest request, HttpSession session);
	public String jusoDel(HttpServletRequest request);
	public String jusoUpdate(HttpServletRequest request, Model model);
	public String jusoUpdateOk(BaesongDTO bdto, HttpSession session);
	public String gumaeOk(GumaeDTO gdto,HttpSession session);
	public String gumaeView(HttpServletRequest request);
}
