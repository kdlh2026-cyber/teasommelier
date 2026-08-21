<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문 확인서</title>
<link rel="stylesheet" href="/css/orderConfirm.css">
</head>
<body>
    <h2>주문완료</h2>
    <div class="order-sub-text">고객님의 주문이 정상적으로 완료되었습니다.</div>
    
    <div class="order-card">
        주문번호 <span class="highlight">${orderInfo.o_no}</span> <br>
        결제금액 <span class="highlight"><fmt:formatNumber value="${orderInfo.o_price}" pattern="#,###" />원</span>
    </div>
    
    <div class="order-card">
        <h4>결제수단</h4>
        <div class="info-text">결제수단 ${orderInfo.o_pay}</div>
    </div>
    
    <div class="order-card">
        <h4>배송지</h4>
        <div class="info-text">받는사람 : <span>${orderInfo.o_name}</span></div>
        <div class="info-text">주소 : <span>${orderInfo.o_addr}</span></div>
        <div class="info-text">연락처 : <span>${orderInfo.o_phone}</span></div>
        <div class="info-text">배송요청 : <span>${orderInfo.o_message}</span></div>
    </div>
    
    <div class="order-card">
        <h4>주문상품</h4>
        <c:forEach var="list" items="${orderDetails}">
            <div class="product-item">
                <img src="/images/product/${list.p_img}" width="50" height="50" alt="상품 이미지">
                <div class="product-info">
                    <span>상품명: ${list.od_product}</span> <br>
                    <span>수량: ${list.od_qty}개</span> / 
                    <span>가격: <fmt:formatNumber value="${list.od_price}" pattern="#,###"/>원</span>
                </div>
            </div>
        </c:forEach>
    </div>
    
    <div class="order-card">
        <h4>결제정보</h4>
        <div class="price-row"><span>주문상품</span> <span><fmt:formatNumber value="${orderInfo.o_price}" pattern="#,###"/>원</span></div>
        <div class="price-row"><span>배송비</span> <span>+0원</span></div>
        <div class="price-row"><sapn>적립금</sapn> <span>-${orderInfo.o_earn}원</span></div>
        <div class="price-row total-row">
            <b>결제금액</b> <span><fmt:formatNumber value="${orderInfo.o_price - orderInfo.o_earn}" pattern="#,###"/>원</span>
        </div>
    </div>
    
    <div class="order-card">
        <h4>적립 혜택</h4>
        <div class="price-row"><span>적립 예정금액</span> <span><fmt:formatNumber value="${orderInfo.o_earn}" pattern="#,###"/>원</span></div>
    </div>
    
    <div class="btn-group">
        <a href="/main">쇼핑 계속하기</a>
    </div>
</body>
</html>