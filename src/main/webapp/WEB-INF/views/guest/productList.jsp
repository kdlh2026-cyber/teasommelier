<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>티 제품</title>
<link rel="stylesheet" href="/css/productList.css">
</head>
<body>
<div class="product-page">
	<div>
		<%@ include file="/WEB-INF/views/header.jsp" %>
	</div>
    <!-- 대분류 탭 -->
    <div class="category-tabs">
        <a href="${pageContext.request.contextPath}/guest/productList" class="tab active">티 제품</a>
        <a href="${pageContext.request.contextPath}/guest/productSet" class="tab">기프트 세트</a>
        <a href="${pageContext.request.contextPath}/guest/productWear" class="tab">티 웨어</a>
        <a href="${pageContext.request.contextPath}/guest/productEvent" class="tab">이벤트</a>
    </div>
    <!-- 굵은 제목: 현재 선택된 상품종류 이름 (티백/잎차/미니 컬렉션 등) -->
    <h2 class="product-type-title">
    ${empty productType ? '티 제품' : productType}
	</h2>
    <!-- 티 제품 하위 6개 상품종류 (p_type 기준) -->
    <div class="sub-tabs">
        <a href="${pageContext.request.contextPath}/guest/productList?productType=티백" class="sub-tab ${productType eq '티백' ? 'active' : ''}">티백</a>
        <a href="${pageContext.request.contextPath}/guest/productList?productType=잎차" class="sub-tab ${productType eq '잎차' ? 'active' : ''}">잎차</a>
        <a href="${pageContext.request.contextPath}/guest/productList?productType=미니 컬렉션" class="sub-tab ${productType eq '미니 컬렉션' ? 'active' : ''}">미니 컬렉션</a>
        <a href="${pageContext.request.contextPath}/guest/productList?productType=디카페인 티" class="sub-tab ${productType eq '디카페인 티' ? 'active' : ''}">디카페인 티</a>
        <a href="${pageContext.request.contextPath}/guest/productList?productType=스테디셀러" class="sub-tab ${productType eq '스테디셀러' ? 'active' : ''}">스테디셀러</a>
        <a href="${pageContext.request.contextPath}/guest/productList?productType=티 프렌즈" class="sub-tab ${productType eq '티 프렌즈' ? 'active' : ''}">티 프렌즈</a>
    </div>
	
    <!-- 세부 필터: 상품종류(p_type)에 따라 필터 목록이 달라짐 -->
    <c:if test="${productType eq '티백'}">
    <div class="filter-tabs">
        <a href="${pageContext.request.contextPath}/guest/productList?productType=${productType}&filter=홍차" class="filter ${empty filter or filter eq '홍차' ? 'active' : ''}">홍차</a>
        <a href="${pageContext.request.contextPath}/guest/productList?productType=${productType}&filter=녹차" class="filter ${filter eq '녹차' ? 'active' : ''}">녹차</a>
        <a href="${pageContext.request.contextPath}/guest/productList?productType=${productType}&filter=루이보스" class="filter ${filter eq '루이보스' ? 'active' : ''}">루이보스</a>
        <a href="${pageContext.request.contextPath}/guest/productList?productType=${productType}&filter=청차(우롱차)" class="filter ${filter eq '청차(우롱차)' ? 'active' : ''}">청차(우롱차)</a>
        <a href="${pageContext.request.contextPath}/guest/productList?productType=${productType}&filter=허브차" class="filter ${filter eq '허브차' ? 'active' : ''}">허브차</a>
        <a href="${pageContext.request.contextPath}/guest/productList?productType=${productType}&filter=기타" class="filter ${filter eq '기타' ? 'active' : ''}">기타</a>
    </div>
    </c:if>
    <c:if test="${productType eq '잎차'}">
    <div class="filter-tabs">
        <a href="${pageContext.request.contextPath}/guest/productList?productType=${productType}&filter=홍차" class="filter ${empty filter or filter eq '홍차' ? 'active' : ''}">홍차</a>
        <a href="${pageContext.request.contextPath}/guest/productList?productType=${productType}&filter=녹차" class="filter ${filter eq '녹차' ? 'active' : ''}">녹차</a>
        <a href="${pageContext.request.contextPath}/guest/productList?productType=${productType}&filter=루이보스" class="filter ${filter eq '루이보스' ? 'active' : ''}">루이보스</a>
        <a href="${pageContext.request.contextPath}/guest/productList?productType=${productType}&filter=백차" class="filter ${filter eq '백차' ? 'active' : ''}">백차</a>
        <a href="${pageContext.request.contextPath}/guest/productList?productType=${productType}&filter=보이차" class="filter ${filter eq '보이차' ? 'active' : ''}">보이차</a>
    </div>
    </c:if>
    

    <!-- 정렬 탭 -->
    <div class="sort-tabs">
        <a href="${pageContext.request.contextPath}/guest/productList?productType=${productType}&filter=${filter}&sort=new" class="sort-link ${sort eq 'new' ? 'active' : ''}">신상품 |</a>
        <a href="${pageContext.request.contextPath}/guest/productList?productType=${productType}&filter=${filter}&sort=name" class="sort-link ${sort eq 'name' ? 'active' : ''}">상품명 |</a>
        <a href="${pageContext.request.contextPath}/guest/productList?productType=${productType}&filter=${filter}&sort=best" class="sort-link ${sort eq 'best' ? 'active' : ''}">인기상품 |</a>
    	<a href="${pageContext.request.contextPath}/guest/productList?productType=${productType}&filter=${filter}&sort=hits" class="sort-link ${sort eq 'hits' ? 'active' : ''}">조회수</a>
    </div>

    <!-- 상품 목록 카드 그리드 (3열) -->
