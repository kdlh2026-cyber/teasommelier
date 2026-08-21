<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이벤트</title>

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/productList.css">
</head>

<body>

<div class="product-page">
	<div>
		<%@ include file="/WEB-INF/views/header.jsp" %>
	</div>
    <!-- 대분류 탭 --> 
    <div class="category-tabs">
    <a href="${pageContext.request.contextPath}/guest/productList"class="tab">티 제품</a>
    <a href="${pageContext.request.contextPath}/guest/productSet"class="tab">기프트 세트</a>
 	<a href="${pageContext.request.contextPath}/guest/productWear"class="tab">티 웨어</a>
 	<a href="${pageContext.request.contextPath}/guest/productEvent"class="tab active">이벤트</a>
    </div>

    <!-- 현재 선택된 상품 종류 제목 -->
    <h2 class="product-type-title">${empty productType ? '이벤트' : productType}</h2>

    <!-- 이벤트 종류 -->
    <div class="sub-tabs">
        <a href="${pageContext.request.contextPath}/guest/productEvent?productType=UP%20TO%2050%25OFF"
           class="sub-tab ${productType eq 'UP TO 50%OFF' ? 'active' : ''}">
            UP TO 50%OFF
        </a>
    </div>

    <!-- 세부 필터 -->
    <!-- productType이 이벤트인 경우 -->
    <c:if test="${productType eq '이벤트'}">
        <div class="filter-tabs">
            <a href="${pageContext.request.contextPath}/guest/productEvent?productType=이벤트&filter=이벤트"
               class="filter ${empty filter or filter eq '이벤트' ? 'active' : ''}">
                이벤트</a>
        </div>
    </c:if>

    <!-- productType이 UP TO 50%OFF인 경우 -->
    <c:if test="${productType eq 'UP TO 50%OFF'}">
        <div class="filter-tabs">
            <a href="${pageContext.request.contextPath}/guest/productEvent?productType=UP%20TO%2050%25OFF&filter=UP%20TO%2050%25OFF"
               class="filter ${empty filter or filter eq 'UP TO 50%OFF' ? 'active' : ''}">
                UP TO 50%OFF
            </a>
        </div>
    </c:if>
    
    <!-- 정렬 탭 -->
    <div class="sort-tabs">
        <!-- 신상품 -->
        <a href="${pageContext.request.contextPath}/guest/productEvent?productType=${productType}&filter=${filter}&sort=new"
           class="sort-link ${sort eq 'new' ? 'active' : ''}">신상품 |</a>

        <!-- 상품명 -->
        <a href="${pageContext.request.contextPath}/guest/productEvent?productType=${productType}&filter=${filter}&sort=name"
           class="sort-link ${sort eq 'name' ? 'active' : ''}">상품명 |</a>

        <!-- 인기상품 -->
        <a href="${pageContext.request.contextPath}/guest/productEvent?productType=${productType}&filter=${filter}&sort=best"
           class="sort-link ${sort eq 'best' ? 'active' : ''}">인기상품 |</a>

        <!-- 조회수 -->
        <a href="${pageContext.request.contextPath}/guest/productEvent?productType=${productType}&filter=${filter}&sort=hits"
           class="sort-link ${sort eq 'hits' ? 'active' : ''}">조회수</a>
    </div>
    
    <!-- 상품 목록 -->
    <div class="product-grid">
        <c:forEach var="product" items="${productEvent}">
            <div class="product-card">

                <!-- 상품 이미지 + 상세페이지 링크 (호버시 p_img2로 전환) -->
                <a href="${pageContext.request.contextPath}/guest/productDetail?p_no=${product.p_no}" class="img-wrap">
                    <img class="card-img img-default" src="/images/product/${product.p_img}" alt="${product.p_name}">
                    <c:if test="${not empty product.p_img2}">
                        <img class="card-img img-hover" src="/images/product/${product.p_img2}" alt="${product.p_name}">
                    </c:if>
                </a>

     <!-- 상품명 -->
       <div class="product-name">
           <a href="${pageContext.request.contextPath}/guest/productDetail?p_no=${product.p_no}">
                      ${product.p_name}</a>
       </div>           
               <!-- 상품 가격 -->
                <div class="product-price">
                    <fmt:formatNumber
                        value="${product.p_price}"
                        pattern="#,###" />원
                </div>

                <!-- 상품 카테고리 -->
                <c:if test="${not empty product.p_category}">
                    <div class="info-line">
                        ${product.p_category}
                    </div>
                </c:if>

                <!-- 상품 종류 (이벤트 페이지 전용: UP TO 50%OFF 등을 다홍색으로 강조) -->
                <c:if test="${not empty product.p_type}">
                    <div class="info-line info-line-event">
                        ${product.p_type}
                    </div>
                </c:if>

                <!-- 상품 설명 -->
               <!--<c:if test="${not empty product.p_desc}"><div class="info-line">${product.p_desc} </div></c:if>  --> 

                <!-- 용량 -->
                <div class="product-capacity">
                    ${product.p_capacity}
                </div>

                <!-- 판매 상태 -->
                <c:if test="${not empty product.p_sale and product.p_sale ne '판매중'}">
                    <span class="badge-status">
                        ${product.p_sale}
                    </span>
                </c:if>
            </div>
        </c:forEach>
    </div>

    <!-- 상품이 없는 경우 -->
    <c:if test="${empty productEvent}">
        <div class="empty-product">
            등록된 이벤트 상품이 없습니다.
        </div>
    </c:if>

    <!-- 페이지네이션 -->
    <div class="pagination">
        <!-- PREV -->
        <a href="${pageContext.request.contextPath}/guest/productEvent?productType=${productType}&filter=${filter}&sort=${sort}&page=${pageNum > 1 ? pageNum - 1 : 1}"
           class="page-btn page-prev">PREV</a>


        <!-- 페이지 번호 -->
        <c:forEach var="i" begin="1" end="${totalPage}">
            <a href="${pageContext.request.contextPath}/guest/productEvent?productType=${productType}&filter=${filter}&sort=${sort}&page=${i}"
               class="page-btn page-num ${pageNum eq i ? 'active' : ''}">${i}</a>
        </c:forEach>


        <!-- NEXT -->
        <a href="${pageContext.request.contextPath}/guest/productEvent?productType=${productType}&filter=${filter}&sort=${sort}&page=${pageNum < totalPage ? pageNum + 1 : totalPage}"
           class="page-btn page-next">NEXT</a>
    </div>

</div>
<div>
        <%@ include file="/WEB-INF/views/footer.jsp" %>
    </div>
</body>
</html>
