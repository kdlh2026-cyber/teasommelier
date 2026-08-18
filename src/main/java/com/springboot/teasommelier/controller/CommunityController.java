package com.springboot.teasommelier.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.springboot.teasommelier.dao.ICommunityDao;
import com.springboot.teasommelier.dao.IProductDao;
import com.springboot.teasommelier.dto.CommunityDto;
import com.springboot.teasommelier.dto.ProductDto;
import com.springboot.teasommelier.dto.QnaResponseDto;

@Controller
public class CommunityController {
	@Autowired
	ICommunityDao cb_dao;
	@Autowired
	private IProductDao p_dao;
	
	@RequestMapping("/cb_communityBoard")
	public String CBoard(){
		return "cb_communityBoard";
	}
	
	@RequestMapping("/guest/community/cb_brandnoticeList")
	public String brandnoticeList(Model model) {
	    model.addAttribute("brandnoticeList", cb_dao.CommunityList_category("브랜드소식"));
	    return "guest/community/cb_brandnoticeList";
	}
	
	@RequestMapping("/guest/community/cb_brandnoticeDetail")
	public String brandnoticeDetail(@RequestParam("cb_no") int cb_no,Model model) {
		model.addAttribute("viewCBdao",cb_dao.CommunityView(cb_no));
		cb_dao.CommunityHit(cb_no);
		return "guest/community/cb_brandnoticeDetail";
	}
	
	@RequestMapping("/guest/community/cb_editorialList")
	public String editorialList(Model model) {
		model.addAttribute("editorialList",cb_dao.CommunityList_category("에디토리얼"));
		return "guest/community/cb_editorialList";
	}
	
	@RequestMapping("/guest/community/cb_editorialDetail")
	public String editorialDetail(@RequestParam("cb_no") int cb_no,Model model) {
		model.addAttribute("viewCBdao",cb_dao.CommunityView(cb_no));
		cb_dao.CommunityHit(cb_no);
		return "guest/community/cb_editorialDetail";
	}
	
	@RequestMapping("/guest/community/cb_reviewList")
	public String reviewList(Model model) {

	    List<CommunityDto> reviewList = cb_dao.CommunityList_category("리뷰");
	    model.addAttribute("reviewList", reviewList);

	    Map<Integer, ProductDto> productMap = new HashMap<>();
	    for (CommunityDto review : reviewList) {
	        Integer p_no = review.getP_no();
	        if (p_no != null && !productMap.containsKey(p_no)) {
	            productMap.put(p_no, p_dao.select_tea_product(p_no));
	        }
	    }
	    model.addAttribute("productMap", productMap);

	    return "guest/community/cb_reviewList";
	}
	
	@RequestMapping("/guest/community/cb_reviewDetail")
	public String reviewDetail(@RequestParam("cb_no") int cb_no, Model model) {

	    CommunityDto viewCBdao = cb_dao.CommunityView(cb_no);
	    model.addAttribute("viewCBdao", viewCBdao);
	    cb_dao.CommunityHit(cb_no);

	    if (viewCBdao.getP_no() != null) {
	        ProductDto p_dto = p_dao.select_tea_product(viewCBdao.getP_no());
	        model.addAttribute("product", p_dto);
	    }

	    return "guest/community/cb_reviewDetail";
	}
	
	@RequestMapping("/guest/community/cb_qnaList")
	public String qnaList(Model model) {

	    List<CommunityDto> qnaList = cb_dao.CommunityList_category("Q&A");
	    model.addAttribute("qnaList", qnaList);

	    Map<Integer, ProductDto> productMap = new HashMap<>();
	    for (CommunityDto qna : qnaList) {
	        Integer p_no = qna.getP_no();
	        if (p_no != null && !productMap.containsKey(p_no)) {
	            productMap.put(p_no, p_dao.select_tea_product(p_no));
	        }
	    }
	    model.addAttribute("productMap", productMap);

	    return "guest/community/cb_qnaList";
	}
	
