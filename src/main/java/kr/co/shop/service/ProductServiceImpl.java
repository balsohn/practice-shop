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
import kr.co.shop.dto.BaesongDTO;
import kr.co.shop.dto.GumaeDTO;
import kr.co.shop.dto.ProductDTO;
import kr.co.shop.mapper.ProductMapper;
import kr.co.shop.utils.MyUtils;

@Service
@Qualifier("ps")
public class ProductServiceImpl implements ProductService {

	@Autowired 
	private ProductMapper mapper;

	@Override
	public String list(HttpServletRequest request, Model model) {
		String pcode=request.getParameter("pcode");
		model.addAttribute("pcode",pcode);
		String pos="HOME-";
		if(pcode.length()==3) {
			String code=pcode.substring(1);
			pos+=mapper.getDaeName(code);
		} else if(pcode.length()==5) {
			String daecode=pcode.substring(1,3);
			pos=pos+mapper.getDaeName(daecode);
			String code=pcode.substring(3);
			pos=pos+"-"+mapper.getJungName(code, daecode);
		} else if(pcode.length()==7) {
			String daecode=pcode.substring(1,3);
			pos+=mapper.getDaeName(daecode);
			
			String daejung=pcode.substring(1,5);
			String jungcode=pcode.substring(3,5);
			String code=pcode.substring(5);
			pos+="-"+mapper.getJungName(jungcode, daecode);
			
			pos+="-"+mapper.getSoName(code, daejung);
		}
		
		model.addAttribute("pos",pos);
		
		String order=request.getParameter("order")==null?"0":request.getParameter("order");
		model.addAttribute("order",order);
		switch(order) {
			case"0":order="pansu desc"; break;
			case"1":order="price asc"; break;
			case"2":order="price desc"; break;
			case"3":order="star desc"; break;
			case"4":order="writeday desc"; break;
		}		
		
		int page=request.getParameter("page")==null?1:Integer.parseInt(request.getParameter("page"));
		int index=(page-1)*10;
		int p=(page-1)/10;
		int pstart=p*10+1;
		int pend=pstart+9;
		int chong=mapper.getChong(pcode);
		if(chong<pend) {
			pend=chong;
		}
		model.addAttribute("page",page);
		model.addAttribute("pstart",pstart);
		model.addAttribute("pend",pend);
		model.addAttribute("chong",chong);
		ArrayList<ProductDTO> plist=mapper.list(pcode,order,index);
		
		for(int i=0;i<plist.size();i++) {
			ProductDTO pdto=plist.get(i);
			int halinPrice=(int)(pdto.getPrice()-(pdto.getPrice()*(pdto.getHalin()/100.0)));
			int jukPrice=(int)(pdto.getPrice()*(pdto.getJuk()/100.0));
			
			LocalDate today=LocalDate.now();
			LocalDate xday=today.plusDays(pdto.getBaeday());
			String yoil=MyUtils.getYoil(xday);
			
			String baeEx=null;
			if(pdto.getBaeday()==1) {
				baeEx="내일("+yoil+") 도착예정";
			} else if(pdto.getBaeday()==2) {
				baeEx="모레("+yoil+") 도착예정";
			} else {
				int m=xday.getMonthValue();
				int d=xday.getDayOfMonth();
				baeEx=m+"/"+d+"("+yoil+") 도착예정";
			}
			
			plist.get(i).setHalinPrice(halinPrice);
			plist.get(i).setJukPrice(jukPrice);
			plist.get(i).setBaeEx(baeEx);
		}
		
		model.addAttribute("plist",plist);
		return "/product/productList";
	}

	@Override
	public String content(HttpServletRequest request, Model model,HttpSession session) {
		String pcode=request.getParameter("pcode");
		ProductDTO pdto=mapper.content(pcode);		
			
		int halinPrice=(int)(pdto.getPrice()-(pdto.getPrice()*(pdto.getHalin()/100.0)));
		int jukPrice=(int)(pdto.getPrice()*(pdto.getJuk()/100.0));
		
		LocalDate today=LocalDate.now();
		LocalDate xday=today.plusDays(pdto.getBaeday());
		String yoil=MyUtils.getYoil(xday);
		
		String baeEx=null;
		if(pdto.getBaeday()==1) {
			baeEx="내일("+yoil+") 도착예정";
		} else if(pdto.getBaeday()==2) {
			baeEx="모레("+yoil+") 도착예정";
		} else {
			int m=xday.getMonthValue();
			int d=xday.getDayOfMonth();
			baeEx=m+"/"+d+"("+yoil+") 도착예정";
		}
		
		pdto.setHalinPrice(halinPrice);
		pdto.setJukPrice(jukPrice);
		pdto.setBaeEx(baeEx);
		
		model.addAttribute("pdto",pdto);
		
		if(session.getAttribute("userid")!=null) {
			String userid=session.getAttribute("userid").toString();
			int ch=mapper.jjimChk(pcode, userid);	
		}
		return "/product/productContent";
	}

