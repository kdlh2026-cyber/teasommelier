package com.springboot.teasommelier.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.springboot.teasommelier.dto.OrderDTO;
import com.springboot.teasommelier.dto.OrderDetailDTO;
import com.springboot.teasommelier.dto.cartDTO;

@Mapper
public interface IorderDAO {
	// 주문할 물품 조회
	// [결제 전]회원이 주문할 경우 회원 데이터(m_no)도 같이 불러와서 주문서에 자동 기입
	public List<cartDTO> orderList(@Param("caNoList") List<Integer> caNoList,
            					   @Param("m_no") Integer m_no);
	
	// 결제하기 버튼 클릭시 tea_order DB에 저장(orderInsert)
	public int orderInsert(OrderDTO orderDto);
	
	// 결제하기 버튼 클릭시 tea_order_detail DB에 저장(orderDetailInsert)
	public int orderDetailInsert(@Param("o_no") int o_no,
								 @Param("p_no") int p_no,
								 @Param("od_qty") int od_qty,
								 @Param("od_product") String od_product,
								 @Param("od_price") int od_price);
	
	// [결제 후] tea_order 조회, 배송지/결제정보 표시
	public OrderDTO orderHeader(int o_no);
	
	// [결제 후]주문 확인서에 회원의 주문내역 출력하기(tea_order join tea_order_detail, orderConfirm)
	public List<OrderDTO> orderDetailList(int o_no);
	
	// 관리자 페이지에서 회원들이 주문한 주문 목록 조회하기
	public List<OrderDTO> allOrderList();
	
	// 회원 마이페이지에서 본인의 주문정보 조회하기
	public List<OrderDTO> memberOrderList(@Param("m_no") int m_no);
	
	// [결제 후] 장바구니의 상품 정보 삭제
	public int deleteOrderCart(cartDTO cdto);
	
	// [결제 후] 관심상품의 상품 정보 삭제
	public int deleteOrderFavorite(@Param("f_no") int f_no,
								   @Param("m_no") int m_no);
	
	// [결제 후] 회원 테이블의 m_cash(적립금) 업데이트(-, +)
	public void updateMcash(@Param("m_no") int m_no,
							@Param("usedCash") int usedCash,
							@Param("earnCash") int earnCash);
	
	// 마이페이지 적립금 조회
	public List<OrderDTO> memberCashList(int m_no);
	
}
