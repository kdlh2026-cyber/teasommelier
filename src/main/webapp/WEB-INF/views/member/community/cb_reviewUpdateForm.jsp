<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 수정 폼 페이지</title>
<link rel="stylesheet" href="/css/community-form.css">
<script src="/js/communityUpdate.js"></script>
</head>
<body>
<%@ include file="../../header.jsp" %>
	<div class="form-container">
		<h2>리뷰</h2>
		<p class="form-description">상품 사용후기입니다.</p>
		
		<form id="reviewUpdateForm" method="post" action="/cb_communityUpdate" enctype="multipart/form-data" onsubmit="return (insertCheck() && (saveTabState(), true));">
			<input name="m_no" type="hidden" value="${viewCBdao.m_no}">
			<input name="p_no" type="hidden" value="${viewCBdao.p_no}">
			<input name="cb_no" type="hidden" value="${viewCBdao.cb_no}">
			<input type="hidden" name="cb_category" value="리뷰">
			<!-- 기존 첨부파일 목록 전달 (DB에 저장되어 있던 cb_file 값) -->
			<input type="hidden" name="existingFiles" value="${viewCBdao.cb_file}">
			
			<table class="form-table">
				<tr>
					<th>제목</th>
					<td><input type="text" name="cb_subject" value="${viewCBdao.cb_subject}" class="input-text" required></td>
				</tr>
				<tr>
					<th>평점</th>
					<td>
						<div class="rating-group">
							<label><input type="radio" name="cb_rating" value="5" ${viewCBdao.cb_rating == 5 ? 'checked' : ''}> ★★★★★</label>
							<label><input type="radio" name="cb_rating" value="4" ${viewCBdao.cb_rating == 4 ? 'checked' : ''}> ★★★★</label>
							<label><input type="radio" name="cb_rating" value="3" ${viewCBdao.cb_rating == 3 ? 'checked' : ''}> ★★★</label>
							<label><input type="radio" name="cb_rating" value="2" ${viewCBdao.cb_rating == 2 ? 'checked' : ''}> ★★</label>
							<label><input type="radio" name="cb_rating" value="1" ${viewCBdao.cb_rating == 1 ? 'checked' : ''}> ★</label>
						</div>
					</td>
				</tr>
				<tr>
					<td colspan="2"><textarea name="cb_content" class="input-textarea">${viewCBdao.cb_content}</textarea></td>
				</tr>
				<tr>
					<th>UCC URL</th>
					<td><input type="text" name="cb_url" value="${viewCBdao.cb_url}" class="input-text"></td>
				</tr>
				<tr>
			        <th>첨부파일</th>
			        <td>
			            <c:if test="${not empty viewCBdao.cb_file}">
			                <div style="margin-bottom: 10px; font-size: 13px; color: #555;">
			                    <strong>현재 등록된 파일:</strong> ${viewCBdao.cb_file}
			                </div>
			            </c:if>
			            <div style="display: flex; flex-direction: column; gap: 6px;">
			                <input type="file" name="files" class="input-file">
			                <input type="file" name="files" class="input-file">
			                <input type="file" name="files" class="input-file">
			                <input type="file" name="files" class="input-file">
			                <input type="file" name="files" class="input-file">
			            </div>
			            <small style="color: #888;">* 새 파일을 첨부하지 않으면 기존 파일이 그대로 유지됩니다.</small>
			        </td>
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