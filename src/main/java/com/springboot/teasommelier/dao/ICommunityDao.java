package com.springboot.teasommelier.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.springboot.teasommelier.dto.CommunityDto;
import com.springboot.teasommelier.dto.MemberDto;
import com.springboot.teasommelier.dto.QnaResponseDto;

@Mapper
public interface ICommunityDao {
	public List<CommunityDto> CommunityList();
	
	public List<CommunityDto> CommunityList_category(String cb_category);
	
	public List<CommunityDto> CommunityList_product(@Param("p_no") int p_no, @Param("cb_category") String cb_category);
	
	public CommunityDto CommunityView(int cb_no);
	
	public int CommunityInsert(CommunityDto cb_dto);
	
	public int CommunityUpdate(CommunityDto cb_dto);
	
	public int CommunityDelete(int cb_no);
	
	public int CommunityHit(int cb_no);
	
	public QnaResponseDto ResponseQnaView(int cb_no);

	public int ResponseQnaInsert(QnaResponseDto res_dto);

	public MemberDto findById(String m_id);

	public void ResponseQnaUpdate(QnaResponseDto res_dto);
	
	public int ResponseQnaDelete(int res_no);
	
	MemberDto select_member_by_id(String m_id);
}