	@Override
	public String jjimOk(HttpServletRequest request, HttpSession session, HttpServletResponse response) {
		String jjimchk=request.getParameter("jjimchk");
		String pcode=request.getParameter("pcode");
		if(session.getAttribute("userid")==null) {
			String oriURL ="/product/productContent?pcode=" + pcode;
			Cookie cookie=new Cookie("url", oriURL);
			cookie.setMaxAge(500);
			cookie.setPath("/");
			response.addCookie(cookie);
			
			return "0";
		} else {
			String userid=session.getAttribute("userid").toString();
			if(mapper.jjimChk(pcode, userid)==1) {
				mapper.jjimDel(pcode, userid);
			} else {
				mapper.jjimOk(pcode, userid);
			}
			return "1";
		}
	}

	@Override
	public String jjimChk(HttpServletRequest request,HttpSession session) {
		String pcode=request.getParameter("pcode");
		if(session.getAttribute("userid")!=null) {
			String userid=session.getAttribute("userid").toString();
			if(mapper.jjimChk(pcode, userid)==1) {
				return "1";
			} else {
				return "0";
			}
		} else {
			return "0";
		}
		
		
	}

	@Override
	public String addCart(HttpServletRequest request, HttpSession session,
			HttpServletResponse response) {
		String pcode=request.getParameter("pcode");
		int su=Integer.parseInt(request.getParameter("su"));
		String cartNum=null;
		if(session.getAttribute("userid")==null) {

			// 로그인을 하지 않아도 장바구니 처리를 실행
			// 이전의 쿠키변수 pcode를 읽어오기
			Cookie cookie=WebUtils.getCookie(request, "pcode");
			String newPro=pcode+"-"+su+"/";
			
			String newPcode=null;
			if(cookie==null || cookie.getValue().isEmpty()) {
				newPcode=newPro;
				cartNum="1";
			} else {
				String getPcode=cookie.getValue();
				String[] pcodes=getPcode.split("/");
				
				
				
				int chk=-1;
				for(int i=0;i<pcodes.length;i++) {
					if(pcodes[i].indexOf(pcode)!=-1) {
						chk=i;
					}
				}
				
				if(chk!=-1) {
					int num=Integer.parseInt(pcodes[chk].substring(13));
					num+=su;
					pcodes[chk]=pcodes[chk].substring(0,13)+num;
					
					String imsi="";
					for(int i=0;i<pcodes.length;i++) {
						imsi+=pcodes[i]+"/";
					}
					newPcode=imsi;
				} else {
					newPcode=cookie.getValue()+newPro;			
					cartNum=(pcodes.length+1)+"";
				}
			}
			
			System.out.println(newPcode);
			
			// newPcode를 새로운 쿠키객체로 생성
			Cookie newCookie=new Cookie("pcode",newPcode);
			newCookie.setMaxAge(600);
			newCookie.setPath("/");
			response.addCookie(newCookie);
			
			return cartNum;
			
		} else {
			String userid=session.getAttribute("userid").toString();
			
			if(mapper.isCart(pcode, userid)) {
				mapper.upCart(pcode,userid,su);
			} else {
				mapper.addCart(pcode, userid, su);				
			}
			return mapper.getCartNum(userid);
		}
		
	}

