<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 주문 목록</title>
<!-- 구글 폰트 Noto Sans KR 불러오기 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;600;700&display=swap" rel="stylesheet">
<style>
.orderlist-wrap {
    max-width: 1200px;
    margin: 40px auto;
    padding: 0 20px;
    font-family: 'Noto Sans KR', sans-serif;
    color: #333;
}

/* 제목 + 설명 (회원/상품 목록과 통일) */
.header {
    display: flex;
    align-items: center;
    justify-content: space-between;
    margin-bottom: 20px;
}

.header-title-box {
    display: flex;
    align-items: center;
    gap: 15px;
}

.header h3 { 
    margin: 0; 
    font-size: 22px; 
    font-weight: 700; 
}

.header p { 
    margin: 0; 
    color: #888; 
    border-left: 1px solid #ddd; 
    padding-left: 15px; 
    font-size: 14px; 
}

/* 깔끔한 테이블 */
table {
    width: 100%;
    border-collapse: collapse;
    border-top: 1px solid #e5e5e5;
    border-bottom: 1px solid #e5e5e5;
    text-align: center;
    font-size: 14px;
    font-family: 'Noto Sans KR', sans-serif;
}

th {
    background-color: #fafafa;
    padding: 14px 10px;
    border-bottom: 1px solid #eee;
    font-weight: 600;
}

td {
    padding: 14px 10px;
    border-bottom: 1px solid #eee;
    vertical-align: middle;
}

/* 주문번호 링크 및 마우스 오버 효과 */
td a {
    color: #333;
    text-decoration: none;
    transition: color 0.2s ease;
}

td a:hover {
    color: #0066cc; /* 마우스 올렸을 때 변경될 색상 */
    text-decoration: underline;
}

/* 기본 네모 버튼 (.btn 클래스 통일) */
.btn {
    padding: 6px 14px;
    background: #fff;
    border: 1px solid #ccc;
    cursor: pointer;
    text-decoration: none;
    color: #333;
    font-size: 13px;
    display: inline-block;
    font-family: 'Noto Sans KR', sans-serif;
    border-radius: 0;
}

.btn:hover {
    background: #f5f5f5;
}

.bottom {
    margin-top: 20px;
}
</style>
</head>
<body>
<%@ include file="/WEB-INF/views/header.jsp" %>

<div class="orderlist-wrap">
    <div class="header">
        <div class="header-title-box">
            <h3>주문 목록</h3>
            <p>회원들의 전체 주문 내역을 관리할 수 있습니다.</p>
        </div>
    </div>
    
    <table>
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
    
    <div class="bottom">
        <a href="#" class="btn" onclick="history.back(); return false;">뒤로가기</a>
    </div>
</div>

<%@ include file="/WEB-INF/views/footer.jsp" %>
</body>
</html>