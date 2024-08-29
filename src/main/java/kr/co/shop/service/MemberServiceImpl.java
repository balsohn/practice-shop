package kr.co.shop.service;

import java.time.LocalDate;
import java.time.format.TextStyle;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Locale;

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
					HashMap product=mapper.getProduct(pcode);
					product.put("su", su);
					
					pMapAll.add(product);
					
				}
			}
		} else {
			String userid=session.getAttribute("userid").toString();
			pMapAll=mapper.cartView(userid);
		}
		
		if(pMapAll!=null) {
			for(int i=0;i<pMapAll.size();i++) {
				HashMap map=pMapAll.get(i);
				
				LocalDate today=LocalDate.now();
				int baeday=Integer.parseInt(map.get("baeday").toString());
				LocalDate xday=today.plusDays(baeday);
				String yoil=xday.getDayOfWeek().getDisplayName(TextStyle.SHORT, Locale.KOREAN);
				String baeEx=null;
				if(baeday==1) {
					baeEx="내일("+yoil+") 도착예정";
				} else if(baeday==2) {
					baeEx="모레("+yoil+") 도착예정";
				} else {
					int m=xday.getMonthValue();
					int d=xday.getDayOfMonth();
					baeEx=m+"/"+d+"("+yoil+") 도착예정";
				}
				// ArrayList<HashMap>에 baeEx넣어주기
				map.put("baeEx", baeEx);
				
				// 2. 상품금액(할인율이 적용된 금액)
				int price=Integer.parseInt(map.get("price").toString());
				int halin=Integer.parseInt(map.get("halin").toString());
				int su=Integer.parseInt(map.get("cart_su").toString());
				int halinprice=(int)( price-(price*halin/100.0) )*su;
			    map.put("halinprice", halinprice);
			    
				// 3. 적립금
				int juk=Integer.parseInt(map.get("juk").toString());
				int jukprice=(int)(price*juk/100.0)*su;
				map.put("jukprice", jukprice);
				
			}
		}
		
		model.addAttribute("pMapAll",pMapAll);
		return "/member/cartView";
	}
}
