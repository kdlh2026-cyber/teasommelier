<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Q&amp;A 답변 작성 폼 페이지</title>
<link rel="stylesheet" href="/css/community-form.css">
</head>
<body>
<%@ include file="../../header.jsp" %>

<div class="form-container">
    <h2>Q&amp;A</h2>
    <p class="form-description">상품문의 답변입니다.</p>

    <form name="qnaResponseInsertForm" method="post" action="/responseInsert">
        <input type="hidden" name="m_no" value="${viewRESdao.m_no}">
        <input type="hidden" name="cb_no" value="${viewRESdao.cb_no}">
        <input type="hidden" name="cb_category" value="${viewRESdao.cb_category}">

        <table class="form-table">
            <tr>
                <th>제목</th>
                <td>
                    <!-- CSS의 select-input-inline, input-select, input-text 클래스 적용 -->
                    <div class="select-input-inline">
                        <select name="cb_qna_category" class="input-select">
                            <option value="상품 문의">상품 문의</option>
                            <option value="배송 문의">배송 문의</option>
                            <option value="교환/반품 문의">교환/반품 문의</option>
                            <option value="기타 문의">기타 문의</option>
                            <option value="카카오페이 문의">카카오페이 문의</option>
                        </select>
                        <input type="text" name="res_subject" value="${viewRESdao.cb_subject}" class="input-text">
                    </div>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <c:set var="cleanContent" value="${fn:replace(viewRESdao.cb_content, '<br>', '&#10;')}" />
                    <c:set var="cleanContent" value="${fn:replace(cleanContent, '<br/>', '&#10;')}" />
                    
                    <textarea name="res_content" class="input-textarea" wrap="hard">[Original Message]
${cleanContent}

</textarea>
                </td>
            </tr>
        </table>
        <div class="btn-group">
            <input type="submit" value="등록" class="btn btn-submit">
            <a href="/guest/community/cb_communityBoard" class="btn btn-cancel" onclick="return confirm('사이트에서 나가시겠습니까?');">취소</a>
            <a href="/guest/community/cb_communityBoard" class="btn btn-cancel">목록</a>
        </div>
    </form>
</div>

<%@ include file="../../footer.jsp" %>
</body>
</html>