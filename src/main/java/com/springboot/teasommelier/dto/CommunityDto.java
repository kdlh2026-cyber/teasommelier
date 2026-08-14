package com.springboot.teasommelier.dto;

import java.util.Date;

import lombok.Data;

@Data
public class CommunityDto {
	private int cb_no;
	private String cb_category;
	private String cb_qna_category;
	private Date cb_date;
	private String cb_subject;
	private Integer cb_rating;
	private String cb_content;
	private int cb_view_count;
	private String cb_url;
	private String cb_file;
	private Integer p_no;
	private Integer m_no;
	
	private String m_id;

	public String getM_id() { return m_id; }
	public void setM_id(String m_id) { this.m_id = m_id; }
}
