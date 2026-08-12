package com.springboot.teasommelier.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.springboot.teasommelier.dao.IMemberDao;
import com.springboot.teasommelier.dto.MemberDto;

@Service
public class CustomUserDetailsService implements UserDetailsService{
	@Autowired
	private IMemberDao dao;
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException{
		MemberDto dto = dao.MemberFindId(username);
		
		if(dto == null) {
			throw new UsernameNotFoundException("사용자가 없습니다");
		}
		
		return User.builder()
				   .username(dto.getM_id())
				   .password(dto.getM_passwd())
				   .roles(dto.getM_authority())
				   .build();
	}
	
	

}
