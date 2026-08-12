package com.springboot.teasommelier.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.springboot.teasommelier.dto.CustomerServiceDto;

@Mapper
public interface ICustomerServiceDao {
public List<CustomerServiceDto> CustomerServiceList();
	
	public CustomerServiceDto CustomerServiceView(int cs_no);
	
	public int CustomerServiceInsert(CustomerServiceDto cs_dto);
	
	public int CustomerServiceUpdate(CustomerServiceDto cs_dto);
	
	public int CustomerServiceDelete(int cs_no);
}