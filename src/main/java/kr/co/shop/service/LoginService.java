package kr.co.shop.service;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.HttpSessionEvent;

public interface LoginService {
	public String login(HttpSession session);
	public String loginOk(String userid, String pwd,HttpSession session, HttpServletRequest request, HttpServletResponse response, ServletContext application);
	public String logout(HttpSession session);
	
}
