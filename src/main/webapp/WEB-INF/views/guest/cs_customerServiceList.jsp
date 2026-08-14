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
	<ul>
		<li>전체</li>
		<li>운영</li>
		<li>상품</li>
		<li>주문</li>
		<li>배송</li>
		<li>회원</li>
		<li>기타</li>
	</ul>

	<!-- accordion -->
	<div>
	<c:forEach var="cs" items="${csList}">
	  <div>
	    <h5><button type="button">${cs.cs_subject}</button></h5>
	    <div>
	      <div>
	        ${cs.cs_content}
	      </div>
	    </div>
	  </div>
	</c:forEach>
	</div>
	<!-- //accordion -->
<%@ include file="../footer.jsp" %>
</body>
</html>