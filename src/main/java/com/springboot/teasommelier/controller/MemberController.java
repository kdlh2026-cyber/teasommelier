package com.springboot.teasommelier.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.DateTimeException;
import java.time.LocalDate;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.springboot.teasommelier.dao.IMemberDao;
import com.springboot.teasommelier.dto.MemberDto;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


@Controller
public class MemberController {
	@Autowired
	private IMemberDao m_dao;
	
	@Autowired
	private PasswordEncoder passwordEncoder;
	
	@RequestMapping("/MemberWrite")
	public String MemberWrite(HttpServletRequest request, MemberDto m_dto, 
			@RequestParam(value="m_birth1", required=false) Integer m_birth1,
			@RequestParam(value="m_birth2", required=false) Integer m_birth2,
			@RequestParam(value="m_birth3", required=false) Integer m_birth3,
			HttpServletResponse response
			) throws IOException {
		
		String m_id = request.getParameter("m_id");
		String m_phone1 = request.getParameter("m_phone1");
		String m_phone2 = request.getParameter("m_phone2");
		String m_phone3 = request.getParameter("m_phone3");
		String m_tel1 = request.getParameter("m_tel1");
		String m_tel2 = request.getParameter("m_tel2");
		String m_tel3 = request.getParameter("m_tel3");
		String m_addr1 = request.getParameter("m_addr1");
		String m_addr2 = request.getParameter("m_addr2");
		String m_rsms = request.getParameter("m_rsms");
		String m_remail = request.getParameter("m_remail");
		
		MemberDto m_dtoid = m_dao.MemberFindId(m_id);
		
		if (m_dtoid != null) {
			response.setContentType("text/html; charset=UTF-8");
	        PrintWriter out = response.getWriter();
	        out.println("<script>");
	        out.println("alert('이미 존재하는 아이디입니다.');");
	        out.println("history.back();"); // 이전 페이지(작성 폼)로 이동하며 입력값 유지
	        out.println("</script>");
	        out.flush();
	        return null;
	    }
		
		m_dto.setM_addr(m_addr1+","+m_addr2);
		m_dto.setM_tel(m_tel1+"-"+m_tel2+"-"+m_tel3);
		m_dto.setM_phone(m_phone1+"-"+m_phone2+"-"+m_phone3);
		
		if(m_rsms == null) {
			m_rsms = "F";
			m_dto.setM_rsms(m_rsms);
		}
		
		if(m_remail == null) {
			m_remail = "F";
			m_dto.setM_remail(m_remail);
		}
		
		if (m_birth1 != null && m_birth2 != null && m_birth3 != null) {
	        try {
	            LocalDate m_birth = LocalDate.of(m_birth1, m_birth2, m_birth3);
	            m_dto.setM_birth(java.sql.Date.valueOf(m_birth));
	        } catch (DateTimeException e) {
	            m_dto.setM_birth(null);
	        }
	    } else {
	        m_dto.setM_birth(null);
	    }
		
		m_dto.setM_passwd(passwordEncoder.encode(m_dto.getM_passwd()));
		
		m_dao.MemberWrite(m_dto);
		
		return "redirect:main";
	}

	@RequestMapping("/member/MemberUpdateForm")
	public String passwordCheckForm(Authentication authentication, HttpServletRequest request, Model model) {
		String m_id = authentication.getName();
		MemberDto m_dto = m_dao.MemberFindId(m_id);
		model.addAttribute("MemberUpdate", m_dto);
		
		
		return "member/MemberUpdateForm";
	}
	
	@RequestMapping("/guest/jusoPopup")
	public String jusoPopup() {
		return "guest/jusoPopup";
	}
	
	@RequestMapping("/MemberUpdate")
	public String MemberUpdate(HttpServletRequest request, MemberDto m_dto, 
			@RequestParam(value="m_birth1", required=false) Integer m_birth1,
			@RequestParam(value="m_birth2", required=false) Integer m_birth2,
			@RequestParam(value="m_birth3", required=false) Integer m_birth3
			) throws IOException  {
		
		String m_phone1 = request.getParameter("m_phone1");
		String m_phone2 = request.getParameter("m_phone2");
		String m_phone3 = request.getParameter("m_phone3");
		String m_tel1 = request.getParameter("m_tel1");
		String m_tel2 = request.getParameter("m_tel2");
		String m_tel3 = request.getParameter("m_tel3");
		String m_addr1 = request.getParameter("m_addr1");
		String m_addr2 = request.getParameter("m_addr2");
		String m_rsms = request.getParameter("m_rsms");
		String m_remail = request.getParameter("m_remail");	
		
		m_dto.setM_addr(m_addr1+","+m_addr2);
		m_dto.setM_tel(m_tel1+"-"+m_tel2+"-"+m_tel3);
		m_dto.setM_phone(m_phone1+"-"+m_phone2+"-"+m_phone3);
		
		if(m_rsms == null) {
			m_rsms = "F";
			m_dto.setM_rsms(m_rsms);
		}
		
		if(m_remail == null) {
			m_remail = "F";
			m_dto.setM_remail(m_remail);
		}
		
		if (m_birth1 != null && m_birth2 != null && m_birth3 != null) {
	        try {
	            LocalDate m_birth = LocalDate.of(m_birth1, m_birth2, m_birth3);
	            m_dto.setM_birth(java.sql.Date.valueOf(m_birth));
	        } catch (DateTimeException e) {
	            m_dto.setM_birth(null);
	        }
	    } else {
	        m_dto.setM_birth(null);
	    }
		
		m_dto.setM_passwd(passwordEncoder.encode(m_dto.getM_passwd()));
		
		m_dao.MemberUpdate(m_dto);
		
		return "redirect:main";
	}
	
	@RequestMapping("/MemberDelete")
	public String MemberDelete(@RequestParam("m_id") String m_id) {
		
		m_dao.MemberDelete(m_id);
		
		return "redirect:logout";
	}
	
	@RequestMapping("/member/RefundAcc")
	public String RefundAcc(@RequestParam(value="m_id") String m_id, Model model) {
		
		model.addAttribute("m_id", m_id);
		
		return "member/RefundAcc";
	}
	
	@RequestMapping("/RefundUpdate")
	@ResponseBody
	public String RefundUpdate(MemberDto m_dto) {
		
		m_dao.RefundUpdate(m_dto);
		
		return "<script>"
		         + "window.close();"
		         + "</script>";
	}
	
	@RequestMapping("/admin/MemberList")
	public String MemberList(Model model) {
		model.addAttribute("MemberList", m_dao.MemberList());
		return "admin/MemberList";
	}
	@RequestMapping("/AdminMDelete")
	public String AdminMDelete(@RequestParam("m_id") String m_id) {
		
		m_dao.MemberDelete(m_id);
		
		return "redirect:admin/MemberList";
	}
	
}
