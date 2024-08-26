package kr.co.shop.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import jakarta.servlet.http.HttpSession;
import kr.co.shop.mapper.LoginMapper;

@Service
@Qualifier("ls")
public class LoginServiceImpl implements LoginService {

	@Autowired
	private LoginMapper mapper;

	@Override
	public String loginOk(String userid,String pwd,HttpSession session) {
		int chk=mapper.loginOk(userid, pwd);
		if(chk==1) {
			session.setAttribute("userid", userid);
			return "redirect:../main/index";
		} else {
			return "redirect:/login/login?err=1";
		}
	}

	@Override
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:../main/index";
	}

	@Override
	public String login(HttpSession session) {
		if(session.getAttribute("userid")!=null) {
			return "redirect:../main/index";
		} else {
			return "/login/login";
		}
	}
}
