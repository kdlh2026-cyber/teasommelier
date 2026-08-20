<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<link rel="stylesheet" href="/css/qna.css">
	<div class="qna-page">
		<div class="qna-title-row">
			<h2 class="qna-title">Q&amp;A</h2>
			<span class="qna-subtitle">상품 문의입니다.</span>
		</div>

		<table class="qna-table">
			<tr>
				<th class="col-no">번호</th>
				<th class="col-product">상품</th>
				<th class="col-category">카테고리</th>
				<th class="col-subject">제목</th>
				<th class="col-writer">작성자</th>
				<th class="col-date">작성일</th>
				<th class="col-view">조회</th>
			</tr>
		<c:forEach var="QAL" items="${qnaList}">
			<tr>
				<td class="col-no">${QAL.cb_no}</td>
				<td class="col-product">
					<c:set var="pNoKey" value="${QAL.p_no}" />
					<c:set var="pd" value="${productMap[pNoKey]}" />
					<c:if test="${not empty pd}">
						<a href="/guest/productDetail?p_no=${QAL.p_no}">
							<img class="qna-thumb" src="/images/product/${pd.p_img}" width="60" height="60" alt="${pd.p_name}">
						</a>
					</c:if>
				</td>
				<td class="col-category">
					<span class="qna-category-badge">${QAL.cb_qna_category}</span>
				</td>
				<td class="col-subject">
					<a class="qna-subject-link" href="/guest/community/cb_qnaDetail?cb_no=${QAL.cb_no}">${QAL.cb_subject}</a>
				</td>
				<td class="col-writer">${QAL.m_id}</td>
				<td class="col-date">${fn:substring(QAL.cb_date, 0, 10)}</td>
				<td class="col-view">${QAL.cb_view_count}</td>
			</tr>
		</c:forEach>
		</table>

		<sec:authorize access="hasRole('USER')">
			<a class="qna-write-btn" href="/member/community/cb_qnaInsertForm">새 문의 작성</a>
		</sec:authorize>
	</div>