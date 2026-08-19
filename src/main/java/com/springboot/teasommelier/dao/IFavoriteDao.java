package com.springboot.teasommelier.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.springboot.teasommelier.dto.FavoriteDto;
import com.springboot.teasommelier.dto.cartDTO;

@Mapper
public interface IFavoriteDao {
	// 마이페이지 관심상품에 저장
	public int insertFavorite(FavoriteDto fdto);
	
	// 마이페이지 관심상품 조회
	// 회원 사용가능(장바구니와 차이점)
	public List<FavoriteDto> favList(int m_no);
	
	// 관심상품 하나 이상 삭제
	public int deleteFav(@Param("m_no") int m_no,
						 @Param("f_no") List<Integer> f_no);
	
	// 관심상품 모두 삭제
	public int deleteFavAll(int m_no);
	
	// 선택한 관심상품
	public List<cartDTO> getOrderItemsFromFav(@Param("m_no") int m_no, 
			 @Param("f_noList") List<Integer> f_noList);
	
	// 관심상품에 중복된 상품이 있는지 확인
	public int checkFavorite(@Param("m_no") int m_no,
							 @Param("p_no") int p_no);
}
