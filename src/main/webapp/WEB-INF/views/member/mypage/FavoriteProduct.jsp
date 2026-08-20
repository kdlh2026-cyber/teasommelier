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
<link rel="stylesheet" href="/css/favoriteProduct.css">
</head>
<body>
<%@ include file="/WEB-INF/views/header.jsp" %>

<div class="addr-container">
    <div>
        <%@ include file ="Mymenu.jsp" %> 
    </div>
    
    <div class="addr-header">
        <h3>관심상품</h3>
        <p>고객님이 찜하신 관심상품 목록입니다.</p>
    </div>
    
    <form name="favList">
        <table class="addr-table">
            <colgroup>
                <col style="width: 50px;">
                <col style="width: 100px;">
                <col style="width: auto;">
                <col style="width: 120px;">
                <col style="width: 120px;">
            </colgroup>
            <thead>
                <tr>
                    <th><input type="checkbox" class="checkAll" checked></th>
                    <th>이미지</th>
                    <th>상품정보</th>
                    <th>판매가</th>
                    <th>장바구니</th>
                </tr>
            </thead>
            <tbody>
            <c:choose>
                <c:when test="${empty fav}">
                    <tr>
                        <td colspan="5" style="padding: 40px 0; color: #888;">관심상품 내역이 존재하지 않습니다.</td>
                    </tr>
                </c:when>
                <c:otherwise>
                    <c:forEach var="list" items="${fav}" varStatus="status">
                        <tr>
                            <td><input type="checkbox" name="f_no" value="${list.f_no}" checked class="favCheck"></td>
                            <td>
                                <a href="/guest/productDetail?p_no=${list.p_no}">
                                    <img src="/images/product/${list.f_image}" width="70" height="70" alt="상품 이미지">
                                </a>
                            </td>
                            <td class="td-info">
                                <a href="/guest/productDetail?p_no=${list.p_no}">${list.f_info}</a>
                            </td>
                            <td><fmt:formatNumber value="${list.f_price}" type="number"/>원</td>
                            <td>
                                <a href="/insertCart?p_no=${list.p_no}&ca_qty=1" class="btn-cart-link">장바구니 담기</a>
                            </td>
                        </tr>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
            </tbody>
        </table>
    </form>
    
    <!-- 하단 버튼 영역 (전체선택/선택상품 기능 포함) -->
    <div class="addr-actions">
        <div class="action-group">
            <button type="button" class="btn-delete" onclick="allDeleteChoice()">전체상품삭제</button>
            <button type="button" class="btn-submit" onclick="allOrderChoice(this)">전체상품주문</button>
        </div>
        <div class="action-group">
            <button type="button" class="btn-delete" onclick="choice('delete')">선택상품삭제</button>
            <button type="button" class="btn-submit" onclick="choice('order')">선택상품주문</button>
        </div>
    </div>
    
    <!-- 스크립트 연동을 위한 숨김 폼 -->
    <form class="favForm" action="" method="post" style="display:none;"></form>
</div>

<%@ include file="/WEB-INF/views/footer.jsp" %>
</body>
<script>
function choice(type){
	const favForm = document.querySelector('.favForm');
	const checkedBoxes = document.querySelectorAll('.favCheck:checked');
	
	// 선택된 상품이 없는 경우
	if(checkedBoxes.length === 0){
		alert('선택한 상품이 없습니다.');
		return;
	}
	
	favForm.querySelectorAll('input[name="f_no"]').forEach(input => input.remove());
	
	for(const box of checkedBoxes){
		const input = document.createElement('input');
		input.type = 'hidden';
		input.name = 'f_no';
		input.value = box.value;

		favForm.appendChild(input);
	}
	
	if(type === 'delete'){
		favForm.action = '/deleteFav';
	}else if(type === 'order'){
		favForm.action = '/orderWriteFav';
	}
	
	favForm.submit();
}

// 전체 상품 주문
function allOrderChoice(){
	const allCheckBoxes = document.querySelectorAll('.favCheck');

	// 모든 상품 체크
	for(const box of allCheckBoxes){
		box.checked = true;
	}

	// 전체 상품 주문
	choice('order');
}

// 전체 상품 삭제
function allDeleteChoice(){
	const allCheckBoxes = document.querySelectorAll('.favCheck');

	// 모든 상품 체크
	for(const box of allCheckBoxes){
		box.checked = true;
	}

	// 전체 상품 삭제
	choice('delete');
}

// 체크박스 전체선택
	const checkAll = document.querySelector('.checkAll');

	checkAll.addEventListener('click', function(){

		const isChecked = checkAll.checked;
		const checkBoxes = document.querySelectorAll('.favCheck');

		for(const checkBox of checkBoxes){
			checkBox.checked = isChecked;
		}

	});

	// 개별 상품 체크 상태에 따라 전체선택 체크박스 상태 변경
	const favChecks = document.querySelectorAll('.favCheck');

	favChecks.forEach(function(checkBox){

		checkBox.addEventListener('click', function(){

			const total = document.querySelectorAll('.favCheck').length;
			const checked = document.querySelectorAll('.favCheck:checked').length;

			checkAll.checked = (total === checked);

		});

	});
	
// 개별 상품 체크 박스
</script>
</html>