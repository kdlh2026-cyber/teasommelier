<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Q&A 작성 폼 페이지</title>
<link rel="stylesheet" href="/css/community-form.css">
<script src="/js/communityInsert.js"></script>
</head>
<body>
<%@ include file="../../header.jsp" %>
	<div class="form-container">
		<h2>Q&A</h2>
		<p class="form-description">상품문의입니다.</p>
		
		<form id="qnaInsertForm" method="post" action="/cb_communityInsert" enctype="multipart/form-data" onsubmit="saveTabState()">
			<input name="m_no" type="hidden" value="${m_no}">
			<input name="p_no" type="hidden" value="${p_no}">
			<input type="hidden" name="cb_category" value="Q&A">
			
			<c:if test="${not empty product}">
				<div class="product-info-box">
					<img src="${product.p_img}" alt="${product.p_name}" class="product-img">
					<div class="product-details">
						<p class="product-name">${product.p_name}</p>
						<p class="product-price"><fmt:formatNumber value="${product.p_price}" pattern="#,###"/>원</p>
					</div>
				</div>
			</c:if>
			
			<table class="form-table">
				<tr>
					<th>제목</th>
					<td>
						<div class="select-input-inline">
							<select name="cb_qna_category" class="input-select">
								<option value="상품 문의">상품 문의</option>
								<option value="배송 문의">배송 문의</option>
								<option value="교환/반품 문의">교환/반품 문의</option>
								<option value="기타 문의">기타 문의</option>
								<option value="카카오페이 문의">카카오페이 문의</option>
							</select>
							<input type="text" name="cb_subject" class="input-text" required>
						</div>
					</td>
				</tr>
				<tr>
					<td colspan="2"><textarea name="cb_content" class="input-textarea" placeholder="문의내용을 입력해주세요."></textarea></td>
				</tr>
				<tr>
					<th>UCC URL</th>
					<td><input type="text" name="cb_url" class="input-text" placeholder="https://"></td>
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