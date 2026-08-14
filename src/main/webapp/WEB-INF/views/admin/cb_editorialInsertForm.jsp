<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>에디토리얼 작성 폼 페이지</title>
</head>
<body>
<%@ include file="../header.jsp" %>
	<h2>에디토리얼</h2>
	<p>에디토리얼입니다.</p>
	<form id="editorialInsertForm" method="post" action="/member/cb_communityInsert" enctype="multipart/form-data">
		<input name="m_no" type="hidden" value=1>
		<input type="hidden" name="cb_category" value="에디토리얼">
			<table border="1">
			<tr>
				<td>제목</td>
				<td><input type="text" name="cb_subject"></td>
			</tr>
			<tr>
				<td colspan=2><textarea name="cb_content"></textarea></td>
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
		<a href="/guest/cb_editorialList">취소</a>
	</form>
<%@ include file="../footer.jsp" %>
</body>
</html>