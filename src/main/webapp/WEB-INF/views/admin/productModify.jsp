<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 정보 수정</title>
<script src="/js/productModify.js"></script>
<!-- 구글 폰트 Noto Sans KR 불러오기 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;600;700&display=swap" rel="stylesheet">
<style>
.product-modify-wrap {
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

/* 수정 폼 테이블 스타일 */
table.modify-table {
    width: 100%;
    border-collapse: collapse;
    border-top: 1px solid #e5e5e5;
    border-bottom: 1px solid #e5e5e5;
    font-size: 14px;
    font-family: 'Noto Sans KR', sans-serif;
}

table.modify-table th {
    background-color: #fafafa;
    width: 150px;
    padding: 14px 15px;
    border-bottom: 1px solid #eee;
    font-weight: 600;
    text-align: center;
    color: #333;
}

table.modify-table td {
    padding: 12px 15px;
    border-bottom: 1px solid #eee;
    color: #555;
    vertical-align: middle;
}

/* 입력 필드 공통 디자인 */
table.modify-table input[type="text"],
table.modify-table textarea {
    width: 100%;
    padding: 8px 12px;
    border: 1px solid #ddd;
    box-sizing: border-box;
    font-family: 'Noto Sans KR', sans-serif;
    font-size: 14px;
    color: #333;
    outline: none;
    transition: border-color 0.2s ease;
}

table.modify-table input[type="text"]:focus,
table.modify-table textarea:focus {
    border-color: #333;
}

table.modify-table input[type="file"] {
    font-family: 'Noto Sans KR', sans-serif;
    font-size: 13px;
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

/* 수정하기(저장) 강조 버튼 스타일 */
.btn-primary {
    background: #333;
    color: #fff;
    border-color: #333;
}

.btn-primary:hover {
    background: #444;
}
</style>
</head>
<body>
    <%@ include file="../header.jsp" %>
    
    <div class="product-modify-wrap">
        <div class="header">
            <h3>상품 정보 수정</h3>
            <p>등록된 상품의 세부 정보를 변경할 수 있습니다.</p>
        </div>
        
        <form name="product" method="post" action="/admin/productUpdate" enctype="multipart/form-data" onsubmit="return productCheck();">
            <input type="hidden" name="p_no" value="${product.p_no}">
            
            <table class="modify-table">
                <tr>
                    <th>상품명</th>
                    <td><input type="text" name="p_name" value="${product.p_name}"></td>
                </tr>
                <tr>
                    <th>카테고리</th>
                    <td><input type="text" name="p_category" value="${product.p_category}"></td>
                </tr>
                <tr>    
                    <th>가격</th>
                    <td><input type="text" name="p_price" value="${product.p_price}"></td>
                </tr>
                <tr>
                    <th>종류</th>
                    <td><input type="text" name="p_type" value="${product.p_type}"></td>
                </tr>
                <tr>
                    <th>상세설명</th>
                    <td><input type="text" name="p_desc" value="${product.p_desc}"></td>
                </tr>
                <tr>
                    <th>용량</th>
                    <td><input type="text" name="p_capacity" value="${product.p_capacity}"></td>
                </tr>
                <tr>
                    <th>재고수량</th>
                    <td><input type="text" name="p_stock" value="${product.p_stock}"></td>
                </tr>
                <tr>
                    <th>상태 여부</th>
                    <td><input type="text" name="p_sale" value="${product.p_sale}"></td>
                </tr>
                <tr>
                    <th>유통기한</th>
                    <td><input type="text" name="p_time" value="${product.p_time}"></td>
                </tr>
                <tr>
                    <th>상품이미지</th>
                    <td><input type="file" name="p_image"></td>
                </tr>
            </table>
            
            <div class="button-group">
                <!-- 취소 버튼에 history.back() 연결 복구 -->
                <button type="button" class="btn" onclick="history.back();">취소</button>
                <div class="button-group-right">
                    <input type="reset" value="작성 초기화" class="btn">
                    <input type="submit" value="수정하기" class="btn btn-primary">
                </div>
            </div>
        </form>
    </div>
    
    <%@ include file="../footer.jsp" %>
</body>
</html>