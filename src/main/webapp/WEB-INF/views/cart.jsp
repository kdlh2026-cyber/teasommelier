<%-- <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니</title>
</head>
<body>
	<h1>CART</h1>
	<a href="/deleteCart">선택상품삭제</a>
	<form name="cartList" method="get" action="#">
		<table border=1 width=1000>
			<tr>
				<th><input type="checkbox" id="checkALL"></th>
				<th>이미지</th>
				<th>상품정보</th>
				<th>수량</th>
				<th>상품구매금액</th>
				<th>할인금액</th>
				<th>적립금</th>
				<th>배송구분</th>
				<th>배송비</th>
				<th>선택</th>
			</tr>
		<c:forEach var="list" items="${list}" varStatus="status">
			<tr>
				<td><input type="checkbox" name="ca_no" value="${list.ca_no}"></td>
				<td><a href="#"><img src="${list.ca_image}" width="50"></a></td>
				<td><a href="#">${list.p_name}</a></td>
				<td>${list.ca_qty}개</td> 
				<td><fmt:formatNumber value="${list.p_price * list.ca_qty}" type="number"/>원</td>
				<td>0원</td>
				<td><fmt:formatNumber value="${(list.p_price * list.ca_qty) * 0.1}" type="number"/>원</td>
				<td>${list.ca_del}</td>
				<td>무료</td> 
				<td>
					<input type="button" value="주문하기" onclick="#">
					<input type="button" value="관심상품등록">
					<input type="button" value="X 삭제">
				</td>
			</tr>
		</c:forEach>
		</table>
	</form>
	<a href="">전체상품주문</a>
	<a href="">선택상품주문</a>
</body>
</html> --%>