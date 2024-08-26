package kr.co.shop.service;

import java.util.ArrayList;

import org.springframework.ui.Model;

import jakarta.servlet.http.HttpServletRequest;
import kr.co.shop.dto.ProductDTO;

public interface ProductService {
	public String list(HttpServletRequest request, Model model);

	public String content(HttpServletRequest request, Model model);
}
