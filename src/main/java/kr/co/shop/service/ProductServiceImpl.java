package kr.co.shop.service;

import java.time.LocalDate;
import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import jakarta.servlet.http.HttpServletRequest;
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
	public String content(HttpServletRequest request, Model model) {
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
		return "/product/productContent";
	}
	
	
}
