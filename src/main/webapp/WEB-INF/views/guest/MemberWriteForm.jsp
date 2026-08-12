<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>

</head>
<body>
<%@ include file="../header.jsp" %>
<div>
    <div>
	<form name="member" method="post" action="/MemberWrite">
		<div>
			<label>아이디</label> 
			<input type="text"  name="m_id" placeholder="아이디를 입력하세요">
		</div>
		<div>
			<label>비밀번호</label> 
			<input type="text"  name="m_passwd" placeholder="">
		</div>
		<div>
			<label>비밀번호 확인</label> 
			<input type="text"  name="chk_passwd" placeholder="">
		</div>
		<div>
			<label>이름</label> 
			<input type="text"  name="m_name" placeholder="">
		</div>
		<div>
			<label>휴대폰번호</label> 
			<input type="text"  name="m_phone" placeholder="">
		</div>
		<div>
			<label>이메일</label> 
			<input type="text"  name="m_email" placeholder="">
		</div>
		<div>
			<input type="submit" value="회원가입" onclick="return membercheck();"> 
			<input type="button" value="취소" onclick="history.back()">
		</div>
		</form>
	</div>
</div>
<%@ include file="../footer.jsp" %>
</body>
</html>