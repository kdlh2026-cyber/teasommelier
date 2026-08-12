<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>


<div>
	<div>
		<a href="/main"><img src="" alt="이미지 로고"></a>
	</div>
	<div class="login">
	<!--비회원-->
	<sec:authorize access="isAnonymous()">	
		<%@ include file="menu.jsp" %>
		<a href="/loginForm">로그인</a> 
		<a href="/guest/MemberWriteForm">회원가입</a> 
		<a href="/guest/">고객센터</a>
	</sec:authorize>
	<!--일반회원-->
	<sec:authorize access="hasRole('USER')">
		<%@ include file="menu.jsp" %>
		<div class="member-menu">
		<a href="/logout">로그아웃</a>
		<a href="/member/passwordCheckForm?mode=update">정보수정</a>
		<a href="/guest/">고객센터</a>
		</div>
	</sec:authorize>
	<!--관리자-->
	<sec:authorize access="hasRole('ADMIN')">
		<%@ include file="menu.jsp" %>
		<span class="member-welcome"><sec:authentication property="principal.username"/>님 환영합니다.</span>
		<div class="member-menu">
		<a href="/admin/EarphoneWriteForm">상품등록</a>
		<a href="/admin/MemberList">회원목록</a>
		<a href="/logout">로그아웃</a>
		</div>
	</sec:authorize>
	</div>
</div>