package com.springboot.teasommelier.controller;

import java.security.Principal;
import java.util.List;
import java.util.stream.Collectors;

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
	
	// 관심상품 삭제(선택, 모두)
	@RequestMapping("/deleteFav")
	public String deleteFav(@RequestParam(value="f_no", required = false) List<String> f_noList,
							Principal principal){
		
		MemberDto member = memberDao.MemberFindId(principal.getName());
		int m_no = member.getM_no();
		
		// 전체 삭제
		if(f_noList == null || f_noList.isEmpty() || (f_noList.size() == 1 && "all".equals(f_noList.get(0)))){
			favDAO.deleteFavAll(m_no);
			return "redirect:/myFavorite";
		}
		
		// 선택 삭제
		List<Integer> nos = f_noList.stream()
							.map(Integer::parseInt)
							.collect(Collectors.toList());
		
		favDAO.deleteFav(m_no, nos);
		
		return "redirect:/myFavorite";
	}
}
