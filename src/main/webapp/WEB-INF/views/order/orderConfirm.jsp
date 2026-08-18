<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문 확인서</title>
</head>
<body>
	<a href="/main"><img src="/images/logo/logo1.png" alt="이미지 로고"></a>
	<h2>주문완료</h2>
	<div>고객님의 주문이 정상적으로 완료되었습니다.</div>
	<div>
		주문번호 <span>${orderInfo.o_no}</span> <br>
		결제금액 <span><fmt:formatNumber value="${orderInfo.o_price}" pattern="#,###" />원</span>
	</div>
	<div>
		<h4>결제수단</h4>
		결제수단 ${orderInfo.o_pay} <br>
	</div>
	<div>
		<h4>배송지</h4>
		받는사람 : <span>${orderInfo.o_name}</span> <br>
		주소 : <span>${orderInfo.o_addr}</span> <br>
		연락처 : <span>${orderInfo.o_phone}</span> <br>
		배송요청 : <span>${orderInfo.o_message}</span> 
	</div>
	<div>
		<h4>주문상품</h4>
		<c:forEach var="list" items="${orderDetails}">
			<img src="/images/product/${list.p_img}" width="30">
			<span>상품명: ${list.od_product}</span> <br>
			<span>수량: ${list.od_qty}개</span> <br>
			<span>가격: <fmt:formatNumber value="${list.od_price}" pattern="#,###"/>원</span> <br>
		</c:forEach>
	</div>
	<div>
		<h4>결제정보</h4>
		주문상품 <span><fmt:formatNumber value="${orderInfo.o_price}" pattern="#,###"/>원</span> <br>
		배송비 <span>+0원</span> <br>
		<b>결제금액</b> <span><fmt:formatNumber value="${orderInfo.o_price}" pattern="#,###"/>원</span>
	</div>
	<div>
		<h4>적립 혜택</h4>
		적립 예정금액  <span><fmt:formatNumber value="${orderInfo.o_earn}" pattern="#,###"/>원</span>
	</div>
	<div>
		<a href="/member/mypage/OrderSelect">주문확인하기</a>
		<a href="/main">쇼핑 계속하기</a>
	</div>
</body>
</html>