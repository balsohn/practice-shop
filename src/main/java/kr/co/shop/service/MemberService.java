package kr.co.shop.service;

import java.util.ArrayList;

import org.springframework.ui.Model;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.co.shop.dto.DaeDTO;
import kr.co.shop.dto.MemberDTO;
import kr.co.shop.dto.ReviewDTO;

public interface MemberService {
	public String useridChk(String userid);
	public String memberOk(MemberDTO mdto);
	public String member(HttpSession session);
	public String cartView(HttpSession session, HttpServletRequest request, Model model);
	public String cartDel(HttpServletRequest request, HttpSession session, HttpServletResponse response);
	public int[] chgSu(HttpServletRequest request,HttpSession session,HttpServletResponse response);
	public String jjimList(HttpSession session,Model model);
	public String addCart(HttpServletRequest request, HttpSession session);
	public String jjimDel(HttpServletRequest request, HttpSession session);
	public String jumunList(HttpSession session, Model model, HttpServletResponse response);
	public String chgState(HttpServletRequest request);
	public String reviewWrite(HttpServletRequest request, HttpSession session, Model model);
	public String reviewOk(ReviewDTO rdto, HttpSession session,HttpServletRequest request);
	
}
