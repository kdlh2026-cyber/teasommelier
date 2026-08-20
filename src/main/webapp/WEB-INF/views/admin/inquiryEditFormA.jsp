<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>대량주문문의 수정</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/inquiry.css">
</head>
<body>
<%@ include file="../header.jsp" %>
<div class="inquiry-edit-container">
    <h2 class="page-title">대량주문문의 수정</h2>

    <form action="${pageContext.request.contextPath}/admin/InquiryEditA" method="post">

        <input type="hidden" name="i_no" value="${inquiry.i_no}">

        <table class="edit-table">
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

            <!-- 개인정보동의: 읽기전용 표시만, 수정폼 제출대상 아님 -->
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
            	<th>첨부파일1</th>
            	<td><input type="image" name="i_img" value="${inquiry.i_img}"></td>
            </tr>
            <tr>
            	<th>첨부파일2</th>
            	<td><input type="image" name="i_img" value="${inquiry.i_img}"></td>
            </tr>
            <tr>
            	<th>첨부파일3</th>
            	<td><input type="image" name="i_img" value="${inquiry.i_img}"></td>
            </tr>
            <tr>
            	<th>첨부파일4</th>
            	<td><input type="image" name="i_img" value="${inquiry.i_img}"></td>
            </tr>
            <tr>
            	<th>첨부파일5</th>
            	<td><input type="image" name="i_img" value="${inquiry.i_img}"></td>
            </tr>
            <tr>

            <!-- 실제 수정 가능 항목: 답변상태 + 답변내용 -->
            <tr>
                <th>답변상태</th>
                <td>
                    <select name="i_reply" class="reply-select">
                        <option value="N" ${inquiry.i_reply == 'N' ? 'selected' : ''}>답변대기</option>
                        <option value="Y" ${inquiry.i_reply == 'Y' ? 'selected' : ''}>답변완료</option>
                    </select>
                </td>
            </tr>
            <tr>
                <th>답변내용</th>
                <td>
                    <textarea name="i_answer" class="reply-textarea">${inquiry.i_answer}</textarea>
                </td>
            </tr>
        </table>

        <div class="button-area">
            <button type="submit" class="btn btn-submit">저장</button>
            <a href="${pageContext.request.contextPath}/admin/inquiryDetailA?i_no=${inquiry.i_no}" class="btn btn-cancel">취소</a>
        </div>

    </form>
</div>
<%@ include file="../footer.jsp" %>
</body>
</html>