	@Override
	public String gumae(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) {
		String pcode=request.getParameter("pcode");
		String su=request.getParameter("su");
		
		if(session.getAttribute("userid")==null) {
			Cookie url=new Cookie("url", "/member/cartView");
			url.setMaxAge(500);
			url.setPath("/");
			response.addCookie(url);
			
			return "redirect:/login/login";
		} else {
			String userid=session.getAttribute("userid").toString();
			model.addAttribute("mdto",mapper.getMember(userid)); 
			
			// 배송지 정보
			BaesongDTO bdto=mapper.getBaesong(userid);
			if(bdto!=null) {
				String breq="";
				switch(bdto.getReq()) {
					case 0:breq="문 앞"; break;
					case 1:breq="직접받고 부재시 문앞"; break;
					case 2:breq="경비실"; break;
					case 3:breq="택배함"; break;
					case 4:breq="공동현관 앞"; break;				
				}
				bdto.setBreq(breq);
				
			}
			model.addAttribute("bdto",bdto);
			
			String[] pcodes=pcode.split("/");
			String[] imsi=su.split("/");
			int[] sues=new int[imsi.length];
			for(int i=0;i<sues.length;i++) {
				sues[i]=Integer.parseInt(imsi[i]);
			}
			
			ArrayList<ProductDTO> plist=new ArrayList<>();
			for(int i=0;i<pcodes.length;i++) {
				ProductDTO pdto=mapper.content(pcodes[i]);
				pdto.setSu(sues[i]);
				plist.add(pdto);
				int halinPrice=(int)(pdto.getPrice()-(pdto.getPrice()*(pdto.getHalin()/100.0)));
				int jukPrice=(int)(pdto.getPrice()*(pdto.getJuk()/100.0));
				
				LocalDate today=LocalDate.now();
				LocalDate xday=today.plusDays(pdto.getBaeday());
				String yoil=MyUtils.getYoil(xday);
				
				String baeEx=null;
				if(pdto.getBaeday()==1) {
					baeEx="내일("+yoil+") 도착예정";
				} else if(pdto.getBaeday()==2) {
					baeEx="모레("+yoil+") 도착예정";
				} else {
					int m=xday.getMonthValue();
					int d=xday.getDayOfMonth();
					baeEx=m+"/"+d+"("+yoil+") 도착예정";
				}
				
				pdto.setHalinPrice(halinPrice);
				pdto.setJukPrice(jukPrice);
				pdto.setBaeEx(baeEx);
			}
			model.addAttribute("plist",plist);
			
			int halinPrice=0;
			int baePrice=0;
			int jukPrice=0;
			
			for(int i=0;i<plist.size();i++) {
				ProductDTO pdto=plist.get(i);
				int price=pdto.getPrice();
				int halin=pdto.getHalin();
				int su2=pdto.getSu();
				int bae=pdto.getBaeprice();
				int juk=pdto.getJuk();
				halinPrice=halinPrice+price-(int)(price*halin/100.0)*su2;
				baePrice=baePrice+bae;
				jukPrice=jukPrice+(int)(price*juk/100.0);
			}
			
			model.addAttribute("halinPrice",halinPrice);
			model.addAttribute("baePrice",baePrice);
			model.addAttribute("jukPrice",jukPrice);			
			
			model.addAttribute("juk", mapper.getJuk(userid));
			
			return "/product/gumae";
		}
	}

	@Override
	public String jusoWriteOk(BaesongDTO bdto, Model model, HttpSession session) {
		
		String userid=session.getAttribute("userid").toString();
		bdto.setUserid(userid);
		
		if(bdto.getGibon()==1) {
			mapper.gibonInit(userid);
		}
		mapper.jusoWriteOk(bdto);
		
		
		if(bdto.getTt().equals("1")) {
			//추가입력
			return "redirect:/product/jusoList";
		} else {
			model.addAttribute("bname",bdto.getName());
			model.addAttribute("bjuso", bdto.getJuso());
			model.addAttribute("bphone",bdto.getPhone());
			model.addAttribute("baeId",mapper.getBaeId(userid));
			String breq="";
			switch(bdto.getReq()) {
				case 0:breq="문 앞"; break;
				case 1:breq="직접받고 부재시 문앞"; break;
				case 2:breq="경비실"; break;
				case 3:breq="택배함"; break;
				case 4:breq="공동현관 앞"; break;			
			}
			
			model.addAttribute("breq",breq);
		}
		
		
		
		return null;
		
	}

	@Override
	public String jusoList(HttpSession session, Model model) {
		
		if(session.getAttribute("userid")==null) {
			return "redirect:/main/index";
		} else {
			String userid=session.getAttribute("userid").toString();
			ArrayList<BaesongDTO> bdto=mapper.jusoList(userid);
			for(BaesongDTO juso:bdto) {
				String breq="";
				switch(juso.getReq()) {
				case 0:breq="문 앞"; break;
				case 1:breq="직접받고 부재시 문앞"; break;
				case 2:breq="경비실"; break;
				case 3:breq="택배함"; break;
				case 4:breq="공동현관 앞"; break;				
				}
				juso.setBreq(breq);
			}
			model.addAttribute("bdto",bdto);			
			return "/product/jusoList";
		}
	}

	@Override
	public int chgPhone(HttpServletRequest request,HttpSession session) {
		String userid=session.getAttribute("userid").toString();
		String phone=request.getParameter("phone");
		mapper.chgPhone(userid, phone);
		return 1;
	}

