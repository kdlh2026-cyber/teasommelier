package com.springboot.teasommelier.dto;

import java.util.Date;

import lombok.Data;

@Data
public class ProductDto {
	private int p_no;
	private String p_category;
	private String p_name;
	private	int p_price;
	private String p_type;
	private String p_desc;
	private String p_capacity;
	private	int p_stock;
	private String p_sale;
	private String p_img;
	private	Date p_date;
}
