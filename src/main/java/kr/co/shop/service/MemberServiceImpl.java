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
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.co.shop.dto.MemberDTO;
import kr.co.shop.dto.ProductDTO;
import kr.co.shop.dto.ReviewDTO;
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
		return "redirect:/login/login";
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
			
			if(code!=null) {
				String[] codes=code.getValue().split("/");
				

				pMapAll=new ArrayList<HashMap>();
				
				for(int i=0;i<codes.length;i++) {
					String pcode=codes[i].substring(0,12);
					int su=Integer.parseInt(codes[i].substring(13));
					HashMap product=mapper.getProduct(pcode);
					product.put("cart_su", su);
					product.put("days", "0");
					pMapAll.add(product);					
				}
			}
		} else {
			String userid=session.getAttribute("userid").toString();
			pMapAll=mapper.cartView(userid);
		}
		
		if(pMapAll!=null) {
			
			// 1. 모든 상품의 구매금액 , 모든 상품의 적립금 , 모든 상품의 배송비
			int halinpriceTot=0, jukpriceTot=0, baepriceTot=0;
			
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

				int days=Integer.parseInt(map.get("days").toString());
				if(days<2) {
					// 2-1. 모든 상품의 구매금액을 누적
				    halinpriceTot=halinpriceTot+halinprice;
				    // 3-1 모든 상품의 적립금액을 누적
					jukpriceTot=jukpriceTot+jukprice;
					// 4 모든 상품의 배송비를 누적
					int baeprice=Integer.parseInt(map.get("baeprice").toString());
					baepriceTot=baepriceTot+baeprice;
				}
			}
			// 뷰에 모든 상품의 구매금액,적립금,배송비를 전달
			model.addAttribute("halinpriceTot",halinpriceTot);
			model.addAttribute("jukpriceTot",jukpriceTot);
			model.addAttribute("baepriceTot",baepriceTot);
		}
		
		model.addAttribute("pMapAll",pMapAll);
		return "/member/cartView";
	}

	@Override
	public String cartDel(HttpServletRequest request, HttpSession session, HttpServletResponse response) 
	{
		String[] pcodes=request.getParameter("pcode").split("/");
		
		if(session.getAttribute("userid")==null)
		{
			// 쿠키변수에 삭제할 pcode를 삭제
			Cookie cookie=WebUtils.getCookie(request, "pcode");
			if(cookie!=null)
			{
				String[] ckPcodes=cookie.getValue().split("/");
				
				for(int j=0;j<ckPcodes.length;j++) { // 쿠키변수에 있는 상품코드 배열
					for(int k=0;k<pcodes.length;k++) {
						if(ckPcodes[j].indexOf(pcodes[k]) != -1) { // 참이면 포함되어 있다
							ckPcodes[j]="";
							break;
						}
					}
				}
				
				// ckPcodes에는 삭제하는 상품코드는 ""이다
				// ckPcodes를 문자열로 합쳐서 쿠키에 다시 저장
				String newPcode="";
				for(int i=0;i<ckPcodes.length;i++)
				{
					if(ckPcodes[i] != "")
					  newPcode=newPcode+ckPcodes[i]+"/";
				}
				
				if(newPcode.isEmpty()) {
					Cookie newCookie=new Cookie("pcode",newPcode);
					newCookie.setMaxAge(0);
					newCookie.setPath("/");
					response.addCookie(newCookie);

				} else {
					Cookie newCookie=new Cookie("pcode",newPcode);
					newCookie.setMaxAge(3600);
					newCookie.setPath("/");
					response.addCookie(newCookie);
				}				
			}
		}
		else
		{
			String userid=session.getAttribute("userid").toString();
			
			for(int i=0;i<pcodes.length;i++)
			{
			   // cart테이블에서 pcode에 해당하는 레코드를 삭제
			   mapper.cartDel(userid,pcodes[i]);
			}
		}
		return "redirect:/member/cartView";
	}

	@Override
	public int[] chgSu(HttpServletRequest request,HttpSession session,HttpServletResponse response) {
		String pcode=request.getParameter("pcode");
		int su=Integer.parseInt(request.getParameter("su"));
		
		if(session.getAttribute("userid")==null) {
			Cookie code=WebUtils.getCookie(request, "pcode");
			String[] codes=code.getValue().split("/");
			
			for(int i=0;i<codes.length;i++) {
				if(codes[i].indexOf(pcode)!=-1) {
					codes[i]=pcode+"-"+su;
					
					break;
				}
			}
			String newPcode="";
			for(int i=0;i<codes.length;i++) {
				newPcode+=codes[i]+"/";
			}
			
			code=new Cookie("pcode", newPcode);
			code.setMaxAge(500);
			code.setPath("/");
			response.addCookie(code);
			
		} else {
			String userid=session.getAttribute("userid").toString();
			mapper.chgSu(userid, pcode, su);
			
		}
				
		HashMap map=mapper.getProduct(pcode);
		
		int price=Integer.parseInt(map.get("price").toString());
		int juk=Integer.parseInt(map.get("juk").toString());
		int halin=Integer.parseInt(map.get("halin").toString());
		
		int[] tot=new int[3];
		tot[0]=(int)(price-(price*halin/100.0))*su;
	    tot[1]=(int)(price*juk/100.0)*su;
	    tot[2]=Integer.parseInt(map.get("baeprice").toString());
	    
	    return tot;
	}

	@Override
	public String jjimList(HttpSession session,Model model) {
		if(session.getAttribute("userid")==null) {
			return "redirect:/login/login";
		} else {
			String userid=session.getAttribute("userid").toString();
			ArrayList<ProductDTO> plist=mapper.jjimList(userid);
			
			for(ProductDTO product : plist) {
				int price=product.getPrice();
				int halin=product.getHalin();
				
				int halinPrice=(int) (price-(price*halin/100.0));
				product.setHalinPrice(halinPrice);
			}
			
			model.addAttribute("pdto",plist);
			
			return "member/jjimList";
		}
	}

	@Override
	public String addCart(HttpServletRequest request, HttpSession session) {
		String pcode=request.getParameter("pcode");
		if(session.getAttribute("userid")==null) {
			return "redirect:/login/login";
		} else {
			String userid=session.getAttribute("userid").toString();
			if(!mapper.isCart(userid, pcode)) {
				mapper.addCart(userid,pcode);	
				mapper.jjimDel(userid, pcode);
			}
		}
		return null;
	}

	@Override
	public String jjimDel(HttpServletRequest request, HttpSession session) {
		String del=request.getParameter("del");
		if(session.getAttribute("userid")==null) {
			return "redirect:/login/login";
		} else {
			String userid=session.getAttribute("userid").toString();
			String[] pcodes=del.split("/");
			for(String pcode:pcodes) {
				mapper.jjimDel(userid, pcode);
			}
			return "redirect:/member/jjimList";
		}		
	}

	@Override
	public String jumunList(HttpSession session, Model model, HttpServletResponse response) {
		if(session.getAttribute("userid")==null) {
			Cookie url=new Cookie("url", "/member/jumunList");
			url.setMaxAge(500);
			url.setPath("/");
			response.addCookie(url);
			return "redirect:/login/login";
		} else {
			String userid=session.getAttribute("userid").toString();
			ArrayList<HashMap> mapAll=mapper.jumunList(userid);
			
			for(HashMap map:mapAll) {
				String sts="";
				switch((int)map.get("state")) {
					case 0:sts="결제완료"; break;
					case 1:sts="상품준비중"; break;
					case 2:sts="배송중"; break;
					case 3:sts="배송완료"; break;
					case 4:sts="취소완료"; break;
					case 5:sts="반품"; break;
					case 6:sts="교환"; break;
				}
				map.put("stat", sts );
			}
			
			model.addAttribute("mapAll", mapAll);
			return "/member/jumunList";
		}
	}

	@Override
	public String chgState(HttpServletRequest request) {
		String state=request.getParameter("state");
		String id=request.getParameter("id");
		
		mapper.chgState(state,id);
		return "redirect:/member/jumunList";
	}

	@Override
	public String reviewWrite(HttpServletRequest request, HttpSession session, Model model) {
		String pcode=request.getParameter("pcode");
		String id=request.getParameter("id");
		model.addAttribute("id",id);
		model.addAttribute("pcode",pcode);
		return "/member/reviewWrite";
	}

	@Override
	public String reviewOk(ReviewDTO rdto, HttpSession session,HttpServletRequest request) {
		String userid=session.getAttribute("userid").toString();
		String gumae_id=request.getParameter("gumae_id");
		rdto.setUserid(userid);
		mapper.reviewOk(rdto);
		
		// product테이블에 star필드에 평균값을 다시 구해서 저장 rdto.getPcode();
		double star=mapper.getReviewAvg(rdto.getPcode());
		// product테이블에 review필드에 1증가
		mapper.setProduct(star,rdto.getPcode());
		
		mapper.chgIsReview(gumae_id);
		
		return "redirect:/member/jumunList";
	}	
}
