<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<style>
	/* 전체 기본 스타일 설정 (깔끔한 폰트 및 여백) */
	body {
		font-family: 'Malgun Gothic', '맑은 고딕', helvetica, sans-serif;
		background-color: #f8f9fa;
		color: #333;
		padding: 40px;
		max-width: 1000px;
		margin: 0 auto;
	}

	/* 제목 스타일 */
	h3 {
		font-size: 24px;
		color: #222;
		margin-bottom: 20px;
		padding-left: 5px;
		border-left: 4px solid #4a90e2; /* 왼쪽에 깔끔한 포인트 바 */
	}

	/* 테이블 전체 테이블 스타일 */
	table {
		width: 100%;
		border-collapse: collapse; /* 테두리 겹침 제거 */
		background-color: #ffffff;
		box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); /* 부드러운 그림자 */
		border-radius: 8px;
		overflow: hidden; /* 라운드 코너 유지 */
		margin-bottom: 25px;
	}

	/* 테이블 헤더(Th) 스타일 */
	th {
		background-color: #4a90e2; /* 신뢰감을 주는 블루 톤 */
		color: white;
		font-weight: 600;
		padding: 14px 12px;
		font-size: 15px;
		letter-spacing: 0.5px;
	}

	/* 테이블 셀(Td) 스타일 */
	td {
		padding: 12px;
		text-align: center;
		border-bottom: 1px solid #eeeeee;
		color: #555;
		font-size: 14px;
	}

	/* 마우스 올렸을 때 행(Row) 하이라이트 효과 (가시성 핵심!) */
	tbody tr:hover {
		background-color: #f1f7fe;
		cursor: pointer;
	}

	/* 뒤로가기 링크 버튼 스타일화 */
	.btn-back {
		display: inline-block;
		text-decoration: none;
		color: #fff;
		background-color: #6c757d;
		padding: 10px 20px;
		border-radius: 5px;
		font-size: 14px;
		font-weight: bold;
		transition: background-color 0.2s;
	}

	.btn-back:hover {
		background-color: #5a6268;
	}
</style>
<html>
<head>
<meta charset="UTF-8">
<title>회원 목록</title>
</head>
<body>
	<h3>회원 목록</h3>
	<table>
		<tr>
			<th>번호</th>
			<th>아이디</th>
			<th>이름</th>
			<th>휴대전화</th>
			<th>주소</th>
			<th>가입일</th>
			<th>이메일</th>
			<th>삭제</th>
		</tr>
		<c:forEach var="list" items="${MemberList}">
		<tr>
			<td>${list.m_no}</td>
			<td>${list.m_id}</td>
			<td>${list.m_name}</td>
			<td>${list.m_phone}</td>
			<td>${list.m_addr}</td>
			<td><fmt:formatDate value="${list.m_date}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
			<td>${list.m_email}</td>
			<td><button type="button" onclick="location.href='/AdminMDelete?m_id=${list.m_id}'">삭제</button></td>
		</tr>
		</c:forEach>
	</table>
	<a href="/main" class="btn-back">뒤로가기</a><br>
</body>
</html>