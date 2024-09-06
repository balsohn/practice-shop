package kr.co.shop.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.co.shop.dto.MemberDTO;
import kr.co.shop.service.MemberService;

@Controller
public class MemberController {

	@Autowired
	@Qualifier("ms2")
	private MemberService service;
	
	@RequestMapping("/member/member")
	public String member(HttpSession session) {
		return service.member(session);
	}
	
	@RequestMapping("/member/useridChk")
	public @ResponseBody String useridChk(HttpServletRequest request) {
		String userid=request.getParameter("userid");
		return service.useridChk(userid);
	}
	
	@RequestMapping("/member/memberOk")
	public String memberOk(MemberDTO mdto) {
		return service.memberOk(mdto);
	}
	
	@RequestMapping("/member/cartView")
	public String cartView(HttpSession session, HttpServletRequest request,
			Model model) {
		return service.cartView(session, request, model);
	}
	
	@RequestMapping("/member/cartDel")
	public String cartDel(HttpServletRequest request, HttpSession session,
			HttpServletResponse response) {
		return service.cartDel(request, session, response);
	}
	
	@RequestMapping("/member/chgSu")
	public @ResponseBody int[] chgSu(HttpServletRequest request, HttpSession session, HttpServletResponse response) {
		return service.chgSu(request,session,response);
	}
	
	@RequestMapping("/member/jjimList")
	public String jjimList(HttpSession session,Model model) {
		return service.jjimList(session,model);
	}
	
	@RequestMapping("/member/addCart")
	public @ResponseBody String addCart(HttpServletRequest request, HttpSession session) {
		return service.addCart(request,session);
	}
	
	@RequestMapping("/member/jjimDel")
	public String jjimDel(HttpServletRequest request, HttpSession session) {
		return service.jjimDel(request,session);
	}
	
	@RequestMapping("/member/jumunList")
	public String jumunList(HttpSession session,Model model,HttpServletResponse response) {
		return service.jumunList(session ,model, response);
	}
	
	@RequestMapping("/member/chgState")
	public String chgState(HttpServletRequest request) {
		return service.chgState(request);
	}
}
