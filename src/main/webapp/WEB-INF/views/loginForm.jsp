<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<link rel="stylesheet" href="css/checkForm.css">
<script>
// 기존 비회원 주문조회 함수
function guestForm(){
	var formDisplay = document.querySelector(".guestOrderSearch");
	
	if(formDisplay.style.display === "none"){
		formDisplay.style.display = "block";
	}else{
		formDisplay.style.display = "none";
	}
}

document.addEventListener("DOMContentLoaded", function() {
    // 요소 선택
    var idInput = document.querySelector('input[name="m_id"]');
    var rememberChk = document.querySelector('input[name="rememberId"]');
    var loginForm = document.loginForm;

    // 1. 페이지 로딩 시, 저장된 아이디가 있으면 불러오기
    var savedId = localStorage.getItem("savedId");
    if (savedId) {
        idInput.value = savedId;        // 입력창에 아이디 채우기
        rememberChk.checked = true;     // 체크박스 체크 상태로 유지
    }
    
    // 2. 로그인 폼이 제출될 때(submit), 체크박스 상태에 따라 저장/삭제 처리
    loginForm.addEventListener("submit", function() {
        if (rememberChk.checked) {
            // 체크되어 있으면 로컬 스토리지에 아이디 저장
            localStorage.setItem("savedId", idInput.value);
        } else {
            // 체크 해제되어 있으면 로컬 스토리지에서 아이디 삭제
            localStorage.removeItem("savedId");
        }
    });
});
</script>
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
    </div>
   <div class="button-group">
      <input type="submit" value="로그인">
   </div>
   <div class="sub-buttons">
      <input type="button" value="회원가입" onclick="location.href='guest/MemberWriteForm'">
      <button type="button" class="btn" onclick="guestForm()">비회원 주문조회</button>
   </div>
   </form>

   <div class="guestOrderSearch" style="display: none;">
		<h3 class="order-title">ORDER</h3>
		<p class="order-desc">비회원의 경우, 주문시의 주문번호로 주문조회가 가능합니다.</p>
		<form method="post" action="/guestOrderConfirm" onsubmit="return checkGuestOrder()">
			<div class="input-group">
				<input type="text" name="o_name" id="searchName" placeholder="주문자명">
				<input type="text" name="o_no" id="searchNo" placeholder="주문번호">
				<input type="password" name="o_passwd" id="searchPasswd" placeholder="비회원주문 비밀번호">
			</div>
			<div class="button-group">
				<input type="submit" value="비회원 주문조회">
			</div>
		</form>	
	</div>
</div>
<%@ include file="footer.jsp" %>
</body>
<script>
function guestForm(){
	var formDisplay = document.querySelector(".guestOrderSearch");
	
	if(formDisplay.style.display === "none"){
		formDisplay.style.display = "block";
	}else{
		formDisplay.style.display = "none";
	}
}

function checkGuestOrder() {
    const name = document.getElementById("searchName").value.trim();
    const no = document.getElementById("searchNo").value.trim();
    const passwd = document.getElementById("searchPasswd").value.trim();

    if (!name) {
        alert("주문자명을 입력해주세요.");
        document.getElementById("searchName").focus();
        return false; // 서버로 전송 중단
    }
    if (!no) {
        alert("주문번호를 입력해주세요.");
        document.getElementById("searchNo").focus();
        return false; // 서버로 전송 중단
    }
    if (!passwd) {
        alert("비밀번호를 입력해주세요.");
        document.getElementById("searchPasswd").focus();
        return false; // 서버로 전송 중단
    }
    
    return true; // 모두 입력되었을 때만 정상 전송
}
</script>
</html>