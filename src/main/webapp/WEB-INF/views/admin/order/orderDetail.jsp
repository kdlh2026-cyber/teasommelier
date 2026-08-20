<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 주문 상세정보 열람</title>
</head>
<body>
<%@ include file="/WEB-INF/views/header.jsp" %>
	<h2>주문 상세 정보</h2>
    <hr>
    <h3>주문 기본 및 결제 정보</h3>
    <table>
        <tr>
            <th>주문번호</th>
            <td>${orderInfo.o_no}</td>
        </tr>
        <tr>
            <th>주문일자</th>
            <td><fmt:formatDate value="${orderInfo.o_date}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
        </tr>
        <tr>
            <th>주문자(id|이름)</th>
            <td>${orderInfo.m_id} | ${orderInfo.m_name}</td>
        </tr>
        <tr>
            <th>결제수단</th>
            <td>${orderInfo.o_pay}</td>
        </tr>
        <tr>
            <th>결제금액</th>
            <td><fmt:formatNumber value="${orderInfo.o_price}" pattern="#,###"/>원</td>
        </tr>
        <tr>
            <th>적립예정금액</th>
            <td><fmt:formatNumber value="${orderInfo.o_earn}" pattern="#,###"/>원</td>
        </tr>
        <tr>
            <th>결제 고유번호(TID)</th>
            <td>${orderInfo.paymentId}</td>
        </tr>
    </table>
	<hr>
    <h3>배송지 정보</h3>
    <table>
        <tr>
            <th>수령인</th>
            <td>${orderInfo.o_name}</td>
        </tr>
        <tr>
            <th>연락처</th>
            <td>${orderInfo.o_phone}</td>
        </tr>
        <tr>
            <th>배송지 주소</th>
            <td>${orderInfo.o_zip} | ${orderInfo.o_addr}</td>
        </tr>
        <tr>
            <th>배송메시지</th>
            <td>${orderInfo.o_message}</td>
        </tr>
    </table>
	<hr>
    <h3>주문 상품 목록</h3>
    <table>
         <tr>
         	<th></th>
            <th>상품명</th>
            <th>수량</th>
            <th>상품 가격</th>
        </tr>
    <c:forEach var="item" items="${orderDetails}">
        <tr>
        	<td><img src="/images/product/${item.p_img}" width="100"></td>
            <td>${item.od_product}</td>
            <td>${item.od_qty}개</td>
            <td><fmt:formatNumber value="${item.od_price}" pattern="#,###"/>원</td>
        </tr>
    </c:forEach>
    </table>
	<hr>
    <div>
        <a href="#" onclick="history.back()">목록으로 돌아가기</a>
    </div>
<%@ include file="/WEB-INF/views/footer.jsp" %>
</body>
</html>