	@RequestMapping("/guest/community/cb_qnaDetail")
	public String qnaDetail(@RequestParam("cb_no") int cb_no, Model model) {

	    CommunityDto viewCBdao = cb_dao.CommunityView(cb_no);
	    model.addAttribute("viewCBdao", viewCBdao);
	    model.addAttribute("responseQnaDto", cb_dao.ResponseQnaView(cb_no));

	    cb_dao.CommunityHit(cb_no);

	    if (viewCBdao.getP_no() != null) {
	        ProductDto p_dto = p_dao.select_tea_product(viewCBdao.getP_no());
	        model.addAttribute("product", p_dto);
	    }

	    return "guest/community/cb_qnaDetail";
	}
	
	@RequestMapping("/guest/community/cb_qnaResponseDetail")
	public String cb_qnaResponseDetail() {
		return "guest/community/cb_qnaResponseDetail";
	}
	
	@RequestMapping("/admin/community/cb_brandnoticeInsertForm")
	public String brandnoticeInsertForm() {
	    return "admin/community/cb_brandnoticeInsertForm";
	}
	
	@RequestMapping("/admin/community/cb_brandnoticeUpdateForm")
	public String brandnoticeUpdateForm(CommunityDto cb_dto, Model model) {
	    model.addAttribute("viewCBdao", cb_dao.CommunityView(cb_dto.getCb_no()));
	    return "admin/community/cb_brandnoticeUpdateForm";
	}
	
	@RequestMapping("/admin/community/cb_editorialInsertForm")
	public String editorialInsertForm() {
	    return "admin/community/cb_editorialInsertForm";
	}
	
	@RequestMapping("/admin/community/cb_editorialUpdateForm")
	public String editorialUpdateForm(CommunityDto cb_dto,Model model) {
		model.addAttribute("viewCBdao",cb_dao.CommunityView(cb_dto.getCb_no()));
		return "admin/community/cb_editorialUpdateForm";
	}
	
	@RequestMapping(value = "/member/community/cb_reviewInsertForm", method = RequestMethod.GET)
	public String reviewInsertForm(
	        @RequestParam(value = "p_no", required = false) Integer p_no,
	        Model model) {

	    if (p_no != null) {
	        ProductDto p_dto = p_dao.select_tea_product(p_no);
	        model.addAttribute("product", p_dto);
	    }
	    model.addAttribute("p_no", p_no);

	    return "member/community/cb_reviewInsertForm";
	}
	
	@RequestMapping("/member/community/cb_reviewUpdateForm")
	public String reviewUpdateForm(CommunityDto cb_dto,Model model) {
		model.addAttribute("viewCBdao",cb_dao.CommunityView(cb_dto.getCb_no()));
		return "member/community/cb_reviewUpdateForm";
	}
	
	@RequestMapping("/member/community/cb_qnaInsertForm")
	public String qnaInsertForm(@RequestParam(value = "p_no", required = false) Integer p_no, Model model) {

	    if (p_no != null) {
	        ProductDto p_dto = p_dao.select_tea_product(p_no);
	        model.addAttribute("product", p_dto);
	    }
	    model.addAttribute("p_no", p_no);

	    return "member/community/cb_qnaInsertForm";
	}
	
	@RequestMapping("/member/community/cb_qnaUpdateForm")
	public String qnaUpdateForm(CommunityDto cb_dto, Model model) {
	    model.addAttribute("viewCBdao", cb_dao.CommunityView(cb_dto.getCb_no()));
	    return "member/community/cb_qnaUpdateForm";
	}
	
	@RequestMapping("/admin/community/cb_qnaResponseInsertForm")
	public String qnaResponseInsertForm(@RequestParam("cb_no") int cb_no, Model model) {
	    model.addAttribute("viewRESdao", cb_dao.CommunityView(cb_no));
	    return "admin/community/cb_qnaResponseInsertForm";
	}
	
