package kr.co.shop.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.web.util.WebUtils;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.co.shop.mapper.LoginMapper;
import kr.co.shop.mapper.ProductMapper;

@Service
@Qualifier("ls")
public class LoginServiceImpl implements LoginService {

	@Autowired
	private LoginMapper mapper;
	
	@Autowired
	private ProductMapper pMapper;

	@Override
	public String loginOk(String userid,String pwd,HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		int chk=mapper.loginOk(userid, pwd);
		if(chk==1) {
			session.setAttribute("userid", userid);
			
			Cookie cookie=WebUtils.getCookie(request, "url");
			Cookie code=WebUtils.getCookie(request, "pcode");
			String oriURL=cookie==null?null:cookie.getValue();
			String[] codes=code==null?null:code.getValue().split("/");
			if(cookie!=null) {
				cookie=new Cookie("url", "");
				cookie.setMaxAge(0);
				cookie.setPath("/");
				response.addCookie(cookie);
			}
			
			if(code!=null) {
				String[] pcode =new String[codes.length];
				String[] su =new String[codes.length];
				int index=codes[0].indexOf("-");
				
				for(int i=0;i<codes.length;i++) {
					pcode[i]=codes[i].substring(0,index);
					su[i]=codes[i].substring(index+1);
					if(pMapper.isCart(pcode[i], session.getAttribute("userid").toString())) {
						pMapper.upCart(pcode[i], session.getAttribute("userid").toString(), Integer.parseInt(su[i]));
					} else {
						pMapper.addCart(pcode[i], session.getAttribute("userid").toString(), Integer.parseInt(su[i]));						
					}
				}
				code=new Cookie("pcode", "");
				code.setMaxAge(0);
				code.setPath("/");
				response.addCookie(code);
			}
			
			if(oriURL==null) {
				return "redirect:../main/index";
			} else {
				return "redirect:"+oriURL;
			}
			
			
			
			/*
			if(cookie==null) {
				if(code==null) {
					return "redirect:../main/index";
				} else {
					String[] codes=code.getValue().split("/");
					String[] pcode =new String[codes.length];
					String[] su =new String[codes.length];
					int index=codes[0].indexOf("-");
					
					for(int i=0;i<codes.length;i++) {
						pcode[i]=codes[i].substring(0,index);
						su[i]=codes[i].substring(index+1);
						if(pMapper.isCart(pcode[i], session.getAttribute("userid").toString())) {
							pMapper.upCart(pcode[i], session.getAttribute("userid").toString(), Integer.parseInt(su[i]));
						} else {
							pMapper.addCart(pcode[i], session.getAttribute("userid").toString(), Integer.parseInt(su[i]));						
						}
					}
					
					code=new Cookie("pcode", "");
					code.setMaxAge(0);
					code.setPath("/");
					response.addCookie(code);
					
					return "redirect:../main/index";
				}			
			} else {
				String oriURL=cookie.getValue();
				cookie=new Cookie("url", "");
				cookie.setMaxAge(0);
				cookie.setPath("/");
				response.addCookie(cookie);
				
				return "redirect:"+oriURL;
			}	
			*/
			
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
