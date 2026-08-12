package com.springboot.teasommelier.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.springboot.teasommelier.dao.ICommunityDao;
import com.springboot.teasommelier.dto.CommunityDto;

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
	public String brandnoticeList() {
		return "guest/cb_brandnoticeList";
	}
	
	@RequestMapping("/guest/cb_brandnoticeDetail")
	public String brandnoticeDetail() {
		return "guest/cb_brandnoticeDetail";
	}
	
	@RequestMapping("/guest/cb_editorialList")
	public String editorialList() {
		return "guest/cb_editorialList";
	}
	
	@RequestMapping("/guest/cb_reviewList")
	public String reviewList() {
		return "guest/cb_reviewList";
	}
	
	@RequestMapping("/guest/cb_qnaList")
	public String qnaList() {
		return "guest/cb_qnaList";
	}
	
	@RequestMapping("/member/cb_reviewForm")
	public String reviewForm(Model model) {
	    return "member/cb_reviewForm";
	}
	
	@RequestMapping("/member/cb_communityInsert")
	public String communityInsert(CommunityDto cb_dto,
	                               @RequestParam("m_no") int m_no,
	                               @RequestParam(value = "file1", required = false) MultipartFile file1,
	                               @RequestParam(value = "file2", required = false) MultipartFile file2,
	                               @RequestParam(value = "file3", required = false) MultipartFile file3,
	                               @RequestParam(value = "file4", required = false) MultipartFile file4,
	                               @RequestParam(value = "file5", required = false) MultipartFile file5) {
	    cb_dto.setM_no(m_no);
	    // 파일 저장 로직 + 파일 경로를 cb_dto 혹은 첨부파일 테이블에 세팅
	    cb_dao.CommunityInsert(cb_dto);
	    //cb_dao.insert(cb_dto, fileList); // 내부에서 category별 분기. 필요할 시 사용
	    return "redirect:/main";
	}
	
}
  

//1. 조회수 1 증가 실행
// communityDao.CommunityHit(cb_no);