<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 작성 폼 페이지</title>
</head>
<body>
<%@ include file="../../header.jsp" %>
	<h2>리뷰</h2>
	<p>상품 사용후기입니다.</p>
	<form id="reviewInsertForm" method="post" action="/cb_communityInsert" enctype="multipart/form-data">
		<input name="m_no" type="hidden" value="${m_no}">
		<input name="p_no" type="hidden" value="${p_no}">
		<input type="hidden" name="cb_category" value="리뷰">
		<!-- 상품창에서 넘어갈 때 자동으로 p_no를 불러오는 방식으로 작성했습니다. -->
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
				<td><input type="text" name="cb_subject"></td>
			</tr>
			<tr>
				<td>평점</td>
				<td>
					<input type="radio" name="cb_rating" value="5">★★★★★
					<input type="radio" name="cb_rating" value="4">★★★★
					<input type="radio" name="cb_rating" value="3">★★★
					<input type="radio" name="cb_rating" value="2">★★
					<input type="radio" name="cb_rating" value="1">★
				</td>
			</tr>
			<tr>
				<td colspan=2><textarea name="cb_content"></textarea></td>
			</tr>
			<tr>
				<td>UCCURL</td>
				<td><input type="text" name="cb_url"></td>
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
		<a href="/guest/community/cb_reviewList">취소</a>
	</form>
<%@ include file="../../footer.jsp" %>
</body>
</html>