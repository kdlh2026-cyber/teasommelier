<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니</title>
</head>
<body>
	<h1>CART</h1>
	<a href="/deleteCart">선택상품삭제</a>
	<form name="cartList" method="post" action="#">
		<input type="hidden" name="p_price" value="${view.p_price}">
		<table border=1 width=1000>
			<tr>
				<th><input type="checkbox" class="checkAll" checked></th>
				<th>이미지</th>
				<th>상품정보</th>
				<th>수량</th>
				<th>상품구매금액</th>
				<th>할인금액</th>
				<th>적립금</th>
				<th>배송구분</th>
				<th>배송비</th>
				<th>선택</th>
			</tr>
		<c:forEach var="list" items="${list}" varStatus="status">
			<tr>
				<td><input type="checkbox" name="ca_no" value="${list.ca_no}" checked class="cartCheck"></td>
				<td><a href="#"><img src="/images/product/${list.ca_image}" width="150"></a></td>
				<td><a href="#">${list.p_name}</a></td>
				<td><input type="number" name="ca_qty" value="${list.ca_qty}" min="1" class="qtyInput" data-unit-price="${list.ca_price}"> 개</td> 
				
				<!-- 상품구매금액 -->
				<td class="itemPrice" data-price="${list.ca_price * list.ca_qty}">
					<fmt:formatNumber value="${list.ca_price * list.ca_qty}" type="number"/>원
				</td>
				
				<td></td>
				
				<!-- 적립금 칸에 itemPoint 클래스 추가 -->
				<td class="itemPoint">
					<fmt:formatNumber value="${(list.ca_price * list.ca_qty) * 0.1}" type="number"/>원
				</td>
				
				<td>${list.ca_del}</td>
				<td>무료</td> 
				<td>
					<input type="button" value="주문하기" onclick="#">
					<input type="button" value="관심상품등록">
					<input type="button" value="X 삭제">
				</td>
			</tr>
		</c:forEach>
		</table>
		<div>총가격 : <span class="finalPrice">0</span>원</div>
	</form>
	<a href="">전체상품주문</a>
	<a href="">선택상품주문</a>
</body>
<script>
	const checkAll = document.querySelector('.checkAll');
	const cartCheck = document.querySelectorAll('.cartCheck');
	const qtyInputs = document.querySelectorAll('.qtyInput');

	checkAll.addEventListener('click', function(){
		const isChecked = checkAll.checked;	
		const checkBoxes = document.querySelectorAll('.cartCheck');
		
		if(isChecked){
			for(const checkBox of checkBoxes){
				checkBox.checked = true;
			}
		}
		else{
			for(const checkBox of checkBoxes){
				checkBox.checked = false;
			}
		}
		
		setFinalPrice();
	});
	
	function setFinalPrice(){
		const checkedBoxes = document.querySelectorAll('.cartCheck:checked');

		let finalPrice = 0;
		for(const checkedBox of checkedBoxes){
			const price = parseInt(checkedBox.closest('tr').querySelector('.itemPrice').dataset.price) || 0;
		
			finalPrice = price + finalPrice;
		}
		
		document.querySelector('.finalPrice').innerText = '￦' + finalPrice.toLocaleString();
	}
	
	for(const chk of cartCheck){
		chk.addEventListener('click', function(){
			setFinalPrice();
		});	
	}
	
	for(const qtyInput of qtyInputs){
		qtyInput.addEventListener('input', function(){
			const row = this.closest('tr');
			const unitPrice = parseInt(this.dataset.unitPrice) || 0;
			let qty = parseInt(this.value);
			
			if(isNaN(qty) || qty < 1){
				qty = 1;
				this.value = 1;
			}
			
			const newPrice = unitPrice * qty;
			
			// 1. 상품 구매금액 업데이트
			const itemPriceTd = row.querySelector('.itemPrice');
			itemPriceTd.dataset.price = newPrice;
			itemPriceTd.innerText = newPrice.toLocaleString() + '원';
			
			// 2. 적립금 업데이트 (구매금액의 10% 기준)
			const itemPointTd = row.querySelector('.itemPoint');
			const newPoint = Math.floor(newPrice * 0.1);
			itemPointTd.innerText = newPoint.toLocaleString() + '원';
			
			// 3. 총 가격 재계산
			setFinalPrice();
		});
	}
	
	setFinalPrice();
</script>
</html>