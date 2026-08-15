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
        <p>등록한 문의 내용을 확인할 수 있습니다.</p>
    </div>
    <table class="inquiry-detail-table">
        <tr>
            <th>문의번호</th>
            <td>${inquiry.i_no}</td>
            <th>문의유형</th>
            <td>${inquiry.i_type}</td>
        </tr>
        <tr>
            <th>작성자</th>
            <td>${inquiry.i_name}</td>
            <th>회원아이디</th>
            <td>${inquiry.m_id}</td>
        </tr>
        <tr>
            <th>이메일</th>
            <td>${inquiry.i_email}</td>
            <th>연락처</th>
            <td>${inquiry.i_phone}</td>
        </tr>
        <tr>
            <th>제목</th>
            <td colspan="3">${inquiry.i_title}</td>
        </tr>
        <tr>
            <th>문의내용</th>
            <td colspan="3" class="memo-cell">${inquiry.i_memo}</td>
        </tr>
        <tr>
            <th>첨부파일</th>
            <td colspan="3">
                <c:choose>
                    <c:when test="${not empty inquiry.i_file}">
                        <c:forEach var="file" items="${inquiry.i_file.split(',')}">
                            <a href="${pageContext.request.contextPath}/images/inquiry/${file}" target="_blank">${file}</a><br>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        첨부파일 없음
                    </c:otherwise>
                </c:choose>
            </td>
        </tr>
        <tr>
            <th>답변상태</th>
            <td colspan="3">
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
            <td colspan="3" class="memo-cell">${inquiry.i_define}</td>
        </tr>
    </table>
    <div class="detail-buttons">
        <a href="${pageContext.request.contextPath}/member/inquiryListM" class="btn-list">목록</a>
        <a href="${pageContext.request.contextPath}/member/inquiryEditFormM?i_no=${inquiry.i_no}" class="btn-edit">수정</a>
        <a href="${pageContext.request.contextPath}/member/InquiryDeleteM?i_no=${inquiry.i_no}" class="btn-delete" onclick="return confirm('정말 삭제하시겠습니까?');">삭제</a>
    </div>
</div>
</body>
</html>