package com.springboot.teasommelier.controller;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.springboot.teasommelier.dao.IFavoriteDao;
import com.springboot.teasommelier.dao.IMemberDao;
import com.springboot.teasommelier.dao.IProductDao;
import com.springboot.teasommelier.dto.FavoriteDto;
import com.springboot.teasommelier.dto.MemberDto;
import com.springboot.teasommelier.dto.ProductDto;

@Controller
public class FavoriteController {
	@Autowired
	private IMemberDao memberDao;
	
	@Autowired
	private IProductDao p_dao;
	
	@Autowired
	private IFavoriteDao favDAO;
	
	//관심상품 담기
	@RequestMapping("/insertFavorite")
	public String insertFavorite(@RequestParam("p_no") int p_no,
								 Principal principal) {
		
		if(principal == null) return "redirect:/login";
		
		String m_id = principal.getName();
		MemberDto member = memberDao.MemberFindId(m_id);
		if(member == null) return "redirect:/login";
		int m_no = member.getM_no();
		
		ProductDto product = p_dao.select_tea_product(p_no);
	
		FavoriteDto fdto = new FavoriteDto();
		fdto.setM_no(m_no);
		fdto.setP_no(p_no);
		fdto.setF_info(product.getP_name());
		fdto.setF_image(product.getP_img());
		fdto.setF_price(product.getP_price());
		
		int result = favDAO.insertFavorite(fdto);
		
		return "redirect:/myFavorite?m_no=" + m_no;
	}
	
	// 마이페이지 관심상품으로 이동
	@RequestMapping("/myFavorite")
	public String myFavorite(Principal principal,
							 Model model) {
		
		if(principal == null) return "redirect:/login";
		
		MemberDto member = memberDao.MemberFindId(principal.getName());
		model.addAttribute("fav", favDAO.favList(member.getM_no()));
		
		return "member/mypage/FavoriteProduct";
	}
}
