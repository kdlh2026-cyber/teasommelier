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
	<%@ include file="header.jsp" %>
		<h1>CART</h1>
		<form name="cartList">
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
				</tr>
			<c:forEach var="cart" items="${list}" varStatus="status">
				<tr>
					<td><input type="checkbox" value="${cart.ca_no}" checked class="cartCheck"></td>
					<td><a href="/guest/productDetail?p_no=${cart.p_no}"><img src="/images/product/${cart.ca_image}" width="150"></a></td>
					<td><a href="/guest/productDetail?p_no=${cart.p_no}">${cart.ca_info}</a></td>
					<td>
						<input type="number" name="ca_qty" value="${cart.ca_qty}" min="1" class="qtyInput" data-unit-price="${cart.ca_price}" data-original-qty="${cart.ca_qty}"> 개
						<input type="button" value="변경하기" class="updateQtyBtn" data-cano="${cart.ca_no}">
					</td> 
					
					<!-- 상품구매금액 -->
					<td class="itemPrice" data-price="${cart.ca_price * cart.ca_qty}">
						<fmt:formatNumber value="${cart.ca_price * cart.ca_qty}" type="number"/>원
					</td>
					
					<td></td>
					
					<!-- 적립금 -->
					<td class="itemPoint">
						<fmt:formatNumber value="${(cart.ca_price * cart.ca_qty) * 0.01}" type="number"/>원
					</td>
					
					<td>${cart.ca_del}</td>
					
					<c:if test="${status.first}">
						<td rowspan="${fn:length(list)}">무료</td>
					</c:if> 
				</tr>
			</c:forEach>
				<tr>
					<td colspan=4 class="subtext">기본배송</td>
					<td colspan=5>
						<div class="totalPrice">총가격 : <span class="finalPrice">0</span>원</div>
					</td>
				</tr>
			</table>
		</form>
		
		<div class="orderBtn">
				<button type="button" class="buy" onclick="allOrderChoice(this)">전체상품주문</button>
				<button type="button" class="delete" onclick="allDeleteChoice()">전체상품삭제</button>
			<form class="cartForm" action="" method="post">
				<button type="button" class="buy" onclick="choice('order')">선택상품주문</button>
				<button type="button" class="delete" onclick="choice('delete')">선택상품삭제</button>
			</form>
		</div>
		
		<!-- 수량 변경 전용 form (별도, 화면에는 안 보임) -->
		<form id="qtyUpdateForm" action="/updateCartQty" method="post" style="display:none;">
			<input type="hidden" name="ca_no" id="update_ca_no">
			<input type="hidden" name="ca_qty" id="update_ca_qty">
		</form>
		
		<a href="/main">쇼핑계속하기</a>
	<%@ include file="footer.jsp" %>
</body>
<script>
	function choice(type){
		const cartForm = document.querySelector('.cartForm');
		const checkedBoxes = document.querySelectorAll('.cartCheck:checked');
		
		// 선택한 상품이 없는 경우 알람창
		if(checkedBoxes.length == 0){
			alert('선택한 상품이 없습니다.')
			return;
		}
		
		cartForm.querySelectorAll('input[name="ca_no"]').forEach(input => input.remove());
		
		// 선택된 상품의 ca_no를 hidden input에 추가
		for(const box of checkedBoxes){
	        const input = document.createElement('input');
	        input.type = 'hidden';
	        input.name = 'ca_no';
	        input.value = box.value;
	        cartForm.appendChild(input);
	    }
		
		// 주문, 삭제에 따라 action 지정
		if(type === 'delete'){
			cartForm.action = '/deleteCarts';
		}else{
			cartForm.action = '/orderWrite';
		}
		
		cartForm.submit();
	}
	
	// 전체상품 선택
	function allOrderChoice(){
	    const allCheckBoxes = document.querySelectorAll('.cartCheck');
	    for(const box of allCheckBoxes){
	        box.checked = true;
	    }
	    choice('order');
	}
	
	// 전체상품 삭제
	function allDeleteChoice(){
	    const allCheckBoxes = document.querySelectorAll('.cartCheck');

	    for(const box of allCheckBoxes){
	        box.checked = true;
	    }

	    choice('delete');
	}

	
	// 전체선택 체크박스
	const checkAll = document.querySelector('.checkAll');
	
	checkAll.addEventListener('click', function(){
		const isChecked = checkAll.checked;	
		const checkBoxes = document.querySelectorAll('.cartCheck');
		
		for(const checkBox of checkBoxes){
			checkBox.checked = isChecked;
		}
		
		setFinalPrice();
	});
	
	// 개별 채크박스
	const cartCheck = document.querySelectorAll('.cartCheck');
	
	for(const chk of cartCheck){
		chk.addEventListener('click', function(){
			const total = document.querySelectorAll('.cartCheck').length;
			const checked = document.querySelectorAll('.cartCheck:checked').length;

			// 모든 상품이 선택됐으면 전체선택 체크
			checkAll.checked = (total === checked);

			setFinalPrice();
		});

	}
	
	// 선택 상품 총가격
	function setFinalPrice(){
		const checkedBoxes = document.querySelectorAll('.cartCheck:checked');

		let finalPrice = 0;
		for(const checkedBox of checkedBoxes){
			const price = parseInt(checkedBox.closest('tr').querySelector('.itemPrice').dataset.price) || 0;
		
			finalPrice = price + finalPrice;
		}
		
		document.querySelector('.finalPrice').innerText = finalPrice.toLocaleString();
	}
	
	// 수량 변경시 가격, 적립금 변경
	const qtyInputs = document.querySelectorAll('.qtyInput');

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
			
			// 수량 1 밑으로 안돼~
			if(isNaN(qty) || qty < 1){
				qty = 1;
				this.value = 1;
			}
			
			// 상품 가격 재계산
			const newPrice = unitPrice * qty;
			
			// 상품 금액 변경 (상품 가격 그대로 적용)
			const itemPriceTd = row.querySelector('.itemPrice');
			itemPriceTd.dataset.price = newPrice;
			itemPriceTd.innerText = newPrice.toLocaleString() + '원';
			
			// 적립금 변경(상품 가격의 1%)
			const itemPointTd = row.querySelector('.itemPoint');
			const newPoint = Math.floor(newPrice * 0.01);
			itemPointTd.innerText = newPoint.toLocaleString() + '원';
			
			// 전체 가격 계싼
			setFinalPrice();
		});
	}
	
	
	// 수량 변경하기 버튼	
	const updateBtns = document.querySelectorAll('.updateQtyBtn');
	
	for(const btn of updateBtns){
		btn.addEventListener('click', function(){
			const caNo = this.dataset.cano;
			const row = this.closest('tr');
			const qtyInput = row.querySelector('.qtyInput');
			let qty = parseInt(qtyInput.value);
			
			// 수량 최소 하나~
			if(isNaN(qty) || qty < 1){
				alert('수량은 1개 이상이어야 합니다.');
				qty = 1;
				qtyInput.value = 1;
				return;
			}
	
			// hidden form에 값 입력
			document.getElementById('update_ca_no').value = caNo;
			document.getElementById('update_ca_qty').value = qty;
			
			// 수량 변경 form 제출
			document.getElementById('qtyUpdateForm').submit();
		});
	}
	
	setFinalPrice();
</script>
</html>