	@Override
	public String jusoDel(HttpServletRequest request) {
		String id=request.getParameter("id");
		mapper.jusoDel(id);
		return "redirect:/product/jusoList";
	}

	@Override
	public String jusoUpdate(HttpServletRequest request, Model model) {
		String id=request.getParameter("id");
		model.addAttribute("bdto",mapper.jusoUpdate(id));
		return "/product/jusoUpdate";
	}

	@Override
	public String jusoUpdateOk(BaesongDTO bdto, HttpSession session) {
		String userid=session.getAttribute("userid").toString();
		
		if(bdto.getGibon()==1) {
			mapper.gibonInit(userid);
		}
		mapper.jusoUpdateOk(bdto);
		return "redirect:/product/jusoList";
	}

	@Override
	public String gumaeOk(GumaeDTO gdto,HttpSession session) {
		String userid=session.getAttribute("userid").toString();
		gdto.setUserid(userid);
		LocalDate today=LocalDate.now();
		String y=String.format("%02d", today.getYear()); 
		String m=String.format("%02d", today.getMonthValue());
		String d=String.format("%02d", today.getDayOfMonth());
		
		String jumuncode="j"+y+m+d;
		jumuncode=jumuncode+String.format("%03d", mapper.getJumuncode(jumuncode));
		gdto.setJumuncode(jumuncode);		
		
		String[] pcodes=gdto.getPcodes();
		int[] sues=gdto.getSues();
		mapper.useJuk(userid,gdto.getUseJuk());
		
		for(int i=0;i<pcodes.length;i++) {
			gdto.setPcode(pcodes[i]);
			gdto.setSu(sues[i]);
			mapper.gumaeOk(gdto);
			
			// 장바구니에 있는 구매된 상품은 삭제
			mapper.cartDel(userid, pcodes[i]);
			// 잔여수량과 판매수량 업데이트
			mapper.suUp(pcodes[i], sues[i]);	
		}
		
		return "redirect:/product/gumaeView?jumuncode="+jumuncode;
	}
	
	@Override
	public String gumaeView(HttpServletRequest request, Model model) {
		String jumuncode=request.getParameter("jumuncode");
		
		ArrayList<HashMap> mapAll=mapper.gumaeView2(jumuncode);
		
		// 상품금액당, 총삼품금액, 총배송비, 도착예정일
		
		int baesong=0;
		int chong=0;
		String baeEx="";
		String breq="";
		LocalDate today=LocalDate.now();
		
		
		
		for(HashMap map:mapAll) {
			int price=(int)map.get("price");
			int hal=(int) map.get("halin");
			int halinPrice=(int) (price-(price*hal/100.0));
			chong+=halinPrice;
			
			int baePrice=(int) map.get("baeprice");
			baesong+=baePrice;
			
			map.put("halinPrice", halinPrice);
			
			int beaday=(int)map.get("baeday");
			LocalDate xday=today.plusDays(beaday);
			int m=xday.getMonthValue();
			int d=xday.getDayOfMonth();
			
			String yoil=xday.getDayOfWeek().getDisplayName(TextStyle.SHORT, Locale.KOREAN);
			switch((int)map.get("baeday")) {
				case 0:map.put("baeEx", "오늘 도착"); break;
				case 1:map.put("baeEx", "내일 도착"); break;
				case 2:map.put("baeEx", "모레 도착"); break;
				default:map.put("baeEx", m+"/"+d+"("+yoil+") 도착");
			}	
			
			int req=(int)map.get("req");
			switch(req) {
				case 0: map.put("breq","문 앞"); break;
				case 1: map.put("breq", "직접받고 부재시 문앞"); break;
				case 2: map.put("breq","경비실"); break;
				case 3: map.put("breq","택배함"); break;
				case 4: map.put("breq","공동현관 앞"); break;
			}
		}
		
		model.addAttribute("baesong",baesong);
		model.addAttribute("chong",chong);
		model.addAttribute("map",mapAll);
		/*
		ArrayList<GumaeDTO> glist=mapper.gumaeView(jumuncode);
		ArrayList<ProductDTO> plist=new ArrayList<>();
		ArrayList<BaesongDTO> blist=new ArrayList<>();
		
		for(int i=0;i<glist.size();i++) {
			GumaeDTO gdto=glist.get(i);
			ProductDTO pdto=mapper.content(gdto.getPcode());
			plist.add(pdto);
			
			BaesongDTO bdto=mapper.jusoUpdate(gdto.getBaeId()+"");
			blist.add(bdto);
		}*/
		
		return "/product/gumaeView";
	}
	

	
	
}
