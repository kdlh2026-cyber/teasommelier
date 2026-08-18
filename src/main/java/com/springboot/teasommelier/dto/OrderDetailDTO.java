package com.springboot.teasommelier.dto;

import lombok.Data;

@Data
public class OrderDetailDTO {
	private int od_no;
	private int od_qty;
	private String od_product;
	private int od_price;
	private int o_no;
	private int p_no;
	
	// 상품과 join할 때
	private String p_name;
	private int p_price;
	private String p_img;
	
	private String m_name;
	private String m_id;
}
