<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Q&A 작성 폼 페이지</title>
</head>
<body>
<%@ include file="../../header.jsp" %>
	<h2>Q&A</h2>
	<p>상품문의입니다.</p>
	<form id="qnaInsertForm" method="post" action="/cb_communityInsert" enctype="multipart/form-data">
		<input name="m_no" type="hidden" value="${m_no}">
		<input name="p_no" type="hidden" value="${p_no}">
		<input type="hidden" name="cb_category" value="Q&A">
		<!-- 상품창에서 상품 문의로 직접 넘어갈 때 자동으로 p_no를 불러오는 방식으로 작성했습니다. -->
		<div>
			<c:if test="${not empty product}">
				<img src="${product.p_img}" alt="${product.p_name}" width="75" height="75">
				<p>${product.p_name}</p>
				<p><fmt:formatNumber value="${product.p_price}" pattern="#,###"/>원</p>
			</c:if>
		</div>
		<table border="1">
			<tr>
				<td>제목</td>
				<td>
					<select name="cb_qna_category">
						<option value="상품 문의">상품 문의</option>
						<option value="배송 문의">배송 문의</option>
						<option value="교환/반품 문의">교환/반품 문의</option>
						<option value="기타 문의">기타 문의</option>
						<option value="카카오페이 문의">카카오페이 문의</option>
					</select>
				<input type="text" name="cb_subject"></td>
			</tr>
			</tr>
			<tr>
				<td colspan=2><textarea name="cb_content" rows="3" cols="50" wrap="hard"></textarea></td>
			</tr>
			<tr>
				<td>UCCURL</td>
				<td><input type="text" name="cb_url"></td>
			</tr>
		</table>
		<input type="submit" value="등록">
		<a href="/guest/community/cb_qnaList">취소</a>
	</form>
<%@ include file="../../footer.jsp" %>
</body>
</html>