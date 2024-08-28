package kr.co.shop.service;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public interface LoginService {
	public String login(HttpSession session);
	public String loginOk(String userid, String pwd,HttpSession session, HttpServletRequest request, HttpServletResponse response);
	public String logout(HttpSession session);
	
}
