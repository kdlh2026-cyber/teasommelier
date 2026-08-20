<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TeaSommelier</title>
<script src="/js/addrcheck.js"></script>
<style>
.required {
  color: #007bff;        /* 파란색 별표 */
  margin-right: 2px;
}
</style>
</head>
<body>
<%@ include file="/WEB-INF/views/header.jsp" %>
	<div>
		<h3>배송주소록 관리</h3>
		<p>자주 쓰는 배송지를 등록 관리하실 수 있습니다.</p>
	</div>
	<form name="shipaddr" method="post" action="/ShipaddrWrite">
	<input type="hidden" name="m_no" id="m_no" value="${m_no}">
	<table>
		<tr>
			<th>
				배송지명<span class="required">*</span>
			</th>
			<td>
				<input type="text" id="s_deliveryname" name="s_deliveryname">
			</td>
		</tr>
		<tr>
			<th>
				성명<span class="required">*</span>
			</th>
			<td>
				<input type="text" id="s_name" name="s_name">
			</td>
		</tr>
		<tr>
			<th>
				주소<span class="required">*</span>
			</th>
			<td>
				<ul>
				<li>
					<input type="text" name="s_zipno" id="s_zipno" size="5" maxlength="5" readonly placeholder="우편번호">	
					<button type="button" class="btn_search" onclick="goPopup();">주소검색</button>
				</li>
				<li>	
					<input type="text" id="s_addr1" name="s_addr1" readonly>
				</li>
				<li>
					<input type="text" id="s_addr2" name="s_addr2">
				</li>
				</ul>
			</td>
		</tr>
		<tr>
			<th>
				일반전화
			</th>
			<td>
				<select name="s_tel1" id="s_tel1">
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
				<input type="text" id="s_tel2" name="s_tel2" size="4" maxlength="4">
				<input type="text" id="s_tel3" name="s_tel3" size="4" maxlength="4">
			</td>
		</tr>
		<tr>
			<th>
				휴대전화<span class="required">*</span>
			</th>
			<td>
				<input type="text" id="s_phone1" name="s_phone1" size="3" maxlength="3" value="010" readonly>-
				<input type="text" id="s_phone2" name="s_phone2" size="4" maxlength="4">-
				<input type="text" id="s_phone3" name="s_phone3" size="4" maxlength="4">
				<button type="button" class="">인증번호 받기</button>
			</td>
		</tr>
		<tr>
			<td><input type="checkbox" name="s_defaddr" value="T">기본배송지로 저장</td>
		</tr>
	</table>
	<input type="submit" value="등록" onclick="return addrcheck();">
	<input type="button" value="취소" onclick="history.back();">
	</form>
</body>
<%@ include file="/WEB-INF/views/footer.jsp" %>
</html>