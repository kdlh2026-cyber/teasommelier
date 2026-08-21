<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TeaSommelier</title>
<link rel="stylesheet" href="/css/shipAddrManagement.css.css">
<script>
function goPopup(){
   var pop = window.open("/guest/jusoPopup","pop","width=570,height=420, scrollbars=yes, resizable=yes"); 

}

function jusoCallBack(s_addr1,s_addr2,s_zipno){
   // 팝업페이지에서 주소입력한 정보를 받아서, 현 페이지에 정보를 등록합니다.
   document.shipaddr.s_addr1.value = s_addr1;
   document.shipaddr.s_addr2.value = s_addr2;
   document.shipaddr.s_zipno.value = s_zipno;
}
</script>
</head>
<body>
<%@ include file="/WEB-INF/views/header.jsp" %>
   <div class="addr-form-wrap">
   <div class="addr-form-header">
      <h3>배송주소록 관리</h3>
      <p>자주 쓰는 배송지를 등록 관리하실 수 있습니다.</p>
   </div>
   <form name="shipaddr" method="post" action="/ShippingaddrUpdate">
   <input type="hidden" name="s_no" id="s_no" value="${AddrlistUpdate.s_no}">
   <table>
      <tr>
         <th>
            배송지명<span class="required">*</span>
         </th>
         <td>
            <input type="text" id="s_deliveryname" name="s_deliveryname" value="${AddrlistUpdate.s_deliveryname }">
         </td>
      </tr>
      <tr>
         <th>
            성명<span class="required">*</span>
         </th>
         <td>
            <input type="text" id="s_name" name="s_name" value="${AddrlistUpdate.s_name }">
         </td>
      </tr>
      <tr>
         <th>
            주소<span class="required">*</span>
         </th>
         <td>
            <ul>
            <li>
               <input type="text" name="s_zipno" id="s_zipno" size="5" maxlength="5" readonly placeholder="우편번호" value="${AddrlistUpdate.s_zipno}">   
               <button type="button" class="btn_search" onclick="goPopup();">주소검색</button>
            </li>
            <li>   
               <input type="text" id="s_addr1" name="s_addr1" readonly value="${fn:split(AddrlistUpdate.s_addr, ',')[0]}">
            </li>
            <li>
               <input type="text" id="s_addr2" name="s_addr2" value="${fn:split(AddrlistUpdate.s_addr, ',')[1]}">
            </li>
            </ul>
         </td>
      </tr>
      <tr>
         <th>
            일반전화
         </th>
         <td>
            <select name="s_tel1" id="s_tel1">
                   <option value="02" <c:if test="${fn:split(AddrlistUpdate.s_tel, '-')[0] == '02'}">selected</c:if>>02</option>
                   <option value="031" <c:if test="${fn:split(AddrlistUpdate.s_tel, '-')[0] == '031'}">selected</c:if>>031</option>
                   <option value="032" <c:if test="${fn:split(AddrlistUpdate.s_tel, '-')[0] == '032'}">selected</c:if>>032</option>
                   <option value="033" <c:if test="${fn:split(AddrlistUpdate.s_tel, '-')[0] == '033'}">selected</c:if>>033</option>
                   <option value="041" <c:if test="${fn:split(AddrlistUpdate.s_tel, '-')[0] == '041'}">selected</c:if>>041</option>
                   <option value="042" <c:if test="${fn:split(AddrlistUpdate.s_tel, '-')[0] == '042'}">selected</c:if>>042</option>
                   <option value="043" <c:if test="${fn:split(AddrlistUpdate.s_tel, '-')[0] == '043'}">selected</c:if>>043</option>
                   <option value="044" <c:if test="${fn:split(AddrlistUpdate.s_tel, '-')[0] == '044'}">selected</c:if>>044</option>
                   <option value="051" <c:if test="${fn:split(AddrlistUpdate.s_tel, '-')[0] == '051'}">selected</c:if>>051</option>
                   <option value="052" <c:if test="${fn:split(AddrlistUpdate.s_tel, '-')[0] == '052'}">selected</c:if>>052</option>
                   <option value="053" <c:if test="${fn:split(AddrlistUpdate.s_tel, '-')[0] == '053'}">selected</c:if>>053</option>
                   <option value="054" <c:if test="${fn:split(AddrlistUpdate.s_tel, '-')[0] == '054'}">selected</c:if>>054</option>
                   <option value="055" <c:if test="${fn:split(AddrlistUpdate.s_tel, '-')[0] == '055'}">selected</c:if>>055</option>
                   <option value="070" <c:if test="${fn:split(AddrlistUpdate.s_tel, '-')[0] == '070'}">selected</c:if>>070</option>
            </select>
            <input type="text" id="s_tel2" name="s_tel2" size="4" maxlength="4" value="${fn:split(AddrlistUpdate.s_tel, '-')[1]}">
            <input type="text" id="s_tel3" name="s_tel3" size="4" maxlength="4" value="${fn:split(AddrlistUpdate.s_tel, '-')[2]}">
         </td>
      </tr>
      <tr>
         <th>
            휴대전화<span class="required">*</span>
         </th>
         <td>
            <input type="text" id="s_phone1" name="s_phone1" size="3" maxlength="3" value="010" readonly>-
            <input type="text" id="s_phone2" name="s_phone2" size="4" maxlength="4" value="${fn:split(AddrlistUpdate.s_phone, '-')[1]}">-
            <input type="text" id="s_phone3" name="s_phone3" size="4" maxlength="4" value="${fn:split(AddrlistUpdate.s_phone, '-')[2]}">
            <button type="button" class="">인증번호 받기</button>
         </td>
      </tr>
      <tr>
         <td colspan="2"><input type="checkbox" name="s_defaddr" value="T" ${AddrlistUpdate.s_defaddr == 'T' ? 'checked' : ''}>기본배송지로 저장</td>
      </tr>
   </table>
   <input type="submit" value="등록">
   <input type="button" value="취소" onclick="history.back();">
   </form>
   </div>
<%@ include file="/WEB-INF/views/footer.jsp" %>
</body>
</html>
