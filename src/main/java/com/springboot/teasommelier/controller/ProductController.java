package com.springboot.teasommelier.controller;

import java.io.File;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.springboot.teasommelier.dao.IProductDao;
import com.springboot.teasommelier.dto.ProductDto;

@Controller
public class ProductController {
	@Autowired
	private IProductDao IProductDao;
	
	// -- test -- 
	@RequestMapping("/guest/productTest")
	public String productTest(ProductDto pdto, Model model) {
		model.addAttribute("pdto", IProductDao.productList());
		
		return "guest/productTest";
	}
	
	@RequestMapping("/guest/ViewForm")
	public String ViewForm(@RequestParam("p_no") int p_no, Model model) {
		model.addAttribute("view", IProductDao.select_tea_product(p_no));
		return "guest/view";
	}
	
	// -- 전체 공개 (guest) --

	// 티 제품
	@RequestMapping("/guest/productList")
	public String productList(Model model) {
		model.addAttribute("productList", IProductDao.select_tea_products_List());
		return "guest/productList";
	}

	// 기프트 세트
	@RequestMapping("/guest/productSet")
	public String productSet(Model model) {
		model.addAttribute("productSet", IProductDao.select_tea_products_set());
		return "guest/productSet";
	}

	// 티 웨어
	@RequestMapping("/guest/productWear")
	public String productWear(Model model) {
		model.addAttribute("productWear", IProductDao.select_tea_products_wear());
		return "guest/productWear";
	}

	// 할인메뉴
	@RequestMapping("/guest/productEvent")
	public String productEvent(Model model) {
		model.addAttribute("productEvent", IProductDao.select_tea_products_event());
		return "guest/productEvent";
	}

	// 상품 상세 조회
	@RequestMapping("/guest/productDetail")
	public String productDetail(@RequestParam("p_no") int p_no, Model model) {
		model.addAttribute("product", IProductDao.select_tea_product(p_no));
		return "guest/productDetail";
	}

	// -- 관리자 전용 (ADMIN) --

	// 상품 목록
	@RequestMapping("/admin/productLists")
	public String productLists( Model model) {
		model.addAttribute("list", IProductDao.productList());
		return "admin/productLists";
	}

	// 상품 등록 폼
	@RequestMapping("/admin/productWriteForm")
	public String productWriteForm() {
		return "admin/productWriteForm";
	}

	// 상품 등록 처리
	@RequestMapping("/admin/productWritePro")
	public String productWritePro(ProductDto tea_product,
								  Model model,
								  @RequestParam("p_image") MultipartFile p_image) throws Exception {
		
		if(!p_image.isEmpty()) {
			String pimage = p_image.getOriginalFilename();
			
			p_image.transferTo(new File("C:\\easommelier\\src\\main\\resources\\static\\images\\product\\"+pimage));
			tea_product.setP_img(pimage);
		}
	
		int result = IProductDao.insert_tea_product(tea_product);
		model.addAttribute("result", result);
		
		return "redirect:/admin/productLists";
	}

	// 상품 상세 보기
	@RequestMapping("/admin/productView")
	public String productView(@RequestParam("p_no") int p_no, Model model) {
		model.addAttribute("product", IProductDao.select_tea_product(p_no));
		return "admin/productView";
	}
	
	// 상품 수정 폼
	@RequestMapping("/admin/productModify")
	public String productModifyForm(@RequestParam("p_no") int p_no, Model model) {
		model.addAttribute("product", IProductDao.select_tea_product(p_no));
		return "admin/productModify";
	}

	// 상품 수정
	@RequestMapping("/admin/productUpdate")
	public String productModifyPro(ProductDto tea_product,
			  					   Model model,
			  					   @RequestParam("p_image") MultipartFile p_image) throws Exception {

		if(!p_image.isEmpty()) {
			String pimage = p_image.getOriginalFilename();
			
			p_image.transferTo(new File("C:\\easommelier\\src\\main\\resources\\static\\images\\product\\"+pimage));
			tea_product.setP_img(pimage);
		}
	
		int result = IProductDao.update_tea_product(tea_product);
		model.addAttribute("result", result);
		
		return "redirect:/admin/productLists";
	}
	

	// 상품 삭제
	@RequestMapping("/admin/productDelete")
	public String productDelete(@RequestParam("p_no") int p_no) {
		IProductDao.delete_tea_product(p_no);

		return "redirect:/admin/productLists";
	}



	// 상품 관리 페이지 버튼 admin만 볼수있게
	// private boolean isAdmin() {
//	 	if (principal == null) return false;
//	 	MemberDto mdto = IMemberDao.selectMemberById(principal.getName());
//	 	return mdto != null && "ADMIN".equals(mdto.getMauthority());
	// }
}
