<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 주문 목록</title>
</head>
<body>
<%@ include file="/WEB-INF/views/header.jsp" %>
    <h2>관리자 - 회원 주문 목록</h2>
    <table border="1">
            <tr>
                <th>주문번호</th>
                <th>주문자ID</th>
                <th>이름</th>
                <th>결제금액</th>
                <th>결제수단</th>
                <th>주문일자</th>
            </tr>
     <c:forEach var="order" items="${orderList}">
            <tr>
                <td><a href="/admin/orderDetail?o_no=${order.o_no}">${order.o_no}</a></td>
                <td>${order.m_id}</td>
                <td>${order.m_name}</td>
                <td><fmt:formatNumber value="${order.o_price}" pattern="#,###"/>원</td>
                <td>${order.o_pay}</td>
                <td><fmt:formatDate value="${order.o_date}" pattern="yyyy-MM-dd HH:mm"/></td>
            </tr>
     </c:forEach>
    </table>
    <a href="#" onclick="history.back()">관리자 메인</a>
<%@ include file="/WEB-INF/views/footer.jsp" %>
</body>
</html>