	@RequestMapping("/responseInsert")
	public String qnaResponseInsert(QnaResponseDto res_dto,@RequestParam("cb_no") int cb_no) {
		res_dto.setCb_no(cb_no);
		// res_dto.setM_no(m_no);
		cb_dao.ResponseQnaInsert(res_dto);
		return "redirect:/guest/community/cb_qnaList";
	}
	
	// 카테고리 -> 목록 페이지 경로 매핑
	private String getCategoryListUrl(String category) {
	    if (category == null) return "redirect:/main";

	    switch (category) {
	        case "브랜드소식":
	            return "redirect:/guest/community/cb_brandnoticeList";
	        case "에디토리얼":
	            return "redirect:/guest/community/cb_editorialList";
	        case "리뷰":
	            return "redirect:/guest/community/cb_reviewList";
	        case "Q&A":
	            return "redirect:/guest/community/cb_qnaList";
	        default:
	            return "redirect:/main";
	    }
	}
	
	@RequestMapping("/cb_communityInsert")
	public String communityInsert(CommunityDto cb_dto,
	                               @RequestParam(value = "files", required = false) List<MultipartFile> files) {

	    String uploadDir = "C:\\teasommelier\\src\\main\\resources\\static\\images\\community\\";
	    File dirCheck = new File(uploadDir);
	    if (!dirCheck.exists()) {
	        dirCheck.mkdirs();
	    }

	    List<String> savedFileNames = new ArrayList<>();
	    if (files != null) {
	        for (MultipartFile file : files) {
	            if (file != null && !file.isEmpty()) {
	                try {
	                    String originalName = file.getOriginalFilename();
	                    String savedName = UUID.randomUUID().toString() + "_" + originalName;
	                    file.transferTo(new File(uploadDir + savedName));
	                    savedFileNames.add(savedName);
	                } catch (IOException e) {
	                    e.printStackTrace();
	                }
	            }
	        }
	    }

	    cb_dto.setCb_file(String.join(",", savedFileNames));
	    cb_dao.CommunityInsert(cb_dto);

	    return getCategoryListUrl(cb_dto.getCb_category());
	}

	@RequestMapping("/cb_communityUpdate")
	public String communityUpdate(CommunityDto cb_dto,
	                               @RequestParam(value = "files", required = false) List<MultipartFile> files) {

	    String uploadDir = "C:\\teasommelier\\src\\main\\resources\\static\\images\\community\\";
	    File dirCheck = new File(uploadDir);
	    if (!dirCheck.exists()) {
	        dirCheck.mkdirs();
	    }

	    List<String> savedFileNames = new ArrayList<>();
	    if (files != null) {
	        for (MultipartFile file : files) {
	            if (file != null && !file.isEmpty()) {
	                try {
	                    String originalName = file.getOriginalFilename();
	                    String savedName = UUID.randomUUID().toString() + "_" + originalName;
	                    file.transferTo(new File(uploadDir + savedName));
	                    savedFileNames.add(savedName);
	                } catch (IOException e) {
	                    e.printStackTrace();
	                }
	            }
	        }
	    }

	    if (savedFileNames.isEmpty()) {
	        CommunityDto existing = cb_dao.CommunityView(cb_dto.getCb_no());
	        cb_dto.setCb_file(existing != null ? existing.getCb_file() : null);
	    } else {
	        cb_dto.setCb_file(String.join(",", savedFileNames));
	    }

	    cb_dao.CommunityUpdate(cb_dto);

	    return getCategoryListUrl(cb_dto.getCb_category());
	}
	
	@RequestMapping("/cb_communityDelete")
	public String CommunityDelete(@RequestParam("cb_no") int cb_no) {
	    CommunityDto existing = cb_dao.CommunityView(cb_no);
	    String category = (existing != null) ? existing.getCb_category() : null;

	    cb_dao.CommunityDelete(cb_no);

	    return getCategoryListUrl(category);
	}
	
}
  

//1. 조회수 1 증가 실행
// cb_dao.CommunityHit(cb_no);