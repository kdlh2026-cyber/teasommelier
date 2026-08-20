<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<c:set var="orderPtotal" value="0"/>
<c:forEach var="orderP" items="${orderItems}">
    <c:set var="orderPtotal" value="${orderPtotal + (orderP.ca_qty * orderP.ca_price)}"/>
</c:forEach>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문서 작성 폼</title>
<link rel="stylesheet" href="/css/orderWrite.css">
<script src="https://cdn.portone.io/v2/browser-sdk.js"></script>
<script>
    const orderPtotal = ${orderPtotal};
    const maxLimit = 3000;
</script>
<script src="/js/orderWriteMember.js"></script>
</head>
<body>
<%@ include file="../header.jsp" %>
	
	<div class="order-wrapper">
		<div class="order-title-area">
			<span class="main-title">주문서작성</span> 
			<span class="sub-desc">주문서를 작성해주세요</span>
		</div>
		
		<form name="writeForm" method="post" action="/orderSubmit">
			<input type="hidden" name="orderType" value="${orderType}">
			<input type="hidden" name="paymentId" id="paymentId">
			
			<c:choose>
				<c:when test="${orderType eq 'direct'}">
					<c:forEach var="orderP" items="${orderItems}">
						<input type="hidden" name="p_no" value="${orderP.p_no}">
						<input type="hidden" name="ca_qty" value="${orderP.ca_qty}">
					</c:forEach>
				</c:when>
				<c:when test="${orderType eq 'cart'}">
					<c:forEach var="orderP" items="${orderItems}">
						<input type="hidden" name="ca_no" value="${orderP.ca_no}">
					</c:forEach>
				</c:when>
				<c:when test="${orderType eq 'favorite'}">
					<c:forEach var="orderP" items="${orderItems}">
						<input type="hidden" name="f_no" value="${orderP.ca_no}">
					</c:forEach>
				</c:when>
			</c:choose>

			<!-- 배송지 정보 섹션 -->
			<div class="order-section delivery-section">
				<h4>배송지</h4>
				<div class="form-row">
					<label>받는 사람*</label> 
					<input type="text" name="o_name" value="${member.m_name}">
				</div>
				<div class="form-row">
					<label>주소*</label> 
					<input type="text" name="o_zip" readonly placeholder="우편번호" value="${member.m_zipno}">
					<input type="button" value="주소검색" onclick="goPopup()" class="btn-zip">
				</div>
				<div class="form-row">
					<input type="text" name="o_addr1" readonly placeholder="기본주소" value="${fn:split(member.m_addr,',')[0]}">
				</div>
				<div class="form-row">
					<input type="text" name="o_addr2" readonly placeholder="상세주소" value="${fn:split(member.m_addr,',')[1]}">
				</div>
				<div class="form-row">
					<label>휴대전화*</label> 
					<input type="text" name="o_phone1" size="3" maxlength="3" value="010" readonly> -
					<input type="text" name="o_phone2" size="4" maxlength="4" value="${fn:split(member.m_phone,'-')[1]}"> -
					<input type="text" name="o_phone3" size="4" maxlength="4" value="${fn:split(member.m_phone,'-')[2]}">
				</div>
				<div class="form-row">
					<label>이메일*</label> 
					<input type="text" name="o_email" value="${member.m_email}">
				</div>
				<div class="form-row">
					<label>배송메세지</label> 
					<select name="o_message">
						<option value="메시지 선택(선택사항)">메시지 선택(선택사항)</option>
						<option value="배송 전에 미리 연락바랍니다.">배송 전에 미리 연락바랍니다.</option>
						<option value="부재 시 경비실에 맡겨주세요.">부재 시 경비실에 맡겨주세요.</option>
						<option value="부재 시 문 앞에 놓아주세요.">부재 시 문 앞에 놓아주세요.</option>
						<option value="빠른 배송 부탁드립니다.">빠른 배송 부탁드립니다.</option>
						<option value="택배함에 보관해 주세요.">택배함에 보관해 주세요.</option>
						<option value="직접 입력">직접 입력</option>
					</select>
				</div>
			</div>

			<!-- 배송방식 섹션 -->
			<div class="order-section method-section"> 
				<h4>배송방식/출입정보</h4>
				<div class="form-row">
					<label>배송방식*</label><br>
					<label><input type="radio" checked> 일반배송</label>
				</div>
			</div>

			<!-- 주문상품 섹션 -->
		<div class="order-section products-section">
		    <h4>주문상품</h4>
		    <c:forEach var="orderP" items="${orderItems}" varStatus="status">
		        <div class="orderItem">
		            <div class="item-img"><img src="/images/product/${orderP.ca_image}" width="80"></div>
		            <div class="item-info">
		                <span class="item-name">상품명: ${orderP.p_name}</span>
		                <span class="item-qty">수량: ${orderP.ca_qty}개</span>
		            </div>
		            <div class="item-price">
		                가격: <fmt:formatNumber value="${orderP.ca_qty * orderP.ca_price}" pattern="#,###" />원
		            </div>
		        </div>
		    </c:forEach>
		    <div class="shipping-fee-text">배송비 0원</div>
		</div>

			<!-- 할인/부가결제 섹션 -->
			<div class="order-section discount-section">
				<h4>할인/부가결제</h4>
				<div class="form-row">
					<label>적립금</label> 
					<input type="text" name="m_cash" class="useCash" value="0" onkeyup="totalDiscount()">
					<input type="button" value="전액 사용" onclick="allCash()" class="useAll">
				</div>
				<div class="notice-row">
					보유 잔액 <span class="maxCash">${member.m_cash}</span>원<br>
					<span class="notice-text">! 1회 구매 시 적립금 최대 사용금액은 3,000원입니다.</span>
				</div>
				<div class="apply-result-row">
					<b>적용금액</b> <span class="applyDiscount">0</span>원
				</div>
			</div>

			<!-- 결제정보 섹션 -->
			<div class="order-section payment-info-section">
				<h4>결제정보</h4>
				<div class="pay-calc-row">주문상품 <span class="orderPtotal"><fmt:formatNumber value="${orderPtotal}" pattern="#,###"/></span>원</div>
				<div class="pay-calc-row">배송비 + <span class="shippingTotal">0</span>원</div>
				<div class="pay-calc-row">할인/부가결제 - <span class="discountTotal">0</span>원</div>
				<div class="pay-calc-row final-row">
					<b>최종 결제 금액</b> <span class="finalTotal"><fmt:formatNumber value="${orderPtotal}" pattern="#,###"/></span>원
				</div>
			</div>

			<!-- 결제수단 섹션 -->
			<div class="order-section pay-method-section">
				<h4>결제수단</h4>
				<div class="form-row">
					<span class="pay-method-name">카카오페이</span>
					<input type="hidden" name="o_pay" value="카카오페이">
				</div>
			</div>

			<!-- 적립 혜택 섹션 -->
			<div class="order-section point-benefit-section">
				<h4>적립 혜택</h4>
				<div class="form-row">
					구매 적립금: <span class="earnPoint"><fmt:formatNumber value="${orderPtotal * 0.01}" pattern="#,###"/></span>원
				</div>
			</div>

			<!-- 최종 결제 버튼 -->
			<div class="submit-btn-wrapper">
				<input type="button" value="결제하기" class="btn-payment" onclick="requestPayment()">
			</div>
		</form>
	</div>

<%@ include file="../footer.jsp" %>	
</body>
</html>