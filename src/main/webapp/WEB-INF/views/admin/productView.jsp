<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 상세 정보</title>
</head>
<body>
    <%@ include file="../header.jsp" %>
    <h1>상품 상세 정보</h1>
    
    <table border="1" width="800">
    	<tr>
            <td rowspan=8 width=150><img src="/images/product/${product.p_img}" width="100"></td>
        </tr>
        <tr>
            <th>상품번호</th>
            <td colspan=3>${product.p_no}</td>
       </tr>
       <tr>    
            <th>상품명</th>
            <td colspan=3>${product.p_name}</td>
        </tr>
        <tr>
            <th>가격</th>
            <td colspan=3><fmt:formatNumber value="${product.p_price}" pattern="#,###" />원</td>
        </tr>
        <tr>
            <th>용량</th>
            <td>${product.p_capacity}</td>
            <th>재고</th>
            <td>${product.p_stock}</td>
        </tr>
        <tr>
            <th>상품 카테고리</th>
            <td>${product.p_category}</td>
            <th>상품 종류</th>
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
            <td colspan=3>${product.p_desc}</td>
        </tr>
    </table>

    <a href="/admin/productLists">목록으로</a>
    <a href="/admin/productModify?p_no=${product.p_no}">수정하기</a>
    <a href="/admin/productDelete?p_no=${product.p_no}">삭제하기</a>    
    
    <%@ include file="../footer.jsp" %>
</body>
</html>