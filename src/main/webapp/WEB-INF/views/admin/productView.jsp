<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 상세 정보</title>
<!-- 구글 폰트 Noto Sans KR 불러오기 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;600;700&display=swap" rel="stylesheet">
<style>
.product-detail-wrap {
    max-width: 1000px;
    margin: 40px auto;
    padding: 0 20px;
    font-family: 'Noto Sans KR', sans-serif;
    color: #333;
}

/* 제목 + 설명 (다른 관리자 페이지와 통일) */
.header {
    display: flex;
    align-items: center;
    gap: 15px;
    margin-bottom: 20px;
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

/* 상세 정보 테이블 스타일 */
table.detail-table {
    width: 100%;
    border-collapse: collapse;
    border-top: 1px solid #e5e5e5;
    border-bottom: 1px solid #e5e5e5;
    font-size: 14px;
    font-family: 'Noto Sans KR', sans-serif;
}

table.detail-table th {
    background-color: #fafafa;
    width: 15%;
    padding: 14px 15px;
    border-bottom: 1px solid #eee;
    font-weight: 600;
    text-align: center;
    color: #333;
}

table.detail-table td {
    padding: 14px 15px;
    border-bottom: 1px solid #eee;
    color: #555;
    vertical-align: middle;
}

/* 이미지 셀 */
.product-img-cell {
    text-align: center;
    width: 200px;
    background-color: #fff;
}

.product-img-cell img {
    max-width: 160px;
    height: auto;
    border: 1px solid #f0f0f0;
}

/* 상세설명 내용 영역 */
.desc-content {
    line-height: 1.6;
    white-space: pre-wrap; /* 줄바꿈 유지 */
}

/* 하단 버튼 그룹 */
.button-group {
    margin-top: 25px;
    display: flex;
    justify-content: space-between;
}

.button-group-right {
    display: flex;
    gap: 8px;
}

/* 기본 네모 버튼 (.btn 클래스 통일) */
.btn {
    padding: 8px 16px;
    background: #fff;
    border: 1px solid #ccc;
    cursor: pointer;
    text-decoration: none;
    color: #333;
    font-size: 13px;
    display: inline-block;
    font-family: 'Noto Sans KR', sans-serif;
    border-radius: 0;
    transition: background-color 0.2s ease;
}

.btn:hover {
    background: #f5f5f5;
}

/* 삭제 버튼 강조 (선택 사항) */
.btn-delete {
    border-color: #d9534f;
    color: #d9534f;
}

.btn-delete:hover {
    background: #d9534f;
    color: #fff;
}
</style>
</head>
<body>
    <%@ include file="../header.jsp" %>
    
    <div class="product-detail-wrap">
        <div class="header">
            <h3>상품 상세 정보</h3>
            <p>등록된 상품의 세부 정보를 확인하고 수정할 수 있습니다.</p>
        </div>
        
        <table class="detail-table">
            <tr>
                <td rowspan="8" class="product-img-cell">
                    <img src="/images/product/${product.p_img}" alt="상품이미지">
                </td>
                <th>상품번호</th>
                <td colspan="3">${product.p_no}</td>
            </tr>
            <tr>    
                <th>상품명</th>
                <td colspan="3"><strong>${product.p_name}</strong></td>
            </tr>
            <tr>
                <th>가격</th>
                <td colspan="3"><fmt:formatNumber value="${product.p_price}" pattern="#,###" />원</td>
            </tr>
            <tr>
                <th>용량</th>
                <td>${product.p_capacity}</td>
                <th>재고</th>
                <td>${product.p_stock}개</td>
            </tr>
            <tr>
                <th>카테고리</th>
                <td>${product.p_category}</td>
                <th>종류</th>
                <td>${product.p_type}</td>
            </tr>
            <tr>
                <th>상태여부</th>
                <td>${product.p_sale}</td>
                <th>유통기한</th>
                <td>${product.p_time}</td>
            </tr>
            <tr>
                <th>상세설명</th>
                <td colspan="3" class="desc-content">
                   <img src="/images/product/${product.p_img2}" alt="상품이미지">}
                </td>
            </tr>
        </table>

        <div class="button-group">
            <a href="/admin/productLists" class="btn">목록으로</a>
            <div class="button-group-right">
                <a href="/admin/productModify?p_no=${product.p_no}" class="btn">수정하기</a>
                <a href="/admin/productDelete?p_no=${product.p_no}" class="btn btn-delete" onclick="return confirm('정말 삭제하시겠습니까?');">삭제하기</a>    
            </div>
        </div>
    </div>
    
    <%@ include file="../footer.jsp" %>
</body>
</html>