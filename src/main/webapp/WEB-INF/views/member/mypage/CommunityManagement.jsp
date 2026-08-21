<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TeaSommelier</title>
<link rel="stylesheet" href="/css/community-list.css">
</head>
<body>
<%@ include file="/WEB-INF/views/header.jsp" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<div>
	<div>
		<%@ include file ="Mymenu.jsp" %>
	</div>
	<div class="addr-container">

		<div class="addr-header">
			<h3>내가 쓴 게시물</h3>
			<p>총 ${fn:length(myList)}건</p>
		</div>

		<c:choose>
			<c:when test="${empty myList}">
				<table class="addr-table">
					<tr>
						<th>번호</th>
						<th>카테고리</th>
						<th>제목</th>
						<th>작성일</th>
						<th>조회</th>
					</tr>
					<tr>
						<td colspan="5">작성한 게시물이 없습니다.</td>
					</tr>
				</table>
			</c:when>
			<c:otherwise>
				<table class="addr-table">
					<tr>
						<th>번호</th>
						<th>카테고리</th>
						<th>제목</th>
						<th>작성일</th>
						<th>조회</th>
					</tr>
					<c:forEach var="MYL" items="${myList}">
						<tr>
							<td>${MYL.cb_no}</td>
							<td>${MYL.cb_category}</td>
							<td class="td-info">
								<c:choose>
									<c:when test="${MYL.cb_category == '리뷰'}">
										<a href="/guest/community/cb_reviewDetail?cb_no=${MYL.cb_no}">${MYL.cb_subject}</a>
									</c:when>
									<c:when test="${MYL.cb_category == 'Q&A'}">
										<a href="/guest/community/cb_qnaDetail?cb_no=${MYL.cb_no}">${MYL.cb_subject}</a>
									</c:when>
									<c:otherwise>
										${MYL.cb_subject}
									</c:otherwise>
								</c:choose>
							</td>
							<td>${fn:substring(MYL.cb_date, 0, 10)}</td>
							<td>${MYL.cb_view_count}</td>
						</tr>
					</c:forEach>
				</table>
			</c:otherwise>
		</c:choose>

		<div class="addr-actions">
			<div class="action-group"></div>
			<a href="/guest/community/cb_communityBoard" class="btn-cart-link">전체 게시판 보기</a>
		</div>

	</div>
</div>
<%@ include file="/WEB-INF/views/footer.jsp" %>
</body>
</html>