<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<link rel="stylesheet" href="css/checkForm.css">
</head>
<body>
<%@ include file="header.jsp" %>
<div class="check-wrapper">
	<h2 class="login-title">Login</h2>
	<form name="loginForm" method="post" action="/j_spring_security_check">
	<div class="input-group">
		<input type="text" name="m_id" placeholder="아이디">
		<input type="password" name="m_passwd" placeholder="비밀번호">
	</div>
	<div class="login-utility">
            <label class="remember-id">
                <input type="checkbox" name="rememberId"> 아이디 저장
            </label>
            <div class="find-links">
                <a href="#">아이디찾기</a>
                <span class="divider">|</span>
                <a href="#">비밀번호찾기</a>
            </div>
    </div>
	<div class="button-group">
		<input type="submit" value="로그인">
	</div>
	<div class="sub-buttons">
		<input type="button" value="회원가입" onclick="location.href='guest/MemberWriteForm'">
		<input type="button" value="비회원주문조회">
	</div>
	</form>
</div> 
<%@ include file="footer.jsp" %>
</body>
</html>