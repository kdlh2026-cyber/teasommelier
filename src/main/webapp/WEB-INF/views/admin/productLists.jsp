<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 목록</title>
<!-- 구글 폰트 Noto Sans KR 불러오기 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;600;700&display=swap" rel="stylesheet">
<style>
.productlist {
    max-width: 1200px;
    margin: 40px auto;
    padding: 0 20px;
    font-family: 'Noto Sans KR', sans-serif;
    color: #333;
}

/* 제목 + 설명 (회원 목록과 통일) */
.header {
    display: flex;
    align-items: center;
    justify-content: space-between;
    margin-bottom: 20px;
}

.header-title-box {
    display: flex;
    align-items: center;
    gap: 15px;
}

.header h3 { 
    margin: 0; 
    font-size: 22px; 
    font-weight: 700; 
}

.header p { 
    margin: 0; 
    color: #888; 
    border-left: 1px solid #ddd; 
    padding-left: 15px; 
    font-size: 14px; 
}

/* 깔끔한 테이블 */
table {
    width: 100%;
    border-collapse: collapse;
    border-top: 1px solid #e5e5e5;
    border-bottom: 1px solid #e5e5e5;
    text-align: center;
    font-size: 14px;
    font-family: 'Noto Sans KR', sans-serif;
}

th {
    background-color: #fafafa;
    padding: 14px 10px;
    border-bottom: 1px solid #eee;
    font-weight: 600;
}

td {
    padding: 14px 10px;
    border-bottom: 1px solid #eee;
    vertical-align: middle;
}

/* 상품명 왼쪽 정렬 또는 이미지 정렬 */
td.product-name {
    text-align: left;
}

td.product-name a {
    color: #333;
    text-decoration: none;
}

td.product-name a:hover {
    text-decoration: underline;
}

/* 기본 네모 버튼 (.btn 클래스 통일) */
.btn {
    padding: 6px 14px;
    background: #fff;
    border: 1px solid #ccc;
    cursor: pointer;
    text-decoration: none;
    color: #333;
    font-size: 13px;
    display: inline-block;
    font-family: 'Noto Sans KR', sans-serif;
    border-radius: 0;
}

.btn:hover {
    background: #f5f5f5;
}

.bottom {
    margin-top: 20px;
}

/* 상품명 링크 및 마우스 오버(Hover) 효과 */
td.product-name a {
    color: #333;
    text-decoration: none;
    transition: color 0.2s ease; /* 색상이 부드럽게 변하도록 전환 효과 추가 */
}

td.product-name a:hover {
    color: #0066cc; /* 마우스 올렸을 때 변할 색상 (포인트 컬러 등 원하시는 색상으로 변경 가능) */
    text-decoration: underline;
}
</style>
</head>
<body>
<%@ include file="../header.jsp" %>
<div class="productlist">
    <div class="header">
        <div class="header-title-box">
            <h3>상품 목록</h3>
            <p>등록된 전체 상품 정보를 관리할 수 있습니다.</p>
        </div>
        <a href="/admin/productWriteForm" class="btn">상품 등록</a>
    </div>
    
    <table>
        <tr>
            <th>상품번호</th>
            <th>이미지</th>
            <th>상품명</th>
            <th>용량</th>
            <th>가격</th>
            <th>카테고리 | 종류</th>
            <th>재고</th>
            <th>상태/유통기한</th>
        </tr>
    <c:forEach var="item" items="${list}">
        <tr>
            <td>${item.p_no}</td>
            <td><img src="/images/product/${item.p_img}" width="50" alt="상품이미지"></td>
            <td class="product-name"><a href="/admin/productView?p_no=${item.p_no}">${item.p_name}</a></td>
            <td>${item.p_capacity}</td>
            <td><fmt:formatNumber value="${item.p_price}" pattern="#,###" />원</td>
            <td>${item.p_category} | ${item.p_type}</td>
            <td>${item.p_stock}</td>
            <td>${item.p_sale}</td>
        </tr>
    </c:forEach>
    </table>
    
    <div class="bottom">
        <a href="/main" class="btn">뒤로가기</a>
    </div>
</div>
<%@ include file="../footer.jsp" %>
</body>
</html>