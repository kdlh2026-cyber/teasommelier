package com.springboot.teasommelier.dto;

import lombok.Data;

@Data
public class QnaResponseDto {
	private int res_no;
	private String res_subject;
	private String res_content;
	private String res_date;
	private int res_view_count;
	private int m_no;
	private int cb_no;
}
