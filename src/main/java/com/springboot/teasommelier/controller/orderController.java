package com.springboot.teasommelier.controller;

import java.security.Principal;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.springboot.teasommelier.dao.IFavoriteDao;
import com.springboot.teasommelier.dao.IMemberDao;
import com.springboot.teasommelier.dao.IProductDao;
import com.springboot.teasommelier.dao.IcartDAO;
import com.springboot.teasommelier.dao.IorderDAO;
import com.springboot.teasommelier.dto.MemberDto;
import com.springboot.teasommelier.dto.OrderDTO;
import com.springboot.teasommelier.dto.ProductDto;
import com.springboot.teasommelier.dto.cartDTO;

import jakarta.servlet.http.HttpSession;

@Controller
public class orderController {
	@Autowired
	private IMemberDao memberDao;
	
	@Autowired
	private IorderDAO ordao;
	
	@Autowired
	private IcartDAO cadao;
	
	@Autowired
	private IProductDao pdao;
	
	@Autowired
	private IFavoriteDao favDAO;
	
	private int getMno(Principal principal) {
		String m_id = principal.getName();
		MemberDto member = memberDao.MemberFindId(m_id);
		return member.getM_no();
	}
	
	@RequestMapping("/orderWriteDirect")
	public String orderWriteDirect(@RequestParam("p_no") int p_no,
								   @RequestParam("ca_qty") int ca_qty,
								   Principal principal,
								   Model model) {
		
		ProductDto product = pdao.select_tea_product(p_no);
		
		cartDTO directItem = new cartDTO();
		directItem.setP_no(p_no);
		directItem.setCa_info(product.getP_name());
		directItem.setCa_price(product.getP_price());
		directItem.setCa_image(product.getP_img());
		directItem.setCa_qty(ca_qty);
		
		List<cartDTO> orderItems = new ArrayList<>();
		orderItems.add(directItem);
		
		model.addAttribute("orderItems", orderItems);
		
		boolean loggedIn = (principal != null);
		
		if (loggedIn) {
			MemberDto member = memberDao.MemberFindId(principal.getName());
			model.addAttribute("member", member);
		}
		
		model.addAttribute("orderType", "direct");
		
		return loggedIn ? "order/orderWriteMember" : "order/orderWriteGuest";
	}
	
	@RequestMapping("/orderWrite")
	public String orderWrite(@RequestParam("ca_no") List<Integer> caNoList,
						     Principal principal,
						     HttpSession session,
						     Model model,
						     cartDTO ca_dto) {

		boolean loggedIn = (principal != null);
		List<cartDTO> orderItems;

		if (loggedIn) {
			int m_no = getMno(principal);
			orderItems = ordao.orderList(caNoList, m_no);
			
			MemberDto member = memberDao.MemberFindId(principal.getName());
			model.addAttribute("member", member);
		} else {
			List<cartDTO> guestCart = (List<cartDTO>) session.getAttribute("guestCart");
			
			if (guestCart == null || guestCart.isEmpty()) {
				throw new IllegalStateException("비회원 장바구니 정보가 없거나 세션이 만료되었습니다.");
			}
			
			orderItems = guestCart.stream()
					.filter(item -> caNoList.contains(item.getCa_no()))
					.collect(Collectors.toList());
		}

		if (orderItems.isEmpty()) {
			return "redirect:/cart";
		}

		model.addAttribute("orderItems", orderItems);
		model.addAttribute("orderType", "cart");
	   
		return loggedIn ? "order/orderWriteMember" : "order/orderWriteGuest";
	}
	
