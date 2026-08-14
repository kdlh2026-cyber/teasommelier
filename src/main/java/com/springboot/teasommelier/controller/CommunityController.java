package com.springboot.teasommelier.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.springboot.teasommelier.dao.ICommunityDao;
import com.springboot.teasommelier.dto.CommunityDto;
import com.springboot.teasommelier.dto.QnaResponseDto;

import jakarta.servlet.http.HttpSession;

@Controller
public class CommunityController {
	@Autowired
	ICommunityDao cb_dao;
	
	@RequestMapping("/cb_communityBoard")
	public String CBoard(){
		return "cb_communityBoard";
	}
	
	@RequestMapping("/guest/cb_brandnoticeList")
	public String brandnoticeList(Model model) {
	    model.addAttribute("brandnoticeList", cb_dao.CommunityList_category("브랜드소식"));
	    return "guest/cb_brandnoticeList";
	}
	
	@RequestMapping("/guest/cb_brandnoticeDetail")
	public String brandnoticeDetail(@RequestParam("cb_no") int cb_no,Model model) {
		model.addAttribute("viewCBdao",cb_dao.CommunityView(cb_no));
		cb_dao.CommunityHit(cb_no);
		return "guest/cb_brandnoticeDetail";
	}
	
	@RequestMapping("/guest/cb_editorialList")
	public String editorialList(Model model) {
		model.addAttribute("editorialList",cb_dao.CommunityList_category("에디토리얼"));
		return "guest/cb_editorialList";
	}
	
	@RequestMapping("/guest/cb_editorialDetail")
	public String editorialDetail(@RequestParam("cb_no") int cb_no,Model model) {
		model.addAttribute("viewCBdao",cb_dao.CommunityView(cb_no));
		cb_dao.CommunityHit(cb_no);
		return "guest/cb_editorialDetail";
	}
	
	@RequestMapping("/guest/cb_reviewList")
	public String reviewList(Model model) {
		model.addAttribute("reviewList",cb_dao.CommunityList_category("리뷰"));
		return "guest/cb_reviewList";
	}
	
	@RequestMapping("/guest/cb_reviewDetail")
	public String reviewDetail(@RequestParam("cb_no") int cb_no,Model model) {
		model.addAttribute("viewCBdao",cb_dao.CommunityView(cb_no));
		cb_dao.CommunityHit(cb_no);
		return "guest/cb_reviewDetail";
	}
	
	@RequestMapping("/guest/cb_qnaList")
	public String qnaList(Model model) {
		model.addAttribute("qnaList",cb_dao.CommunityList_category("Q&A"));
		return "guest/cb_qnaList";
	}
	
	@RequestMapping("/guest/cb_qnaDetail")
	public String qnaDetail(@RequestParam("cb_no") int cb_no, Model model) {
	    model.addAttribute("viewCBdao", cb_dao.CommunityView(cb_no));
	    model.addAttribute("responseQnaDto", cb_dao.ResponseQnaView(cb_no));
	    cb_dao.CommunityHit(cb_no);
	    return "guest/cb_qnaDetail";
	}
	
	@RequestMapping("/guest/cb_qnaResponseDetail")
	public String cb_qnaResponseDetail() {
		return "guest/cb_qnaResponseDetail";
	}
	
	@RequestMapping("/admin/cb_brandnoticeInsertForm")
	public String brandnoticeInsertForm() {
	    return "admin/cb_brandnoticeInsertForm";
	}
	
	@RequestMapping("/admin/cb_brandnoticeUpdateForm")
	public String brandnoticeUpdateForm(CommunityDto cb_dto, Model model) {
	    model.addAttribute("viewCBdao", cb_dao.CommunityView(cb_dto.getCb_no()));
	    return "admin/cb_brandnoticeUpdateForm";
	}
	
	@RequestMapping("/admin/cb_editorialInsertForm")
	public String editorialInsertForm() {
	    return "admin/cb_editorialInsertForm";
	}
	
	@RequestMapping("/admin/cb_editorialUpdateForm")
	public String editorialUpdateForm(CommunityDto cb_dto,Model model) {
		model.addAttribute("viewCBdao",cb_dao.CommunityView(cb_dto.getCb_no()));
		return "admin/cb_editorialUpdateForm";
	}
	
	@RequestMapping("/member/cb_reviewInsertForm")
	public String reviewInsertForm() {
	    return "member/cb_reviewInsertForm";
	}
	
	@RequestMapping("/member/cb_reviewUpdateForm")
	public String reviewUpdateForm(CommunityDto cb_dto,Model model) {
		model.addAttribute("viewCBdao",cb_dao.CommunityView(cb_dto.getCb_no()));
		return "member/cb_reviewUpdateForm";
	}
	
	@RequestMapping("/member/cb_qnaInsertForm")
	public String qnaInsertForm() {
	    return "member/cb_qnaInsertForm";
	}
	
	@RequestMapping("/member/cb_qnaUpdateForm")
	public String qnaUpdateForm(CommunityDto cb_dto,Model model) {
		model.addAttribute("viewCBdao",cb_dao.CommunityView(cb_dto.getCb_no()));
		return "member/cb_qnaUpdateForm";
	}
	
	@RequestMapping("/admin/cb_qnaResponseInsertForm")
	public String qnaResponseInsertForm(@RequestParam("cb_no") int cb_no, Model model) {
	    model.addAttribute("viewRESdao", cb_dao.CommunityView(cb_no));
	    return "admin/cb_qnaResponseInsertForm";
	}
	
	@RequestMapping("/admin/responseInsert")
	public String qnaResponseInsert(QnaResponseDto res_dto,@RequestParam("cb_no") int cb_no) {
		res_dto.setCb_no(cb_no);
		// res_dto.setM_no(m_no);
		cb_dao.ResponseQnaInsert(res_dto);
		return "redirect:/guest/cb_qnaList";
	}
	
	// 카테고리 -> 목록 페이지 경로 매핑
	private String getCategoryListUrl(String category) {
	    if (category == null) return "redirect:/main";

	    switch (category) {
	        case "브랜드소식":
	            return "redirect:/guest/cb_brandnoticeList";
	        case "에디토리얼":
	            return "redirect:/guest/cb_editorialList";
	        case "리뷰":
	            return "redirect:/guest/cb_reviewList";
	        case "Q&A":
	            return "redirect:/guest/cb_qnaList";
	        default:
	            return "redirect:/main";
	    }
	}
	
	@RequestMapping("/member/cb_communityInsert")
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

	@RequestMapping("/member/cb_communityUpdate")
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