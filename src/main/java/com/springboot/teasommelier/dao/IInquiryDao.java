package com.springboot.teasommelier.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.springboot.teasommelier.dto.InquiryDto;

@Mapper
public interface IInquiryDao {

	// 대량문의 등록
	public int insert_tea_inquiry(InquiryDto tea_inquiry);

	// 대량문의 목록 조회
	public List<InquiryDto> select_tea_inquiry_List();

	// 대량문의 단건 조회
	public InquiryDto select_tea_inquiry(int i_no);

	// 대량문의 수정
	public int update_tea_inquiry(InquiryDto tea_inquiry);

	// 대량문의 삭제
	public int delete_tea_inquiry(int i_no);
}
