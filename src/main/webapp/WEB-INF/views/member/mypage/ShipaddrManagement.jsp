<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TeaSommelier</title>
<script>
document.querySelector('input[name="all_chk"]').addEventListener('change', function() {
    const checkboxes = document.querySelectorAll('input[name="addr_chk"]');
    checkboxes.forEach(cb => cb.checked = this.checked);
});
</script>
</head>
<body>
<%@ include file="/WEB-INF/views/header.jsp" %>
<div>
	<div>
		<%@ include file ="Mymenu.jsp" %> 
	</div>
	<div>
		<h3>배송주소록 관리</h3>
		<p>자주 쓰는 배송지를 등록 관리하실 수 있습니다.</p>
	</div>
	<form name="shipaddrlist" id="shipaddrlist" method="post" action="../mypage/ShipaddrWriteForm">
	<input type="hidden" name="m_no" id="m_no" value="${m_dto.m_no}">
	<div>
	<table>
		<tr>
			<th><input type="checkbox" name="all_chk"></th>
			<th>배송지명</th>
			<th>수령인</th>
			<th>일반전화</th>
			<th>휴대전화</th>
			<th>주소</th>
			<th>수정</th>
		</tr>
		<c:forEach var="addrlist" items="${ShippingaddrList}">
		<tr>
			<td><input type="checkbox" name="addr_chk" value="${addrlist.s_no}"></td>
			<td>${addrlist.s_deliveryname}</td>
			<td>${addrlist.s_name}</td>
			<td>${addrlist.s_tel }</td>
			<td>${addrlist.s_phone}</td>
			<td>${addrlist.s_addr}</td>
			<td><input type="button" value="수정" onclick="ShippingaddrUpdateForm"></td>
		</tr>
		</c:forEach>
	</table>
	</div>
	<div>
		<span><a href="#" onclick="deleteShippingAddr(); return false;">선택 주소록 삭제</a></span>
		<span><input type="submit" value="배송지 등록"></span>
	</div>
	</form>
</div>
<%@ include file="/WEB-INF/views/footer.jsp" %>
</body>
</html>