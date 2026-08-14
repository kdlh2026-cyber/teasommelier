package com.springboot.teasommelier.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.springboot.teasommelier.dto.ShippingaddrDto;

@Mapper
public interface IShippingaddrDao {
	//배송주소록 관리
	public List<ShippingaddrDto> ShippingaddrList();
	//배송지등록
	public int ShippingaddrWrite(ShippingaddrDto s_dto);
	//배송주소록 수정
	public int ShippingaddrUpdate(ShippingaddrDto s_dto);
	//주소록 삭제
	public int ShippingaddrDelete(List<Integer> s_noList);
}
