package com.springboot.teasommelier.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.springboot.teasommelier.dto.ProductDto;
@Mapper
public interface IProductDao {
	// 상품 등록
	public int insert_tea_product(ProductDto tea_product);
	
	// 티제품
	public List<ProductDto> select_tea_products_List();
	
	// 기프트 세트
	public List<ProductDto> select_tea_products_set();
	
	// 티 웨어 
	public List<ProductDto> select_tea_products_wear();
	
	// 이벤트
	public List<ProductDto> select_tea_products_event();
	
	//  조회
	public ProductDto select_tea_product(int p_no);
	
	// 상품 수정
	public int update_tea_product (ProductDto tea_product);
	
	// 상품 삭제
	public int delete_tea_product(int p_no);
}
