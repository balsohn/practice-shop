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
		
		if(session.getAttribute("userid")==null) {
			Cookie code=WebUtils.getCookie(request, "pcode");
			if(code!=null) {
				String[] codes=code.getValue().split("/");
				int index=codes[0].indexOf("-");
				ArrayList<HashMap> pMapAll=new ArrayList<>();
				for(int i=0;i<codes.length;i++) {
					String pcode=codes[i].substring(0,index);
					int su=Integer.parseInt(codes[i].substring(index+1));
					HashMap product=mapper.getProduct(pcode);
					product.put("su", su);
					pMapAll.add(product);
				}
				
				model.addAttribute("pMapAll",pMapAll);
			}
		} else {
			String userid=session.getAttribute("userid").toString();
			ArrayList<HashMap> cartData=mapper.cartView(userid);
			System.out.println(cartData.get(0).get("cart_su").getClass());
			model.addAttribute("pMapAll",cartData);
		}
		return "/member/cartView";
	}
}
