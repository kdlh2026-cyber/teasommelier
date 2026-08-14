package com.springboot.teasommelier.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.springboot.teasommelier.dao.IInquiryDao;
import com.springboot.teasommelier.dto.InquiryDto;

@Controller
public class InqiryController {

	@Autowired
	private IInquiryDao inquiryDao;

	// 대량주문문의 작성폼 화면 (비회원도 접근 가능)
	@RequestMapping("/guest/inquiryWrite")
	public String inquiryWriteForm() {
		return "guest/inquiryWrite";
	}

	// 대량주문문의 등록 처리 (비회원도 등록 가능)
	@RequestMapping("/InquiryWrite")
	public String InquiryWrite(InquiryDto i_dto) {

		inquiryDao.insert_tea_inquiry(i_dto);

		return "redirect:/guest/inquiryWrite";
	}

	// 문의 목록 조회 (로그인한 회원만 가능)
	@RequestMapping("/member/inquiryList")
	public String inquiryList(Authentication authentication, Model model) {

		if (authentication == null) {
			return "redirect:/login";
		}

		List<InquiryDto> inquiryList = inquiryDao.select_tea_inquiry_List();
		model.addAttribute("inquiryList", inquiryList);

		return "member/inquiryList";
	}

	// 문의 상세 조회 (로그인한 회원만 가능)
	@RequestMapping("/member/inquiryDetail")
	public String inquiryDetail(Authentication authentication, @RequestParam("i_no") int i_no, Model model) {

		if (authentication == null) {
			return "redirect:/login";
		}

		InquiryDto i_dto = inquiryDao.select_tea_inquiry(i_no);
		model.addAttribute("inquiry", i_dto);

		return "member/inquiryDetail";
	}

	// 문의 수정폼 (로그인한 회원만 가능)
	@RequestMapping("/member/inquiryEditForm")
	public String inquiryEditForm(Authentication authentication, @RequestParam("i_no") int i_no, Model model) {

		if (authentication == null) {
			return "redirect:/login";
		}

		InquiryDto i_dto = inquiryDao.select_tea_inquiry(i_no);
		model.addAttribute("inquiry", i_dto);

		return "member/inquiryEdit";
	}

	// 문의 수정 처리 (로그인한 회원만 가능)
	@RequestMapping("/InquiryEdit")
	public String InquiryEdit(Authentication authentication, InquiryDto i_dto) {

		if (authentication == null) {
			return "redirect:/login";
		}

		inquiryDao.update_tea_inquiry(i_dto);

		return "redirect:/member/inquiryDetail?i_no=" + i_dto.getI_no();
	}

	// 문의 삭제 (로그인한 회원만 가능)
	@RequestMapping("/InquiryDelete")
	public String InquiryDelete(Authentication authentication, @RequestParam("i_no") int i_no) {

		if (authentication == null) {
			return "redirect:/login";
		}

		inquiryDao.delete_tea_inquiry(i_no);

		return "redirect:/member/inquiryList";
	}

	// 관리자 - 대량주문문의 전체 목록
	@RequestMapping("/admin/inquiryList")
	public String adminInquiryList(Model model) {

		List<InquiryDto> inquiryList = inquiryDao.select_tea_inquiry_List();
		model.addAttribute("inquiryList", inquiryList);

		return "admin/inquiryList";
	}

	// 관리자 - 대량주문문의 상세보기
	@RequestMapping("/admin/inquiryDetail")
	public String adminInquiryDetail(@RequestParam("i_no") int i_no, Model model) {

		InquiryDto i_dto = inquiryDao.select_tea_inquiry(i_no);
		model.addAttribute("inquiry", i_dto);

		return "admin/inquiryDetail";
	}

	// 관리자 - 문의 수정 처리
	@RequestMapping("/AdminInquiryEdit")
	public String AdminInquiryEdit(InquiryDto i_dto) {

		inquiryDao.update_tea_inquiry(i_dto);

		return "redirect:/admin/inquiryDetail?i_no=" + i_dto.getI_no();
	}

	// 관리자 - 문의 삭제
	@RequestMapping("/AdminInquiryDelete")
	public String AdminInquiryDelete(@RequestParam("i_no") int i_no) {

		inquiryDao.delete_tea_inquiry(i_no);

		return "redirect:/admin/inquiryList";
	}
}