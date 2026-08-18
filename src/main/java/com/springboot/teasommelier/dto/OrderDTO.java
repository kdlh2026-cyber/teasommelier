package com.springboot.teasommelier.dto;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class OrderDTO {
	private int o_no;
	private Date o_date;
	private String o_deliver;
	private int o_price;
	private int o_earn;
	private String o_passwd;
	private String o_name;
	private String o_phone;
	private String o_zip;
	private String o_addr;
	private String o_email;
	private String o_message;
	private String o_pay;
	private Integer m_no;
	
	private List<cartDTO> orderItems;
	
	private String paymentId;
	
	private String m_name;
	private String m_id;
	
	private String p_img;
	private String p_name;
	
	private String od_product;
	private int od_qty;
	private int od_price;
}
