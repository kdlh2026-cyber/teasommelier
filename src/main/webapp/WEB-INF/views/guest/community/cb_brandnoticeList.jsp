<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<link rel="stylesheet" href="/css/cb.css">
	<div class="cb-page">
		<div class="cb-title-row">
			<h2 class="cb-title">브랜드 소식</h2>
			<span class="cb-subtitle">브랜드 소식입니다.</span>
		</div>

		<table class="cb-table">
			<tr>
				<th class="col-no">번호</th>
				<th class="col-subject">제목</th>
				<th class="col-writer">작성자</th>
				<th class="col-date">작성일</th>
				<th class="col-view">조회</th>
			</tr>
		<c:forEach var="BNL" items="${brandnoticeList}">
			<tr>
				<td class="col-no">${BNL.cb_no}</td>
				<td class="col-subject">
					<a class="cb-subject-link" href="/guest/community/cb_brandnoticeDetail?cb_no=${BNL.cb_no}">${BNL.cb_subject}</a>
				</td>
				<td class="col-writer">${BNL.m_id}</td>
				<td class="col-date">${fn:substring(BNL.cb_date, 0, 10)}</td>
				<td class="col-view">${BNL.cb_view_count}</td>
			</tr>
		</c:forEach>
		</table>

		<sec:authorize access="hasRole('ADMIN')">
			<a class="cb-write-btn" href="/admin/community/cb_brandnoticeInsertForm">새 공지 작성</a>
		</sec:authorize>
	</div>