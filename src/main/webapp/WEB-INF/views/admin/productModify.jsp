<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 정보 수정</title>
</head>
<body>
    <%@ include file="../header.jsp" %>
    <h1>상품 정보 수정</h1>
	<form name="product" method="post" action="/admin/productUpdate" enctype="multipart/form-data">
		<input type="hidden" name="p_no" value="${product.p_no}">
		<table border=1>
			<tr>
				<th width=100>상품명</th>
				<td width=500><input type="text" name="p_name" value="${product.p_name}"></td>
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
		<input type="submit" value="수정하기" onclick="#">
		<input type="reset" value="작성취소" oncclick="history.back();">
	</form>
    
    <%@ include file="../footer.jsp" %>
</body>
</html>