<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<script src="/js/membercheck.js"></script>
<style>
body {
    font-family: 'Noto Sans KR', 'Malgun Gothic', sans-serif;
}
.box {
        border: 1px solid #ccc; /* 테두리 */
        padding: 15px;
        height: 150px; /* 박스 높이 (이 높이를 넘어가면 스크롤 생성) */
        overflow-y: auto; /* 세로 스크롤 생성 */
        font-size: 13px;
        color: #666; /* 텍스트 색상 (약간 흐리게) */
        line-height: 1.6; /* 줄 간격 */
        white-space: pre-wrap; /* HTML 코드 내의 줄바꿈을 화면에 그대로 반영 */
        background-color: #fff;
}
/* 회원가입 폼 전체 감싸는 영역 */
.join-wrapper {
    max-width: 640px;      /* 폼 전체 너비 */
    margin: 50px auto;     /* 가운데 정렬 */
    padding: 0 20px;
    box-sizing: border-box;
}

.join-wrapper h2 {
    font-size: 32px;
    font-weight: bold;
    margin-bottom: 20px;
    color: #000;
}

/* 필수입력사항 안내 텍스트 */
.req-notice {
    text-align: right;
    font-size: 13px;
    color: #666;
    margin-bottom: 10px;
}
.required {
    color: #007bff; /* 파란색 별표 */
    margin-right: 3px;
    font-weight: bold;
}

/* 공통 입력 박스 스타일 (테두리 있는 한 줄) */
.input-box {
    display: flex;
    align-items: center;
    border: 1px solid #e1e1e1;
    background-color: #fff;
    height: 50px;
    padding: 0 15px;
    margin-bottom: 10px;
    box-sizing: border-box;
}

/* 가로 분할 영역 (우편번호, 전화번호 등) */
.flex-row {
    display: flex;
    gap: 10px;
    margin-bottom: 10px;
}
.flex-row .input-box {
    margin-bottom: 0; /* flex-row 안에서는 하단 마진 제거 */
}
.flex-1 { flex: 1; }
.flex-2 { flex: 2; }

/* 박스 내부 라벨 (placeholder처럼 보이는 텍스트) */
.input-box .inline-label {
    color: #999;
    font-size: 14px;
    white-space: nowrap;
    min-width: 100px; /* 라벨 영역 너비 고정 */
}

/* 박스 내부 입력 필드 */
.input-box input[type="text"],
.input-box input[type="password"] {
    flex: 1;
    border: none;
    outline: none;
    font-size: 14px;
    color: #333;
    background: transparent;
    width: 100%;
    padding: 0;
}

/* 우측 설명 텍스트 (예: 영문소문자/숫자...) */
.input-box .desc {
    color: #b3b3b3;
    font-size: 13px;
    white-space: nowrap;
    margin-left: 10px;
}

/* 박스 내부 Select (전화번호 앞자리) */
.input-box select {
    flex: 1;
    border: none;
    outline: none;
    font-size: 14px;
    color: #333;
    background: transparent;
    -webkit-appearance: none;
    appearance: none;
    cursor: pointer;
}

/* 버튼 전용 박스 스타일 */
.input-box.btn-box {
    padding: 0;
    background-color: #f8f8f8; /* 살짝 회색 배경 */
}
.input-box.btn-box button {
    width: 100%;
    height: 100%;
    background: transparent;
    border: none;
    font-size: 14px;
    color: #333;
    cursor: pointer;
}

/* placeholder 색상 통일 */
::placeholder {
    color: #999;
    opacity: 1;
}

.additional-info {
    margin-top: 40px;
}
.additional-info .form-title {
    font-size: 18px;
    font-weight: bold;
    margin-bottom: 15px;
    color: #111;
}

.info-table {
    width: 100%;
    border-collapse: collapse;
    border-top: 1px solid #eaeaea;
    margin-bottom: 20px;
}
.info-table th, .info-table td {
    border-bottom: 1px solid #eaeaea;
    padding: 15px;
    font-size: 14px;
}
.info-table th {
    width: 120px;
    background-color: #f9f9f9;
    text-align: left;
    font-weight: normal;
    vertical-align: middle;
    color: #555;
}
.info-table td {
    background-color: #fff;
}

/* 추가정보 폼 요소 스타일 */
.info-table input[type="text"], .info-table select {
    height: 32px;
    border: 1px solid #dcdcdc;
    padding: 0 10px;
    box-sizing: border-box;
    font-size: 14px;
    vertical-align: middle;
}
.info-table input[type="text"]:focus, .info-table select:focus {
    outline: none;
    border-color: #999;
}
.info-table input[type="radio"] {
    vertical-align: middle;
    margin: 0 4px 0 0;
}
.info-table label {
    margin-right: 15px;
    cursor: pointer;
    vertical-align: middle;
}

