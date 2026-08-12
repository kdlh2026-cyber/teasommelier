package com.springboot.teasommelier.auth;

import java.util.Collection;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.User;

public class CustomUserDetails extends User {
	private int m_no;

	public CustomUserDetails(String username, String password,
			Collection<? extends GrantedAuthority> authorities, int m_no) {
		super(username, password, authorities);
		this.m_no = m_no;
	}

	public int getM_no() {
		return m_no;
	}
}