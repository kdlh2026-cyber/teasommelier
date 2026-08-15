<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>대량주문문의 수정</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/inquiry.css">
</head>
<body>
<div class="inquiry-container">
    <div class="inquiry-header">
        <h2>대량주문문의 수정</h2>
        <p>등록한 문의 내용을 수정할 수 있습니다.</p>
    </div>
    <form action="${pageContext.request.contextPath}/member/InquiryEditM" method="post">
        <input type="hidden" name="i_no" value="${inquiry.i_no}">
        <table class="inquiry-detail-table">
            <tr>
                <th>문의유형</th>
                <td><input type="text" name="i_type" value="${inquiry.i_type}" required></td>
            </tr>
            <tr>
                <th>제목</th>
                <td><input type="text" name="i_title" value="${inquiry.i_title}" required></td>
            </tr>
            <tr>
                <th>작성자</th>
                <td><input type="text" name="i_name" value="${inquiry.i_name}" required></td>
            </tr>
            <tr>
                <th>이메일</th>
                <td><input type="email" name="i_email" value="${inquiry.i_email}" required></td>
            </tr>
            <tr>
                <th>연락처</th>
                <td><input type="text" name="i_phone" value="${inquiry.i_phone}" required></td>
            </tr>
            <tr>
                <th>문의내용</th>
                <td><textarea name="i_memo" required>${inquiry.i_memo}</textarea></td>
            </tr>
            <tr>
                <th>공개여부</th>
                <td>
                    <select name="i_search">
                        <option value="Y" ${inquiry.i_search == 'Y' ? 'selected' : ''}>공개</option>
                        <option value="N" ${inquiry.i_search == 'N' ? 'selected' : ''}>비공개</option>
                    </select>
                </td>
            </tr>
        </table>
        <div class="detail-buttons">
            <a href="${pageContext.request.contextPath}/member/inquiryDetailM?i_no=${inquiry.i_no}" class="btn-list">취소</a>
            <button type="submit" class="btn-edit">수정</button>
        </div>
    </form>
</div>
</body>
</html>