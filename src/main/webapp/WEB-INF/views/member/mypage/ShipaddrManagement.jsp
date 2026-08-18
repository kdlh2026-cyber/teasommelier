<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TeaSommelier</title>
<style>
/* 컨테이너 및 기본 설정 */
.addr-container {
    max-width: 1400px; 
    margin: 40px auto;
    padding: 0 20px;
    box-sizing: border-box;
    font-family: 'Pretendard', -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
    color: #333;
}

/* 상단 타이틀 영역 */
.addr-header {
    display: flex;
    align-items: center;
    gap: 15px;
    margin-bottom: 25px;
}

.addr-header h3 {
    font-size: 24px;
    font-weight: 700;
    margin: 0;
    color: #111;
}

.addr-header p {
    font-size: 14px;
    color: #888;
    margin: 0;
    padding-left: 15px;
    border-left: 1px solid #ddd;
    line-height: 1.2;
}

/* 테이블 스타일 */
.addr-table {
    width: 100%;
    border-collapse: collapse;
    border-top: 1px solid #e5e5e5;
    border-bottom: 1px solid #e5e5e5;
    text-align: center;
    font-size: 13px;
}

.addr-table th {
    background-color: #fafafa;
    color: #555;
    font-weight: 600;
    padding: 16px 10px;
    border-bottom: 1px solid #eee;
}

.addr-table td {
    padding: 18px 10px;
    color: #444;
    border-bottom: 1px solid #f2f2f2;
    vertical-align: middle;
}

.addr-table tr:last-child td {
    border-bottom: none;
}

/* 체크박스 정렬 */
.addr-table input[type="checkbox"] {
    cursor: pointer;
    width: 15px;
    height: 15px;
}

/* 주소 열 좌측 정렬 */
.addr-table td.td-addr {
    text-align: left;
    padding-left: 20px;
}

/* 버튼 영역 및 스타일 */
.addr-actions {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-top: 25px;
}

/* 삭제 버튼 (좌측 외곽선 버튼) */
.btn-delete {
    padding: 8px 16px;
    background-color: #fff;
    border: 1px solid #ccc;
    color: #333;
    font-size: 13px;
    cursor: pointer;
    transition: all 0.2s ease;
}

.btn-delete:hover {
    background-color: #f8f8f8;
    border-color: #999;
}

/* 배송지 등록 버튼 (우측 검정 버튼) */
.btn-submit {
    padding: 10px 24px;
    background-color: #111;
    border: 1px solid #111;
    color: #fff;
    font-size: 13px;
    font-weight: 500;
    cursor: pointer;
    transition: background-color 0.2s ease;
}

.btn-submit:hover {
    background-color: #333;
    border-color: #333;
}

/* 테이블 내 수정 버튼 */
.btn-edit {
    padding: 4px 10px;
    background-color: #fff;
    border: 1px solid #ccc;
    color: #555;
    font-size: 12px;
    cursor: pointer;
}

.btn-edit:hover {
    background-color: #f5f5f5;
}
</style>
<script>
function checkAll(main) {
    const checkboxes = document.getElementsByName('addr_chk');
    checkboxes.forEach((checkbox) => {
        checkbox.checked = main.checked;
    });
}

function deleteSelected() {
    const checkedList = document.querySelectorAll('input[name="addr_chk"]:checked');
    if (checkedList.length === 0) {
        alert("삭제할 배송지를 최소 하나 이상 선택해주세요.");
        return;
    }
    
    if (confirm("선택한 배송지를 삭제하시겠습니까?")) {
        const form = document.getElementById('shipaddrlist');
        form.action = "${pageContext.request.contextPath}/ShippingaddrDelete";
        form.method = "post";
        form.submit();
    }
}
</script>
</head>
<body>
<%@ include file="/WEB-INF/views/header.jsp" %>

<div class="addr-container">
    <div>
        <%@ include file ="Mymenu.jsp" %> 
    </div>
    
    <div class="addr-header">
        <h3>배송 주소록 관리</h3>
        <p>자주 쓰는 배송지를 등록 관리하실 수 있습니다.</p>
    </div>
    
    <form name="shipaddrlist" id="shipaddrlist" method="post" action="../mypage/ShipaddrWriteForm">
        <input type="hidden" name="m_no" id="m_no" value="${m_dto.m_no}">
        
        <div>
            <table class="addr-table">
                <colgroup>
                    <col style="width: 50px;">
                    <col style="width: 120px;">
                    <col style="width: 100px;">
                    <col style="width: 120px;">
                    <col style="width: 140px;">
                    <col style="width: auto;">
                    <col style="width: 80px;">
                </colgroup>
                <thead>
                    <tr>
                        <th><input type="checkbox" name="all_chk" onclick="checkAll(this)"></th>
                        <th>배송지명</th>
                        <th>수령인</th>
                        <th>일반전화</th>
                        <th>휴대전화</th>
                        <th>주소</th>
                        <th>수정</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="addrlist" items="${ShippingaddrList}">
                    <tr>
                        <td><input type="checkbox" name="addr_chk" value="${addrlist.sno}"></td>
                        <td>${addrlist.sdeliveryname}</td>
                        <td>${addrlist.sname}</td>
                        <td>${addrlist.stel}</td>
                        <td>${addrlist.sphone}</td>
                        <td class="td-addr">${fn:replace(addrlist.saddr, ',',' ')}</td>
                        <td>
                            <input type="hidden" value="${addrlist.mid}">
                            <input type="button" class="btn-edit" value="수정" onclick="location.href='${pageContext.request.contextPath}/member/mypage/ShippingaddrUpdateForm?s_no=${addrlist.sno}'">
                        </td>
                    </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
        
        <div class="addr-actions">
            <input type="button" class="btn-delete" value="선택 주소록 삭제" onclick="deleteSelected();">
            <input type="submit" class="btn-submit" value="배송지등록">
        </div>
    </form>
</div>

<%@ include file="/WEB-INF/views/footer.jsp" %>
</body>
</html>