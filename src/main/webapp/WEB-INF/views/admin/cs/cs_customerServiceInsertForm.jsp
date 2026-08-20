<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고객센터 작성 폼</title>
<link rel="stylesheet" href="/css/customerService.css">
<script src="/js/cs-form.js"></script>
</head>
<body>
<%@ include file="../../header.jsp" %>
	<div class="cs-page">
		<div class="cs-form-title">
			<h2>문의 작성</h2>
		</div>
		<form name="customerServiceInsert" class="cs-form" method="post" action="/customerServiceInsert" onsubmit="return csCheck();">
			<table class="cs-table">
				<tr>
					<th>제목</th>
					<td><input type="text" name="cs_subject"></td>
				</tr>
				<tr>
					<th>카테고리</th>
					<td>
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
					<th>내용</th>
					<td><textarea name="cs_content"></textarea></td>
				</tr>
			</table>
			<div class="cs-btn-area">
				<button type="submit" class="btn-submit">등록</button>
				<a class="cs-cancel-link" href="/guest/cs/cs_customerServiceList" onclick="return confirm('사이트에서 나가시겠습니까?');">취소</a>
			</div>
		</form>
	</div>
<%@ include file="../../footer.jsp" %>
</body>
</html>