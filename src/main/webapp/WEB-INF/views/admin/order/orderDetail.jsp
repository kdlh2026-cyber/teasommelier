<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 주문 상세정보 열람</title>
<!-- 구글 폰트 Noto Sans KR 불러오기 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;600;700&display=swap" rel="stylesheet">
<style>
.order-detail-wrap {
    max-width: 1000px;
    margin: 40px auto;
    padding: 0 20px;
    font-family: 'Noto Sans KR', sans-serif;
    color: #333;
}

/* 제목 + 설명 */
.header {
    display: flex;
    align-items: center;
    gap: 15px;
    margin-bottom: 30px;
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

/* 섹션 타이틀 (세로 선 추가) */
.section-title {
    font-size: 16px;
    font-weight: 600;
    margin: 35px 0 12px 0;
    color: #333;
    display: flex;
    align-items: center;
    gap: 10px;
}

.section-title::before {
    content: "";
    display: inline-block;
    width: 4px;
    height: 16px;
    background-color: #333;
}

/* 상세 정보 테이블 스타일 */
table.detail-table {
    width: 100%;
    border-collapse: collapse;
    border-top: 1px solid #e5e5e5;
    border-bottom: 1px solid #e5e5e5;
    font-size: 14px;
    font-family: 'Noto Sans KR', sans-serif;
    margin-bottom: 20px;
}

table.detail-table th {
    background-color: #fafafa;
    width: 180px;
    padding: 14px 15px;
    border-bottom: 1px solid #eee;
    font-weight: 600;
    text-align: center;
    color: #333;
}

table.detail-table td {
    padding: 12px 15px;
    border-bottom: 1px solid #eee;
    color: #555;
    vertical-align: middle;
}

/* 주문 상품 목록 테이블 전용 */
table.product-table {
    width: 100%;
    border-collapse: collapse;
    border-top: 1px solid #e5e5e5;
    border-bottom: 1px solid #e5e5e5;
    font-size: 14px;
    font-family: 'Noto Sans KR', sans-serif;
    margin-bottom: 25px;
    text-align: center;
}

table.product-table th {
    background-color: #fafafa;
    padding: 14px 15px;
    border-bottom: 1px solid #eee;
    font-weight: 600;
    color: #333;
}

table.product-table td {
    padding: 12px 15px;
    border-bottom: 1px solid #eee;
    color: #555;
    vertical-align: middle;
}

/* 상품 이미지 스타일 */
.product-img {
    width: 60px;
    height: 60px;
    object-fit: cover;
    border: 1px solid #ddd;
}

/* 하단 버튼 그룹 */
.button-group {
    margin-top: 25px;
    display: flex;
    justify-content: flex-start;
}

/* 기본 네모 버튼 */
.btn {
    padding: 8px 16px;
    background: #fff;
    border: 1px solid #ccc;
    cursor: pointer;
    text-decoration: none;
    color: #333;
    font-size: 13px;
    display: inline-block;
    font-family: 'Noto Sans KR', sans-serif;
    border-radius: 0;
    transition: background-color 0.2s ease;
}

.btn:hover {
    background: #f5f5f5;
}

/* 섹션 타이틀 (간격 넓힘) */
.section-title {
    font-size: 16px;
    font-weight: 600;
    margin: 80px 0 15px 0; /* 위쪽 여백을 50px로 확대 */
    color: #333;
    display: flex;
    align-items: center;
    gap: 10px;
}
</style>
</head>
<body>
    <%@ include file="/WEB-INF/views/header.jsp" %>
    
    <div class="order-detail-wrap">
        <div class="header">
            <h3>주문 상세 정보</h3>
            <p>회원의 주문 내역 및 상세 품목을 확인할 수 있습니다.</p>
        </div>
        
        <!-- 주문 기본 및 결제 정보 -->
        <div class="section-title">주문 기본 및 결제 정보</div>
        <table class="detail-table">
            <tr>
                <th>주문번호</th>
                <td>${orderInfo.o_no}</td>
            </tr>
            <tr>
                <th>주문일자</th>
                <td><fmt:formatDate value="${orderInfo.o_date}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
            </tr>
            <tr>
                <th>주문자(id|이름)</th>
                <td>${orderInfo.m_id} | ${orderInfo.m_name}</td>
            </tr>
            <tr>
                <th>결제수단</th>
                <td>${orderInfo.o_pay}</td>
            </tr>
            <tr>
                <th>결제금액</th>
                <td><fmt:formatNumber value="${orderInfo.o_price}" pattern="#,###"/>원</td>
            </tr>
            <tr>
                <th>적립예정금액</th>
                <td><fmt:formatNumber value="${orderInfo.o_earn}" pattern="#,###"/>원</td>
            </tr>
            <tr>
                <th>결제 고유번호(TID)</th>
                <td>${orderInfo.paymentId}</td>
            </tr>
        </table>

        <!-- 배송지 정보 -->
        <div class="section-title">배송지 정보</div>
        <table class="detail-table">
            <tr>
                <th>수령인</th>
                <td>${orderInfo.o_name}</td>
            </tr>
            <tr>
                <th>연락처</th>
                <td>${orderInfo.o_phone}</td>
            </tr>
            <tr>
                <th>배송지 주소</th>
                <td>[${orderInfo.o_zip}] ${orderInfo.o_addr}</td>
            </tr>
            <tr>
                <th>배송메시지</th>
                <td>${orderInfo.o_message}</td>
            </tr>
        </table>

        <!-- 주문 상품 목록 -->
        <div class="section-title">주문 상품 목록</div>
        <table class="product-table">
            <thead>
                <tr>
                    <th style="width: 100px;">상품이미지</th>
                    <th>상품명</th>
                    <th style="width: 100px;">수량</th>
                    <th style="width: 130px;">상품 가격</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="item" items="${orderDetails}">
                    <tr>
                        <td>
                            <img src="/images/product/${item.p_img}" class="product-img" alt="상품 이미지">
                        </td>
                        <td style="text-align: left; padding-left: 20px;">${item.od_product}</td>
                        <td>${item.od_qty}개</td>
                        <td><fmt:formatNumber value="${item.od_price}" pattern="#,###"/>원</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <!-- 하단 버튼 -->
        <div class="button-group">
            <button type="button" class="btn" onclick="history.back();">목록으로 돌아가기</button>
        </div>
    </div>
    
    <%@ include file="/WEB-INF/views/footer.jsp" %>
</body>
</html>