package com.springboot.teasommelier.controller;

import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.springboot.teasommelier.auth.CustomUserDetails;
import com.springboot.teasommelier.dao.IcartDAO;
import com.springboot.teasommelier.dto.cartDTO;

@Controller
public class cartController {
	@Autowired
	private IcartDAO ca_dao;

	@RequestMapping("/insertCart")
	public String insertCart(cartDTO ca_dto, Authentication authentication) {
		int m_no = getMno(authentication);
		ca_dto.setM_no(m_no);
		ca_dao.insertCart(ca_dto);
		return "redirect:/cart";
	}

	@RequestMapping("/cartList")
	public String cartList() {
		return "redirect:/cart";
	}

	@RequestMapping("/cart")
	public String cart(Model model, Authentication authentication) {
		int m_no = getMno(authentication);
		List<cartDTO> list = ca_dao.cartList(m_no);
		list.forEach(cartDTO::calc);
		model.addAttribute("list", list);
		return "cart";
	}

	@RequestMapping("/deleteCart")
	public String deleteCart(@RequestParam String ca_no) {
		List<Integer> nos = Arrays.stream(ca_no.split(","))
								   .map(Integer::parseInt)
								   .collect(Collectors.toList());
		ca_dao.deleteCarts(nos);
		return "redirect:/cart";
	}

	@RequestMapping("/clearCart")
	public String clearCart(Authentication authentication) {
		int m_no = getMno(authentication);
		ca_dao.deleteAll(m_no);
		return "redirect:/cart";
	}

	private int getMno(Authentication authentication) {
		CustomUserDetails userDetails = (CustomUserDetails) authentication.getPrincipal();
		return userDetails.getM_no();
	}
}
