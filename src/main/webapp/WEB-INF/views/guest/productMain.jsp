<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<link rel="stylesheet" href="/css/productList.css">
<div>
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
</div>