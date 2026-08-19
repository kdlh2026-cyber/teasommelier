<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TeaSommelier</title>
</head>
<body>
<%@ include file="/WEB-INF/views/header.jsp" %>
<div>
	<div>
		<%@ include file ="Mymenu.jsp" %> 
	</div>
	<div>
		<table border=1 width=1000>
			<tr>
				<td>주문번호</td>
				<td>주문일자</td>
				<td>이미지</td>
				<td>상품명</td>
				<td>수량</td>
				<td>상품구매금액</td>
				<td>총결제금액</td>
			</tr>
		<c:forEach var="list" items="${memberOrder}" varStatus="status">
			<tr>
				<c:if test="${status.first or memberOrder[status.index - 1].o_no ne list.o_no}">
					<c:set var="rowSpanCount" value="0" />
						<c:forEach var="item" items="${memberOrder}">
							<c:if test="${item.o_no eq list.o_no}">
								<c:set var="rowSpanCount" value="${rowSpanCount + 1}" />
							</c:if>
						</c:forEach>
					<td rowspan="${rowSpanCount}">${list.o_no}</td>
				</c:if>
					<td><fmt:formatDate value="${list.o_date}" pattern="yyyy/MM/dd"/></td>
					<td><img src="/images/product/${list.p_img}" width="100"></td>
					<td>${list.od_product}</td>
					<td>${list.od_qty}</td>
					<td><fmt:formatNumber value="${list.od_price * list.od_qty}" type="number"/>원</td>
				<c:if test="${status.first or memberOrder[status.index - 1].o_no ne list.o_no}">
					<td rowspan="${rowSpanCount}">
						<fmt:formatNumber value="${list.o_price}" type="number"/>원
					</td>
				</c:if>
			</tr>
		</c:forEach>	
		</table>
	</div>	
</div>
<%@ include file="/WEB-INF/views/footer.jsp" %>
</body>
</html>