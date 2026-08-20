package com.springboot.teasommelier.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.springboot.teasommelier.dao.ICommunityDao;
import com.springboot.teasommelier.dao.IProductDao;
import com.springboot.teasommelier.dto.CommunityDto;
import com.springboot.teasommelier.dto.ProductDto;

@Controller
public class ProductController {
	@Autowired
	private IProductDao IProductDao;
	@Autowired
	private ICommunityDao cb_dao;
	
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
	public String productList(
	      @RequestParam(value = "productType", required = false) String productType,
	      @RequestParam(value = "filter", required = false) String filter,
	      @RequestParam(value = "sort", required = false, defaultValue = "new") String sort,
	      @RequestParam(value = "page", required = false, defaultValue = "1") int page,
	      Model model) {

	   // p_category = '티 제품' 조건은 이미 SQL(select_tea_products_List)에서 처리됨
	   List<ProductDto> allList = IProductDao.select_tea_products_List();

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

	   // 세부필터(소분류) - p_category가 아니라 같은 p_type 문자열 안에서 포함 여부로 판단
	   if (filter != null && !filter.isEmpty()) {
	      filtered = filtered.stream()
	            .filter(p -> p.getP_type() != null && p.getP_type().contains(filter))
	            .collect(Collectors.toList());
	   }

	   // 정렬
	   if ("name".equals(sort)) {
	      filtered.sort(Comparator.comparing(ProductDto::getP_name));
	   } else if ("new".equals(sort)) {
	      filtered.sort(
	         Comparator.comparing(ProductDto::getP_date).reversed()
	      );
	   }

	   model.addAttribute("productList", filtered);
	   model.addAttribute("productType", productType);
	   model.addAttribute("filter", filter);
	   model.addAttribute("sort", sort);
	   model.addAttribute("pageNum", page);
	   model.addAttribute("totalPage", 1);

	   return "guest/productList";
	}

	// 상품명 검색 (대량주문문의 상품/주문검색 모달에서 사용) - 기존 select_tea_products_List() 재사용
	@RequestMapping("/guest/productSearch")
	@ResponseBody
	public List<ProductDto> productSearch(@RequestParam(value = "keyword", required = false) String keyword) {

		List<ProductDto> allList = IProductDao.select_tea_products_List();

		if (keyword == null || keyword.trim().isEmpty()) {
			return new ArrayList<>();
		}

		String kw = keyword.trim();

		return allList.stream()
				.filter(p -> p.getP_name() != null && p.getP_name().contains(kw))
				.collect(Collectors.toList());
	}

	// 기프트 세트
	@RequestMapping("/guest/productSet")
	public String productSet(
	      @RequestParam(value = "productType", required = false) String productType,
	      @RequestParam(value = "filter", required = false) String filter,
	      @RequestParam(value = "sort", required = false, defaultValue = "new") String sort,
	      @RequestParam(value = "page", required = false, defaultValue = "1") int page,
	      Model model) {

	   // p_category = '기프트 세트' 조건은 이미 SQL(select_tea_products_set)에서 처리됨
	   List<ProductDto> allList = IProductDao.select_tea_products_set();

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

	   // 정렬
	   if ("name".equals(sort)) {
	      filtered.sort(
	         Comparator.comparing(ProductDto::getP_name)
	      );
	   } else if ("new".equals(sort)) {
	      filtered.sort(
	         Comparator.comparing(ProductDto::getP_date).reversed()
	      );
	   }

	   model.addAttribute("productSet", filtered);
	   model.addAttribute("productType", productType);
	   model.addAttribute("filter", filter);
	   model.addAttribute("sort", sort);
	   model.addAttribute("pageNum", page);
	   model.addAttribute("totalPage", 1);

	   return "guest/productSet";
	}
	
	/*
	 * @RequestMapping("/guest/productMain") public String productmain(
	 * 
	 * @RequestParam(value = "productType", required = false) String productType,
	 * 
	 * @RequestParam(value = "filter", required = false) String filter,
	 * 
	 * @RequestParam(value = "sort", required = false, defaultValue = "new") String
	 * sort,
	 * 
	 * @RequestParam(value = "page", required = false, defaultValue = "1") int page,
	 * Model model) {
	 * 
	 * // p_category = '기프트 세트' 조건은 이미 SQL(select_tea_products_set)에서 처리됨
	 * List<ProductDto> allList = IProductDao.select_tea_products_main();
	 * 
	 * List<ProductDto> filtered;
	 * 
	 * // 상품종류(대분류)를 선택했으면 p_type 안에 해당 단어가 포함된 것만 필터링 (contains 방식) if (productType
	 * != null && !productType.isEmpty()) { filtered = allList.stream() .filter(p ->
	 * p.getP_type() != null && p.getP_type().contains(productType))
	 * .collect(Collectors.toList()); } else { // 선택 안 했으면(처음 진입 시) 전체 상품 보여줌
	 * filtered = new ArrayList<>(allList); }
	 * 
	 * // 세부필터(소분류) - 같은 p_type 문자열 안에서 포함 여부로 판단 if (filter != null &&
	 * !filter.isEmpty()) { filtered = filtered.stream() .filter(p -> p.getP_type()
	 * != null && p.getP_type().contains(filter)) .collect(Collectors.toList()); }
	 * 
	 * model.addAttribute("productSet", filtered); model.addAttribute("productType",
	 * productType); model.addAttribute("filter", filter);
	 * model.addAttribute("sort", sort); model.addAttribute("pageNum", page);
	 * model.addAttribute("totalPage", 1);
	 * 
	 * return "guest/productMain"; }
	 */
	

