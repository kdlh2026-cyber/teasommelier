<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
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
	
	<div class="cash-header">
        <h1>적립금</h1>
        <p>| 고객님의 사용가능 적립금 금액입니다.</p>
    </div>
    <br>
    <div>
    	<h3>총 적립금 <fmt:formatNumber value="${member.m_cash}" type="number"/>원</h3>
    </div>
   	<br>
    <div>
    	<h3>적립 내역</h3>
    	<table border=1 width=1000>
    		<tr>
    			<td>주문날짜</td>
    			<td>사용 적립금</td>
    			<td>획득 적립금</td>
    			<td>사용 내용</td>
    		</tr>
		<c:forEach var="cashList" items="${memberCashList}">
		    <tr>
		        <td><fmt:formatDate value="${cashList.o_date}" pattern="yyyy/MM/dd"/></td>
		        <td><fmt:formatNumber value="${cashList.o_used_cash}" type="number"/>원</td>
		        <td>+<fmt:formatNumber value="${cashList.o_earn}" type="number"/>원</td>
		        <td>상품 구매 적립/사용</td>
		    </tr>
		</c:forEach>
    	</table>
    </div>
</div>
<%@ include file="/WEB-INF/views/footer.jsp" %>
</body>
</html>