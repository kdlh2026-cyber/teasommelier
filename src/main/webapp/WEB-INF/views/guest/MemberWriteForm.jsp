<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
.desc {
  white-space: nowrap;
  font-size: 13px;
  color: #a0a0a0;
  margin-left: auto;
}
.required {
  color: #007bff;        /* 파란색 별표 */
  margin-right: 2px;
}
.btn_search {
  height: 48px;
  padding: 0 14px;
  font-size: 13px;
  cursor: pointer;
  border: 1px solid #dcdcdc;
  white-space: nowrap;      /* 글자 줄바꿈 방지 */
  margin-bottom: 10px;
}

/* 우편번호 박스와 버튼을 나란히 배치하는 감싸는 상자 */
.zip_group {
  display: flex;
  align-items: center;
  gap: 8px; /* 우편번호 박스와 주소검색 버튼 사이 간격 */
  box-sizing: border-box;
  max-width: 300px;
}
select{
	appearance: none;
	width: 60px;
}
</style>
<title>회원가입</title>
<script src="/js/membercheck.js">
</script>
</head>
<body>
<%@ include file="../header.jsp" %>
<div>
	<div>
		<h2>JOIN</h2>
	</div>
	<div>
		<label><span class="required">*</span>필수 입력사항</label>
	</div>
    <div>
	<form name="member" method="post" action="/MemberWrite" onsubmit="return membercheck();">
		<div class="">
			<label for="m_id"><span class="required">*</span> 아이디</label>
			<input type="text" id="m_id" name="m_id"><span class="desc">(영문소문자/숫자, 4~16자)</span>
		</div>
		<div class="">
			<label for="m_passwd"><span class="required">*</span> 비밀번호</label> 
			<input type="password" id="m_passwd" name="m_passwd"><span class="desc">(영문 대소문자/숫자/특수문자 중 2가지 이상 조합, 10~16자)</span>
		</div>
		<div class="">
			<label for="chk_passwd"><span class="required">*</span> 비밀번호 확인</label> 
			<input type="password" id="chk_passwd" name="chk_passwd">
		</div>
		<div class="">
			<label><span class="required">*</span>이름</label> 
			<input type="text" id="m_name" name="m_name">
		</div>
		<div class="zip_group">
			<div>
				<label>우편번호</label> 
				<input type="text" name="m_zipno" size="5" maxlength="5" readonly>		
			</div>
			<button type="button" class="btn_search" onclick="goPopup();">주소검색</button>
		</div>
		<div>
			<label>기본주소</label> 
			<input type="text" id="m_addr1" name="m_addr1" readonly>
		</div>
		<div>
			<label>상세주소</label> 
			<input type="text" id="m_addr2" name="m_addr2">
		</div>
		<div class="tel">
			<label>일반전화</label>
			<span>
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
			</span>
			<span>
				<input type="text" id="m_tel2" name="m_tel2" size="4" maxlength="4">
			</span>
			<span>
				<input type="text" id="m_tel3" name="m_tel3" size="4" maxlength="4">
			</span>
		</div>
		<div>
		<div class="tel">
		<label>휴대전화</label>
			<span class="required">*
			</span>
			<span>
				<input type="text" id="m_phone1" name="m_phone1" size="3" maxlength="3" value="010" readonly>
			</span>
			<span>
				<input type="text" id="m_phone2" name="m_phone2" size="4" maxlength="4">
			</span>
			<span>
				<input type="text" id="m_phone3" name="m_phone3" size="4" maxlength="4">
			</span>
		</div>
		<div>
			<button type="button" class="">인증번호 받기</button>
		</div>
		</div>
		<div>
			<label for="m_eamil"><span class="required">*</span>이메일</label> 
			<input type="text" id="m_eamil" name="m_email">
		</div>
		<div>
			<h3>추가정보</h3>
		</div>
		<div>
		<table border=1>
			<tr>
				<td>
					<label>성별</label>
				</td>
				<td>
					<label><input type="radio" name="m_gender" value="남자"> 남자</label>
					<label><input type="radio" name="m_gender" value="여자"> 여자</label>
				</td>
			</tr>
			<tr>
				<td>
					<label>생년월일</label>
				</td>
				<td>
					<label><input type="text" name="m_birth1">년</label>
					<label><input type="text" name="m_birth2">월</label>
					<label><input type="text" name="m_birth3">일</label>
					<label><input type="radio" name="m_lscalendar" value="양력"> 양력</label>
					<label><input type="radio" name="m_lscalendar" value="음력"> 음력</label>
				</td>
			</tr>
			<tr>
				<td>
					<label>환불계좌정보</label>
				</td>
				<td>
					<div>예금주<input type="text" name="m_holder"></div>
					<div>은행명
						<span class="">
						<select name="m_bank">
						    <option value="선택">-은행선택-</option>
						    <option value="기업은행">기업은행</option>
						    <option value="국민은행">국민은행</option>
						    <option value="하나은행">하나은행</option>
						    <option value="신한은행">신한은행</option>
						    <option value="부산은행">부산은행</option>
						    <option value="우리은행">우리은행</option>
						    <option value="농협">농협</option>
						</select>
						</span>
					</div>
					<div>계좌번호<input type="text" name="m_banknumber"></div>
					<div>('-'와 숫자만 입력해주세요.)</div>
				</td>
			</tr>
		</table>
		</div>
		<div>
			<input type="submit" value="회원가입"> 
		</div>	
		<div>
			<div>
				<h3><input type="checkbox" name="all_chk"> 	전체 약관동의</h3>
			</div>
			<div>
				<%@ include file="TermsofUse.jsp" %>
			</div>
			<div>이용약관에 동의하십니까? 
				<input type="checkbox" name="term_chk" value="T"> 동의함
			</div>
			<div>
				<%@ include file="Personalinfo.jsp" %>
			</div>
			<div>개인정보 수집 및 이용에 동의하십니까? 
				<input type="checkbox" name="personal_chk" value="T"> 동의함
			</div>
			<div>
				<%@ include file="ConsentToReceive.jsp" %>
			</div>
			<div>SMS수신을 동의하십니까? 
				<input type="checkbox" name="m_rsms" value="T"> 동의함
			</div>
			<div>이메일수신을 동의하십니까? 
				<input type="checkbox" name="m_remail" value="T"> 동의함
			</div>
		</div>
		</form>
	</div>
</div>
<%@ include file="../footer.jsp" %>
</body>
</html>