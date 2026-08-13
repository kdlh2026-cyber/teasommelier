<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>티 제품</title>
<link rel="stylesheet" href="/css/productList.css">
</head>
<body>

<div class="product-page">

    <!-- 대분류 탭 -->
    <div class="category-tabs">
        <div class="tab active">티 제품</div>
        <div class="tab">기프트 세트</div>
        <div class="tab">티 웨어</div>
        <div class="tab">이벤트</div>
    </div>

    <!-- 티 제품 하위 6개 카테고리 -->
    <h2>티 제품</h2>
    <div class="filter-tabs">
    	<div class="filter">티백</div>
    	<div class="filter">잎차</div>
	    <div class="filter">미니 컬렉션</div>
	    <div class="filter">디카페인 티</div>
	    <div class="filter">스테디셀러</div>
	    <div class="filter">티 테디즈</div>
	 </div>

    <!-- 세부 필터 (티백 기준: 홍차/녹차/루이보스/청차/허브차/기타) -->
    <div class="filter-tabs">
        <div class="filter active">홍차</div>
        <div class="filter">녹차</div>
        <div class="filter">루이보스</div>
        <div class="filter">청차(우롱차)</div>
        <div class="filter">허브차</div>
        <div class="filter">기타</div>
    </div>
    
    <!-- 세부 필터 (잎차 기준: 잎차/홍차/루이보스/백차/보이차) -->
    <div class="filter-tabs">
        <div class="filter active">잎차</div>
        <div class="filter">홍차</div>
        <div class="filter">루이보스</div>
        <div class="filter">백차</div>
        <div class="filter">보이차</div>
    </div>
	 
	<!-- 신상품 상품명 인기상품 조회수 -->
	<div class="sub-tabs">
    <a href="${pageContext.request.contextPath}/product/list.do?category=${selectedCategory}&sort=new"
       class="sub-tab ${sortType eq 'new' ? 'active' : ''}">신상품</a>
    <div class="sub-tab">ㅣ</div>
    <a href="${pageContext.request.contextPath}/product/list.do?category=${selectedCategory}&sort=name"
       class="sub-tab ${sortType eq 'name' ? 'active' : ''}">상품명</a>
    <div class="sub-tab">ㅣ</div>
    <a href="${pageContext.request.contextPath}/product/list.do?category=${selectedCategory}&sort=best"
       class="sub-tab ${sortType eq 'best' ? 'active' : ''}">인기상품</a>
    <div class="sub-tab">ㅣ</div>
    <a href="${pageContext.request.contextPath}/product/list.do?category=${selectedCategory}&sort=view"
       class="sub-tab ${sortType eq 'view' ? 'active' : ''}">조회수</a>
	</div>
	
    <!-- 상품 카드 리스트 -->
    <div class="product-list">

        <c:forEach var="product" items="${productList}">
            <div class="product-card">

                <!-- 1. 이미지 (크게) -->
                <a href="/guest/productDetail?p_no=${product.p_no}" class="product-thumb">
                    <img src="${product.p_img}" alt="${product.p_name}">
                    <c:if test="${product.p_stock == 0}">
                        <span class="badge-soldout">품절</span>
                    </c:if>
                </a>

                <div class="product-info">

                    <!-- 2. 상품명 -->
                    <a href="/guest/productDetail?p_no=${product.p_no}" class="product-name">
                        ${product.p_name}
                    </a>

                    <!-- 3. 상품 간략설명 -->
                    <p class="product-desc">${product.p_desc}</p>

                    <!-- 4. 종류/용량 -->
                    <p class="product-summary">${product.p_type} (${product.p_capacity})</p>

                    <!-- 5. 가격 -->
                    <p class="product-price">${product.p_price}원</p>

                    <c:if test="${not empty product.p_sale}">
                        <span class="badge-sale">${product.p_sale}</span>
                    </c:if>

                </div>
            </div>
        </c:forEach>

    </div>

    <!-- 페이지네이션: 전체 69개 상품 (1페이지 60개 + 2페이지 9개) -->
    <div class="pagination">
    <div class="prev-next">PREV</div>
    <div class="page active">1</div>
    <div class="page">2</div>
    <div class="prev-next">NEXT</div>

	</div>
</body>
</html>
