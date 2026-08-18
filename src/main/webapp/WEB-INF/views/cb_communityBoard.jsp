<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>커뮤니티 게시판</title>
<style>
	@charset "UTF-8";

/* =========================
   페이지 컨테이너
========================= */

.community-board {
    max-width: 1200px;
    margin: 0 auto;
    padding: 24px 16px 40px;
}

.board-title {
    font-size: 17px;
    font-weight: 700;
    color: #222;
    margin-bottom: 16px;
}


/* =========================
   메뉴 카드 목록
========================= */

.board-menu {
    display: flex;
    gap: 12px;
    flex-wrap: wrap;
    padding: 10px 0;
    border-top: 1px solid #eee;
    border-bottom: 1px solid #eee;
}

.board-menu-item {
    flex: 1 1 140px;
    text-align: center;
    padding: 14px 10px;
    font-size: 13px;
    color: #666;
    text-decoration: none;
    border: 1px solid #ddd;
    border-radius: 12px;
    transition: background 0.2s ease, color 0.2s ease, border-color 0.2s ease;
}

.board-menu-item:hover {
    background: #000;
    color: #fff;
    border-color: #000;
}


/* =========================
   회원 등급별 안내 문구
========================= */

.board-role-label {
    margin-top: 20px;
    font-size: 13px;
    color: #999;
}
</style>
</head>
<body>
<%@ include file="header.jsp" %>
	<div class="community-board">
		<h3 class="board-title">커뮤니티 게시판</h3>

		<!-- 비회원 -->
		<div class="board-menu">
			<a class="board-menu-item" href="/guest/community/cb_brandnoticeList">브랜드 소식</a>
			<a class="board-menu-item" href="/guest/community/cb_editorialList">에디토리얼</a>
			<a class="board-menu-item" href="/guest/community/cb_reviewList">리뷰</a>
			<a class="board-menu-item" href="/guest/community/cb_qnaList">Q&A</a>
			<a class="board-menu-item" href="/guest/cs/cs_customerServiceList">고객센터</a>
		</div>

		<!-- 일반 회원 -->
		<sec:authorize access="hasRole('USER')">
			<p class="board-role-label">일반 회원 부분</p>
		</sec:authorize>

		<!-- 관리자 -->
		<sec:authorize access="hasRole('ADMIN')">
			<p class="board-role-label">관리자 부분</p>
		</sec:authorize>
	</div>
<%@ include file="footer.jsp" %>
</body>
</html>