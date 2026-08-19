<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>브랜드 소식 게시글 상세 페이지</title>
<link rel="stylesheet" href="/css/cb-detail.css">
</head>
<body>
<%@ include file="../../header.jsp" %>
	<div class="cb-detail-page">
		<div class="cb-detail-title-row">
			<h2 class="cb-detail-title">브랜드 소식</h2>
			<span class="cb-detail-subtitle">브랜드 소식입니다.</span>
		</div>

		<table class="cb-detail-table">
			<tr>
				<td class="label-cell">제목</td>
				<td>${viewCBdao.cb_subject}</td>
			</tr>
			<tr>
				<td class="label-cell">작성자</td>
				<td>${viewCBdao.m_id}</td>
			</tr>
			<tr>
				<td class="label-cell">작성일</td>
				<td>${fn:substring(viewCBdao.cb_date, 0, 10)}</td>
			</tr>
			<tr>
				<td class="label-cell">조회수</td>
				<td>${viewCBdao.cb_view_count}</td>
			</tr>
			<tr>
				<td colspan="2" class="content-cell">
					<!-- 내용 출력 -->
					<div class="content-area">
					    ${viewCBdao.cb_content}
					</div>
					
					<!-- 이미지 파일 출력 -->
					<c:if test="${not empty viewCBdao.cb_file}">
					    <div class="image-attachment-area" style="margin-top: 20px;">
					        <c:forEach var="fileName" items="${fn:split(viewCBdao.cb_file, ',')}">
					            <c:if test="${not empty fn:trim(fileName)}">
					                <img src="/images/community/${fn:trim(fileName)}" alt="첨부이미지" style="max-width: 100%; display: block; margin-bottom: 10px;">
					            </c:if>
					        </c:forEach>
					    </div>
					</c:if>
				</td>
			</tr>
		</table>

		<div class="cb-detail-actions">
			<a class="cb-list-btn" href="/guest/community/cb_communityBoard">목록</a>
			<sec:authorize access="hasRole('ADMIN')">
				<a class="cb-edit-btn" href="/admin/community/cb_brandnoticeUpdateForm?cb_no=${viewCBdao.cb_no}">수정</a>
				<a class="cb-delete-btn" href="/cb_communityDelete?cb_no=${viewCBdao.cb_no}" onclick="return confirm('정말로 삭제하시겠습니까?');">삭제</a>
			</sec:authorize>
		</div>
	</div>
<%@ include file="../../footer.jsp" %>
</body>
</html>