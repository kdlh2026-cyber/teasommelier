<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>제품 상세보기 장바구니 담기 테스트</title>
</head>
<body>
	<%@ include file="../header.jsp" %>
	<h1>제품 상세보기 -> 장바구니 버튼 눌러서 -> cartDB에 담아지는지 테스트</h1>

	<table>
		<tr>
	<c:forEach var="dto" items="${pdto}" varStatus="status">
			        <td>
			        	<div><img src="/images/product/${dto.p_img}"></div>
			            <a href="/guest/ViewForm?p_no=${dto.p_no}">${dto.p_name}</a>
			            <div>${dto.p_price}원</div><br>    
			            <div>${dto.p_category}</div>
			            <div>${dto.p_capacity}</div>
			        </td>
			    	<c:if test="${(status.index + 1) % 4 == 0 && !status.last}">
			            </tr><tr>
			        </c:if>
	</c:forEach>
		</tr>
	</table>
	
	<%@ include file="../footer.jsp" %>
</body>
</html>