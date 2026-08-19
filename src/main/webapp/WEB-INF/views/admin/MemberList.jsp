<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 목록</title>
<style>
.memberlist {
    max-width: 1200px;
    margin: 40px auto;
    padding: 0 20px;
    font-family: sans-serif;
    color: #333;
}

/* 제목 + 설명 */
.header {
    display: flex;
    align-items: center;
    gap: 15px;
    margin-bottom: 20px;
}
.header h3 { margin: 0; font-size: 22px; }
.header p { margin: 0; color: #888; border-left: 1px solid #ddd; padding-left: 15px; font-size: 14px; }

/* 깔끔한 테이블 */
table {
    width: 100%;
    border-collapse: collapse;
    border-top: 1px solid #e5e5e5;
    border-bottom: 1px solid #e5e5e5;
    text-align: center;
    font-size: 14px;
}

th {
    background-color: #fafafa;
    padding: 14px 10px;
    border-bottom: 1px solid #eee;
    font-weight: 600;
}

td {
    padding: 14px 10px;
    border-bottom: 1px solid #eee;
}

/* 주소만 왼쪽 정렬 */
td.addr {
    text-align: left;
}

/* 기본 네모 버튼 */
button, .btn {
    padding: 6px 14px;
    background: #fff;
    border: 1px solid #ccc;
    cursor: pointer;
    text-decoration: none;
    color: #333;
    font-size: 13px;
    display: inline-block;
}
button:hover, .btn:hover {
    background: #f5f5f5;
}

.bottom {
    margin-top: 20px;
}
</style>
</head>
<body>
<%@ include file="../header.jsp" %>
<div class="memberlist">
	<div class="header">
	    <h3>회원 목록</h3>
	    <p>등록된 전체 회원 정보를 관리할 수 있습니다.</p>
	</div>
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
	        <td class="addr">${fn:replace(list.m_addr, ',', ' ')}</td>
	        <td><fmt:formatDate value="${list.m_date}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
	        <td>${list.m_email}</td>
	        <td>
	            <button type="button" onclick="if(confirm('삭제하시겠습니까?')) location.href='/AdminMDelete?m_id=${list.m_id}'">삭제</button>
	        </td>
	    </tr>
	    </c:forEach>
	</table>
	<div class="bottom">
	    <a href="/main" class="btn">뒤로가기</a>
	</div>
</div>
<%@ include file="../footer.jsp" %>
</body>
</html>