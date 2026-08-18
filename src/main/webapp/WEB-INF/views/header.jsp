<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<link rel="stylesheet" href="/css/header.css">
<div class="header-container">
	<div class="header-logo">
		<a href="/main"><img src="/images/main_img/logo1.png" alt="이미지 로고"></a>
	</div>
	<nav class="header-nav">
		<a href="/guest/productList">티 제품</a>
		<a href="/guest/productTest">테스트</a>
		<a href="/guest/productSet">기프트세트</a>
		<a href="/guest/productWear">티 웨어</a>
		<a href="/guest/productEvent">이벤트</a>
		<a href="/guest/ShopList">매장 안내</a>
		<a href="/cb_communityBoard">커뮤니티</a>
		<a href="/guest/inquiryWrite">기업구매</a>
	</nav>
	<div class="login">
	<!--비회원-->
	<sec:authorize access="isAnonymous()">
		<div class="header-menu">
		<a href="/loginForm">로그인</a> 
		<a href="/guest/MemberWriteForm">회원가입</a> 
		<a href="/guest/">고객센터</a>
		<a href="/member/mypage/OrderSelect">
    		<img src="/images/main_img/mypage.png" alt="마이페이지">
		</a>
		<a href="/cartList">
			<img src="/images/main_img/cartlist.png" alt="장바구니">
		</a>
		<a href="#">
			<img src="/images/main_img/search.png" alt="검색">
		</a>
		</div>
	</sec:authorize>
	<!--일반회원-->
	<sec:authorize access="hasRole('USER')">
		<div class="header-menu">
		<a href="/logout">로그아웃</a>
		<a href="/member/MemberUpdateForm">정보수정</a>
		<a href="/guest/">고객센터</a>
		<a href="/member/mypage/OrderSelect">
    		<img src="/images/main_img/mypage.png" alt="마이페이지">
		</a>
		<a href="/cartList">
			<img src="/images/main_img/cartlist.png" alt="장바구니">
		</a>
		<a href="#">
			<img src="/images/main_img/search.png" alt="검색">
		</a>
		</div>
	</sec:authorize>
	<!--관리자-->
	<sec:authorize access="hasRole('ADMIN')">
		<span class="member-welcome"><sec:authentication property="principal.username"/>님 환영합니다.</span>
		<div class="header-menu">
		<a href="/logout">로그아웃</a>
		<a href="/admin/MemberList">회원목록</a>
		<a href="/admin/productLists">상품목록</a>
		<a href="#">주문목록</a>
		</div>
	</sec:authorize>
	</div>
</div>