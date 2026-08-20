<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Q&A 수정 폼 페이지</title>
<link rel="stylesheet" href="/css/community-form.css">
<script src="/js/communityUpdate.js"></script>
</head>
<body>
<%@ include file="../../header.jsp" %>
	<div class="form-container">
		<h2>Q&A</h2>
		<p class="form-description">상품문의입니다.</p>
		
		<form id="qnaUpdateForm" method="post" action="/cb_communityUpdate" enctype="multipart/form-data" onsubmit="return (insertCheck() && (saveTabState(), true));">
			<input name="m_no" type="hidden" value="${viewCBdao.m_no}">
			<input name="p_no" type="hidden" value="${viewCBdao.p_no}">
			<input name="cb_no" type="hidden" value="${viewCBdao.cb_no}">
			<input type="hidden" name="cb_category" value="Q&A">
			
			<table class="form-table">
				<tr>
					<th>제목</th>
					<td><input type="text" name="cb_subject" value="${viewCBdao.cb_subject}" class="input-text" required></td>
				</tr>
				<tr>
					<td colspan="2"><textarea name="cb_content" class="input-textarea">${viewCBdao.cb_content}</textarea></td>
				</tr>
				<tr>
					<th>UCC URL</th>
					<td><input type="text" name="cb_url" value="${viewCBdao.cb_url}" class="input-text"></td>
				</tr>
			</table>
			
			<div class="btn-group">
				<input type="submit" value="수정" class="btn btn-submit">
				<a href="/guest/community/cb_communityBoard" class="btn btn-cancel">취소</a>
			</div>
		</form>
	</div>
<%@ include file="../../footer.jsp" %>
</body>
</html>