<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고객센터 페이지</title>
</head>
<body>
<%@ include file="../header.jsp" %>
	<h2>고객센터</h2>
	<p>자주 묻는 질문을 한 눈에 확인하실 수 있습니다.</p>
	<br>

	<!-- category -->
	<ul id="csCategoryList">
		<li><button type="button" data-category="전체">전체</button></li>
		<li><button type="button" data-category="운영">운영</button></li>
		<li><button type="button" data-category="상품">상품</button></li>
		<li><button type="button" data-category="주문">주문</button></li>
		<li><button type="button" data-category="배송">배송</button></li>
		<li><button type="button" data-category="회원">회원</button></li>
		<li><button type="button" data-category="기타">기타</button></li>
	</ul>
	<!-- //category -->

	<!-- accordion -->
	<div id="csAccordionList">
	<c:forEach var="cs" items="${csList}">
	  <div data-category="${cs.cs_category}">
	    <h5><button type="button" class="csToggleBtn">${cs.cs_subject}</button></h5>
	    <div class="csContent" style="display:none;">
	      <div>
	        ${cs.cs_content}
	      </div>
	    </div>
	  </div>
	</c:forEach>
	</div>
	<!-- //accordion -->

<%@ include file="../footer.jsp" %>

<script>
window.onload = function() {

	// 1. 아코디언 토글 (질문 클릭 시 답변 펼침/접힘)
	var toggleBtns = document.getElementsByClassName("csToggleBtn");
	for (var i = 0; i < toggleBtns.length; i++) {
		toggleBtns[i].onclick = function() {
			var content = this.parentNode.nextElementSibling;
			if (content.style.display === "none") {
				content.style.display = "block";
			} else {
				content.style.display = "none";
			}
		};
	}

	// 2. 카테고리 필터링
	var categoryBtns = document.querySelectorAll("#csCategoryList button");
	var items = document.querySelectorAll("#csAccordionList > div");

	for (var i = 0; i < categoryBtns.length; i++) {
		categoryBtns[i].onclick = function() {
			var selected = this.getAttribute("data-category");

			for (var j = 0; j < items.length; j++) {
				var itemCategory = items[j].getAttribute("data-category");

				if (selected === "전체" || selected === itemCategory) {
					items[j].style.display = "block";
				} else {
					items[j].style.display = "none";
				}
				// 카테고리 전환 시 열려있던 답변은 다시 닫아줌
				items[j].querySelector(".csContent").style.display = "none";
			}
		};
	}

};
</script>
</body>
</html>