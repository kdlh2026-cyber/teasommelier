<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>에디토리얼 상세 페이지</title>
</head>
<body>
<%@ include file="../../header.jsp" %>
	<h2>에디토리얼</h2>
	<p>에디토리얼입니다.</p>
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
				<td>작성일</td>
				<td>${fn:substring(viewCBdao.cb_date, 0, 10)}</td>
			</tr>
			<tr>
				<td>조회수</td>
				<td>${viewCBdao.cb_view_count}</td>
			</tr>
			<tr>
				<td colspan=2>${viewCBdao.cb_content}</td>
			</tr>
		</table>
		<a href="/guest/community/cb_editorialList">목록</a>
	<sec:authorize access="hasRole('ADMIN')">
		<a href="/admin/community/cb_editorialUpdateForm?cb_no=${viewCBdao.cb_no}">수정</a>
		<a href="/cb_communityDelete?cb_no=${viewCBdao.cb_no}" onclick="return confirm('정말로 삭제하시겠습니까?');">삭제</a>
	</sec:authorize>
	</form>
<%@ include file="../../footer.jsp" %>
</body>
</html>