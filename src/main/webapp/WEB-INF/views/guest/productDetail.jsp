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
		<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	</div>
<div class="detail-wrap">
    <!-- 좌측: 이미지 영역 -->    
    <div class="detail-img-area">        
    <img class="main-img" src="/images/product/${product.p_img}" alt="${product.p_name}">        
    <c:if test="${not empty product.p_img2}">            
    <img class="sub-img" src="/images/product/${product.p_img2}" alt="${product.p_name} 서브이미지"> 
           </c:if>    
    </div>
    
    <!-- 우측: 정보 영역 -->    
    <div class="detail-info-area">
        <h1 class="detail-name">${product.p_name}</h1>
        
    <!-- 부가정보: 상품종류(용량) 형태로 표시 -->        
    <p class="detail-subinfo">${product.p_type} (${product.p_capacity})</p>
        <p class="detail-price">
        <fmt:formatNumber value="${product.p_price}" pattern="#,###"/>원</p>
        
        <!-- 배송/재고 안내 박스 -->        
        <div class="detail-notice-box">            
        <div class="notice-row">                
        <span class="notice-label">재고</span>                
        <span class="notice-value">                    
        <c:choose>                        
        <c:when test="${product.p_stock > 0}">${product.p_stock}개 남음</c:when> 
        <c:otherwise>품절</c:otherwise>                    
        </c:choose>                
        </span>            
        </div>            
        <c:if test="${not empty product.p_time}">                
        <div class="notice-row">                    
        <span class="notice-label">유통기한</span>                    
        <span class="notice-value">${product.p_time}</span>                
        </div>            
        </c:if>            
        
        <!-- 판매중이 아닌 경우(품절/박스훼손 등) 상태 안내 -->            
        <c:if test="${product.p_sale != '판매중'}">                
        <div class="notice-row">                    
        <span class="notice-label">상태</span>                    
        <span class="notice-value notice-warning">${product.p_sale}</span>                
        </div>            
        </c:if>        
        </div>
        
        <!-- 상품설명 -->  
              <div class="detail-desc">
                   <c:out value="${product.p_desc}" escapeXml="false"/> 
             </div>
             
        <!-- 수량선택 + 합계 -->        
        <c:if test="${product.p_stock > 0 && product.p_sale == '판매중'}">            
        <div class="detail-qty-area">                
        <input type="number" id="qty" name="qty" value="1" min="1" max="${product.p_stock}">                
        <span class="qty-price" data-unit-price="${product.p_price}">                    
        <fmt:formatNumber value="${product.p_price}" pattern="#,###"/>원                
        </span>            
        </div>
            <div class="detail-total-price">                
            <span id="totalPrice">
            <fmt:formatNumber value="${product.p_price}" pattern="#,###"/>원</span>                
            <span class="total-count">(1개)</span>            
            </div>        
            </c:if>
            
        <!-- 구매 버튼 영역 -->        
        <div class="detail-btn-area">            
        <c:choose>                
        <c:when test="${product.p_stock > 0 && product.p_sale == '판매중'}">                    
        <a href ="#"><button type="button" class="btn-buy">바로구매</button></a>                    
        <a href ="/cartList"><button type="button" class="btn-cart">장바구니</button></a>                   
        <a href ="#"><button type="button" class="btn-wish">관심상품</button></a>               
        </c:when>               
         <c:otherwise>                    
         <button type="button" class="btn-soldout" disabled>SOLD OUT</button>                    
         <a href="#" class="btn-inquiry">관심상품</a>                
         </c:otherwise>            
         </c:choose>            
         </div>
    </div>
</div>
   <script>
   const qtyInput = document.getElementById('qty');if (qtyInput) {    
	qtyInput.addEventListener('input', function() {        
		const unitPrice = document.querySelector('.qty-price').dataset.unitPrice;        
		const qty = this.value || 1;        
		const total = unitPrice * qty;        
		document.getElementById('totalPrice').textContent = total.toLocaleString() + '원';        
		document.querySelector('.total-count').textContent = '(' + qty + '개)';   });}
		</script>
</body>
</html>
