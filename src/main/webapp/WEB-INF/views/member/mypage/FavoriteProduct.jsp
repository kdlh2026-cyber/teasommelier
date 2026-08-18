<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TeaSommelier</title>
</head>
<body>
<%@ include file="/WEB-INF/views/header.jsp" %>
<div>
	<div>
		<%@ include file ="Mymenu.jsp" %> 
	</div>
	<div>
		<h1>관심상품</h1>
		<form name="favList" method="post" action="/orderWriteFav">
			<table border=1 width=1000>
				<tr>
					<th><input type="checkbox" class="checkAll" checked></th>
					<th>이미지</th>
					<th>상품정보</th>
					<th>판매가</th>
					<td>장바구니</td>
				</tr>
			<c:forEach var="list" items="${fav}" varStatus="status">
				<tr>
					<td><input type="checkbox" name="f_no" value="${list.f_no}" checked class="favCheck"></td>
					<td><a href="/guest/ViewForm?p_no=${list.p_no}"><img src="/images/product/${list.f_image}" width="150"></a></td>
					<td><a href="/guest/ViewForm?p_no=${list.p_no}">${list.f_info}</a></td>
					<td><fmt:formatNumber value="${list.f_price}" type="number"/>원</td>
					<td><a href="/insertCart?p_no=${list.p_no}&ca_qty=1">장바구니 담기</a></td>
				</tr>
			</c:forEach>	
			</table>
			<button type="submit">전체상품주문</button>
		</form>
		
		<form class="favForm" action="" method="post">
			<button type="button" class="buy" onclick="choice(this)">선택상품주문</button>
			<button type="button" class="delete" onclick="choice(this)">선택상품삭제</button>
		</form>
	</div>
</div>
<%@ include file="/WEB-INF/views/footer.jsp" %>
</body>
<script>
function choice(selectedTag){
	const favForm = document.querySelector('.favForm');
	const checkedBoxes = document.querySelectorAll('.favCheck:checked');
	
	if(checkedBoxes.length == 0){
		alert('선택한 상품이 없습니다.')
		return;
	}
	
	favForm.innerHTML = '';
	
	for(const box of checkedBoxes){
        const input = document.createElement('input');
        input.type = 'hidden';
        input.name = 'f_no';
        input.value = box.value;
        favForm.appendChild(input);
    }
	
	if(selectedTag.innerText == '선택상품삭제'){
		favForm.action = '/deleteFav';
	}else{
		favForm.action = '/orderWriteFav';
	}
	
	favForm.submit();
}

document.querySelector('form[name="favList"]').addEventListener('submit', function(e){
	const allCheckBoxes = document.querySelectorAll('.favCheck');
	for(const box of allCheckBoxes){
		box.checked = true;
	}
});

const checkAll = document.querySelector('.checkAll');
const cartCheck = document.querySelectorAll('.favCheck');

checkAll.addEventListener('click', function(){
	const isChecked = checkAll.checked;	
	const checkBoxes = document.querySelectorAll('.favCheck');
	
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
});
</script>
</html>