	@RequestMapping("/orderWriteFav")
	public String orderWriteFav(@RequestParam("f_no") List<Integer> f_noList,
								Principal principal,
								Model model) {
		
		if (principal == null) {
			return "redirect:/login";
		}
		
		if (f_noList == null || f_noList.isEmpty()) {
	        return "redirect:/myFavorite";
	    }
		
		MemberDto member = memberDao.MemberFindId(principal.getName());
		
		int m_no = member.getM_no();
		List<cartDTO> orderItems = favDAO.getOrderItemsFromFav(m_no, f_noList);

		model.addAttribute("member", member);
		model.addAttribute("orderItems", orderItems);
		model.addAttribute("orderType", "favorite");
		model.addAttribute("f_no", f_noList);
		
		return "order/orderWriteMember";
	}
	
	@RequestMapping("/orderSubmit")
	public String orderSubmit(OrderDTO orderDto,
							 @RequestParam(value="ca_no", required=false) List<Integer> caNoList,
							 @RequestParam("o_phone1") String phone1,
							 @RequestParam("o_phone2") String phone2,
							 @RequestParam("o_phone3") String phone3,
							 @RequestParam("o_addr1") String addr1,
							 @RequestParam("o_addr2") String addr2,
							 @RequestParam("paymentId") String paymentId,
							 @RequestParam("orderType") String orderType,
							 @RequestParam(value="m_cash", required=false) Integer m_cash,
							 @RequestParam(value="p_no", required=false) Integer p_no,
							 @RequestParam(value="ca_qty", required=false) Integer ca_qty,
							 @RequestParam(value="f_no", required=false) List<Integer> fNoList,
							 Principal principal,
							 HttpSession session,
							 Model model) {
		
		orderDto.setPaymentId(paymentId);
		String o_phone = phone1 + "-" + phone2 + "-" + phone3;
		orderDto.setO_phone(o_phone);
		String o_addr = addr1 + "," + addr2;
		orderDto.setO_addr(o_addr);
		
		boolean loggedIn = (principal != null);
		orderDto.setM_no(loggedIn ? getMno(principal) : null);
		
		List<cartDTO> orderItems = new ArrayList<>();
		
		if("direct".equals(orderType)) {
			ProductDto pdto = pdao.select_tea_product(p_no);
			
			cartDTO cdto = new cartDTO();
	        cdto.setP_no(p_no);
	        cdto.setP_name(pdto.getP_name());
	        cdto.setCa_price(pdto.getP_price());
	        cdto.setCa_image(pdto.getP_img());
	        cdto.setCa_qty(ca_qty);
			
			orderItems.add(cdto);
			
		} else if("cart".equals(orderType)) {
			if(loggedIn) {
				orderItems = ordao.orderList(caNoList, orderDto.getM_no());
			} else {
				List<cartDTO> guestCart = (List<cartDTO>) session.getAttribute("guestCart");
				if (guestCart == null || guestCart.isEmpty()) {
					return "redirect:/cart";
				}
				orderItems = guestCart.stream()
					.filter(cart -> caNoList.contains(cart.getCa_no()))
					.collect(Collectors.toList());
			}
			
		} else if("favorite".equals(orderType)) {
			if(!loggedIn) {
				return "redirect:/login";
			}
			
			int m_no = orderDto.getM_no();
			orderItems = favDAO.getOrderItemsFromFav(m_no, fNoList);

			if(orderItems == null || orderItems.isEmpty()) {
				return "redirect:/myFavorite";
			}
		}
		
		int totalPrice = 0;
		for(cartDTO cdto : orderItems) {
			totalPrice += cdto.getCa_price() * cdto.getCa_qty();
		}
		
		int useCash = 0;
		if(m_cash != null) {
			useCash = m_cash;
		}
		
		int finalPrice = totalPrice - useCash;
		
		orderDto.setO_price(finalPrice);
		int earnPoint = (int) Math.floor(finalPrice * 0.01);
		orderDto.setO_earn(earnPoint);
		orderDto.setO_used_cash(useCash);
		
		ordao.orderInsert(orderDto);
		
		for(cartDTO cdto : orderItems) {
			ordao.orderDetailInsert(orderDto.getO_no(), cdto.getP_no(),
                				cdto.getCa_qty(), cdto.getP_name(),
                				cdto.getCa_price());
		};

		if("cart".equals(orderType)) {
		    if(loggedIn) {
		        int m_no = orderDto.getM_no();
		        for(cartDTO cdto : orderItems) {
		            cdto.setM_no(m_no);
		            ordao.deleteOrderCart(cdto);
		        }
		    } else {
		        List<cartDTO> guestCart = (List<cartDTO>) session.getAttribute("guestCart");
		        if(guestCart != null && caNoList != null) {
		            guestCart.removeIf(cart -> caNoList.contains(cart.getCa_no()));
		            session.setAttribute("guestCart", guestCart);
		        }
		    }
		}
		
		if("favorite".equals(orderType) && loggedIn) {
			int m_no = orderDto.getM_no();
			for(cartDTO cdto :orderItems) {
				int f_no = cdto.getF_no();
				ordao.deleteOrderFavorite(f_no, m_no);
			}
		}
		
		if(loggedIn) {
			ordao.updateMcash(orderDto.getM_no(), useCash, orderDto.getO_earn());
		}
		
		session.setAttribute("ono", orderDto.getO_no());
		
		return "redirect:/orderConfirm?o_no=" + orderDto.getO_no();
	}
	
