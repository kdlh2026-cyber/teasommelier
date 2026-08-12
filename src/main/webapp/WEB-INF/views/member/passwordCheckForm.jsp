<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 확인</title>
<link rel="stylesheet" href="/css/checkForm.css">
</head>
<body>
<div class="check-wrapper">
        <div class="check-container">
            <form name="passwordCheckForm" method="post" action="/member/passwordCheck">
                <input type="hidden" name="mode" value="${mode}">
                <p>비밀번호 확인</p>
                <input type="password" name="mpasswd" placeholder="비밀번호를 입력해 주세요.">
                <c:if test="${not empty msg}">
                    <p style="color:red; font-weight:bold; font-size:14px; margin-top:10px; margin-bottom:0;">
                        ${msg}
                    </p>
                </c:if>
                <p class="login">
                    <input type="submit" value="확인"> 
                    <input type="button" value="취소" onclick="history.back();">
                </p>
            </form>
        </div>
    </div>
</body>
</html>