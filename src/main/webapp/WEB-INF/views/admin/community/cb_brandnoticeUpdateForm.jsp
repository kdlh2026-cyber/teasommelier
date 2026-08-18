<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>브랜 드소식 수정 폼 페이지</title>
</head>
<body>
<%@ include file="../../header.jsp" %>
	<h2>브랜드 소식</h2>
	<p>브랜드 소식입니다.</p>
	<form id="brandnoticeUpdateForm" method="post" action="/cb_communityUpdate" enctype="multipart/form-data">
		<input name="m_no" type="hidden" value="${viewCBdao.m_no}">
		<input type="hidden" name="cb_no" value="${viewCBdao.cb_no}">
		<input type="hidden" name="cb_category" value="브랜드소식">
			<table border="1">
			<tr>
				<td>제목</td>
				<td><input type="text" name="cb_subject" value="${viewCBdao.cb_subject}"></td>
			</tr>
			<tr>
				<td colspan=2><textarea name="cb_content">${viewCBdao.cb_content}</textarea></td>
			</tr>
			<tr>
				<td>첨부파일1</td>
				<td><input type="file" name="files"></td>
			</tr>
			<tr>
				<td>첨부파일2</td>
				<td><input type="file" name="files"></td>
			</tr>
			<tr>
				<td>첨부파일3</td>
				<td><input type="file" name="files"></td>
			</tr>
			<tr>
				<td>첨부파일4</td>
				<td><input type="file" name="files"></td>
			</tr>
			<tr>
				<td>첨부파일5</td>
				<td><input type="file" name="files"></td>
			</tr>
		</table>
		<input type="submit" value="등록">
		<a href="/guest/community/cb_brandnoticeList">취소</a>
	</form>
<%@ include file="../../footer.jsp" %>
</body>
</html> 