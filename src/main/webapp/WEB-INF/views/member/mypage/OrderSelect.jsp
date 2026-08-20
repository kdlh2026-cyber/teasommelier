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
<link rel="stylesheet" href="/css/orderSelect.css">
</head>
<body>
<%@ include file="/WEB-INF/views/header.jsp" %>

<div class="order-container">
    <div class="order-menu-wrap">
        <%@ include file ="Mymenu.jsp" %> 
    </div>
    
    <div class="order-header">
        <h3>주문조회</h3>
        <p>고객님이 주문하신 내역을 확인하실 수 있습니다.</p>
    </div>
    
    <div class="order-table-wrap">
        <table class="order-table">
            <colgroup>
                <col style="width: 130px;">
                <col style="width: 110px;">
                <col style="width: 90px;">
                <col style="width: auto;">
                <col style="width: 70px;">
                <col style="width: 120px;">
                <col style="width: 120px;">
            </colgroup>
            <thead>
                <tr class="order-th-row">
                    <th>주문번호</th>
                    <th>주문일자</th>
                    <th>이미지</th>
                    <th>상품명</th>
                    <th>수량</th>
                    <th>상품구매금액</th>
                    <th>총결제금액</th>
                </tr>
            </thead>
            <tbody>
            <c:choose>
                <c:when test="${empty memberOrder}">
                    <tr>
                        <td colspan="7" class="order-empty">주문 내역이 존재하지 않습니다.</td>
                    </tr>
                </c:when>
                <c:otherwise>
                    <c:forEach var="list" items="${memberOrder}" varStatus="status">
                        <tr class="order-tr">
                            <c:if test="${status.first or memberOrder[status.index - 1].o_no ne list.o_no}">
                                <c:set var="rowSpanCount" value="0" />
                                <c:forEach var="item" items="${memberOrder}">
                                    <c:if test="${item.o_no eq list.o_no}">
                                        <c:set var="rowSpanCount" value="${rowSpanCount + 1}" />
                                    </c:if>
                                </c:forEach>
                                <td rowspan="${rowSpanCount}" class="order-no">${list.o_no}</td>
                            </c:if>
                            <td class="order-date"><fmt:formatDate value="${list.o_date}" pattern="yyyy/MM/dd"/></td>
                            <td class="order-img-td"><img src="/images/product/${list.p_img}" width="60" height="60" alt="상품 이미지"></td>
                            <td class="td-product">${list.od_product}</td>
                            <td class="order-qty">${list.od_qty}개</td>
                            <td class="order-price"><fmt:formatNumber value="${list.od_price * list.od_qty}" type="number"/>원</td>
                            <c:if test="${status.first or memberOrder[status.index - 1].o_no ne list.o_no}">
                                <td rowspan="${rowSpanCount}" class="order-total-price">
                                    <fmt:formatNumber value="${list.o_price}" type="number"/>원
                                </td>
                            </c:if>
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