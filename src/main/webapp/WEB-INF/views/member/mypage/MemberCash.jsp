<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TeaSommelier</title>
<link rel="stylesheet" href="/css/memberCash.css">
</head>
<body>
<%@ include file="/WEB-INF/views/header.jsp" %>

<div class="addr-container">
    <div>
        <%@ include file ="Mymenu.jsp" %> 
    </div>
    
    <div class="addr-header" style="margin-top: 30px;">
        <h3>적립금</h3>
        <p>고객님의 사용가능 적립금 금액입니다.</p>
    </div>
    
    <div class="cash-total-box">
        <h4>총 적립금</h4>
        <span><fmt:formatNumber value="${member.m_cash}" type="number"/>원</span>
    </div>
    
    <div>
        <div class="section-title">적립 내역</div>
        <table class="addr-table">
            <colgroup>
                <col style="width: 25%;">
                <col style="width: 25%;">
                <col style="width: 25%;">
                <col style="width: 25%;">
            </colgroup>
            <thead>
                <tr>
                    <th>주문날짜</th>
                    <th>사용 적립금</th>
                    <th>획득 적립금</th>
                    <th>사용 내용</th>
                </tr>
            </thead>
            <tbody>
            <c:choose>
                <c:when test="${empty memberCashList}">
                    <tr>
                        <td colspan="4" style="padding: 40px 0; color: #888;">적립 내역이 존재하지 않습니다.</td>
                    </tr>
                </c:when>
                <c:otherwise>
                    <c:forEach var="cashList" items="${memberCashList}">
                        <tr>
                            <td><fmt:formatDate value="${cashList.o_date}" pattern="yyyy/MM/dd"/></td>
                            <td><fmt:formatNumber value="${cashList.o_used_cash}" type="number"/>원</td>
                            <td style="color: #2b7de9; font-weight: 500;">+<fmt:formatNumber value="${cashList.o_earn}" type="number"/>원</td>
                            <td>상품 구매 적립/사용</td>
                        </tr>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
            </tbody>
        </table>
    </div>
</div>

<%@ include file="/WEB-INF/views/footer.jsp" %>
</body>
</html>