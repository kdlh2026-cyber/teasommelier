<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Q&A 목록 페이지</title>
</head>
<body>
	<h2>Q&A</h2>
	<p>상품 문의입니다.</p>
	<table border=1>
		<tr>
			<th>번호</th>
			<th>상품</th>
			<th>카테고리</th>
			<th>제목</th>
			<th>작성자</th>
			<th>작성일</th>
			<th>조회</th>
		</tr>
	<c:forEach var="QAL" items="${qnaList}">
		<tr>
			<td>${QAL.cb_no}</td>
			<td>${QAL.p_img}</td>
			<td>${QAL.cb_qna_category}</td>
			<td>${QAL.cb_subject}</td>
			<td>${QAL.m_id}</td>
			<td>${QAL.cb_date}</td>
			<td>${QAL.cb_view_count}</td>
		</tr>
	</c:forEach>
	</table>
	<sec:authorize access="hasRole('ADMIN')">
		<a href="/member/cb_qnaForm">새 문의 작성</a>
	</sec:authorize>
</body>
</html>