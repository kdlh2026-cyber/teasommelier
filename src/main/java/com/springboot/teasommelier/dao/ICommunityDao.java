package com.springboot.teasommelier.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.springboot.teasommelier.dto.CommunityDto;

@Mapper
public interface ICommunityDao {
	public List<CommunityDto> CommunityList();
	
	public List<CommunityDto> CommunityList_category(String cb_category);
	
	public CommunityDto CommunityView(int cb_no);
	
	public int CommunityInsert(CommunityDto cb_dto);
	
	public int CommunityUpdate(CommunityDto cb_dto);
	
	public int CommunityDelete(int cb_no);
	
	public int CommunityHit(int cb_no);
}
