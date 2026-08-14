<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Q&A 답변 작성 폼 페이지</title>
</head>
<body>
<%@ include file="../header.jsp" %>
	<h2>Q&A</h2>
	<p>상품문의입니다.</p>
	<form name="qnaResponseInsertForm" method="post" action="/admin/responseInsert">
	<input type="hidden" name="m_no" value="${viewRESdao.m_no}">
	<input type="hidden" name="cb_no" value="${viewRESdao.cb_no}">
	<input type="hidden" name="cb_category" value="${viewRESdao.cb_category}">
		<table>
			<tr>
				<td>제목</td>
				<td><select name="cb_qna_category">
						<option value="상품 문의">상품 문의</option>
						<option value="배송 문의">배송 문의</option>
						<option value="교환/반품 문의">교환/반품 문의</option>
						<option value="기타 문의">기타 문의</option>
						<option value="카카오페이 문의">카카오페이 문의</option>
					</select>
					<input type="text" name="res_subject" value="${viewRESdao.cb_subject}">
				</td>
			</tr>
			<tr>
				<td colspan=2>
					<textarea col="150" row="3" name="res_content" wrap="hard">
[Original Message]
${viewRESdao.cb_content}

					</textarea>
				</td>
			</tr>
		</table>
		<a href="/guest/cb_qnaList">목록</a>
		<input type="submit" value="등록">
		<a href="/guest/cb_qnaList" onclick="return confirm('사이트에서 나가시겠습니까?');">취소</a>
	</form>
<%@ include file="../footer.jsp" %>
</body>
</html>