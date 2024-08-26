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
		
		String code=pcode.substring(1);
		String dae=pcode.substring(0,2);
		String jung=pcode.substring(2,4);
		String so=pcode.substring(4,6);
		
		System.out.println(dae+" "+jung+" "+so);

		
		
		ArrayList<ProductDTO> plist=mapper.list(pcode);
		
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
	
	
}
