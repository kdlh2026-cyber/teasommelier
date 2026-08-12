package com.springboot.teasommelier.dto;

import lombok.Data;

@Data
public class CustomerServiceDto {
	private int cs_no;
	private String cs_category;
	private String cs_subject;
	private String cs_content;
}
