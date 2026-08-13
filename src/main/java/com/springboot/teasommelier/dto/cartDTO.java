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
	
	// 여러 개의 상품을 체크박스로 선택한 후 선택박스를 누를 떄 주로 사용
	private List<cartDTO> cartDTOList; 
	
	// 상품 테이블과 조인할 때
	private String p_name;
	private int p_price;
	public void setCartDTOList(List<String> cartDTOList2) {
		// TODO Auto-generated method stub
		
	}
	
}
