<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TeaSommelier</title>
<link rel="stylesheet" href="/css/shipAddrManagement.css">
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
                        <td><c:if test="${addrlist.sdefaddr == 'T'}">
        					<img src="/images/main_img/ico_addr_default.png" alt="기본배송지" style="vertical-align: middle; margin-right: 4px;">
    					</c:if>
        					${addrlist.sname}
                        </td>
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