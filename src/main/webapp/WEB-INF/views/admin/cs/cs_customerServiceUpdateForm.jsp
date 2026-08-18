<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고객센터 수정 폼</title>
</head>
<body>
<%@ include file="../../header.jsp" %>
<table>
	<form name="customerServiceUpdate" method="post" action="/customerServiceUpdate">
	<input type="hidden" name="cs_no" value="${csUpdate.cs_no}">
	<tr>
		<td>제목</td>
		<td><input type="text" name="cs_subject" value="${csUpdate.cs_subject}"></td>
	</tr>
	<tr>
		<td colspan=2>
			<select name="cs_category">
				<option value="운영">운영</option>
				<option value="상품">상품</option>
				<option value="주문">주문</option>
				<option value="배송">배송</option>
				<option value="회원">회원</option>
				<option value="기타">기타</option>
			</select>
		</td>
	</tr>
	<tr>
		<td colspan=2>
			<textarea name="cs_content">${csUpdate.cs_content}</textarea>
		</td>
	</tr>
</table>
<input type="submit" value="등록">
<a href="/guest/cs/cs_customerServiceList" onclick="return confirm('사이트에서 나가시겠습니까?');">취소</a>
</form>
<%@ include file="../../footer.jsp" %>
</body>
</html>