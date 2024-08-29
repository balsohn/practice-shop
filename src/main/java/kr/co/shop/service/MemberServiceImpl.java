package kr.co.shop.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.util.WebUtils;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import kr.co.shop.dto.MemberDTO;
import kr.co.shop.dto.ProductDTO;
import kr.co.shop.mapper.MemberMapper;

@Service
@Qualifier("ms2")
public class MemberServiceImpl implements MemberService {

	@Autowired
	private MemberMapper mapper;

	@Override
	public String useridChk(String userid) {
		return mapper.useridChk(userid);
	}

	@Override
	public String memberOk(MemberDTO mdto) {
		mapper.memberOk(mdto);
		return "../login/login";
	}

	@Override
	public String member(HttpSession session) {
		if(session.getAttribute("userid")!=null) {
			return "redirect:../main/index";
		} else {
			return "/member/member";
		}
	}

	@Override
	public String cartView(HttpSession session, HttpServletRequest request, Model model) {
		
		ArrayList<HashMap> pMapAll=null;
		
		if(session.getAttribute("userid")==null) {
			Cookie code=WebUtils.getCookie(request, "pcode");
			System.out.println(code.getValue());
			if(code!=null) {
				String[] codes=code.getValue().split("/");
				
				// 이게 빠졌어요
				pMapAll=new ArrayList<HashMap>();
				
				for(int i=0;i<codes.length;i++) {
					String pcode=codes[i].substring(0,12);
					int su=Integer.parseInt(codes[i].substring(13));
					System.out.println(pcode);
					HashMap product=mapper.getProduct(pcode);
					product.put("su", su);
					System.out.println(product.get("title"));
					pMapAll.add(product);
					
				}
			}
		} else {
			String userid=session.getAttribute("userid").toString();
			pMapAll=mapper.cartView(userid);
		}
		
		model.addAttribute("pMapAll",pMapAll);
		return "/member/cartView";
	}
}
