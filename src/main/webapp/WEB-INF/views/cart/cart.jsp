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
<link rel="stylesheet" href="/css/cart.css">
</head>
<body>
	<%@ include file="../header.jsp" %>
	
	<div class="cart-wrapper">
		<h1 class="cart-title">CART</h1>
		
		<form name="cartList">
			<table class="cart-table">
				<thead>
					<tr>
						<th class="col-chk"><input type="checkbox" class="checkAll" checked></th>
						<th class="col-img">이미지</th>
						<th class="col-info">상품정보</th>
						<th class="col-qty">수량</th>
						<th class="col-price">상품구매금액</th>
						<th class="col-discount">할인금액</th>
						<th class="col-point">적립금</th>
						<th class="col-deliv">배송구분</th>
						<th class="col-fee">배송비</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach var="cart" items="${list}" varStatus="status">
					<tr>
						<td class="col-chk"><input type="checkbox" value="${cart.ca_no}" checked class="cartCheck"></td>
						<td class="col-img">
							<a href="/guest/productDetail?p_no=${cart.p_no}">
								<img src="/images/product/${cart.ca_image}" width="100">
							</a>
						</td>
						<td class="col-info text-left">
							<a href="/guest/productDetail?p_no=${cart.p_no}">${cart.ca_info}</a>
						</td>
						<td class="col-qty">
							<div class="qty-input-box">
								<input type="number" name="ca_qty" value="${cart.ca_qty}" min="1" class="qtyInput" data-unit-price="${cart.ca_price}" data-original-qty="${cart.ca_qty}"> 개
							</div>
							<button type="button" value="변경하기" class="updateQtyBtn" data-cano="${cart.ca_no}">변경하기</button>
						</td> 
						
						<!-- 상품구매금액 -->
						<td class="col-price itemPrice" data-price="${cart.ca_price * cart.ca_qty}">
							<fmt:formatNumber value="${cart.ca_price * cart.ca_qty}" type="number"/>원
						</td>
						
						<td class="col-discount">-</td>
						
						<!-- 적립금 -->
						<td class="col-point itemPoint">
							<fmt:formatNumber value="${(cart.ca_price * cart.ca_qty) * 0.01}" type="number"/>원
						</td>
						
						<td class="col-deliv">${cart.ca_del}</td>
						
						<c:if test="${status.first}">
							<td rowspan="${fn:length(list)}" class="col-fee">무료</td>
						</c:if> 
					</tr>
				</c:forEach>
				<c:if test="${empty list}">
					<tr>
						<td colspan="9" class="empty-row">장바구니에 담긴 상품이 없습니다.</td>
					</tr>
				</c:if>
				</tbody>
				<tfoot>
					<tr>
						<td colspan="4" class="subtext">기본배송</td>
						<td colspan="5" class="total-td">
							<div class="totalPrice">총가격 : <span class="finalPrice">0</span>원</div>
						</td>
					</tr>
				</tfoot>
			</table>
		</form>
		
		<div class="orderBtn">
			<div class="left-btn-group">
				<button type="button" class="delete" onclick="choice('delete')">선택상품삭제</button>
				<button type="button" class="delete" onclick="allDeleteChoice()">전체상품삭제</button>
			</div>
			<div class="right-btn-group">
			    <form class="cartForm" action="" method="post">
			        <!-- 기존 클래스에 .buy가 있어 기본 스타일이 적용됨 -->
			        <button type="button" class="buy" onclick="choice('order')">선택상품주문</button>
			        <!-- 아래와 같이 .all-buy 클래스를 추가해야 초록색이 적용됩니다 -->
			        <button type="button" class="buy all-buy" onclick="allOrderChoice()">전체상품주문</button>
			    </form>
			</div>
		</div>
		
		<!-- 수량 변경 전용 form (별도, 화면에는 안 보임) -->
		<form id="qtyUpdateForm" action="/updateCartQty" method="post" style="display:none;">
			<input type="hidden" name="ca_no" id="update_ca_no">
			<input type="hidden" name="ca_qty" id="update_ca_qty">
		</form>
	</div>

	<%@ include file="../footer.jsp" %>	
