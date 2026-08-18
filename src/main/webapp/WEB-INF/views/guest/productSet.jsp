<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title> 기프트 세트 </title>
<link rel="stylesheet" href="/css/productList.css">
</head>
<div class="product-page">
	<div>
		<%@ include file="/WEB-INF/views/header.jsp" %>
	</div>

    <!-- 대분류 탭 -->
    <div class="category-tabs">
        <a href="${pageContext.request.contextPath}/guest/productList" class="tab">티 제품</a>
        <a href="${pageContext.request.contextPath}/guest/productSet" class="tab active">기프트 세트</a>
        <a href="${pageContext.request.contextPath}/guest/productWear" class="tab">티 웨어</a>
        <a href="${pageContext.request.contextPath}/guest/productEvent" class="tab">이벤트</a>
    </div>
      <!-- 굵은 제목: 현재 선택된 상품종류 이름 (티백/잎차/미니 컬렉션 등) -->
    <h2 class="product-type-title">
    ${empty productType ? '기프트세트' : productType}
	</h2>
	
	<!-- 기프트 세트 종류 -->
	<div class="sub-tabs">
	
	    <a href="${pageContext.request.contextPath}/guest/productSet?productType=티백세트"
	       class="sub-tab ${productType eq '티백세트' ? 'active' : ''}">
	        티백 세트
	    </a>
	
	    <a href="${pageContext.request.contextPath}/guest/productSet?productType=잎차세트"
	       class="sub-tab ${productType eq '잎차세트' ? 'active' : ''}">
	        잎차 세트
	    </a>
	
	</div>
	
    <!-- 세부 필터: 상품종류(p_type)에 따라 필터 목록이 달라짐 -->
    <c:if test="${productType eq '티백세트'}">
    <div class="filter-tabs">
        <a href="${pageContext.request.contextPath}/guest/productSet?productType=${productType}&filter=티백" class="filter ${empty filter or filter eq '티백' ? 'active' : ''}">티백세트</a>
    </div>
    </c:if>
    <c:if test="${productType eq '잎차세트'}">
    <div class="filter-tabs">
        <a href="${pageContext.request.contextPath}/guest/productSet?productType=${productType}&filter=잎차" class="filter ${empty filter or filter eq '잎차' ? 'active' : ''}">잎차세트</a>
    </div>
    </c:if>
    

    <!-- 정렬 탭 -->
    <div class="sort-tabs">
        <a href="${pageContext.request.contextPath}/guest/productSet?productType=${productType}&filter=${filter}&sort=new" class="sort-link ${sort eq 'new' ? 'active' : ''}">신상품 |</a>
        <a href="${pageContext.request.contextPath}/guest/productSet?productType=${productType}&filter=${filter}&sort=name" class="sort-link ${sort eq 'name' ? 'active' : ''}">상품명 |</a>
        <a href="${pageContext.request.contextPath}/guest/productSet?productType=${productType}&filter=${filter}&sort=best" class="sort-link ${sort eq 'best' ? 'active' : ''}">인기상품 |</a>
    	<a href="${pageContext.request.contextPath}/guest/productSet?productType=${productType}&filter=${filter}&sort=hits" class="sort-link ${sort eq 'hits' ? 'active' : ''}">조회수</a>
    </div>

    <!-- 상품 목록 카드 그리드 (3열) -->
    <div class="product-grid">
        <c:forEach var="product" items="${productSet}">
            <div class="product-card">
                <!-- 상품 이미지 + 상세페이지 링크 (호버시 p_img2로 전환) -->
                <a href="${pageContext.request.contextPath}/guest/productDetail?p_no=${product.p_no}" class="img-wrap">
                    <img class="card-img img-default" src="/images/product/${product.p_img}" alt="${product.p_name}">
                    <c:if test="${not empty product.p_img2}">
                        <img class="card-img img-hover" src="/images/product/${product.p_img2}" alt="${product.p_name}">
                    </c:if>
                </a>
                <div class="product-name">
                    <a href="${pageContext.request.contextPath}/guest/productDetail?p_no=${product.p_no}">${product.p_name}</a>
                </div>
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
    </div>

    <!-- 페이지네이션: 전체 69개 상품 (1페이지 60개 + 2페이지 9개) -->
    <div class="pagination">
        <a href="${pageContext.request.contextPath}/guest/productSet?productType=${productType}&filter=${filter}&sort=${sort}&page=${pageNum > 1 ? pageNum - 1 : 1}" class="page-btn page-prev">PREV</a>
        <c:forEach var="i" begin="1" end="${totalPage}">
            <a href="${pageContext.request.contextPath}/guest/productSet?productType=${productType}&filter=${filter}&sort=${sort}&page=${i}" class="page-btn page-num ${pageNum eq i ? 'active' : ''}">${i}</a>
        </c:forEach>
        <a href="${pageContext.request.contextPath}/guest/productSet?productType=${productType}&filter=${filter}&sort=${sort}&page=${pageNum < totalPage ? pageNum + 1 : totalPage}" class="page-btn page-next">NEXT</a>
    </div>
	<div>
        <%@ include file="/WEB-INF/views/footer.jsp" %>
    </div>
</div>
</html>
