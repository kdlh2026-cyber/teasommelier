<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>    
<meta charset="UTF-8">    
<title>${product.p_name} - 상품상세</title>    
<link rel="stylesheet" href="/css/productDetail.css"></head>
<body>
	<div>
		<jsp:include page="/WEB-INF/views/header.jsp" />
	</div>
<div class="detail-wrap">
	<form id="productForm" action="/insertCart" method="get">
		<input type="hidden" name="p_no" value="${product.p_no}">
        <input type="hidden" name="ca_image" value="${product.p_img}">    
        <input type="hidden" name="ca_info" value="${product.p_name}">    
        <input type="hidden" name="ca_price" value="${product.p_price}">
        
	    <div class="detail-container" style="display: flex; width: 100%;">
		    <!-- 좌측: 이미지 영역 -->    
		    <div class="detail-img-area">        
		    <!-- 이미지 슬라이더: 좌/우 화살표로 main/sub 이미지를 전환 -->
		    <div class="img-slider">
		        <img id="mainImg" class="main-img"
		             src="/images/product/${product.p_img}"
		             alt="${product.p_name}"
		             onclick="openImgViewer(this.src)">
		
		        <c:if test="${not empty product.p_img2 && product.p_img2 != product.p_img}">
			        <button type="button" class="slider-arrow slider-prev" onclick="slideImg(-1)">&#8249;</button>
			        <button type="button" class="slider-arrow slider-next" onclick="slideImg(1)">&#8250;</button>
		        </c:if>
		    </div>
		    </div>
		    
		    <!-- 우측: 정보 영역 -->    
		    <div class="detail-info-area">
		        <h1 class="detail-name">${product.p_name}</h1>
		        
		    <!-- 부가정보: 상품종류(용량) 형태로 표시 -->        
		    <p class="detail-subinfo">${product.p_type} (${product.p_capacity})</p>
		
		        <!-- 판매가 -->
		        <div class="info-row">
		            <span class="info-label">판매가</span>
		            <span class="info-value price-value">
		                <fmt:formatNumber value="${product.p_price}" pattern="#,###"/>원
		            </span>
		        </div>
		
		        <!-- 재고 -->
		        <div class="info-row">
		            <span class="info-label">재고</span>
		            <span class="info-value">
		                <c:choose>
		                    <c:when test="${product.p_stock > 0}">${product.p_stock}개 남음</c:when>
		                    <c:otherwise>품절</c:otherwise>
		                </c:choose>
		            </span>
		        </div>
		
		        <!-- 유통기한 -->
		        <c:if test="${not empty product.p_time}">
			        <div class="info-row">
			            <span class="info-label">유통기한</span>
			            <span class="info-value">${product.p_time}</span>
			        </div>
		        </c:if>
		
		        <!-- 수량선택: -/+ 버튼형 스테퍼 -->
		        <c:if test="${product.p_stock > 0}">
		        <div class="info-row qty-row">
		            <span class="info-label">수량</span>
		            <div class="qty-stepper" data-unit-price="${product.p_price}">
		                <button type="button" class="qty-btn" onclick="changeQty(-1)">－</button>
		                <input type="number" id="qty" name="ca_qty" value="1" min="1" max="${product.p_stock}"
		                       oninput="onQtyInput()" onblur="validateQtyInput()">
		                <button type="button" class="qty-btn" onclick="changeQty(1)">＋</button>
		            </div>
		        </div>
		
		        <div class="detail-total-price">
		            <span class="total-label">총 상품금액</span>
		            <span id="totalPrice"><fmt:formatNumber value="${product.p_price}" pattern="#,###"/>원</span>
		            <span class="total-count">(1개)</span>
		        </div>
		        </c:if>
		
		        <!-- 구매 버튼 영역: 재고(p_stock) 기준으로만 판단, 바로구매만 강조 스타일 -->        
		        <div class="detail-btn-area">            
			        <c:choose>                
				        <c:when test="${product.p_stock > 0}">                    
					        <button type="button" class="btn-buy" onclick="submitDirectOrder()">바로구매</button>                  
					        <button type="submit" class="btn-cart">장바구니</button>                   
				        	<a href="/insertFavorite?p_no=${product.p_no}">
				                <button type="button" class="btn-wish">관심상품</button>
				            </a>               
				        </c:when>               
				         <c:otherwise>                    
					         <button type="button" class="btn-soldout" disabled>SOLD OUT</button>                    
					         <a href="#" class="btn-inquiry">관심상품</a>                
				         </c:otherwise>            
			         </c:choose>            
		         </div>
		    </div>
	    </div>
    </form>
</div>

