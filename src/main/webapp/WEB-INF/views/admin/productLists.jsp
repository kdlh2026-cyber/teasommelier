<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품목록 및 등록</title>
<style>
.productlist {
    max-width: 1200px;
    margin: 40px auto;
    padding: 0 20px;
    font-family: sans-serif;
    color: #333;
}
table {
    width: 100%;
    border-collapse: collapse;
    border-top: 1px solid #e5e5e5;
    border-bottom: 1px solid #e5e5e5;
    text-align: center;
    font-size: 14px;
}
th {
    background-color: #fafafa;
    padding: 10px 1px; 
    border-bottom: 1px solid #eee;
    font-weight: 600;
}

td {
    padding: 14px 10px;
    border-bottom: 1px solid #eee;
}
</style>
</head>
<body>
<%@ include file="../header.jsp" %>
<div class="productlist">
	<h1>상품목록</h1>
	<a href="/admin/productWriteForm">상품 등록</a>
	<table>
		<tr>
			<th>상품번호</th>
			<th>이미지</th>
			<th>상품명</th>
			<th>용량</th>
			<th>가격</th>
			<th>카테고리 | 종류</th>
			<th>재고</th>
			<th>유통기한</th>
			<th>상태</th>
		</tr>
	<c:forEach var="item" items="${list}">
		<tr>
			<td>${item.p_no}</td>
            <td><img src="/images/product/${item.p_img}" width="50"></td>
            <td><a href="/admin/productView?p_no=${item.p_no}">${item.p_name}</a></td>
            <td>${item.p_capacity}</td>
            <td>${item.p_capacity}</td>
            <td><fmt:formatNumber value="${item.p_price}" pattern="#,###" />원</td>
            <td>${item.p_category} | ${item.p_type}</td>
            <td>${item.p_stock}</td>
            <td>${item.p_sale}</td>
		</tr>
	</c:forEach>
	</table>
</div>
<%@ include file="../footer.jsp" %>
</body>
</html>