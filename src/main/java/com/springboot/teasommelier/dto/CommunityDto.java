package com.springboot.teasommelier.dto;

import java.util.Date;

import lombok.Data;

@Data
public class CommunityDto {
	private int cb_no;
	private String cb_category;
	private Date cb_date;
	private String cb_subject;
	private int cb_rating;
	private String cb_content;
	private int cb_view_count;
	private String cb_url;
	private String cb_file;
	private int p_no;
	private int m_no;
}
