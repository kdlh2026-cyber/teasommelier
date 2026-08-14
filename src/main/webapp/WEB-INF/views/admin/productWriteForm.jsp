<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품등록</title>
</head>
<body>
	<h1>상품등록</h1>
	
	<form name="product" method="post" action="/admin/productWritePro" enctype="multipart/form-data">
		<table border=1>
			<tr>
				<th>카테고리</th>
				<td><input type="text" name="p_category"></td>
			</tr>
			<tr>
				<th width=100>상품명</th>
				<td width=500><input type="text" name="p_name"></td>
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
		<input type="submit" value="등록하기" onclick="#">
		<input type="reset" value="작성취소" oncclick="history.back();">
	</form>
</body>
</html>