<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>에디토리얼 목록 페이지</title>
</head>
<body>
<%@ include file="../header.jsp" %>
	<h2>에디토리얼</h2>
	<p>에디토리얼입니다.</p>
	<table border=1>
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>작성자</th>
			<th>작성일</th>
			<th>조회</th>
		</tr>
	<c:forEach var="EDL" items="${editorialList}">
		<tr>
			<td>${EDL.cb_no}</td>
			<td><a href="/guest/cb_editorialDetail?cb_no=${EDL.cb_no}">${EDL.cb_subject}</a></td>
			<td>${EDL.m_no}</td>
			<td>${fn:substring(EDL.cb_date, 0, 10)}</td>
			<td>${EDL.cb_view_count}</td>
		</tr>
	</c:forEach>
	</table>
	<sec:authorize access="hasRole('ADMIN')">
		<a href="/admin/cb_editorialInsertForm">새 에디토리얼 작성</a>
	</sec:authorize>
<%@ include file="../footer.jsp" %>
</body>
</html>