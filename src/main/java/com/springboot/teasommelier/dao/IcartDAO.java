package com.springboot.teasommelier.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.springboot.teasommelier.dto.cartDTO;

@Mapper
public interface IcartDAO {
	// 장바구니 저장
	public int insertCart(cartDTO dto);
	
	// 장바구니 조회
	public List<cartDTO> cartList(int m_no);
	
	// 장바구니 상품 하나 이상 삭제
	public int deleteCarts(List<Integer> ca_no);
	
	// 장바구니 상품 모두 삭제
	public int deleteAll(int m_no);
}
