<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>대량주문문의</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/inquiry.css">
</head>
<body>
<%@ include file="../header.jsp" %>
<div class="inquiry-container">
	<%@ include file="mypage/Mymenu.jsp" %>
    <div class="inquiry-header">
        <h2>대량 구매문의</h2>
        <p>고객님이 요청하신 상품 대량구매문의 내역 입니다.</p>
    </div>
    <table class="inquiry-table">
        <thead>
            <tr>
                <th class="no">번호</th>
                <th class="type">문의유형</th>
                <th class="title">제목</th>
                <th class="writer">작성자</th>
                <th class="reply">답변</th>
                <th class="action">수정|삭제</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="inquiry" items="${inquiryList}">
            <tr>
                <td>${inquiry.i_no}</td>
                <td>${inquiry.i_type}</td>
                <td class="title-cell">
                    <a href="${pageContext.request.contextPath}/member/inquiryDetailM?i_no=${inquiry.i_no}">
                        ${inquiry.i_title}
                    </a>
                </td>
                <td>${inquiry.i_name}</td>
                <td>
                    <c:choose>
                        <c:when test="${inquiry.i_reply == 'Y'}">
                            <span class="reply-complete">답변완료</span>
                        </c:when>
                        <c:otherwise>
                            <span class="reply-wait">답변대기</span>
                        </c:otherwise>
                    </c:choose>
                </td>
                <td class="action-cell">
                    <a href="${pageContext.request.contextPath}/member/inquiryEditFormM?i_no=${inquiry.i_no}" class="btn-edit">수정</a>
                    <a href="${pageContext.request.contextPath}/member/InquiryDeleteM?i_no=${inquiry.i_no}" class="btn-delete" onclick="return confirm('정말 삭제하시겠습니까?');">삭제</a>
                </td>
            </tr>
            </c:forEach>
            <c:if test="${empty inquiryList}">
            <tr>
                <td colspan="6" class="empty">등록된 문의가 없습니다.</td>
            </tr>
            </c:if>
        </tbody>
    </table>
</div>
<%@ include file="../footer.jsp" %>
</body>
</html>