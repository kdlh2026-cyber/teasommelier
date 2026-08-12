package com.springboot.teasommelier.dto;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class cartDTO {
	// 장바구니 테이블 속성
	private int ca_no;
	private String ca_image;
	private String ca_info;
	private int ca_qty;
	private int ca_price;
	private String ca_del;
	private Date ca_date;
	private int m_no;
	private int p_no;
	
	// 장바구니 페이지에서 주문할 상품 데이터를 전달할 자기자신의 list
	private List<cartDTO> cartDTOList; 
	
	// 상품 테이블과 조인할 때
	private String p_name;
	private int p_price;
	
	// 상품구매금액과 적립금 계산을 위한 필드, setter 만들지 않음
	private int amount;
	private int point;
	
	public int getAmount() {
		return amount;
	}
	
	public int getPoint() {
		return point;
	}
	
	// 계산 로직 관리
	public void calc() {
		this.amount = this.p_price * this.ca_qty;
		this.point = (int) (this.amount * 0.1);
	}
}
