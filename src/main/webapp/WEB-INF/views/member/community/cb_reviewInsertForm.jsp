<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 작성 폼 페이지</title>
<link rel="stylesheet" href="/css/community-form.css">
<script src="/js/communityInsert.js"></script>
</head>
<body>
<%@ include file="../../header.jsp" %>
	<div class="form-container">
		<h2>리뷰</h2>
		<p class="form-description">상품 사용후기입니다.</p>
		
		<form id="reviewInsertForm" method="post" action="/cb_communityInsert" enctype="multipart/form-data" onsubmit="return (insertCheck() && (saveTabState(), true));">
			<input name="m_no" type="hidden" value="${m_no}">
			<input name="p_no" type="hidden" value="${p_no}">
			<input type="hidden" name="cb_category" value="리뷰">
			
			<c:if test="${not empty product}">
				<div class="product-info-box">
					<img src="/images/product/${product.p_img}" alt="${product.p_name}" class="product-img">
					<div class="product-details">
						<p class="product-name">${product.p_name}</p>
						<p class="product-price"><fmt:formatNumber value="${product.p_price}" pattern="#,###"/>원</p>
					</div>
				</div>
			</c:if>
			
			<table class="form-table">
			    <tr>
			        <th>제목</th>
			        <td><input type="text" name="cb_subject" class="input-text" required></td>
			    </tr>
			    <tr>
			        <th>평점</th>
			        <td>
			            <div class="rating-group">
			                <label><input type="radio" name="cb_rating" value="5" checked> ★★★★★</label>
			                <label><input type="radio" name="cb_rating" value="4"> ★★★★</label>
			                <label><input type="radio" name="cb_rating" value="3"> ★★★</label>
			                <label><input type="radio" name="cb_rating" value="2"> ★★</label>
			                <label><input type="radio" name="cb_rating" value="1"> ★</label>
			            </div>
			        </td>
			    </tr>
			    <tr>
			        <td colspan="2"><textarea name="cb_content" class="input-textarea" placeholder="후기를 작성해주세요." required></textarea></td>
			    </tr>
			    <tr>
			        <th>UCC URL</th>
			        <td><input type="text" name="cb_url" class="input-text" placeholder="https://"></td>
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