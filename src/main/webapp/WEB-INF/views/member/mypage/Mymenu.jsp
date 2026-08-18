<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<ul>
	<li>
		<a href="../mypage/OrderSelect">주문조회</a>
	</li>
	<li>
		<a href="/myFavorite?m_no=${sessionScope.loginMember.m_no}">관심상품</a>
	</li>
	<li>
		<a href="../mypage/MemberCash">적립금</a>
	</li>
	<li>
		<a href="../mypage/CommunityManagement">게시물관리</a>
	</li>
	<li>
		<a href="../mypage/ShipaddrManagement">배송주소관리</a>
	</li>
	<li>
		<a href="../mypage/InqiryManagement">대량구매문의 관리</a>
	</li>
</ul>