package kr.co.shop.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.context.annotation.RequestScope;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.co.shop.service.LoginService;

@Controller
public class LoginController {

	@Autowired
	@Qualifier("ls")
	private LoginService service;
	
	@RequestMapping("login/login")
	public String login(HttpSession session) {
		return service.login(session);
	}
	
	@RequestMapping("/login/loginOk")
	public String loginOk(String userid, String pwd, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		return service.loginOk(userid, pwd, session, request, response);
	}
	
	@RequestMapping("/login/logout")
	public String logout(HttpSession session) {
		return service.logout(session);
	}
}
