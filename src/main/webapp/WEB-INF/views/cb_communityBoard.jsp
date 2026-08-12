<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>커뮤니티 게시판</title>
</head>
<body>
<%@ include file="header.jsp" %>
	<!-- 동작 확인용 임시 페이지 -->
	<h3>커뮤니티 게시판</h3>
	<!-- 비회원 -->
			비회원 부분<br>
			<a href="/guest/cb_brandnoticeList">브랜드 소식</a><br>
			<a href="/guest/cb_editorialList">에디토리얼</a><br>
			<a href="/guest/cb_reviewList">리뷰</a><br>
			<a href="/guest/cb_qnaList">Q&A</a><br>
			<a href="/guest/cb_brandnoticeList">고객센터</a><br>
	<!-- 일반 회원 -->
		<sec:authorize access="hasRole('USER')">
			일반 회원 부분<br>
			<a href="/member/cb_reviewForm">리뷰 게시글 작성</a>
		</sec:authorize>
	<!-- 관리자 -->
		<sec:authorize access="hasRole('ADMIN')">
			관리자 부분<br>
		</sec:authorize>

<%@ include file="footer.jsp" %>
</body>
</html>