<div class=".product-thumb-img">
<c:forEach var="product" items="${productList}">
    <div class="product-card">
        <!-- 상품 이미지 + 상세페이지 링크 -->
        <a href="${pageContext.request.contextPath}/guest/productDetail?p_no=${product.p_no}">
            <img class="product-thumb-img" src="/images/product/${product.p_img}" alt="${product.p_name}">
        </a>
        <!-- 상품명 (상세페이지 링크 포함) -->
        <div class="product-name">
            <a href="${pageContext.request.contextPath}/guest/productDetail?p_no=${product.p_no}">${product.p_name}</a>
        </div>
        <!-- 가격 -->
        <div class="product-price">
            <fmt:formatNumber value="${product.p_price}" pattern="#,###" />원
        </div>
        <c:if test="${not empty product.p_category}"><div class="info-line">${product.p_category}</div></c:if>
        <c:if test="${not empty product.p_type}"><div class="info-line">${product.p_type}</div></c:if>
        <c:if test="${not empty product.p_desc}"><div class="info-line">${product.p_desc}</div></c:if>
        <div class="product-capacity">${product.p_capacity}</div>
        <c:if test="${not empty product.p_sale and product.p_sale ne '판매중'}">
            <span class="badge-status">${product.p_sale}</span>
        </c:if>
    </div>
</c:forEach>

    <!-- 페이지네이션: 전체 69개 상품 (1페이지 60개 + 2페이지 9개) -->
    <div class="pagination">
        <a href="${pageContext.request.contextPath}/guest/productList?productType=${productType}&filter=${filter}&sort=${sort}&page=${pageNum > 1 ? pageNum - 1 : 1}" class="page-btn page-prev">PREV</a>
        <c:forEach var="i" begin="1" end="${totalPage}">
            <a href="${pageContext.request.contextPath}/guest/productList?productType=${productType}&filter=${filter}&sort=${sort}&page=${i}" class="page-btn page-num ${pageNum eq i ? 'active' : ''}">${i}</a>
        </c:forEach>
        <a href="${pageContext.request.contextPath}/guest/productList?productType=${productType}&filter=${filter}&sort=${sort}&page=${pageNum < totalPage ? pageNum + 1 : totalPage}" class="page-btn page-next">NEXT</a>
    </div>

</div>

</body>
</html>