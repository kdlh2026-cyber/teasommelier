<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>브랜드소식 작성 폼 페이지</title>
<link rel="stylesheet" href="/css/community-form.css">
<script src="/js/communityInsert.js"></script>
</head>
<body>
<%@ include file="../../header.jsp" %>
	<div class="form-container">
		<h2>브랜드 소식</h2>
		<p class="form-description">브랜드 소식입니다.</p>
		
		<form id="brandnoticeInsertForm" method="post" action="/cb_communityInsert" enctype="multipart/form-data" onsubmit="return (insertCheck() && (saveTabState(), true));">
			<input name="m_no" type="hidden" value="1">
			<input type="hidden" name="cb_category" value="브랜드소식">
			
			<table class="form-table">
				<tr>
					<th>제목</th>
					<td><input type="text" name="cb_subject" class="input-text" required></td>
				</tr>
				<tr>
					<td colspan="2"><textarea name="cb_content" class="input-textarea" placeholder="내용을 입력하세요."></textarea></td>
				</tr>
				<tr>
					<th>첨부파일1</th>
					<td><input type="file" name="files" class="input-file"></td>
				</tr>
				<tr>
					<th>첨부파일2</th>
					<td><input type="file" name="files" class="input-file"></td>
				</tr>
				<tr>
					<th>첨부파일3</th>
					<td><input type="file" name="files" class="input-file"></td>
				</tr>
				<tr>
					<th>첨부파일4</th>
					<td><input type="file" name="files" class="input-file"></td>
				</tr>
				<tr>
					<th>첨부파일5</th>
					<td><input type="file" name="files" class="input-file"></td>
				</tr>
			</table>
			
			<div class="btn-group">
				<input type="submit" value="등록" class="btn btn-submit">
				<a href="/guest/community/cb_communityBoard" class="btn btn-cancel">취소</a>
			</div>
		</form>
	</div>
<%@ include file="../../footer.jsp" %>
</body>
</html>