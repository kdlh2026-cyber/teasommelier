<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 상세 페이지</title>
</head>
<body>
<%@ include file="../../header.jsp" %>
	<div>
		<c:if test="${not empty product}">
			<img src="${product.p_img}" alt="${product.p_name}" width="75" height="75">
			<p>${product.p_name}</p>
			<p><fmt:formatNumber value="${product.p_price}" pattern="#,###"/>원</p>
		</c:if>
	</div>
	<h2>리뷰</h2>
	<p>상품 사용후기입니다.</p>
	<table border="1">
		<tr>
			<td>제목</td>
			<td>${viewCBdao.cb_subject}</td>
		</tr>
		<tr>
			<td>작성자</td>
			<td>${viewCBdao.m_id}</td>
		</tr>
		<tr>
			<td>평점</td>
			<td>${viewCBdao.cb_rating}</td>
		</tr>
		<tr>
			<td>작성일</td>
			<td>${fn:substring(viewCBdao.cb_date, 0, 10)}</td>
		</tr>
		<tr>
			<td>조회수</td>
			<td>${viewCBdao.cb_view_count}</td>
		</tr>
		<tr>
			<td colspan=2>
				${viewCBdao.cb_content}
				<br>
				<c:if test="${not empty viewCBdao.cb_file}">
					<c:forEach var="file" items="${fn:split(viewCBdao.cb_file, ',')}">
						<img src="/images/community/${file}" width="600" alt="첨부이미지"><br>
					</c:forEach>
				</c:if>
			</td>
		</tr>
	</table>
	<a href="/guest/community/cb_reviewList">목록</a>
	<sec:authorize access="hasRole('USER')">
		<a href="/member/community/cb_reviewUpdateForm?cb_no=${viewCBdao.cb_no}">수정</a>
		<a href="/cb_communityDelete?cb_no=${viewCBdao.cb_no}" onclick="return confirm('정말로 삭제하시겠습니까?');">삭제</a>
	</sec:authorize>
	<sec:authorize access="hasRole('ADMIN')">
		<a href="/member/community/cb_reviewUpdateForm?cb_no=${viewCBdao.cb_no}">수정</a>
		<a href="/cb_communityDelete?cb_no=${viewCBdao.cb_no}" onclick="return confirm('정말로 삭제하시겠습니까?');">삭제</a>
	</sec:authorize>
<%@ include file="../../footer.jsp" %>
</body>
</html>