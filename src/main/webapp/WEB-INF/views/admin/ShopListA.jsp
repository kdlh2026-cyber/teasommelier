<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>매장관리</title>
<link rel="stylesheet" href="/css/admin-shop.css">
</head>
<body>
	<div>
		<%@ include file="/WEB-INF/views/header.jsp" %>
	</div>

	<div class="admin-shop-wrap">
		<h1>매장관리</h1>

		<a href="/admin/ShopWrite" class="btn-shop-write">매장 등록</a>

		<table class="admin-shop-list">
			<tr>
				<th>번호</th>
				<th>매장명</th>
				<th>이미지</th>
				<th>위도</th>
				<th>경도</th>
				<th>관리</th>
			</tr>
			<c:forEach var="shop" items="${shopList}">
				<tr>
					<td>${shop.sh_no}</td>
					<td>${shop.sh_name}</td>
					<td>${shop.sh_img}</td>
					<td>${shop.sh_lat}</td>
					<td>${shop.sh_lon}</td>
					<td>
						<%-- sh_no를 쿼리스트링으로 넘겨야 ShopModify/ShopDelete에서 받을 수 있음 --%>
						<a href="/admin/ShopModify?sh_no=${shop.sh_no}">수정</a>
						<a href="/admin/ShopDelete?sh_no=${shop.sh_no}"
						   onclick="return confirm('정말 삭제하시겠습니까?');">삭제</a>
					</td>
				</tr>
			</c:forEach>
		</table>
	</div>

	<div>
        <%@ include file="/WEB-INF/views/footer.jsp" %>
    </div>
</body>
</html>