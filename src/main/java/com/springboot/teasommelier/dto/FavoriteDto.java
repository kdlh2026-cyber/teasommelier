package com.springboot.teasommelier.dto;

import java.util.Date;

import lombok.Data;

@Data
public class FavoriteDto {
	private int f_no;
	private String f_image;
	private String f_info;
	private int f_price;
	private Date f_date;
	private int m_no;
	private int p_no;
	
	private String p_name;
	private int p_price;
	private String p_img;
}
