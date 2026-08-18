package com.springboot.teasommelier.dto;

import lombok.Data;

@Data
public class ShopDto {
	private int sh_no;
	private String sh_name;
	private double sh_lat;   // int → double
	private double sh_lon;   // int → double
	private String sh_img;
}