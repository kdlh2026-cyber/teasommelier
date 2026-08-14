package com.springboot.teasommelier.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.springboot.teasommelier.dao.IMemberDao;
import com.springboot.teasommelier.dao.IcartDAO;
import com.springboot.teasommelier.dto.MemberDto;
import com.springboot.teasommelier.dto.cartDTO;

import jakarta.servlet.http.HttpSession;

@Controller
public class cartController {
	@Autowired
	private IcartDAO ca_dao;

	@Autowired
	private IMemberDao memberDao;
	
	// 로그인 회원의 m_no 가져오기
	private int getMno(Authentication authentication) {
		String m_id = authentication.getName();
		MemberDto member = memberDao.MemberFindId(m_id);
		
		return member.getM_no();
	}

	// 장바구니 담기(회원과 비회원을 구별하여)
		@RequestMapping("/insertCart")
		public String insertCart(cartDTO ca_dto,
								 Authentication authentication,
								 HttpSession session) {
			
			boolean loggedIn = authentication != null
		            && authentication.isAuthenticated()
		            && !"anonymousUser".equals(authentication.getPrincipal());
			
			if(loggedIn) {
				int m_no = getMno(authentication);
				ca_dto.setM_no(m_no);
				ca_dao.insertCart(ca_dto);
			} else {
				// 비회원은 세션으로 리스트 형식의 장바구니 담기
				List<cartDTO> cart = (List<cartDTO>) session.getAttribute("guestCart");
				
				if(cart == null) {
					cart = new ArrayList<>();
				}
				
				// 동일 상품이 있는 지 확인
				boolean found = false;
				
				for(cartDTO item : cart) {
					if(item.getP_no() == ca_dto.getP_no()) {
						item.setCa_qty(
							item.getCa_qty() + ca_dto.getCa_qty()
						);
						
						found = true;
						break;
					}
				}
				
				// 새로운 상품이면 추가
				// 비회원도 장바구니에서 상품을 삭제 주문해야하기에 가상의 ca_no 값을 부여
				// 음수값으로 지정하여 실제 DB에 양수 ca_no와 충돌을 피하기  
				if(!found) {
					ca_dto.setCa_no(-(cart.size()+1));
					ca_dto.setCa_del("기본배송");
					cart.add(ca_dto);
				}
				
				session.setAttribute("guestCart", cart);
			}
			
			return "redirect:/cart";
		}
	// 장바구니 목록
	@RequestMapping("/cartList")
	public String cartList() {
		return "redirect:/cart";
	}

	// 장바구니 조회
	@RequestMapping("/cart")
	public String cart(Model model,
					   Authentication authentication,
					   HttpSession session) {
		
		List<cartDTO> list;
		
		boolean loggedIn = authentication != null
	            && authentication.isAuthenticated()
	            && !"anonymousUser".equals(authentication.getPrincipal());
		
		if(loggedIn) {
			int m_no = getMno(authentication);
			list = ca_dao.cartList(m_no);
		}else {
			list = (List<cartDTO>) session.getAttribute("guestCart");
			
			if(list == null) {
				list = new ArrayList<>();
			}
		}
		
		model.addAttribute("list", list);
		
		return "cart";
	}

	// 장바구니 상품 삭제(선택, 모두)
	@RequestMapping("/deleteCarts")
	public String deleteCarts(@RequestParam(required = false) String ca_no,
							Authentication authentication,
							HttpSession session,
							cartDTO cadto) {
		
		boolean isloggedIn = authentication != null
	            && authentication.isAuthenticated()
	            && !"anonymousUser".equals(authentication.getPrincipal());
		
		// 상품번호가 없는 경우 
		if(ca_no == null || ca_no.trim().isEmpty() || "all".equals(ca_no)) {
			if(isloggedIn) {
				int m_no = getMno(authentication);
				ca_dao.deleteAll(m_no);
			}else {
				session.removeAttribute("guestCart");
			}
			return "redirect:/cart";
		}
		
		List<Integer> nos = Arrays.stream(ca_no.split(","))
				   .map(Integer::parseInt)
				   .collect(Collectors.toList());
		
		if(isloggedIn) {
			int m_no = getMno(authentication);
			ca_dao.deleteCarts(m_no, nos);
		}else {
			List<cartDTO> cart = (List<cartDTO>) session.getAttribute("guestCart");
			
			if(cart != null) {
				cart.removeIf(item -> nos.contains(item.getCa_no()));
				session.setAttribute("guestCart", cart);
			}
		}
		
		return "redirect:/cart";
	}
	
	// 장바구니 상품 주문하기
	@RequestMapping("/orderCart")
	public String orderCart(Authentication authentication,
							HttpSession session,
							cartDTO cartdto,
							Model model) {
		
		
		
		return "";
	}
}

















