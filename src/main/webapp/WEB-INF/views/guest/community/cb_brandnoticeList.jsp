<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>브랜드 소식</title>
</head>
<body>
<%@ include file="../../header.jsp" %>
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
	<c:forEach var="BNL" items="${brandnoticeList}">
		<tr>
			<td>${BNL.cb_no}</td>
			<td><a href="/guest/community/cb_brandnoticeDetail?cb_no=${BNL.cb_no}">${BNL.cb_subject}</a></td>
			<td>${BNL.m_id}</td>
			<td>${fn:substring(BNL.cb_date, 0, 10)}</td>
			<td>${BNL.cb_view_count}</td>
		</tr>
	</c:forEach>
	</table>
	<sec:authorize access="hasRole('ADMIN')">
		<a href="/admin/community/cb_brandnoticeInsertForm">새 공지 작성</a>
	</sec:authorize>
<%@ include file="../../footer.jsp" %>
</body>
</html>