<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<link rel="stylesheet" href="/css/cb.css">
	<div class="cb-page">
		<div class="cb-title-row">
			<h2 class="cb-title">에디토리얼</h2>
			<span class="cb-subtitle">에디토리얼입니다.</span>
		</div>

		<table class="cb-table">
			<tr>
				<th class="col-no">번호</th>
				<th class="col-subject">제목</th>
				<th class="col-writer">작성자</th>
				<th class="col-date">작성일</th>
				<th class="col-view">조회</th>
			</tr>
		<c:forEach var="EDL" items="${editorialList}">
			<tr>
				<td class="col-no">${EDL.cb_no}</td>
				<td class="col-subject">
					<a class="cb-subject-link" href="/guest/community/cb_editorialDetail?cb_no=${EDL.cb_no}">${EDL.cb_subject}</a>
				</td>
				<td class="col-writer">${EDL.m_id}</td>
				<td class="col-date">${fn:substring(EDL.cb_date, 0, 10)}</td>
				<td class="col-view">${EDL.cb_view_count}</td>
			</tr>
		</c:forEach>
		</table>

		<sec:authorize access="hasRole('ADMIN')">
			<a class="cb-write-btn" href="/admin/community/cb_editorialInsertForm">새 에디토리얼 작성</a>
		</sec:authorize>
	</div>