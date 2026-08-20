<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 등록</title>
<!-- 구글 폰트 Noto Sans KR 불러오기 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;600;700&display=swap" rel="stylesheet">
<style>
.product-write-wrap {
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

/* 등록 폼 테이블 스타일 */
table.write-table {
    width: 100%;
    border-collapse: collapse;
    border-top: 1px solid #e5e5e5;
    border-bottom: 1px solid #e5e5e5;
    font-size: 14px;
    font-family: 'Noto Sans KR', sans-serif;
}

table.write-table th {
    background-color: #fafafa;
    width: 150px;
    padding: 14px 15px;
    border-bottom: 1px solid #eee;
    font-weight: 600;
    text-align: center;
    color: #333;
}

table.write-table td {
    padding: 12px 15px;
    border-bottom: 1px solid #eee;
    color: #555;
    vertical-align: middle;
}

/* 입력 필드 공통 디자인 */
table.write-table input[type="text"],
table.write-table textarea {
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

table.write-table input[type="text"]:focus,
table.write-table textarea:focus {
    border-color: #333;
}

table.write-table input[type="file"] {
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

/* 등록하기(저장) 강조 버튼 스타일 */
.btn-primary {
    background: #333;
    color: #fff;
    border-color: #333;
}

.btn-primary:hover {
    background: #444;
}
</style>
<script src="/js/productWrite.js"></script>
</head>
<body>
    <%@ include file="/WEB-INF/views/header.jsp" %>
    
    <div class="product-write-wrap">
        <div class="header">
            <h3>상품 등록</h3>
            <p>새로운 상품 정보를 입력하여 등록할 수 있습니다.</p>
        </div>
        
        <form name="product" method="post" action="/admin/productWritePro" enctype="multipart/form-data" onsubmit="return productCheck();">
            <table class="write-table">
                <tr>
                    <th>카테고리</th>
                    <td><input type="text" name="p_category" maxlength="10"></td>
                </tr>
                <tr>
                    <th>상품명</th>
                    <td><input type="text" name="p_name"></td>
                </tr>
                <tr>    
                    <th>가격</th>
                    <td><input type="text" name="p_price"></td>
                </tr>
                <tr>
                    <th>종류</th>
                    <td><input type="text" name="p_type"></td>
                </tr>
                <tr>
                    <th>용량</th>
                    <td><input type="text" name="p_capacity"></td>
                </tr>
                <tr>
                    <th>상세설명</th>
                    <td><input type="text" name="p_desc"></td>
                </tr>
                <tr>
                    <th>재고수량</th>
                    <td><input type="text" name="p_stock"></td>
                </tr>
                <tr>
                    <th>상태 여부</th>
                    <td><input type="text" name="p_sale"></td>
                </tr>
                <tr>
                    <th>유통기한</th>
                    <td><input type="text" name="p_time"></td>
                </tr>
                <tr>
                    <th>상품이미지1</th>
                    <td><input type="file" name="p_image"></td>
                </tr>
                <tr>
                    <th>상품이미지2</th>
                    <td><input type="file" name="p_image2"></td>
                </tr>
            </table>
            
            <div class="button-group">
                <button type="button" class="btn" onclick="history.back();">취소</button>
                <div class="button-group-right">
                    <input type="reset" value="작성 초기화" class="btn">
                    <input type="submit" value="등록하기" class="btn btn-primary">
                </div>
            </div>
        </form>
    </div>
    
    <%@ include file="/WEB-INF/views/footer.jsp" %>
</body>
</html>