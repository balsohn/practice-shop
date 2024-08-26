package kr.co.shop.service;

import jakarta.servlet.http.HttpSession;

public interface LoginService {
	public String login(HttpSession session);
	public String loginOk(String userid, String pwd,HttpSession session);
	public String logout(HttpSession session);
}
