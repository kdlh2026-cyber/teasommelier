package com.springboot.teasommelier.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.springboot.teasommelier.dao.IMemberDao;
import com.springboot.teasommelier.dto.MemberDto;

import jakarta.servlet.http.HttpServletRequest;


@Controller
public class MemberController {
	@Autowired
	private IMemberDao m_dao;
	
	@Autowired
	private PasswordEncoder passwordEncoder;
	
	@RequestMapping("/MemberWrite")
	public String MemberWrite(HttpServletRequest request, MemberDto m_dto) {
		String m_tel1 = request.getParameter("m_tel1");
		String m_tel2 = request.getParameter("m_tel2");
		String m_tel3 = request.getParameter("m_tel3");
		String m_addr1 = request.getParameter("m_addr1");
		String m_addr2 = request.getParameter("m_addr2");
		
		m_dto.setM_tel(m_tel1+"-"+m_tel2+"-"+m_tel3);
		m_dto.setM_addr(m_addr1+","+m_addr2);
		
		m_dto.setM_passwd(passwordEncoder.encode(m_dto.getM_passwd()));
		
		m_dao.MemberWrite(m_dto);
		
		return "redirect:main";
	}

	@RequestMapping("/member/passwordCheckForm")
	public String passwordCheckForm(HttpServletRequest request, Model model) {
		String mode =request.getParameter("mode"); // update, delete 공통사용
		model.addAttribute("mode", mode);
		return "member/passwordCheckForm";
	}

	@RequestMapping("/member/passwordCheck")
	public String passwordCheck(Authentication authentication,HttpServletRequest request, Model model){
		String mode = request.getParameter("mode"); // update, delete 공통사용
		String m_passwd = request.getParameter("m_passwd");	
		String m_id = authentication.getName();
		MemberDto m_dto = m_dao.MemberFindId(m_id);

		if(m_dto != null && passwordEncoder.matches(m_passwd, m_dto.getM_passwd())) {
			if("update".equals(mode)) {
				model.addAttribute("MemberUpdate", m_dto);
				return "member/MemberUpdateForm";
				
			}else if("delete".equals(mode)) {
				
				m_dao.MemberDelete(m_id);
				return "redirect:/logout";
			}
		}
		
		model.addAttribute("msg", "비밀번호가 틀렸습니다.");
		model.addAttribute("mode", mode);
		
		return "member/passwordCheckForm";
	}
}
