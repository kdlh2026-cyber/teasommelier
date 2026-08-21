package com.springboot.teasommelier.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.springboot.teasommelier.dao.IProductDao;
import com.springboot.teasommelier.dto.ProductDto;

@Controller
public class MainController {
	@Autowired
	private IProductDao IProductDao;
	
	@RequestMapping("/")
	public String root() {
		
		return "redirect:main";
	}
	
	@RequestMapping("/main")
	public String main(
		      @RequestParam(value = "productType", required = false) String productType,
		      @RequestParam(value = "filter", required = false) String filter,
		      @RequestParam(value = "sort", required = false, defaultValue = "new") String sort,
		      @RequestParam(value = "page", required = false, defaultValue = "1") int page,
		      Model model) {

		   // p_category = '기프트 세트' 조건은 이미 SQL(select_tea_products_set)에서 처리됨
		   List<ProductDto> allList = IProductDao.select_tea_products_main();

		   List<ProductDto> filtered;

		   // 상품종류(대분류)를 선택했으면 p_type 안에 해당 단어가 포함된 것만 필터링 (contains 방식)
		   if (productType != null && !productType.isEmpty()) {
		      filtered = allList.stream()
		            .filter(p -> p.getP_type() != null && p.getP_type().contains(productType))
		            .collect(Collectors.toList());
		   } else {
		      // 선택 안 했으면(처음 진입 시) 전체 상품 보여줌
		      filtered = new ArrayList<>(allList);
		   }

		   // 세부필터(소분류) - 같은 p_type 문자열 안에서 포함 여부로 판단
		   if (filter != null && !filter.isEmpty()) {
		      filtered = filtered.stream()
		            .filter(p -> p.getP_type() != null && p.getP_type().contains(filter))
		            .collect(Collectors.toList());
		   }

		   model.addAttribute("productSet", filtered);
		   model.addAttribute("productType", productType);
		   model.addAttribute("filter", filter);
		   model.addAttribute("sort", sort);
		   model.addAttribute("pageNum", page);
		   model.addAttribute("totalPage", 1);
		   
		   return "main";
	}
	
	@RequestMapping("/guest/MemberWriteForm")
	public String MemberWriteForm() {
		return"guest/MemberWriteForm";
	}
	
	@RequestMapping("/loginForm")
	public String loginForm() {
		return "loginForm";
	}
	@RequestMapping("/loginError")
	public String loginError() {
		return"loginError";
	}
	
	@RequestMapping("/Personalfooter")
	public String Personalfooter() {
		return "Personalfooter";
	}
	
	@RequestMapping("/Termsfooter")
	public String Termsfooter() {
		return "Termsfooter";
	}

}
