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
		ArrayList<ProductDTO> plist=mapper.list(pcode);
		
		for(int i=0;i<plist.size();i++) {
			ProductDTO pdto=plist.get(i);
			int halinPrice=pdto.getPrice()-(pdto.getPrice()*(pdto.getHalin()/100));
			int jukPrice=pdto.getPrice()*(pdto.getJuk()/100);
			
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
		return "/product/productList";
	}
	
	
}
