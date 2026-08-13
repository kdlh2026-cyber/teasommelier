<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>환불계좌등록</title>
</head>
<body>
	<h2>환불계좌등록</h2>
	<form name="refund" method="post" action="/RefundUpdate">
	<input type="hidden" name="m_id" value="${m_id}">
	<table>
		<tr>
			<th>
				예금주
			</th>
			<td>
				<input type="text" name="m_holder">
				<p>예금주명은 주문자명과 동일해야 합니다.</p>
			</td>
		</tr>
		<tr>
			<th>
				은행명
			</th>
			<td>
				<select name="m_bank">
				    <option value="선택">-선택하세요-</option>
				    <option value="기업은행">기업은행</option>
				    <option value="국민은행">국민은행</option>
				    <option value="하나은행">하나은행</option>
				    <option value="신한은행">신한은행</option>
				    <option value="부산은행">부산은행</option>
				    <option value="우리은행">우리은행</option>
				    <option value="농협">농협</option>
				</select>
			</td>
		</tr>
		<tr>
			<th>
				계좌번호
			</th>
			<td>
				<input type="text" name="m_banknumber">
				<p>'-'와 숫자만 입력해주세요.</p>
			</td>
		</tr>
	</table>
	<input type="submit" value="등록">
	<input type="button" value="취소" onclick="window.close();">
	</form>
</body>
</html>