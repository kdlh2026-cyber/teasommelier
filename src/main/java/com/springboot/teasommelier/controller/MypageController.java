package com.springboot.teasommelier.controller;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.springboot.teasommelier.dao.IMemberDao;
import com.springboot.teasommelier.dao.IShippingaddrDao;
import com.springboot.teasommelier.dao.IorderDAO;
import com.springboot.teasommelier.dto.MemberDto;
import com.springboot.teasommelier.dto.OrderDTO;
import com.springboot.teasommelier.dto.ShippingaddrDto;

import jakarta.servlet.http.HttpServletRequest;


@Controller
public class MypageController {
	@Autowired
	IShippingaddrDao s_dao;
	
	@Autowired
	IMemberDao m_dao;
	
	@Autowired
	IorderDAO ordao;
			
	//마이페이지 적립금은 여기서
	@RequestMapping("/member/mypage/MemberCash")
	public String memberCash(Principal principal, Model model) {
	    if (principal == null) {
	        return "redirect:/login";
	    }
	    
	    String m_id = principal.getName();
	    MemberDto member = m_dao.MemberFindId(m_id); 
	    
	    // 디버그용 출력
	    System.out.println("로그인 아이디: " + m_id);
	    System.out.println("조회된 회원 객체: " + member);
	    
	    if (member != null) {
	        System.out.println("회원 번호(m_no): " + member.getM_no());
	        System.out.println("회원 적립금(m_cash): " + member.getM_cash());
	        
	        List<OrderDTO> memberCashList = ordao.memberCashList(member.getM_no());
	        System.out.println("조회된 적립금 내역 개수: " + (memberCashList != null ? memberCashList.size() : 0));
	        
	        model.addAttribute("member", member);
	        model.addAttribute("memberCashList", memberCashList);
	    }
	    
	    return "member/mypage/MemberCash";
	}
	
	//마이페이지 배송주소 관리는 여기서
	@RequestMapping("/member/mypage/ShipaddrManagement")
	public String ShipaddrManagement(Authentication authentication, Model model){
		
		if(authentication != null) {
			String m_id = authentication.getName();
			MemberDto m_dto = m_dao.MemberFindId(m_id);
			model.addAttribute("m_dto", m_dto);
			model.addAttribute("ShippingaddrList", s_dao.ShippingaddrList(m_id));
		}
		return "member/mypage/ShipaddrManagement";
	}
		
	@RequestMapping("/member/mypage/ShipaddrWriteForm")
	public String ShipaddrWriteForm(@RequestParam(value="m_no", required=false) Integer m_no,
			Model model){
		model.addAttribute("m_no", m_no);
		return "member/mypage/ShipaddrWriteForm";
	}
	
	@RequestMapping("/ShipaddrWrite")
	public String ShipaddrWrite(HttpServletRequest request, ShippingaddrDto s_dto,
			@RequestParam(value="m_no", required=false) Integer m_no) {
		
		String s_phone1 = request.getParameter("s_phone1");
		String s_phone2 = request.getParameter("s_phone2");
		String s_phone3 = request.getParameter("s_phone3");
		String s_tel1 = request.getParameter("s_tel1");
		String s_tel2 = request.getParameter("s_tel2");
		String s_tel3 = request.getParameter("s_tel3");
		String s_addr1 = request.getParameter("s_addr1");
		String s_addr2 = request.getParameter("s_addr2");
		String s_defaddr = request.getParameter("s_defaddr");
		
		s_dto.setS_addr(s_addr1+","+s_addr2);
		s_dto.setS_tel(s_tel1+"-"+s_tel2+"-"+s_tel3);
		s_dto.setS_phone(s_phone1+"-"+s_phone2+"-"+s_phone3);
		
		if(s_defaddr == null) {
			s_defaddr="F";
			s_dto.setS_defaddr(s_defaddr);
		}
		
		s_dao.ShippingaddrWrite(s_dto);
		
		return "redirect:/member/mypage/ShipaddrManagement";
	}

	@RequestMapping("/member/mypage/ShippingaddrUpdateForm")
	public String ShippingaddrUpdateForm(Model model, @RequestParam(value="s_no", required=false) Integer s_no) {
		
		ShippingaddrDto s_dto = s_dao.FindNo(s_no);
		model.addAttribute("AddrlistUpdate", s_dto);
		
		return "member/mypage/ShippingaddrUpdateForm";
	}
	@RequestMapping("/ShippingaddrUpdate")
	public String ShippingaddrUpdate(HttpServletRequest request, ShippingaddrDto s_dto) {
		
		String s_tel1 = request.getParameter("s_tel1");
		String s_tel2 = request.getParameter("s_tel2");
		String s_tel3 = request.getParameter("s_tel3");
		String s_phone1 = request.getParameter("s_phone1");
		String s_phone2 = request.getParameter("s_phone2");
		String s_phone3 = request.getParameter("s_phone3");
		String s_addr1 = request.getParameter("s_addr1");
		String s_addr2 = request.getParameter("s_addr2");
		String s_defaddr = request.getParameter("s_defaddr");
		
		s_dto.setS_addr(s_addr1+","+s_addr2);
		s_dto.setS_tel(s_tel1+"-"+s_tel2+"-"+s_tel3);
		s_dto.setS_phone(s_phone1+"-"+s_phone2+"-"+s_phone3);
		
		if(s_defaddr == null) {
			s_defaddr="F";
			s_dto.setS_defaddr(s_defaddr);
		}
		
		s_dao.ShippingaddrUpdate(s_dto);
		return "redirect:/member/mypage/ShipaddrManagement";
	}
	
	@RequestMapping("/ShippingaddrDelete")
	public String MemberDelete(@RequestParam(value = "addr_chk", required = false) List<Integer> s_noList) {
	    if (s_noList != null && !s_noList.isEmpty()) {
	        s_dao.ShippingaddrDelete(s_noList);
	    }
	    return "redirect:/member/mypage/ShipaddrManagement";
	}
}
