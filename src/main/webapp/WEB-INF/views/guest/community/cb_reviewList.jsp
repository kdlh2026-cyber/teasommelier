<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<link rel="stylesheet" href="/css/review.css">
	<div class="review-page">
		<div class="review-title-row">
			<h2 class="review-title">리뷰</h2>
			<span class="review-subtitle">상품 사용후기입니다.</span>
		</div>

		<table class="review-table">
			<tr>
				<th class="col-no">번호</th>
				<th class="col-product">상품</th>
				<th class="col-subject">제목</th>
				<th class="col-writer">작성자</th>
				<th class="col-date">작성일</th>
				<th class="col-view">조회</th>
				<th class="col-rating">평점</th>
			</tr>
		<c:forEach var="RVL" items="${reviewList}">
			<tr>
				<td class="col-no">${RVL.cb_no}</td>
				<td class="col-product">
				    <c:set var="pNoKey" value="${RVL.p_no}" />
				    <c:set var="pd" value="${productMap[pNoKey]}" />
				    <c:if test="${not empty pd}">
				        <a href="/guest/productDetail?p_no=${RVL.p_no}">
				            <img class="review-thumb" src="${pd.p_img}" width="60" height="60" alt="${pd.p_name}">
				        </a>
				    </c:if>
				</td>
				<td class="col-subject">
					<a class="review-subject-link" href="/guest/community/cb_reviewDetail?cb_no=${RVL.cb_no}">${RVL.cb_subject}</a>
				</td>
				<td class="col-writer">${RVL.m_id}</td>
				<td class="col-date">${fn:substring(RVL.cb_date, 0, 10)}</td>
				<td class="col-view">${RVL.cb_view_count}</td>
				<td class="col-rating">
					<span class="review-stars">
						<c:forEach begin="1" end="5" var="i">
							<c:choose>
								<c:when test="${i <= RVL.cb_rating}">★</c:when>
								<c:otherwise>☆</c:otherwise>
							</c:choose>
						</c:forEach>
					</span>
				</td>
			</tr>
		</c:forEach>
		</table>

		<sec:authorize access="hasRole('ADMIN')">
			<a class="review-write-btn" href="/member/community/cb_reviewInsertForm">리뷰 게시글 작성</a>
		</sec:authorize>
	</div>