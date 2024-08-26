package kr.co.shop.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import jakarta.servlet.http.HttpServletRequest;
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
}
