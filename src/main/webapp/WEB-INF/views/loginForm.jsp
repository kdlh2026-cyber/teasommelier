<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
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
<style>
@charset "UTF-8";
@import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap');

/* 기본 스타일 초기화 */
* {
    box-sizing: border-box;
    margin: 0;
    padding: 0;
}

body {
    font-family: 'Noto Sans KR', sans-serif, AppleSDGothicNeo-Regular;
    color: #333;
    background-color: #fff;
}

/* 전체 감싸는 메인 컨테이너 */
.check-wrapper {
    width: 100%;
    max-width: 420px;
    margin: 60px auto;
    padding: 0 20px;
}

/* LOGIN 타이틀 */
.login-title {
    font-size: 26px;
    font-weight: 800;
    margin-bottom: 24px;
    text-transform: uppercase;
    letter-spacing: 0.5px;
    color: #111;
}

/* 아이디 / 비밀번호 입력창 그룹 */
.input-group input[type="text"],
.input-group input[type="password"] {
    width: 100%;
    height: 48px;
    border: 1px solid #e1e1e1;
    padding: 0 14px;
    font-size: 14px;
    margin-bottom: 8px;
    outline: none;
    border-radius: 0; /* 각진 테두리 유지를 위함 */
}

.input-group input::placeholder {
    color: #bbb;
}

.input-group input:focus {
    border-color: #333;
}

/* 아이디 저장 & 아이디/비밀번호 찾기 영역 */
.login-utility {
    display: flex;
    justify-content: space-between;
    align-items: center;
    font-size: 13px;
    color: #555;
    margin: 12px 0 20px 0;
}

.remember-id {
    display: flex;
    align-items: center;
    gap: 6px;
    cursor: pointer;
}

.remember-id input[type="checkbox"] {
    accent-color: #333;
    cursor: pointer;
}

/* 로그인 버튼 */
.button-group {
    margin-bottom: 24px;
}

.button-group input[type="submit"] {
    width: 100%;
    height: 52px;
    background-color: #2b2b2b;
    color: #fff;
    border: none;
    font-size: 15px;
    font-weight: 600;
    cursor: pointer;
    border-radius: 2px;
    transition: background-color 0.2s ease;
}

.button-group input[type="submit"]:hover {
    background-color: #111;
}

/* 하단 회원가입 / 비회원주문조회 버튼 그룹 (2분할 박스) */
.sub-buttons {
    display: flex;
    width: 100%; /* 부모 너비에 딱 맞게 설정 */
    border: 1px solid #ddd;
    box-sizing: border-box;
}

.sub-buttons input[type="button"],
.sub-buttons button {
    flex: 1; /* 두 버튼이 정확히 1:1 비율로 공간을 똑같이 나눠 가짐 */
    width: 50%; /* 너비를 50%씩 균등 배분 */
    height: 48px;
    background-color: #fff;
    color: #333;
    border: none;
    font-size: 13px;
    font-weight: 500;
    cursor: pointer;
    text-align: center;
    transition: background-color 0.2s ease;
    box-sizing: border-box;
}

/* 두 버튼 사이의 세로 경계선 */
.sub-buttons input[type="button"]:first-child {
    border-right: 1px solid #ddd;
}

.sub-buttons input[type="button"]:hover,
.sub-buttons button:hover {
    background-init: #f8f8f8;
    background-color: #f8f8f8;
}

/* 비회원 주문조회 전체 영역 컨테이너 */
.guestOrderSearch {
    margin-top: 30px;
    padding-top: 25px;
    border-top: 1px solid #eaeaea;
}

/* ORDER 타이틀 */
.guestOrderSearch .order-title {
    font-size: 20px;
    font-weight: 800;
    margin-bottom: 8px;
    text-transform: uppercase;
    letter-spacing: 0.5px;
    color: #111;
}

/* 안내 문구 스타일 */
.guestOrderSearch .order-desc {
    font-size: 13px;
    color: #666;
    margin-bottom: 16px;
    line-height: 1.4;
}

</style>
</head>
<body>
<%@ include file="header.jsp" %>
<div class="check-wrapper">
   <h2 class="login-title">Login</h2>
   <form name="loginForm" method="post" action="${pageContext.request.contextPath}/j_spring_security_check">
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
		<form method="post" action="${pageContext.request.contextPath}/guestOrderConfirm" onsubmit="return checkGuestOrder()">
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