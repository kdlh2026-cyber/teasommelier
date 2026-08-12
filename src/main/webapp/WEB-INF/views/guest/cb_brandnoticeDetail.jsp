<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>브랜드 소식 게시글 상세 페이지</title>
</head>
<body>
	<h2>브랜드 소식</h2>
	<p>브랜드 소식입니다.</p>
	<table border="1">
		<tr>
			<td>제목</td>
			<td>${brandnoticeDetail.cb_subject}</td>
		</tr>
		<tr>
			<td>작성자</td>
			<td>${brandnoticeDetail.m_id}</td>
		</tr>
		<tr>
			<td>작성일</td>
			<td>${brandnoticeDetail.cb_date}</td>
		</tr>
		<tr>
			<td>조회수</td>
			<td>${brandnoticeDetail.cb_view_count}</td>
		</tr>
		<tr>
			<td colspan=2>${brandnoticeDetail.cb_content}</td>
		</tr>
	</table>
	<sec:authorize access="hasRole('ADMIN')">
		<a href="/cb_brandnoticeUpdateForm">수정</a>
		<a href="/cb_brandnoticeDelete">삭제</a>
	</sec:authorize>
</body>
</html>