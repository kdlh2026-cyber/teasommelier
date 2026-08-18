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
	private String p_img;

	// 회원 테이블과 조인할 때
	private String m_id;
	private String m_name;
	private String m_phone;
	private String m_email;
	private String m_addr;
	private String m_zipno;
	private String m_cash;
	
	// 관심상품을 List<cartDTO> 담을 떄
	private int f_no;
	private String f_image;
	private String f_info;
	private int f_price;
	private Date f_date;
}
