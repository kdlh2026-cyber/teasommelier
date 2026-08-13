package com.springboot.teasommelier.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.springboot.teasommelier.dto.MemberDto;

@Mapper
public interface IMemberDao {
		//회원목록
		public List<MemberDto> MemberList();
		//회원가입
		public int MemberWrite(MemberDto m_dto);
		//회원정보 수정
		public int MemberUpdate(MemberDto m_dto);
		
		public int RefundUpdate(MemberDto m_dto);
		//회원탈퇴
		public int MemberDelete(String m_id);
		//탈퇴시 비밀번호
		public MemberDto MemberFindId(String m_id);
}	
