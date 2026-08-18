<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고객센터 페이지</title>
<link rel="stylesheet" href="/css/customerService.css">
<script src="/js/customerService.js"></script>
</head>
<body>
<%@ include file="../../header.jsp" %>
	<div class="cs-page">
		<div class="cs-title-row">
			<h2 class="cs-title">고객센터</h2>
			<h2 class="cs-phone">02-536-7300</h2>
		</div>
		<hr class="cs-divider">
		<div class="cs-info-row">
			<p>자주 묻는 질문을 한 눈에 확인하실 수 있습니다.</p>
			<p class="cs-hours">평일 09:30 ~ 18:00 (점심시간 12:30 ~ 13:30) 주말 및 공휴일 휴무</p>
		</div>

		<!-- category -->
		<ul id="csCategoryList">
			<li><button type="button" class="csCategoryBtn active" data-category="전체">전체</button></li>
			<li><button type="button" class="csCategoryBtn" data-category="운영">운영</button></li>
			<li><button type="button" class="csCategoryBtn" data-category="상품">상품</button></li>
			<li><button type="button" class="csCategoryBtn" data-category="주문">주문</button></li>
			<li><button type="button" class="csCategoryBtn" data-category="배송">배송</button></li>
			<li><button type="button" class="csCategoryBtn" data-category="회원">회원</button></li>
			<li><button type="button" class="csCategoryBtn" data-category="기타">기타</button></li>
		</ul>
		<!-- //category -->

		<!-- accordion -->
		<div id="csAccordionList">
		<c:forEach var="cs" items="${csList}">
		  <div class="csItem" data-category="${cs.cs_category}">
		    <h5><button type="button" class="csToggleBtn"><span class="csQMark">Q.</span> ${cs.cs_subject}</button></h5>
		    <div class="csContent" style="display:none;">
		      <div>
		        ${cs.cs_content}<br>
		        <br>
		        <sec:authorize access="hasRole('ADMIN')">
		        <form class="csAdminForm" action="/customerServiceDelete" method="post">
		          <input type="hidden" name="cs_no" value="${cs.cs_no}">
		          <a href="/admin/cs/cs_customerServiceUpdateForm?cs_no=${cs.cs_no}">수정</a>
		          <button type="submit" onclick="return confirm('정말로 삭제하겠습니까?');">삭제</button>
		        </form>
		        </sec:authorize>
		      </div>
		    </div>
		  </div>
		</c:forEach>
		</div>
		<!-- //accordion -->

		<sec:authorize access="hasRole('ADMIN')">
		<a class="cs-add-btn" href="/admin/cs/cs_customerServiceInsertForm">추가</a>
		</sec:authorize>
	</div>

<%@ include file="../../footer.jsp" %>
</body>
</html>