</body>
<script>
	function choice(type){
		const cartForm = document.querySelector('.cartForm');
		const checkedBoxes = document.querySelectorAll('.cartCheck:checked');
		
		if(checkedBoxes.length == 0){
			alert('선택한 상품이 없습니다.');
			return;
		}
		
		cartForm.querySelectorAll('input[name="ca_no"]').forEach(input => input.remove());
		
		for(const box of checkedBoxes){
	        const input = document.createElement('input');
	        input.type = 'hidden';
	        input.name = 'ca_no';
	        input.value = box.value;
	        cartForm.appendChild(input);
	    }
		
		if(type === 'delete'){
			cartForm.action = '/deleteCarts';
		}else{
			cartForm.action = '/orderWrite';
		}
		
		cartForm.submit();
	}
	
	// 전체상품 선택 주문
	function allOrderChoice(){
	    const allCheckBoxes = document.querySelectorAll('.cartCheck');
	    for(const box of allCheckBoxes){
	        box.checked = true;
	    }
	    setFinalPrice();
	    choice('order');
	}

	// 전체상품 선택 삭제
	function allDeleteChoice(){
	    const allCheckBoxes = document.querySelectorAll('.cartCheck');
	    for(const box of allCheckBoxes){
	        box.checked = true;
	    }
	    setFinalPrice();
	    choice('delete');
	}

	const checkAll = document.querySelector('.checkAll');
	if(checkAll){
		checkAll.addEventListener('click', function(){
			const isChecked = checkAll.checked;	
			const checkBoxes = document.querySelectorAll('.cartCheck');
			for(const checkBox of checkBoxes){
				checkBox.checked = isChecked;
			}
			setFinalPrice();
		});
	}
	
	const cartCheck = document.querySelectorAll('.cartCheck');
	for(const chk of cartCheck){
		chk.addEventListener('click', function(){
			const total = document.querySelectorAll('.cartCheck').length;
			const checked = document.querySelectorAll('.cartCheck:checked').length;
			if(checkAll) checkAll.checked = (total === checked);
			setFinalPrice();
		});
	}
	
	function setFinalPrice(){
		const checkedBoxes = document.querySelectorAll('.cartCheck:checked');
		let finalPrice = 0;
		for(const checkedBox of checkedBoxes){
			const price = parseInt(checkedBox.closest('tr').querySelector('.itemPrice').dataset.price) || 0;
			finalPrice = price + finalPrice;
		}
		document.querySelector('.finalPrice').innerText = finalPrice.toLocaleString();
	}
	
	const qtyInputs = document.querySelectorAll('.qtyInput');
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
			const itemPriceTd = row.querySelector('.itemPrice');
			itemPriceTd.dataset.price = newPrice;
			itemPriceTd.innerText = newPrice.toLocaleString() + '원';
			
			const itemPointTd = row.querySelector('.itemPoint');
			const newPoint = Math.floor(newPrice * 0.01);
			itemPointTd.innerText = newPoint.toLocaleString() + '원';
			
			setFinalPrice();
		});
	}
	
	const updateBtns = document.querySelectorAll('.updateQtyBtn');
	for(const btn of updateBtns){
		btn.getElementById = 'no_conflict'; // safety
		btn.addEventListener('click', function(){
			const caNo = this.dataset.cano;
			const row = this.closest('tr');
			const qtyInput = row.querySelector('.qtyInput');
			let qty = parseInt(qtyInput.value);
			
			if(isNaN(qty) || qty < 1){
				alert('수량은 1개 이상이어야 합니다.');
				qty = 1;
				qtyInput.value = 1;
				return;
			}
	
			document.getElementById('update_ca_no').value = caNo;
			document.getElementById('update_ca_qty').value = qty;
			document.getElementById('qtyUpdateForm').submit();
		});
	}
	
	setFinalPrice();
</script>
</html>