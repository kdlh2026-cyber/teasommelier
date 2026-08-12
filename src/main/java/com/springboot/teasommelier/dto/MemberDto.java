package com.springboot.teasommelier.dto;

import java.util.Date;

import lombok.Data;

@Data
public class MemberDto {
	private int m_no;
	private String m_id;
	private String m_passwd;
	private String m_name;
	private String m_zipno;
	private String m_addr;
	private String m_tel;
	private String m_phone;
	private Date m_date;
	private String m_email;
	private String m_gender;
	private Date m_birth;
	private String m_lscalendar;
	private String m_holder;
	private String m_bank;
	private String m_banknumber;
	private int m_cash;
	private String m_authority;
	private String m_rsms;
	private String m_remail;
}
