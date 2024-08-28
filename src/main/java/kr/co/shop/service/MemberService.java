package kr.co.shop.service;

import java.util.ArrayList;

import org.springframework.ui.Model;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import kr.co.shop.dto.DaeDTO;
import kr.co.shop.dto.MemberDTO;

public interface MemberService {
	public String useridChk(String userid);
	public String memberOk(MemberDTO mdto);
	public String member(HttpSession session);
	public String cartView(HttpSession session, HttpServletRequest request, Model model);
	
}