<!-- 탭 메뉴 + 내용: 상품정보 탭에서만 실제 설명(p_desc) 표시, 나머지는 준비중 -->
<div class="detail-tab-wrap">
    <div class="tab-menu">
        <button type="button" class="tab-btn active" onclick="switchTab(this, 'tab-info')">상품정보</button>
        <button type="button" class="tab-btn" onclick="switchTab(this, 'tab-guide')">가이드</button>
        <button type="button" class="tab-btn" onclick="switchTab(this, 'tab-review')">구매후기</button>
        <button type="button" class="tab-btn" onclick="switchTab(this, 'tab-qna')">질문답변</button>
    </div>

    <div id="tab-info" class="tab-panel active">
        <div class="detail-desc">
            <c:out value="${product.p_desc}" escapeXml="false"/> 
        </div>
    </div>
    <div id="tab-guide" class="tab-panel">
        <p class="tab-empty">가이드 준비중입니다.</p>
    </div>
    <div id="tab-review" class="tab-panel">
        <p class="tab-empty">등록된 구매후기가 없습니다.</p>
    </div>
    <div id="tab-qna" class="tab-panel">
        <p class="tab-empty">등록된 질문답변이 없습니다.</p>
    </div>
</div>

<!-- 이미지 상세보기 모달: 이미지 클릭시 원본 크게 표시, 배경 클릭시 닫힘 -->
<div id="imgViewerModal" class="img-viewer-modal" onclick="closeImgViewer()">
    <img id="imgViewerContent" src="" alt="이미지 상세보기">
</div>

   <script>
	// 슬라이더에 쓸 이미지 목록 (main, sub 순서)
	const sliderImages = [
		"/images/product/${product.p_img}"
		<c:if test="${not empty product.p_img2 && product.p_img2 != product.p_img}">
		, "/images/product/${product.p_img2}"
		</c:if>
	];
	let currentSlideIdx = 0;

	// 화살표 클릭시 이전/다음 이미지로 순환 이동 (마지막에서 다음 누르면 처음으로)
	function slideImg(direction) {
		currentSlideIdx = (currentSlideIdx + direction + sliderImages.length) % sliderImages.length;
		document.getElementById('mainImg').src = sliderImages[currentSlideIdx];
	}

	// 총 금액 재계산 (수량 변경시 공통 호출)
	function updateTotalPrice() {
		const stepper = document.querySelector('.qty-stepper');
		const unitPrice = Number(stepper.dataset.unitPrice);
		const qty = Number(document.getElementById('qty').value) || 1;
		const total = unitPrice * qty;
		document.getElementById('totalPrice').textContent = total.toLocaleString() + '원';
		document.querySelector('.total-count').textContent = '(' + qty + '개)';
	}

	// -/+ 버튼으로 수량 변경 (min/max 범위 안에서만 이동)
	function changeQty(delta) {
		const qtyInput = document.getElementById('qty');
		const min = Number(qtyInput.min) || 1;
		const max = Number(qtyInput.max) || 999;
		let next = Number(qtyInput.value) + delta;
		if (next < min) next = min;
		if (next > max) next = max;
		qtyInput.value = next;
		updateTotalPrice();
	}

	// 타이핑 도중 호출 - 최대값(재고)만 넘지 않게 제한, 최소값은 blur에서 처리 (입력 중 강제로 1로 튕기는 것 방지)
	function onQtyInput() {
		const qtyInput = document.getElementById('qty');
		const max = Number(qtyInput.max) || 999;
		const value = Number(qtyInput.value);
		if (!isNaN(value) && value > max) {
			qtyInput.value = max;
		}
		updateTotalPrice();
	}

	// 입력 완료 후(blur) 최종 검증 - 정수화, 빈값/범위 밖 값은 min/max로 보정
	function validateQtyInput() {
		const qtyInput = document.getElementById('qty');
		const min = Number(qtyInput.min) || 1;
		const max = Number(qtyInput.max) || 999;
		let value = Math.floor(Number(qtyInput.value));

		if (isNaN(value) || value < min) value = min;
		if (value > max) value = max;

		qtyInput.value = value;
		updateTotalPrice();
	}

	// 탭 메뉴 클릭시 선택된 탭만 active로 전환 (버튼/내용 둘 다 전환)
	function switchTab(btnEl, panelId) {
		document.querySelectorAll('.tab-btn').forEach(function(b) {
			b.classList.remove('active');
		});
		document.querySelectorAll('.tab-panel').forEach(function(p) {
			p.classList.remove('active');
		});
		btnEl.classList.add('active');
		document.getElementById(panelId).classList.add('active');
	}

	// 이미지 상세보기 모달 열기
	function openImgViewer(src) {
		document.getElementById('imgViewerContent').src = src;
		document.getElementById('imgViewerModal').classList.add('active');
	}

	// 이미지 상세보기 모달 닫기
	function closeImgViewer() {
		document.getElementById('imgViewerModal').classList.remove('active');
	}
	
	// 바로구매 버튼 클릭시 컨트롤러로 이동
	function submitDirectOrder() {
		const pNo = "${product.p_no}";
		const qty = document.getElementById('qty').value;
		location.href = '/orderWriteDirect?p_no=' + pNo + '&ca_qty=' + qty;
	}
	</script>
</body>
</html>
