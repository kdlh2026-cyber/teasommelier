<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Q&A 수정 폼 페이지</title>
</head>
<body>
	<h2>Q&A</h2>
	<p>상품문의입니다.</p>
	<form id="qnaUpdateForm" method="post" action="/member/cb_communityUpdate" enctype="multipart/form-data">
		<input name="m_no" type="hidden" value="${viewCBdao.m_no}">
		<input name="p_no" type="hidden" value="${viewCBdao.p_no}">
		<input name="cb_no" type="hidden" value="${viewCBdao.cb_no}">
		<input type="hidden" name="cb_category" value="Q&A">
		<table border="1">
			<tr>
				<td>제목</td>
				<td><input type="text" name="cb_subject" value="${viewCBdao.cb_subject}"></td>
			</tr>
			</tr>
			<tr>
				<td colspan=2><textarea name="cb_content">${viewCBdao.cb_content}</textarea></td>
			</tr>
			<tr>
				<td>UCCURL</td>
				<td><input type="text" name="cb_url" value="${viewCBdao.cb_url}"></td>
			</tr>
		</table>
		<input type="submit" value="등록">
		<a href="/guest/cb_qnaList">취소</a>
	</form>
</body>
</html>