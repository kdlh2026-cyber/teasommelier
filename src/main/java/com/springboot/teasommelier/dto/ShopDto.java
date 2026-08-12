package com.springboot.teasommelier.dto;

import lombok.Data;

@Data
public class ShopDto {
	private int sh_no;
	private String sh_name;
	private int sh_lat;
	private int sh_lon;
	private String sh_img;
}
