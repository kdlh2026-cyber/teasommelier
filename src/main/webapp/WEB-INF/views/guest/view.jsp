<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>제품 상세정보</h1>
	<form action="/insertCart" method="get">
		<input type="hidden" name="p_no" value="${view.p_no}">
		<input type="hidden" name="ca_image" value="${view.p_img}">	
		<input type="hidden" name="ca_info" value="${view.p_name}">	
		<input type="hidden" name="ca_price" value="${view.p_price}">		
	
		<table border=1 width=1200>
			<tr>
				<td rowspan=2><img src="/images/product/${view.p_img}" width=300></td>
				<td>${view.p_name}</td>
			</tr>
			<tr>
				<td>${view.p_price}</td>
			</tr>
		</table>
		<label>수량: </label>
    	<input type="number" name="ca_qty" value="1" min="1" max="99">
		<button type="submit">장바구니 담기</button>
		<a href="/insertFavorite?p_no=${view.p_no}">관심상품</a>
		<a href="#" onclick="location.href='/orderWriteDirect?p_no=${view.p_no}&ca_qty=' + document.querySelector('input[name=ca_qty]').value; return false;" class="btn">바로 구매하기</a>
	</form>
</body>
</html>