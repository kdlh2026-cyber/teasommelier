package com.springboot.teasommelier.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.springboot.teasommelier.dto.InquiryDto;
@Mapper
public interface IInquiryDao {

    void insert_tea_inquiry(InquiryDto i_dto);

    List<InquiryDto> selectMyInquiryList(@Param("m_id") String m_id);

    InquiryDto selectMyInquiry(@Param("i_no") int i_no, @Param("m_id") String m_id);

    void updateMyInquiry(InquiryDto i_dto);

    void deleteMyInquiry(@Param("i_no") int i_no, @Param("m_id") String m_id);

    List<InquiryDto> select_tea_inquiry_List();

    InquiryDto select_tea_inquiry(int i_no);

    void update_tea_inquiry(InquiryDto i_dto);

    void delete_tea_inquiry(int i_no);
}