	// 티 웨어
	@RequestMapping("/guest/productWear")
	public String productWear(
		      @RequestParam(value = "productType", required = false) String productType,
		      @RequestParam(value = "filter", required = false) String filter,
		      @RequestParam(value = "sort", required = false, defaultValue = "new") String sort,
		      @RequestParam(value = "page", required = false, defaultValue = "1") int page,
		      Model model) {

		   // p_category = '티 웨어' 조건은 이미 SQL(select_tea_products_wear)에서 처리됨
		   List<ProductDto> allList = IProductDao.select_tea_products_wear();

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

		   // 정렬
		   if ("name".equals(sort)) {
		      filtered.sort(
		         Comparator.comparing(ProductDto::getP_name)
		      );
		   } else if ("new".equals(sort)) {
		      filtered.sort(
		         Comparator.comparing(ProductDto::getP_date).reversed()
		      );
		   }

		   model.addAttribute("productWear", filtered);
		   model.addAttribute("productType", productType);
		   model.addAttribute("filter", filter);
		   model.addAttribute("sort", sort);
		   model.addAttribute("pageNum", page);
		   model.addAttribute("totalPage", 1);
		return "guest/productWear";
	}

	// 이벤트메뉴
	@RequestMapping("/guest/productEvent")
	public String productEvent(
		      @RequestParam(value = "productType", required = false) String productType,
		      @RequestParam(value = "filter", required = false) String filter,
		      @RequestParam(value = "sort", required = false, defaultValue = "new") String sort,
		      @RequestParam(value = "page", required = false, defaultValue = "1") int page,
		      Model model) {

		   // p_category = '이벤트' 조건은 이미 SQL(select_tea_products_event)에서 처리됨
		   List<ProductDto> allList = IProductDao.select_tea_products_event();

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

		   // 정렬
		   if ("name".equals(sort)) {
		      filtered.sort(
		         Comparator.comparing(ProductDto::getP_name)
		      );
		   } else if ("new".equals(sort)) {
		      filtered.sort(
		         Comparator.comparing(ProductDto::getP_date).reversed()
		      );
		   }

		   model.addAttribute("productEvent", filtered);
		   model.addAttribute("productType", productType);
		   model.addAttribute("filter", filter);
		   model.addAttribute("sort", sort);
		   model.addAttribute("pageNum", page);
		   model.addAttribute("totalPage", 1);
		return "guest/productEvent";
	}

	// 상품 상세 조회 - guest 경로, 인증 불필요
	@RequestMapping(value = "/guest/productDetail", method = RequestMethod.GET)
	public String productDetail(@RequestParam("p_no") int p_no, Model model){
	    ProductDto product = IProductDao.select_tea_product(p_no);
	    model.addAttribute("product", product);

	    List<CommunityDto> reviewList = cb_dao.CommunityList_product(p_no, "리뷰");
	    List<CommunityDto> qnaList = cb_dao.CommunityList_product(p_no, "Q&A");
	    model.addAttribute("reviewList", reviewList);
	    model.addAttribute("qnaList", qnaList);

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
								  @RequestParam("p_image") MultipartFile p_image,
								  @RequestParam("p_image2") MultipartFile p_image2) throws Exception {
		
		// 업로드할 경로 변수 선언
		String uploadPath = "C:\\easommelier\\src\\main\\resources\\static\\images\\product\\";
		
		if(!p_image.isEmpty()) {
			String pimage = p_image.getOriginalFilename();
			p_image.transferTo(new File(uploadPath + pimage));
			tea_product.setP_img(pimage);
		}
		
		if(p_image2 != null && !p_image2.isEmpty()) {
		    String pimage2 = p_image2.getOriginalFilename();
		    p_image2.transferTo(new File(uploadPath + pimage2));
		    tea_product.setP_img2(pimage2);
		} else {
		    tea_product.setP_img2("default.png"); // 두 번째 이미지가 없을 때 기본 이미지 설정
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
			
			p_image.transferTo(new File("C:\\Teasommelier\\src\\main\\resources\\static\\images\\product\\"+pimage));
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
