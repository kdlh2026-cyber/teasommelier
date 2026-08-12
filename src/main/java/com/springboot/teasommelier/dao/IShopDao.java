package com.springboot.teasommelier.dao;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import com.springboot.teasommelier.dto.ShopDto;

@Mapper
public interface IShopDao {
	// 매장 등록
	public int insert_tea_shop(ShopDto tea_shop);

	// 매장 전체 목록 조회
	public List<ShopDto> select_tea_shop_List();

	// 매장 상세 조회
	public ShopDto select_tea_shop(int sh_no);

	// 매장 수정
	public int update_tea_shop(ShopDto tea_shop);

	// 매장 삭제
	public int delete_tea_shop(int sh_no);
}
