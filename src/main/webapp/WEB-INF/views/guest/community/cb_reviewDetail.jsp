<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 상세 페이지</title>
<link rel="stylesheet" href="/css/cb-detail.css">
</head>
<body>
<%@ include file="../../header.jsp" %>
	<div class="cb-detail-page">
		<c:if test="${not empty product}">
			<div class="product-info-box">
				<a href="/guest/productDetail?p_no=${product.p_no}"><img class="product-info-thumb" src="/images/product/${product.p_img}" alt="${product.p_name}"></a>
				<div class="product-info-body">
					<a href="/guest/productDetail?p_no=${product.p_no}"><p class="product-info-name">${product.p_name}</p></a>
					<p class="product-info-price"><fmt:formatNumber value="${product.p_price}" pattern="#,###"/>원</p>
				</div>
			</div>
		</c:if>

		<div class="cb-detail-title-row">
			<h2 class="cb-detail-title">리뷰</h2>
			<span class="cb-detail-subtitle">상품 사용후기입니다.</span>
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
				<td class="label-cell">평점</td>
				<td>
					<span class="review-stars">
						<c:forEach begin="1" end="5" var="i">
							<c:choose>
								<c:when test="${i <= viewCBdao.cb_rating}">★</c:when>
								<c:otherwise>☆</c:otherwise>
							</c:choose>
						</c:forEach>
					</span>
				</td>
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
					${viewCBdao.cb_content}
					<c:if test="${not empty viewCBdao.cb_file}">
						<div class="review-attachments">
							<c:forEach var="file" items="${fn:split(viewCBdao.cb_file, ',')}">
								<img src="/images/community/${file}" alt="첨부이미지">
							</c:forEach>
						</div>
					</c:if>
				</td>
			</tr>
		</table>

		<div class="cb-detail-actions">
			<a class="cb-list-btn" href="/guest/community/cb_communityBoard">목록</a>
			<sec:authorize access="hasRole('USER')">
				<a class="cb-edit-btn" href="/member/community/cb_reviewUpdateForm?cb_no=${viewCBdao.cb_no}">수정</a>
				<a class="cb-delete-btn" href="/cb_communityDelete?cb_no=${viewCBdao.cb_no}" onclick="return confirm('정말로 삭제하시겠습니까?');">삭제</a>
			</sec:authorize>
			<sec:authorize access="hasRole('ADMIN')">
				<a class="cb-edit-btn" href="/member/community/cb_reviewUpdateForm?cb_no=${viewCBdao.cb_no}">수정</a>
				<a class="cb-delete-btn" href="/cb_communityDelete?cb_no=${viewCBdao.cb_no}" onclick="return confirm('정말로 삭제하시겠습니까?');">삭제</a>
			</sec:authorize>
		</div>
	</div>
<%@ include file="../../footer.jsp" %>
</body>
</html>