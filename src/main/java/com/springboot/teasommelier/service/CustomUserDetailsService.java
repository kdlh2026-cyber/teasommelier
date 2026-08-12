package com.springboot.teasommelier.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.springboot.teasommelier.auth.CustomUserDetails;
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
		
		List<GrantedAuthority> authorities = new ArrayList<>();
		authorities.add(new SimpleGrantedAuthority("ROLE_" + dto.getM_authority()));

		
		return new CustomUserDetails(
				dto.getM_id(),
				dto.getM_passwd(),
				authorities,
				dto.getM_no()
		);
	}
	
	

}
