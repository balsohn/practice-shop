package kr.co.shop.service;

import java.time.LocalDate;
import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.util.WebUtils;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
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
	    String pcode = request.getParameter("pcode");
	    int su = Integer.parseInt(request.getParameter("su"));

	    if (session.getAttribute("userid") == null) {
	        Cookie pookie = WebUtils.getCookie(request, "pcode");
	        Cookie sukie = WebUtils.getCookie(request, "su");
	        
	        if (pookie == null || sukie == null) {
	            // pookie 또는 sukie 쿠키가 없으면 새로운 쿠키 생성
	            Cookie newPookie = new Cookie("pcode", pcode);
	            newPookie.setMaxAge(500);
	            newPookie.setPath("/");
	            response.addCookie(newPookie);

	            Cookie newSukie = new Cookie("su", String.valueOf(su));
	            newSukie.setMaxAge(500);
	            newSukie.setPath("/");
	            response.addCookie(newSukie);
	        } else {
	            // 쿠키가 존재하는 경우
	            String[] pookies = pookie.getValue().split("/");
	            String[] sukies = sukie.getValue().split("/");
	            StringBuilder pookie1 = new StringBuilder();
	            StringBuilder sukie1 = new StringBuilder();
	            boolean found = false;

	            for (int i = 0; i < pookies.length; i++) {
	                if (pookies[i].equals(pcode)) {
	                    // 동일한 pcode가 이미 존재할 경우 su 값을 증가
	                    int currentSu = Integer.parseInt(sukies[i]);
	                    currentSu += su;
	                    sukies[i] = String.valueOf(currentSu);
	                    found = true;
	                }
	                pookie1.append(pookies[i]).append("/");
	                sukie1.append(sukies[i]).append("/");
	            }

	            if (!found) {
	                // 동일한 pcode가 없으면 새 항목 추가
	                pookie1.append(pcode).append("/");
	                sukie1.append(su).append("/");
	            }

	            // 마지막에 "/"를 제거
	            if (pookie1.length() > 0) pookie1.setLength(pookie1.length() - 1);
	            if (sukie1.length() > 0) sukie1.setLength(sukie1.length() - 1);

	            // 쿠키 업데이트
	            Cookie newPookie = new Cookie("pcode", pookie1.toString());
	            newPookie.setMaxAge(500);
	            newPookie.setPath("/");
	            response.addCookie(newPookie);

	            Cookie newSukie = new Cookie("su", sukie1.toString());
	            newSukie.setMaxAge(500);
	            newSukie.setPath("/");
	            response.addCookie(newSukie);
	        }
	    } else {
	        String userid = session.getAttribute("userid").toString();

	        if (mapper.isCart(pcode, userid)) {
	            mapper.upCart(pcode, userid, su);
	        } else {
	            mapper.addCart(pcode, userid, su);
	        }
	    }

	    return "0";
	}

	
	
}
