<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비회원 주문서</title>
<script src="https://cdn.portone.io/v2/browser-sdk.js"></script>
</head>
<body>
<%@ include file="../header.jsp" %>
	<div><span>주문서작성</span> | 주문서를 작성해주세요</div>
	<div>
		<form name="writeForm" method="post" action="/orderSubmit">
		<input type="hidden" name="paymentId" id="paymentId">
		<input type="hidden" name="orderType" value="${orderType}">
		
		<c:if test="${orderType eq 'direct'}">
	        <c:forEach var="orderP" items="${orderItems}">
	            <input type="hidden" name="p_no" value="${orderP.p_no}">
	            <input type="hidden" name="ca_qty" value="${orderP.ca_qty}">
	        </c:forEach>
	    </c:if>
	    
		<c:if test="${orderType eq 'cart'}">
	        <c:forEach var="orderP" items="${orderItems}">
	            <input type="hidden" name="ca_no" value="${orderP.ca_no}">
	        </c:forEach>
	    </c:if>
	    
			<hr>
			<div>
				<h4>배송지</h4>
				받는 사람* <input type="text" name="o_name"> <br>
				주소* <input type="text" name="o_zip" readonly placeholder="우편번호">
					<input type="button" value="주소검색" onclick="goPopup()"> <br>
					<input type="text" name="o_addr1" readonly placeholder="기본주소"> <br>
					<input type="text" name="o_addr2" readonly placeholder="상세주소"> <br>
					
				휴대전화* <input type="text" name="o_phone1" size="3" maxlength="3" value="010" readonly> -
						<input type="text" name="o_phone2" size="4" maxlength="4"> -
						<input type="text" name="o_phone3" size="4" maxlength="4"><br>
				이메일* <input type="text" name="o_email"><br>
				배송메세지 <select name="o_message">
							<option value="메시지 선택(선택사항)">메시지 선택(선택사항)</option>
							<option value="배송 전에 미리 연락바랍니다.">배송 전에 미리 연락바랍니다.</option>
							<option value="부재 시 경비실에 맡겨주세요.">부재 시 경비실에 맡겨주세요.</option>
							<option value="부재 시 문 앞에 놓아주세요.">부재 시 문 앞에 놓아주세요.</option>
							<option value="빠른 배송 부탁드립니다.">빠른 배송 부탁드립니다.</option>
							<option value="택배함에 보관해 주세요.">택배함에 보관해 주세요.</option>
							<option value="직접 입력">직접 입력</option>
						</select><br>
				<h4>비회원 주문조회 비밀번호</h4>
				비밀번호 <input type="password" name="o_passwd"> <br>
				비밀번호 확인 <input type="password" name="o_passwd2"> <br>
			</div>
			<hr>
			<div> 
				<h4>배송방식/출입정보</h4>
				배송방식*<br>
				<input type="radio" checked>일반배송 <br>
			</div>
			<hr>
			<div>
				<h4>주문상품</h4>
				<c:set var="orderPtotal" value="0"/>
				<c:forEach var="orderP" items="${orderItems}" varStatus="status">
					<c:set var="orderPtotal" value="${orderPtotal + (orderP.ca_qty * orderP.ca_price)}"/>
					<div class="orderItem">
						<img src="/images/product/${orderP.ca_image}" width="80">
						상품명 ${orderP.p_name}
						수량 ${orderP.ca_qty}개
						가격 <fmt:formatNumber value="${orderP.ca_qty * orderP.ca_price}" pattern="#,###" />원
						<button type="button" onclick="remove()">삭제</button>
					</div>
				</c:forEach>
				<div>
					배송비 0원
				</div>
			</div>
			<hr>
			<div>
				<h4>결제정보</h4>
				주문상품 <span class="orderPtotal"><fmt:formatNumber value="${orderPtotal}" pattern="#,###"/></span>원<br>
				배송비 + <span class="shippingTotal">0</span>원 <br>
				할인/부가결제 -0원 <br>
				<b>최종 결제 금액</b> <span class="finalTotal"><fmt:formatNumber value="${orderPtotal}" pattern="#,###"/></span>원
			</div>
			<hr>
			<div>
				<h4>결제수단</h4>
				<input type="hidden" name="o_pay" value="카카오페이">
			</div>
			<hr>
			<input type="button" value="결제하기" onclick="requestPayment()">
		</form>
	</div>
<%@ include file="../footer.jsp" %>		
</body>
<script>
	function goPopup(){
		var pop = window.open("/guest/jusoPopup","pop","width=570,height=420, scrollbars=yes, resizable=yes"); 
	}
	
	function jusoCallBack(o_addr1, o_addr2, o_zip){
		document.writeForm.o_zip.value = o_zip;
		document.writeForm.o_addr1.value = o_addr1;
		document.writeForm.o_addr2.value = o_addr2;
	}

	const orderPtotal = ${orderPtotal};
	const shipping = 0;

	
	function updateTotal(discount){
		const finalTotal = orderPtotal + shipping;
		
		document.querySelector(".finalTotal").innerText = finalTotal.toLocaleString();
	}
	
	updateTotal(0);

	
	async function requestPayment(){
		const finalTotalStr = document.querySelector(".finalTotal").innerText.replace(/,/g, '');
		const finalTotalAmount = parseInt(finalTotalStr, 10);
		const paymentId = "order-" + new Date().getTime();
		
		console.log("생성된 paymentId:", paymentId);
		
		try{
			const response = await PortOne.requestPayment({
				storeId : "store-06537574-48da-43b1-9835-1ed0b17839e4",
				channelKey : "channel-key-af20f4e3-df0f-4219-8594-260e8269a7fb",
				paymentId : paymentId,
				orderName : "차 주문",
				totalAmount : finalTotalAmount,
				currency: "CURRENCY_KRW",
				payMethod: "EASY_PAY",
			});
			
			if(response.code != null){
				alert("결제 실패: " + response.message);
				return;
			}
			
			document.getElementById("paymentId").value = paymentId;  
			
			alert("결제가 완료되었습니다.");
			document.writeForm.submit();
		}catch(error){
			console.error("결제 중 오류 발생:", error);
			alert("결제 진행 중 오류 발생");
		}
	}
</script>
</html>