	@RequestMapping("/orderConfirm")
	public String orderConfirm(@RequestParam("o_no") int o_no, Model model) {
		OrderDTO orderInfo = ordao.orderHeader(o_no);
		List<OrderDTO> orderDetails = ordao.orderDetailList(o_no);
		
		model.addAttribute("orderDetails", orderDetails);
		model.addAttribute("orderInfo", orderInfo);
		
		return "order/orderConfirm";
	}
	
	@RequestMapping("/admin/orderList")
	public String adminOrderList(Model model) {
		List<OrderDTO> orderList = ordao.allOrderList();
		model.addAttribute("orderList", orderList);
		
		return "admin/order/orderList";
	}
	
	// [수정 완료] OrderDTO로 통일하여 컴파일 에러 해결
	@RequestMapping("/admin/orderDetail")
	public String orderDetail(@RequestParam("o_no") int o_no, Model model) {
		OrderDTO orderInfo = ordao.orderHeader(o_no);
		List<OrderDTO> orderDetails = ordao.orderDetailList(o_no);
		
		model.addAttribute("orderInfo", orderInfo);
		model.addAttribute("orderDetails", orderDetails);
		
		return "admin/order/orderDetail";
	}
	
	@RequestMapping("/member/orderList")
	public String memberOrderList(Principal principal, Model model) {
	    int m_no = getMno(principal);
	    List<OrderDTO> orderList = ordao.memberOrderList(m_no);
	    model.addAttribute("memberOrder", orderList);
	    return "member/mypage/OrderSelect";
	}
	
	// 비회원주문 확인 기능
	@RequestMapping("/guestOrderConfirm")
	@ResponseBody
	public String guestOrderConfirm(@RequestParam("o_name") String o_name,
	                                @RequestParam("o_no") int o_no,
	                                @RequestParam("o_passwd") String o_passwd,
	                                Principal principal,
	                                Model model) {
			
		if (principal != null) {
			return "redirect:/member/orderList";
		}
			
		OrderDTO orderInfo = ordao.orderHeader(o_no);
		
		if (orderInfo == null || !orderInfo.getO_name().equals(o_name)) {
		    return "<script>alert('주문자 정보가 일치하지 않습니다.'); location.href='/login';</script>";
		}

		if (!orderInfo.getO_passwd().equals(o_passwd)) {
		    return "<script>alert('비밀번호가 일치하지 않습니다.'); location.href='/login';</script>";
		}
			
		List<OrderDTO> orderDetails = ordao.orderDetailList(o_no);
			
		model.addAttribute("orderDetails", orderDetails);
		model.addAttribute("orderInfo", orderInfo);
			
		return "<script>location.href='/orderConfirm?o_no=" + o_no + "';</script>";
	}
}