/* 생년월일 영역 */
.birth-year { width: 70px; }
.birth-month, .birth-day { width: 50px; }
.date-text { margin: 0 8px 0 4px; vertical-align: middle; }
.calendar-type { margin-left: 10px; display: inline-block; }

/* 환불계좌 정보 영역 */
.account-row {
    display: flex;
    align-items: center;
    margin-bottom: 10px;
}
.account-row:last-child {
    margin-bottom: 0;
    align-items: flex-start;
}
.account-label {
    width: 80px;
    flex-shrink: 0;
    font-size: 14px;
}
.account-row:last-child .account-label {
    padding-top: 8px;
}
.account-input {
    width: 100%;
    max-width: 300px;
}
.bank-select { width: 140px; }
.helper-text {
    font-size: 12px;
    color: #222;
    margin: 6px 0 0 0;
}

/* 회원가입 버튼 */
.btn-submit {
    display: block;
    width: 100%;
    background-color: #333;
    color: #fff;
    border: none;
    padding: 16px 0;
    font-size: 16px;
    font-weight: bold;
    border-radius: 4px;
    cursor: pointer;
    text-align: center;
    margin-bottom: 30px;
}
.btn-submit:hover { background-color: #222; }
/* --- 약관동의 영역 스타일 시작 --- */
.terms-wrapper {
    margin-top: 40px;
    margin-bottom: 40px;
}

/* 전체 약관 동의 우측 정렬 */
.all-agree-row {
    text-align: right;
    margin-bottom: 10px;
}
.all-agree-row label {
    font-size: 16px;
    font-weight: bold;
    color: #333;
    cursor: pointer;
    display: inline-flex;
    align-items: center;
}

/* 개별 동의 텍스트 우측 정렬 */
.agree-row {
    text-align: right;
    margin-top: 8px;
    margin-bottom: 30px; /* 다음 박스와의 간격 */
    font-size: 13px;
    color: #555;
}
.agree-row label {
    cursor: pointer;
    display: inline-flex;
    align-items: center;
    margin-left: 10px;
}

/* 체크박스 정렬 및 크기 조정 */
.terms-wrapper input[type="checkbox"] {
    width: 16px;
    height: 16px;
    margin: 0 6px 0 0;
    vertical-align: middle;
    cursor: pointer;
}
/* --- 약관동의 영역 스타일 끝 --- */
</style>
</head>
<body>
<%@ include file="../header.jsp" %>

<div class="join-wrapper">
    <h2>JOIN</h2>

    <div class="req-notice">
        <span class="required">*</span> 필수입력사항
    </div>

    <form name="member" method="post" action="/MemberWrite" onsubmit="return membercheck();">
        
        <div class="input-box">
            <span class="required">*</span>
            <input type="text" id="m_id" name="m_id" placeholder="아이디">
            <span class="desc">(영문소문자/숫자, 4~16자)</span>
        </div>

        <div class="input-box">
            <span class="required">*</span>
            <input type="password" id="m_passwd" name="m_passwd" placeholder="비밀번호">
            <span class="desc">(영문 대소문자/숫자/특수문자 중 2가지 이상 조합, 10~16자)</span>
        </div>

        <div class="input-box">
            <span class="required">*</span>
            <input type="password" id="chk_passwd" name="chk_passwd" placeholder="비밀번호 확인">
        </div>

        <div class="input-box">
            <span class="required">*</span>
            <input type="text" id="m_name" name="m_name" placeholder="이름">
        </div>

        <div class="flex-row">
            <div class="input-box flex-2">
                <input type="text" name="m_zipno" maxlength="5" readonly placeholder="우편번호">		
            </div>
            <div class="input-box btn-box flex-1">
                <button type="button" onclick="goPopup();">주소검색</button>
            </div>
        </div>
        <div class="input-box">
            <input type="text" id="m_addr1" name="m_addr1" readonly placeholder="기본주소">
        </div>
        <div class="input-box">
            <input type="text" id="m_addr2" name="m_addr2" placeholder="나머지 주소">
        </div>
        
        <div class="flex-row">
            <div class="input-box flex-1">
                <select name="m_tel1">
                    <option value="02">02</option>
                    <option value="031">031</option>
                    <option value="032">032</option>
                    <option value="033">033</option>
                    <option value="041">041</option>
                    <option value="042">042</option>
                    <option value="043">043</option>
                    <option value="044">044</option>
                    <option value="051">051</option>
                    <option value="052">052</option>
                    <option value="053">053</option>
                    <option value="054">054</option>
                    <option value="055">055</option>
                    <option value="070">070</option>
                </select>
            </div>
            <div class="input-box flex-1">
                <input type="text" id="m_tel2" name="m_tel2" maxlength="4" placeholder="일반전화">
            </div>
            <div class="input-box flex-1">
                <input type="text" id="m_tel3" name="m_tel3" maxlength="4" placeholder="일반전화">
            </div>
        </div>

        <div class="flex-row">
            <div class="input-box flex-1">
                <label class="inline-label" style="min-width: auto; margin-right: 5px;"><span class="required">*</span></label>
                <select name="m_phone1" id="m_phone1">
                    <option value="010">010</option>
                </select>
            </div>
            <div class="input-box flex-1">
                <input type="text" id="m_phone2" name="m_phone2" maxlength="4" placeholder="휴대전화">
            </div>
            <div class="input-box flex-1">
                <input type="text" id="m_phone3" name="m_phone3" maxlength="4" placeholder="휴대전화">
            </div>
        </div>

        <div class="input-box btn-box">
            <button type="button">인증번호받기</button>
        </div>

        <div class="input-box" style="margin-bottom: 40px;">
            <span class="required">*</span>
            <input type="text" id="m_email" name="m_email" placeholder="이메일">
        </div>

        <div class="additional-info">
            <div class="form-title">추가정보</div>
            <table class="info-table">
                <tbody>
                    <tr>
                        <th scope="row">성별</th>
                        <td>
                            <label><input type="radio" name="m_gender" value="남자"> 남자</label>
                            <label><input type="radio" name="m_gender" value="여자"> 여자</label>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">생년월일</th>
                        <td>
                            <input type="text" name="m_birth1" class="birth-year"><span class="date-text">년</span>
                            <input type="text" name="m_birth2" class="birth-month"><span class="date-text">월</span>
                            <input type="text" name="m_birth3" class="birth-day"><span class="date-text">일</span>
                            
                            <span class="calendar-type">
                                <label><input type="radio" name="m_lscalendar" value="양력" checked> 양력</label>
                                <label><input type="radio" name="m_lscalendar" value="음력"> 음력</label>
                            </span>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">환불계좌 정보</th>
                        <td>
                            <div class="account-row">
                                <span class="account-label">· 예금주</span>
                                <input type="text" name="m_holder" class="account-input">
                            </div>
                            <div class="account-row">
                                <span class="account-label">· 은행명</span>
                                <select name="m_bank" class="bank-select">
                                    <option value="선택">- 은행선택 -</option>
                                    <option value="기업은행">기업은행</option>
                                    <option value="국민은행">국민은행</option>
                                    <option value="하나은행">하나은행</option>
                                    <option value="신한은행">신한은행</option>
                                    <option value="부산은행">부산은행</option>
                                    <option value="우리은행">우리은행</option>
                                    <option value="농협">농협</option>
                                </select>
                            </div>
                            <div class="account-row">
                                <span class="account-label">· 계좌번호</span>
                                <div>
                                    <input type="text" name="m_banknumber" class="account-input">
                                    <p class="helper-text">('-'와 숫자만 입력해주세요.)</p>
                                </div>
                            </div>
                        </td>
                    </tr>
                </tbody>
            </table>

            <button type="submit" class="btn-submit">회원가입</button>
        </div>
        <div class="terms-wrapper">
            <div class="all-agree-row">
                <label><input type="checkbox" name="all_chk"> 전체 약관 동의</label>
            </div>
            <div>
                <%@ include file="TermsofUse.jsp" %>
            </div>
            <div class="agree-row">
                이용약관에 동의하십니까? 
                <label><input type="checkbox" name="term_chk" value="T"> 동의함</label>
            </div>
            <div>
                <%@ include file="Personalinfo.jsp" %>
            </div>
            <div class="agree-row">
                개인정보 수집 및 이용에 동의하십니까? 
                <label><input type="checkbox" name="personal_chk" value="T"> 동의함</label>
            </div>
            <div>
                <%@ include file="ConsentToReceive.jsp" %>
            </div>
            <div class="agree-row">
                <div style="margin-bottom: 5px;">
                    SMS 수신을 동의하십니까? 
                    <label><input type="checkbox" name="m_rsms" value="T"> 동의함</label>
                </div>
                <div>
                    이메일 수신을 동의하십니까? 
                    <label><input type="checkbox" name="m_remail" value="T"> 동의함</label>
                </div>
            </div>
        </div>
    </form>
</div>
<%@ include file="../footer.jsp" %>
</body>
</html>