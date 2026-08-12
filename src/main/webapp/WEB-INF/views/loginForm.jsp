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
	<div class="check-container">
	<form name="loginForm" method="post" action="/j_spring_security_check">
	<p class="m_id">아이디 : <input type="text" name="m_id"></p>
	<p class="m_passwd">비밀번호 : <input type="password" name="m_passwd"></p>
	<p class="login"><input type="submit" value="로그인"> <input type="button" value="취소" onclick="history.back();"></p>
	</form>
	</div>
</div> 
<%@ include file="footer.jsp" %>
</body>
</html>