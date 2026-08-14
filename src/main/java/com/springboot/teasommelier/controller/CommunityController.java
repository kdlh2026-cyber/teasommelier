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
		return "guest/cb_reviewDetail";
	}
	
	@RequestMapping("/guest/cb_qnaList")
	public String qnaList(Model model) {
		model.addAttribute("qnaList",cb_dao.CommunityList_category("Q&A"));
		return "guest/cb_qnaList";
	}
	
	@RequestMapping("/guest/cb_qnaDetail")
	public String qnaDetail(@RequestParam("cb_no") int cb_no,Model model) {
		model.addAttribute("viewCBdao",cb_dao.CommunityView(cb_no));
		return "guest/cb_qnaDetail";
	}
	
	@RequestMapping("/admin/cb_brandnoticeInsertForm")
	public String brandnoticeInsertForm(Model model) {
	    return "admin/cb_brandnoticeInsertForm";
	}
	
	@RequestMapping("/admin/cb_brandnoticeUpdateForm")
	public String brandnoticeUpdateForm(CommunityDto cb_dto, Model model) {
	    model.addAttribute("viewCBdao", cb_dao.CommunityView(cb_dto.getCb_no()));
	    return "admin/cb_brandnoticeUpdateForm";
	}
	
	@RequestMapping("/admin/cb_editorialInsertForm")
	public String editorialInsertForm(Model model) {
	    return "admin/cb_editorialInsertForm";
	}
	
	@RequestMapping("/admin/cb_editorialUpdateForm")
	public String editorialUpdateForm(CommunityDto cb_dto,Model model) {
		model.addAttribute("viewCBdao",cb_dao.CommunityView(cb_dto.getCb_no()));
		return "admin/cb_editorialUpdateForm";
	}
	
	@RequestMapping("/member/cb_reviewInsertForm")
	public String reviewInsertForm(Model model) {
	    return "member/cb_reviewInsertForm";
	}
	
	@RequestMapping("/member/cb_reviewUpdateForm")
	public String reviewUpdateForm(CommunityDto cb_dto,Model model) {
		model.addAttribute("viewCBdao",cb_dao.CommunityView(cb_dto.getCb_no()));
		return "member/cb_reviewUpdateForm";
	}
	
	@RequestMapping("/member/cb_qnaInsertForm")
	public String qnaInsertForm(Model model) {
	    return "member/cb_qnaInsertForm";
	}
	
	@RequestMapping("/member/cb_qnaUpdateForm")
	public String qnaUpdateForm(CommunityDto cb_dto,Model model) {
		model.addAttribute("viewCBdao",cb_dao.CommunityView(cb_dto.getCb_no()));
		return "member/cb_qnaUpdateForm";
	}
	
	@RequestMapping("/admin/cb_qnaResponseInsertForm")
	public String qnaResponseInsertForm(CommunityDto cb_dto,Model model) {
		model.addAttribute("viewCBdao",cb_dao.CommunityView(cb_dto.getCb_no()));
		return "admin/cb_qnaResponseInsertForm";
	}
	
	@RequestMapping({"/admin/cb_communityInsertA", "/member/cb_communityInsertM"})
	public String communityInsert(CommunityDto cb_dto,
	                               @RequestParam(value = "m_no", required = false) Integer m_no,
	                               @RequestParam(value = "file1", required = false) MultipartFile file1,
	                               @RequestParam(value = "file2", required = false) MultipartFile file2,
	                               @RequestParam(value = "file3", required = false) MultipartFile file3,
	                               @RequestParam(value = "file4", required = false) MultipartFile file4,
	                               @RequestParam(value = "file5", required = false) MultipartFile file5) {

	    cb_dto.setM_no(m_no);

	    List<MultipartFile> fileList = Arrays.asList(file1, file2, file3, file4, file5);
	    List<String> savedFileNames = new ArrayList<>();

	    String uploadDir = "C:\\teasommelier\\src\\main\\resources\\static\\images\\community\\";
	    File dirCheck = new File(uploadDir);
	    if (!dirCheck.exists()) {
	        dirCheck.mkdirs();
	    }

	    for (MultipartFile file : fileList) {
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

	    cb_dto.setCb_file(String.join(",", savedFileNames));
	    cb_dao.CommunityInsert(cb_dto);

	    return "redirect:/main";
	}
	
	@RequestMapping({"/admin/cb_communityUpdateA","/member/cb_communityUpdateM"})
	public String communityUpdateA(CommunityDto cb_dto,
	                                @RequestParam(value = "m_no", required = false) Integer m_no,
	                                @RequestParam(value = "file1", required = false) MultipartFile file1,
	                                @RequestParam(value = "file2", required = false) MultipartFile file2,
	                                @RequestParam(value = "file3", required = false) MultipartFile file3,
	                                @RequestParam(value = "file4", required = false) MultipartFile file4,
	                                @RequestParam(value = "file5", required = false) MultipartFile file5) {
	    updateCommunity(cb_dto, m_no, file1, file2, file3, file4, file5);
	    return "redirect:/main";
	}

	// 공통 로직 (요청 매핑 없음, private)
	private void updateCommunity(CommunityDto cb_dto, Integer m_no,
	                              MultipartFile file1, MultipartFile file2,
	                              MultipartFile file3, MultipartFile file4,
	                              MultipartFile file5) {
	    cb_dto.setM_no(m_no);

	    List<MultipartFile> fileList = Arrays.asList(file1, file2, file3, file4, file5);
	    List<String> savedFileNames = new ArrayList<>();

	    String uploadDir = "C:\\teasommelier\\src\\main\\resources\\static\\images\\community\\";
	    File dirCheck = new File(uploadDir);
	    if (!dirCheck.exists()) {
	        dirCheck.mkdirs();
	    }

	    for (MultipartFile file : fileList) {
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

	    if (savedFileNames.isEmpty()) {
	        CommunityDto existing = cb_dao.CommunityView(cb_dto.getCb_no());
	        cb_dto.setCb_file(existing != null ? existing.getCb_file() : null);
	    } else {
	        cb_dto.setCb_file(String.join(",", savedFileNames));
	    }

	    cb_dao.CommunityUpdate(cb_dto);
	}
	
	@RequestMapping("/cb_communityDelete")
	public String CommunityDelete(@RequestParam("cb_no") int cb_no) {
		cb_dao.CommunityDelete(cb_no);
		return "redirect:/main";
	}
	
}
  

//1. 조회수 1 증가 실행
// communityDao.CommunityHit(cb_no);