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
		<c:forEach var="list" items="${list}" varStatus="status">
			<tr>
				<td><input type="checkbox" value="${list.ca_no}" checked class="cartCheck"></td>
				<td><a href="/guest/ViewForm?p_no=${list.p_no}"><img src="/images/product/${list.ca_image}" width="150"></a></td>
				<td><a href="/guest/ViewForm?p_no=${list.p_no}">${list.ca_info}</a></td>
				<td>
					<input type="number" name="ca_qty" value="${list.ca_qty}" min="1" class="qtyInput" data-unit-price="${list.ca_price}" data-original-qty="${list.ca_qty}"> 개
					<input type="button" value="변경하기" class="updateQtyBtn" data-cano="${list.ca_no}">
				</td> 
				
				<!-- 상품구매금액 -->
				<td class="itemPrice" data-price="${list.ca_price * list.ca_qty}">
					<fmt:formatNumber value="${list.ca_price * list.ca_qty}" type="number"/>원
				</td>
				
				<td></td>
				
				<!-- 적립금 칸에 itemPoint 클래스 추가 -->
				<td class="itemPoint">
					<fmt:formatNumber value="${(list.ca_price * list.ca_qty) * 0.01}" type="number"/>원
				</td>
				
				<td>${list.ca_del}</td>
				<td>무료</td> 
			</tr>
		</c:forEach>
		</table>
		<div>총가격 : <span class="finalPrice">0</span>원</div>
		<button type="button" class="buy" onclick="allOrderChoice(this)">전체상품주문</button>
	</form>
	
	<form class="cartForm" action="" method="post">
		<button type="button" class="buy" onclick="choice(this)">선택상품주문</button>
		<button type="button" class="delete" onclick="choice(this)">선택상품삭제</button>
	</form>
	
	<!-- 수량 변경 전용 form (별도, 화면에는 안 보임) -->
	<form id="qtyUpdateForm" action="/updateCartQty" method="post" style="display:none;">
		<input type="hidden" name="ca_no" id="update_ca_no">
		<input type="hidden" name="ca_qty" id="update_ca_qty">
	</form>
	
	<a href="/guest/productTest">쇼핑계속하기</a>
</body>
<script>
	function choice(selectedTag){
		const cartForm = document.querySelector('.cartForm');
		const checkedBoxes = document.querySelectorAll('.cartCheck:checked');
		
		if(checkedBoxes.length == 0){
			alert('선택한 상품이 없습니다.')
			return;
		}
		
		cartForm.innerHTML = '';
		
		for(const box of checkedBoxes){
	        const input = document.createElement('input');
	        input.type = 'hidden';
	        input.name = 'ca_no';
	        input.value = box.value;
	        cartForm.appendChild(input);
	    }
		
		if(selectedTag.innerText == '선택상품삭제'){
			cartForm.action = '/deleteCarts';
		}else{
			cartForm.action = '/orderWrite';
		}
		
		cartForm.submit();
	}
	
	function allOrderChoice(selectedTag){
	    const allCheckBoxes = document.querySelectorAll('.cartCheck');
	    for(const box of allCheckBoxes){
	        box.checked = true;
	    }
	    choice(selectedTag);
	}

	const checkAll = document.querySelector('.checkAll');
	const cartCheck = document.querySelectorAll('.cartCheck');
	const qtyInputs = document.querySelectorAll('.qtyInput');
	const updateBtns = document.querySelectorAll('.updateQtyBtn');

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
			
			const itemPriceTd = row.querySelector('.itemPrice');
			itemPriceTd.dataset.price = newPrice;
			itemPriceTd.innerText = newPrice.toLocaleString() + '원';
			
			const itemPointTd = row.querySelector('.itemPoint');
			const newPoint = Math.floor(newPrice * 0.01);
			itemPointTd.innerText = newPoint.toLocaleString() + '원';
			
			setFinalPrice();
		});
	}
	
	// 변경하기 버튼 -> hidden form에 값 채워서 제출
	for(const btn of updateBtns){
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