<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>대량주문문의 상세</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/inquiry.css">
</head>
<body>
<div class="inquiry-container">
    <div class="inquiry-header">
        <h2>대량주문문의 상세</h2>
    </div>

    <table class="inquiry-detail-table">
        <tr>
            <th>문의유형</th>
            <td>${inquiry.i_type}</td>
        </tr>
        <tr>
            <th>제목</th>
            <td>${inquiry.i_title}</td>
        </tr>
        <tr>
            <th>상품/주문검색</th>
            <td>${inquiry.i_search}</td>
        </tr>
        <tr>
            <th>작성자</th>
            <td>${inquiry.i_name}</td>
        </tr>
        <tr>
            <th>이메일</th>
            <td>${inquiry.i_email}</td>
        </tr>
        <tr>
            <th>연락처</th>
            <td>${inquiry.i_phone}</td>
        </tr>
        <tr>
            <th>내용</th>
            <td class="memo-cell">${inquiry.i_memo}</td>
        </tr>
        <c:if test="${not empty inquiry.i_file}">
            <tr>
                <th>첨부파일</th>
                <td>${inquiry.i_file}</td>
            </tr>
        </c:if>
        <tr>
            <th>개인정보동의</th>
            <td>
                <c:choose>
                    <c:when test="${inquiry.i_define == 'Y'}">동의</c:when>
                    <c:otherwise>미동의</c:otherwise>
                </c:choose>
            </td>
        </tr>
        <tr>
            <th>답변상태</th>
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
        </tr>
        <tr>
            <th>답변내용</th>
            <td class="memo-cell">${inquiry.i_answer}</td>
        </tr>
    </table>

    <div class="detail-buttons">
        <a href="${pageContext.request.contextPath}inquiryEditFormM?i_no=${inquiry.i_no}" class="btn-edit">수정</a>
        <a href="${pageContext.request.contextPath}/admin/inquiryListA" class="btn-list">목록</a>
    </div>
</div>
</body>
</html>