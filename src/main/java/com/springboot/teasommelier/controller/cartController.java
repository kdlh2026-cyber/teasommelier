package com.springboot.teasommelier.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.springboot.teasommelier.dao.IMemberDao;
import com.springboot.teasommelier.dao.IProductDao;
import com.springboot.teasommelier.dao.IcartDAO;
import com.springboot.teasommelier.dto.MemberDto;
import com.springboot.teasommelier.dto.ProductDto;
import com.springboot.teasommelier.dto.cartDTO;

import jakarta.servlet.http.HttpSession;
import java.security.Principal;

@Controller
public class cartController {
	@Autowired
	private IcartDAO ca_dao;

	@Autowired
	private IMemberDao memberDao;
	
	@Autowired
	private IProductDao p_dao;
	
	// 장바구니 담기
	@RequestMapping("/insertCart")
	public String insertCart(cartDTO ca_dto,
							 Principal principal,
							 HttpSession session) {
		
		ProductDto product = p_dao.select_tea_product(ca_dto.getP_no());
		if (product == null) {
			return "redirect:/cart";
		}
		
		ca_dto.setCa_price(product.getP_price());
		ca_dto.setCa_image(product.getP_img());
		ca_dto.setCa_info(product.getP_name());
		
		int m_no = 0;
        if (principal != null) {
            MemberDto member = memberDao.MemberFindId(principal.getName());
            if (member != null) {
                m_no = member.getM_no();
            }
        }
		
		if (m_no > 0) {
			ca_dto.setM_no(m_no);
			ca_dao.insertCart(ca_dto);
		} else {
			List<cartDTO> cart = (List<cartDTO>) session.getAttribute("guestCart");
			if (cart == null) {
				cart = new ArrayList<>();
			}
			
			boolean found = false;
			for (cartDTO item : cart) {
				if (item.getP_no() == ca_dto.getP_no()) {
					item.setCa_qty(item.getCa_qty() + ca_dto.getCa_qty());
					found = true;
					break;
				}
			}
			
			if (!found) {
				ca_dto.setCa_no(-(cart.size() + 1));
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
	public String cart(Model model, Principal principal, HttpSession session) {
		List<cartDTO> list;
		
		int m_no = 0;
        if (principal != null) {
            MemberDto member = memberDao.MemberFindId(principal.getName());
            if (member != null) {
                m_no = member.getM_no();
            }
        }

		if (m_no > 0) {
			list = ca_dao.cartList(m_no);
		} else {
			list = (List<cartDTO>) session.getAttribute("guestCart");
			if (list == null) {
				list = new ArrayList<>();
			}
		}

		model.addAttribute("list", list);
		return "cart/cart";
	}

	// 장바구니 상품 삭제(선택, 모두)
	@RequestMapping("/deleteCarts")
	public String deleteCarts(@RequestParam(value = "ca_no", required = false) List<String> ca_noList,
							Principal principal,
							HttpSession session) {
		
		int m_no = 0;
        if (principal != null) {
            MemberDto member = memberDao.MemberFindId(principal.getName());
            if (member != null) {
                m_no = member.getM_no();
            }
        }
		
		if (ca_noList == null || ca_noList.isEmpty() || (ca_noList.size() == 1 && "all".equals(ca_noList.get(0)))) {
			if (m_no > 0) {
				ca_dao.deleteAll(m_no);
			} else {
				session.removeAttribute("guestCart");
			}
			return "redirect:/cart";
		}
		
		List<Integer> nos = ca_noList.stream()
				.map(Integer::parseInt)
				.collect(Collectors.toList());
		
		if (m_no > 0) {
			ca_dao.deleteCarts(m_no, nos);
		} else {
			List<cartDTO> cart = (List<cartDTO>) session.getAttribute("guestCart");
			if (cart != null) {
				cart.removeIf(item -> nos.contains(item.getCa_no()));
				session.setAttribute("guestCart", cart);
			}
		}
		
		return "redirect:/cart";
	}
	
	// 장바구니 수량 변경 후 DB 업데이트 한 다음에 카트로 넘어온다
	@RequestMapping("/updateCartQty")
	public String updateCartQty(@RequestParam("ca_no") int ca_no,
								@RequestParam("ca_qty") int ca_qty,
								Principal principal,
								HttpSession session) {
		
		int m_no = 0;
        if (principal != null) {
            MemberDto member = memberDao.MemberFindId(principal.getName());
            if (member != null) {
                m_no = member.getM_no();
            }
        }
		
		if (m_no > 0) {
			ca_dao.updateCartQty(m_no, ca_no, ca_qty);
		} else {
			List<cartDTO> cart = (List<cartDTO>) session.getAttribute("guestCart");
			if (cart != null) {
				for (cartDTO item : cart) {
					if (item.getCa_no() == ca_no) {
						item.setCa_qty(ca_qty);
						break;
					}
				}
				session.setAttribute("guestCart", cart);
			}
		}
		
		return "redirect:/cart";
	}
}