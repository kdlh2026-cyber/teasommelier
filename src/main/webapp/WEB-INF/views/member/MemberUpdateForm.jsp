<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보수정</title>
<script src="/js/membercheck.js"></script>
<script>
function confirmDelete() {
    if (confirm("정말 삭제하시겠습니까?")) {
    	const member_id = document.getElementById("m_id").value;
    	location.href = "/MemberDelete?m_id=" + encodeURIComponent(member_id);
    }
}
function goRefundAcc(){ 
	const member_id = "${MemberUpdate.m_id}";
	var pop = window.open("/member/RefundAcc?m_id=" + encodeURIComponent(member_id),"pop","width=570,height=420, scrollbars=yes, resizable=yes");
}
</script>
<style>
.required {
  color: #007bff;        /* 파란색 별표 */
  margin-right: 2px;
}
</style>
</head>
<body>
<%@ include file="../header.jsp" %>
<div>
	<div>
		<h2>정보수정</h2>
	</div>
	<div>
		기본정보
		<span class="required">*</span>필수 입력사항
	</div>
    <div>
	<form name="member" method="post" action="/MemberUpdate">
		<table border=1>
		<tr>
			<th>
				아이디<span class="required">*</span>
			</th>
			<td>
				<input type="text" id="m_id" name="m_id" value="${MemberUpdate.m_id}" readonly><span class="desc">(영문소문자/숫자, 4~16자)</span>
			</td>
		</tr>
		<tr>
			<th>
				비밀번호<span class="required">*</span>
			</th>
			<td>
				<input type="password" id="m_passwd" name="m_passwd"><span class="desc">(영문 대소문자/숫자/특수문자 중 2가지 이상 조합, 10~16자)</span>
			</td>
		</tr>
		<tr>
			<th>
				비밀번호 확인<span class="required">*</span>
			</th>
			<td>
				<input type="password" id="chk_passwd" name="chk_passwd">
			</td>
		</tr>
		<tr>
			<th>
				이름<span class="required">*</span>
			</th>
			<td>
				<input type="text" id="m_name" name="m_name" value="${MemberUpdate.m_name}" readonly>
			</td>
		</tr>
		<tr>
			<th>
				주소
			</th>
			<td>
				<ul type="none">
				<li>
					<input type="text" name="m_zipno" id="m_zipno" size="5" maxlength="5" readonly placeholder="우편번호" value="${MemberUpdate.m_zipno}">	
					<button type="button" class="btn_search" onclick="goPopup();">주소검색</button>
				</li>
				<li>	
					<input type="text" id="m_addr1" name="m_addr1" readonly value="${fn:split(MemberUpdate.m_addr, ',')[0]}">
				</li>
				<li>
					<input type="text" id="m_addr2" name="m_addr2" value="${fn:split(MemberUpdate.m_addr, ',')[1]}">
				</li>
				</ul>
			</td>
		</tr>
		<tr>
			<th>
				일반전화
			</th>
			<td>
				<select name="m_tel1" id="m_tel1">
					    <option value="02" <c:if test="${fn:split(MemberUpdate.m_tel, '-')[0] == '02'}">selected</c:if>>02</option>
					    <option value="031" <c:if test="${fn:split(MemberUpdate.m_tel, '-')[0] == '031'}">selected</c:if>>031</option>
					    <option value="032" <c:if test="${fn:split(MemberUpdate.m_tel, '-')[0] == '032'}">selected</c:if>>032</option>
					    <option value="033" <c:if test="${fn:split(MemberUpdate.m_tel, '-')[0] == '033'}">selected</c:if>>033</option>
					    <option value="041" <c:if test="${fn:split(MemberUpdate.m_tel, '-')[0] == '041'}">selected</c:if>>041</option>
					    <option value="042" <c:if test="${fn:split(MemberUpdate.m_tel, '-')[0] == '042'}">selected</c:if>>042</option>
					    <option value="043" <c:if test="${fn:split(MemberUpdate.m_tel, '-')[0] == '043'}">selected</c:if>>043</option>
					    <option value="044" <c:if test="${fn:split(MemberUpdate.m_tel, '-')[0] == '044'}">selected</c:if>>044</option>
					    <option value="051" <c:if test="${fn:split(MemberUpdate.m_tel, '-')[0] == '051'}">selected</c:if>>051</option>
					    <option value="052" <c:if test="${fn:split(MemberUpdate.m_tel, '-')[0] == '052'}">selected</c:if>>052</option>
					    <option value="053" <c:if test="${fn:split(MemberUpdate.m_tel, '-')[0] == '053'}">selected</c:if>>053</option>
					    <option value="054" <c:if test="${fn:split(MemberUpdate.m_tel, '-')[0] == '054'}">selected</c:if>>054</option>
					    <option value="055" <c:if test="${fn:split(MemberUpdate.m_tel, '-')[0] == '055'}">selected</c:if>>055</option>
					    <option value="070" <c:if test="${fn:split(MemberUpdate.m_tel, '-')[0] == '070'}">selected</c:if>>070</option>
				</select>
				<input type="text" id="m_tel2" name="m_tel2" size="4" maxlength="4" value="${fn:split(MemberUpdate.m_tel, '-')[1]}">
				<input type="text" id="m_tel3" name="m_tel3" size="4" maxlength="4" value="${fn:split(MemberUpdate.m_tel, '-')[2]}">
			</td>
		</tr>
		<tr>
			<th>
				휴대전화<span class="required">*</span>
			</th>
			<td>
				<input type="text" id="m_phone1" name="m_phone1" size="3" maxlength="3" value="010" readonly>-
				<input type="text" id="m_phone2" name="m_phone2" size="4" maxlength="4" value="${fn:split(MemberUpdate.m_phone, '-')[1]}">-
				<input type="text" id="m_phone3" name="m_phone3" size="4" maxlength="4" value="${fn:split(MemberUpdate.m_phone, '-')[2]}">
				<button type="button" class="">인증번호 받기</button>
			</td>
		</tr>
		<tr>
			<th>
				SMS수신여부
			</th>
			<td>
				<input type="radio" name="m_rsms" value="T" ${MemberUpdate.m_rsms == 'T' ? 'checked' : ''}> 수신함
				<input type="radio" name="m_rsms" value="F" ${MemberUpdate.m_rsms == 'F' ? 'checked' : ''}> 수신안함
			</td>
		</tr>
		<tr>
			<th>
				이메일<span class="required">*</span>
			</th>
			<td>
				<input type="text" id="m_eamil" name="m_email" value="${MemberUpdate.m_email}">
			</td>
		</tr>
		<tr>
			<th>
				이메일 수신여부
			</th>
			<td>
				<input type="radio" name="m_remail" value="T" ${MemberUpdate.m_remail == 'T' ? 'checked' : ''}> 수신함
				<input type="radio" name="m_remail" value="F" ${MemberUpdate.m_remail == 'F' ? 'checked' : ''}> 수신안함
			</td>
		</tr>
		</table>
		<div>
			<h3>추가정보</h3>
		</div>
		<div>
		<table border=1>
			<tr>
				<th>
					성별
				</th>
				<td>
					<input type="radio" name="m_gender" disabled value="남자" ${MemberUpdate.m_gender == '남자' ? 'checked' : ''}> 남자
					<input type="radio" name="m_gender" disabled value="여자" ${MemberUpdate.m_gender == '여자' ? 'checked' : ''}> 여자
				</td>
			</tr>
			<tr>
				<th>
					생년월일
				</th>
				<td>
					<input type="text" name="m_birth1" value="<fmt:formatDate value='${MemberUpdate.m_birth}' pattern='yyyy'/>">년
					<input type="text" name="m_birth2" value="<fmt:formatDate value='${MemberUpdate.m_birth}' pattern='MM'/>">월
					<input type="text" name="m_birth3" value="<fmt:formatDate value='${MemberUpdate.m_birth}' pattern='dd'/>">일
					<input type="radio" name="m_lscalendar" value="양력" ${MemberUpdate.m_lscalendar == '양력' ? 'checked' : ''}> 양력
					<input type="radio" name="m_lscalendar" value="음력" ${MemberUpdate.m_lscalendar == '음력' ? 'checked' : ''}> 음력
				</td>
			</tr>
			<tr>
				<th>
					환불계좌
				</th>
				<td>
					<input type="button" name="btn_RefundAcount" value="환불계좌등록" onclick="goRefundAcc();">
				</td>
			</tr>
		</table>
		</div>
		<div>
			<input type="submit" value="회원가입" onclick="return membercheck();">
			<input type="button" value="회원탈퇴" onclick="return confirmDelete();">
		</div>
		</form>
	</div>
</div>
<%@ include file="../footer.jsp" %>
</body>
</html>