<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>대량 문의</title>
</head>
<body>
<div class="inquiry-page-wrap">

    <div class="inquiry-page-title">
        <h2>대량 주문 &amp; BtoB 문의</h2>
    </div>

    <form id="inquiryForm" method="post"
          action="${pageContext.request.contextPath}/inquiry/write.do"
          enctype="multipart/form-data">

        <input type="hidden" name="p_no" value="${param.p_no}">

        <div class="inquiry-board-label">
            견적 게시판
        </div>

        <table class="inquiry-table">
            <tbody>

                <tr>
                    <th>질문유형</th>
                    <td>
                        <select name="i_type">
                            <option value="상품문의">상품문의</option>
                            <option value="주문문의">주문문의</option>
                            <option value="대량주문문의">대량주문문의</option>
                            <option value="기타문의">기타문의</option>
                        </select>
                    </td>
                </tr>

                <tr>
                    <th>문의제목</th>
                    <td><input type="text" name="i_title" maxlength="100"></td>
                </tr>

                <tr>
                    <th>상품 / 주문 검색</th>
                    <td>
                        <input type="text" name="i_search" placeholder="상품명 또는 주문번호로 검색">
                        <button type="button" class="btn-search">검색</button>
                    </td>
                </tr>

                <tr>
                    <th>답변수신방식</th>
                    <td>
                        <label><input type="radio" name="i_reply" value="이메일" checked> 이메일</label>
                        <label><input type="radio" name="i_reply" value="SMS"> SMS</label>
                        <label><input type="radio" name="i_reply" value="이메일+SMS"> 이메일+SMS</label>
                    </td>
                </tr>

                <tr>
                    <th>이메일</th>
                    <td><input type="email" name="i_email" placeholder="예) master@domain.com"></td>
                </tr>

                <tr>
                    <th>휴대폰</th>
                    <td><input type="tel" name="i_phone" placeholder="예) 000-0000-0000"></td>
                </tr>

                <tr>
                    <th>작성자 <span class="required-dot">•</span></th>
                    <td><input type="text" name="i_name" required></td>
                </tr>

                <tr>
                    <th>내용 <span class="required-dot">•</span></th>
                    <td><textarea name="i_memo" rows="8" required></textarea></td>
                </tr>

                <tr><th>첨부파일1</th><td><input type="file" name="i_file1"></td></tr>
                <tr><th>첨부파일2</th><td><input type="file" name="i_file2"></td></tr>
                <tr><th>첨부파일3</th><td><input type="file" name="i_file3"></td></tr>
                <tr><th>첨부파일4</th><td><input type="file" name="i_file4"></td></tr>
                <tr><th>첨부파일5</th><td><input type="file" name="i_file5"></td></tr>

                <tr>
                    <th>개인정보 수집 및<br>이용 동의</th>
                    <td>
                        <div class="privacy-notice">
                            
                        </div>
                        <label><input type="radio" name="i_define" value="Y"> 동의함</label>
                        <label><input type="radio" name="i_define" value="N" checked> 동의안함</label>
                    </td>
                </tr>

            </tbody>
        </table>

        <div class="inquiry-btn-area">
            <button type="submit" class="btn-submit">등록</button>
        </div>

    </form>

</div>
</body>
</html>