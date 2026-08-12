<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 목록 페이지</title>
</head>
<body>
	<h2>리뷰</h2>
	<p>리뷰입니다.</p>
	<table border=1>
		<tr>
			<th>번호</th>
			<th>상품</th>
			<th>제목</th>
			<th>작성자</th>
			<th>작성일</th>
			<th>조회</th>
			<th>평점</th>
		</tr>
	<c:forEach var="RVL" items="${reviewList}">
		<tr>
			<td>${RVL.cb_no}</td>
			<td>${RVL.p_img}</td>
			<td>${RVL.cb_subject}</td>
			<td>${RVL.m_id}</td>
			<td>${RVL.cb_date}</td>
			<td>${RVL.cb_view_count}</td>
			<td>${RVL.cb_rating}</td>
		</tr>
	</c:forEach>
	</table>
	<sec:authorize access="hasRole('ADMIN')">
		<a href="/member/cb_reviewForm">리뷰 게시글 작성</a>
	</sec:authorize>
</body>
</html>