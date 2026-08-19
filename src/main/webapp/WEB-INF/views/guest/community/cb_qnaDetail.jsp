<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Q&amp;A 상세 페이지</title>
<link rel="stylesheet" href="/css/cb-detail.css">
</head>
<body>
<%@ include file="../../header.jsp" %>
	<div class="cb-detail-page">
		<c:if test="${not empty product}">
			<div class="product-info-box">
				<a href="/guest/productDetail?p_no=${product.p_no}"><img class="product-info-thumb" src="${product.p_img}" alt="${product.p_name}"></a>
				<div class="product-info-body">
					<a href="/guest/productDetail?p_no=${product.p_no}"><p class="product-info-name">${product.p_name}</p></a>
					<p class="product-info-price">${product.p_price}원</p>
				</div>
			</div>
		</c:if>

		<div class="cb-detail-title-row">
			<h2 class="cb-detail-title">Q&amp;A</h2>
			<span class="cb-detail-subtitle">상품 문의입니다.</span>
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
				<td colspan="2" class="content-cell">${viewCBdao.cb_content}</td>
			</tr>
		</table>

		<c:if test="${not empty responseQnaDto}">
			<div class="qna-answer-box">
				<h3 class="qna-answer-title">답변</h3>
				<table class="cb-detail-table">
					<tr>
						<td class="label-cell">답변 제목</td>
						<td>${responseQnaDto.res_subject}</td>
					</tr>
					<tr>
						<td class="label-cell">답변일</td>
						<td>${fn:substring(responseQnaDto.res_date, 0, 10)}</td>
					</tr>
					<tr>
						<td colspan="2" class="content-cell">${responseQnaDto.res_content}</td>
					</tr>
				</table>
			</div>
		</c:if>
		<sec:authorize access="hasRole('ADMIN')">
			<c:if test="${not empty responseQnaDto}">
				<a class="cb-delete-btn" href="/responseDelete?res_no=${responseQnaDto.res_no}">답변 삭제</a>
			</c:if>
		</sec:authorize>
		<div class="cb-detail-actions">
			<a class="cb-list-btn" href="/guest/community/cb_communityBoard">목록</a>
			<sec:authorize access="hasRole('USER')">
				<a class="cb-edit-btn" href="/member/community/cb_qnaUpdateForm?cb_no=${viewCBdao.cb_no}">수정</a>
				<a class="cb-delete-btn" href="/cb_communityDelete?cb_no=${viewCBdao.cb_no}" onclick="return confirm('정말로 삭제하시겠습니까?');">삭제</a>
			</sec:authorize>
			<sec:authorize access="hasRole('ADMIN')">
			    <%-- 답변이 등록되지 않은 경우에만 '답변' 버튼 표시 --%>
			    <c:if test="${empty responseQnaDto}">
			        <a class="cb-answer-btn" href="/admin/community/cb_qnaResponseInsertForm?cb_no=${viewCBdao.cb_no}">답변</a>
			    </c:if>
			    <a class="cb-edit-btn" href="/member/community/cb_qnaUpdateForm?cb_no=${viewCBdao.cb_no}">수정</a>
			    <a class="cb-delete-btn" href="/cb_communityDelete?cb_no=${viewCBdao.cb_no}" onclick="return confirm('정말로 삭제하시겠습니까?');">삭제</a>
			</sec:authorize>
		</div>
	</div>
<%@ include file="../../footer.jsp" %>
</body>
</html>