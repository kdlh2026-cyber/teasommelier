<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>브랜드 소식</title>
</head>
<body>
	<h2>브랜드 소식</h2>
	<p>브랜드 소식입니다.</p>
	<table border=1>
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>작성자</th>
			<th>작성일</th>
			<th>조회</th>
		</tr>
	<c:forEach var="BNL" items="${CommunityList}">
		<tr>
			<td>${BNL.cb_no}</td>
			<td>${BNL.cb_subject}</td>
			<td>${BNL.m_no}</td>
			<td>${BNL.cb_date}</td>
			<td>${BNL.cb_view_count}</td>
		</tr>
	</c:forEach>
	</table>
	<sec:authorize access="hasRole('ADMIN')">
		<a href="/cb_brandnoticeForm">새 공지 작성</a>
	</sec:authorize>
</body>
</html>