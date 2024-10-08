package kr.co.shop.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.web.util.WebUtils;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.HttpSessionEvent;
import kr.co.shop.mapper.LoginMapper;
import kr.co.shop.mapper.ProductMapper;

@Service
@Qualifier("ls")
public class LoginServiceImpl implements LoginService {

	@Autowired
	private LoginMapper mapper;
	
	@Autowired
	private ProductMapper proMapper;

	@Override
	public String loginOk(String userid,String pwd,HttpSession session, 
			HttpServletRequest request, HttpServletResponse response, ServletContext application) {
		
		int chk=mapper.loginOk(userid, pwd);
		if(chk==1) {
			session.setAttribute("userid", userid);
			
			Cookie cookie=WebUtils.getCookie(request, "url");
			Cookie code=WebUtils.getCookie(request, "pcode");
			String oriURL=(cookie==null)?null:cookie.getValue();
			String[] codes=(code==null)?null:code.getValue().split("/");
			
			String names=application.getAttribute("names").toString();
			
			application.setAttribute("names", names+userid+"/");
			names=application.getAttribute("names").toString();
			System.out.println(application.getAttribute("names").toString());
			String[] users=names.split("/");
			application.setAttribute("users", users.length);
			System.out.println(users.length);
			if(cookie!=null) {
				cookie.setMaxAge(0);
				cookie.setPath("/");
				response.addCookie(cookie);
			}
			
			if(code!=null) {
				int index=codes[0].indexOf("-");
				
				for(int i=0;i<codes.length;i++) {
					String pcode=codes[i].substring(0,index);
					int su=Integer.parseInt(codes[i].substring(index+1));
					if(proMapper.isCart(pcode, userid)) {
						proMapper.upCart(pcode, userid, su);
					} else {
						proMapper.addCart(pcode, userid, su);						
					}
				}
				
				code.setMaxAge(0);
				code.setPath("/");
				response.addCookie(code);
			}
			
			
			if(oriURL==null) {
				return "redirect:../main/index";
			} else {
				return "redirect:"+oriURL;
			}			
		} else {
			return "redirect:/login/login?err=1";
		}	
	}

	@Override
	public String logout(HttpSession session) {
		ServletContext application = session.getServletContext();
		String userid=session.getAttribute("userid").toString();
		String names=application.getAttribute("names").toString().replace(userid+"/", "");
		application.setAttribute("names", names);
		String[] users=names.split("/");
		application.setAttribute("users", users.length);
		
		
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
