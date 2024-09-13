package kr.co.shop.service;

import java.time.LocalDate;
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
import kr.co.shop.dto.CateDTO;
import kr.co.shop.dto.DaeDTO;
import kr.co.shop.dto.JungDTO;
import kr.co.shop.dto.ProductDTO;
import kr.co.shop.dto.SoDTO;
import kr.co.shop.mapper.MainMapper;
import kr.co.shop.utils.MyUtils;

@Service
@Qualifier("ms")
public class MainServiceImpl implements MainService {

	@Autowired
	private MainMapper mapper;
	
	private void processProductList(ArrayList<ProductDTO> productList) {
	    for (ProductDTO pdto : productList) {
	        // 할인 가격과 적립금 계산
	        int halinPrice = (int) (pdto.getPrice() - (pdto.getPrice() * (pdto.getHalin() / 100.0)));
	        int jukPrice = (int) (pdto.getPrice() * (pdto.getJuk() / 100.0));

	        // 예상 도착일 계산
	        LocalDate today = LocalDate.now();
	        LocalDate xday = today.plusDays(pdto.getBaeday());
	        String yoil = MyUtils.getYoil(xday);

	        String baeEx = null;
	        if (pdto.getBaeday() == 1) {
	            baeEx = "내일(" + yoil + ") 도착예정";
	        } else if (pdto.getBaeday() == 2) {
	            baeEx = "모레(" + yoil + ") 도착예정";
	        } else {
	            int m = xday.getMonthValue();
	            int d = xday.getDayOfMonth();
	            baeEx = m + "/" + d + "(" + yoil + ") 도착예정";
	        }

	        // 각각의 ProductDTO에 값 설정
	        pdto.setHalinPrice(halinPrice);
	        pdto.setJukPrice(jukPrice);
	        pdto.setBaeEx(baeEx);

	        // 별점 처리
	        double star = pdto.getStar();
	        int ystar = (int) star;
	        int hstar = 0;
	        int gstar = 0;

	        star -= ystar;

	        if (star >= 0.8) {
	            ystar++;
	        } else if (star >= 0.3) {
	            hstar = 1;
	        }

	        gstar = 5 - (ystar + hstar);

	        pdto.setYstar(ystar);
	        pdto.setGstar(gstar);
	        pdto.setHstar(hstar);
	    }
	}
	
	
	@Override
	public String index(Model model) {
		
		// 여러 리스트에서 데이터를 가져옴
	    ArrayList<ProductDTO> time = mapper.getProduct1();
	    ArrayList<ProductDTO> halin = mapper.getProduct2();
	    ArrayList<ProductDTO> writeday = mapper.getProduct3();
	    ArrayList<ProductDTO> best = mapper.getProduct4();

	    // 4가지 리스트에 대해 동일한 작업 수행
	    processProductList(time);
	    processProductList(halin);
	    processProductList(writeday);
	    processProductList(best);

	    // 모델에 각각의 리스트 추가
	    model.addAttribute("time", time);
	    model.addAttribute("halin", halin);
	    model.addAttribute("writeday", writeday);
	    model.addAttribute("best", best);

	    return "/main/index";
	}

	@Override
	public ArrayList<DaeDTO> getDae() {
		return mapper.getDae();
	}

	@Override
	public ArrayList<CateDTO> getCate() {
		return mapper.getCate();
	}

	@Override
	public ArrayList<JungDTO> getJung() {
		return mapper.getJung();
	}

	@Override
	public ArrayList<SoDTO> getSo() {
		return mapper.getSo();
	}

	@Override
	public String cartNum(HttpServletRequest request, HttpSession session) {		
		if(session.getAttribute("userid")==null) {
			Cookie cookie=WebUtils.getCookie(request, "pcode");
			
			if(cookie!=null && !cookie.getValue().isEmpty()) {
				String[] pcodes=cookie.getValue().split("/");
				return pcodes.length+"";				
			} else {
				return "0";
			}			
		} else {
			String userid=session.getAttribute("userid").toString();
			return mapper.cartNum(userid);
		}
	}

	@Override
	public String gumaeAll(Model model) {
		ArrayList<HashMap> mapAll=mapper.gumaeAll();
		model.addAttribute("mapAll",mapAll);
		return "/gumae/gumaeAll";
	}
	
	
	
}
