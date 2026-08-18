<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>대량주문문의 수정</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/inquiry.css">
</head>
<body>
<div class="inquiry-edit-container">
    <h2 class="page-title">대량주문문의 수정</h2>

    <form action="${pageContext.request.contextPath}/member/InquiryEditM" method="post" enctype="multipart/form-data">

        <input type="hidden" name="i_no" value="${inquiry.i_no}">

        <table class="edit-table">
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
                <th>기존 첨부파일</th>
                <td>${empty inquiry.i_file ? '없음' : inquiry.i_file}</td>
            </tr>
            <tr>
                <th>첨부파일1</th>
                <td><input type="file" name="i_file1"></td>
            </tr>
            <tr>
                <th>첨부파일2</th>
                <td><input type="file" name="i_file2"></td>
            </tr>
            <tr>
                <th>첨부파일3</th>
                <td><input type="file" name="i_file3"></td>
            </tr>
            <tr>
                <th>첨부파일4</th>
                <td><input type="file" name="i_file4"></td>
            </tr>
            <tr>
                <th>첨부파일5</th>
                <td><input type="file" name="i_file5"></td>
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

        <div class="button-area">
            <button type="submit" class="btn btn-submit">수정</button>
            <a href="${pageContext.request.contextPath}/member/inquiryDetailM?i_no=${inquiry.i_no}" class="btn btn-cancel">취소</a>
        </div>

    </form>
</div>
</body>
</html>