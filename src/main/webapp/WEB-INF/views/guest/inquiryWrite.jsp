<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>대량 문의</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/inquiryWrite.css">
</head>
<body>
<%@ include file="/WEB-INF/views/header.jsp" %>

<div class="inquiry-page-wrap">
    <div class="inquiry-page-title"><h2>대량 주문 &amp; BtoB 문의</h2></div>

    <form id="inquiryForm" method="post" action="${pageContext.request.contextPath}/guest/InquiryWrite" enctype="multipart/form-data">
        <input type="hidden" id="p_no" name="p_no" value="${empty param.p_no ? 0 : param.p_no}">

        <div class="inquiry-board-label">견적 게시판</div>

        <table class="inquiry-table">
            <tbody>
                <tr>
                    <th>질문유형</th>
                    <td>
                        <select name="i_type">
                            <option value="상품문의">상품문의</option>
                            <option value="주문문의">주문문의</option>
                            <option value="대량주문문의" selected>대량주문문의</option>
                            <option value="기타문의">기타문의</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <th>문의제목</th>
                    <td><input type="text" name="i_title" maxlength="50" required></td>
                </tr>
                <tr>
                    <th>상품 / 주문 검색</th>
                    <td>
                        <input type="text" id="i_search" name="i_search" placeholder="상품명 또는 주문번호로 검색" readonly>
                        <button type="button" class="btn-search" onclick="openSearchModal()">검색</button>
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
                    <td><input type="email" name="i_email" maxlength="50" placeholder="예) master@domain.com"></td>
                </tr>
                <tr>
                    <th>휴대폰</th>
                    <td><input type="tel" name="i_phone" maxlength="20" placeholder="예) 010-0000-0000"></td>
                </tr>
                <tr>
                    <th>작성자 <span class="required-dot">•</span></th>
                    <td><input type="text" name="i_name" maxlength="30" required></td>
                </tr>
                <tr>
                    <th>내용 <span class="required-dot">•</span></th>
                    <td><textarea name="i_memo" rows="8" maxlength="1000" required></textarea></td>
                </tr>
                <tr><th>첨부파일1</th><td><input type="file" name="i_file1"></td></tr>
                <tr><th>첨부파일2</th><td><input type="file" name="i_file2"></td></tr>
                <tr><th>첨부파일3</th><td><input type="file" name="i_file3"></td></tr>
                <tr><th>첨부파일4</th><td><input type="file" name="i_file4"></td></tr>
                <tr><th>첨부파일5</th><td><input type="file" name="i_file5"></td></tr>
                <tr>
                    <th>개인정보 수집 및<br>이용 동의 <span class="required-dot">•</span></th>
                    <td>
                        <div class="privacy-notice">문의 접수를 위해 개인정보를 수집 및 이용합니다.</div>
                        <label><input type="radio" name="i_define" value="Y"> 동의함</label>
                        <label><input type="radio" name="i_define" value="N" checked> 동의안함</label>
                    </td>
                </tr>
            </tbody>
        </table>

        <div class="inquiry-btn-area"><button type="submit" class="btn-submit">등록</button></div>
    </form>
</div>

<div class="search-modal-overlay" id="searchModalOverlay">
    <div class="search-modal">
        <div class="search-modal-header">
            <span>상품 / 주문 검색</span>
            <button type="button" class="modal-close" onclick="closeSearchModal()">×</button>
        </div>

        <div class="search-modal-tabs">
            <button type="button" class="modal-tab active" data-tab="order" onclick="switchTab('order')">주문번호</button>
            <button type="button" class="modal-tab" data-tab="product" onclick="switchTab('product')">상품</button>
        </div>

        <div class="search-modal-body">
            <div class="search-modal-panel active" id="panel-order">
                <div class="search-modal-row">
                    <input type="text" id="orderKeyword" placeholder="주문번호 입력">
                    <button type="button" onclick="searchOrder()">검색</button>
                </div>
                <div class="search-modal-results" id="orderResults">
                    <div class="search-modal-empty">주문번호를 입력하고 검색해주세요.</div>
                </div>
            </div>

            <div class="search-modal-panel" id="panel-product">
                <div class="search-modal-row">
                    <input type="text" id="productKeyword" placeholder="상품명 입력">
                    <button type="button" onclick="searchProduct()">검색</button>
                </div>
                <div class="search-modal-results" id="productResults">
                    <div class="search-modal-empty">상품명을 입력하고 검색해주세요.</div>
                </div>
            </div>
        </div>

        <div class="search-modal-footer"><button type="button" onclick="closeSearchModal()">닫기</button></div>
    </div>
</div>

<script>
var contextPath = "${pageContext.request.contextPath}";

function openSearchModal() {
    document.getElementById('searchModalOverlay').classList.add('open');
}

function closeSearchModal() {
    document.getElementById('searchModalOverlay').classList.remove('open');
}

function switchTab(tab) {
    document.querySelectorAll('.modal-tab').forEach(function(btn) {
        btn.classList.toggle('active', btn.getAttribute('data-tab') === tab);
    });
    document.querySelectorAll('.search-modal-panel').forEach(function(panel) {
        panel.classList.remove('active');
    });
    document.getElementById('panel-' + tab).classList.add('active');
}

function pickResult(text, p_no) {
    document.getElementById('p_no').value = p_no;
    document.getElementById('i_search').value = text;
    closeSearchModal();
}

function searchOrder() {
    var keyword = document.getElementById('orderKeyword').value.trim();
    var resultBox = document.getElementById('orderResults');

    if (!keyword) {
        resultBox.innerHTML = '<div class="search-modal-empty">주문번호를 입력해주세요.</div>';
        return;
    }

    resultBox.innerHTML = '<div class="search-modal-empty">주문번호 조회 기능은 아직 연결 전이에요.</div>';
}

function searchProduct() {
    var keyword = document.getElementById('productKeyword').value.trim();
    var resultBox = document.getElementById('productResults');

    if (!keyword) {
        resultBox.innerHTML = '<div class="search-modal-empty">상품명을 입력해주세요.</div>';
        return;
    }

    resultBox.innerHTML = '<div class="search-modal-empty">검색 중...</div>';

    fetch(contextPath + '/guest/productSearch?keyword=' + encodeURIComponent(keyword))
        .then(function(res) {
            if (!res.ok) throw new Error('상품 검색 실패');
            return res.json();
        })
        .then(function(list) {
            if (!list || list.length === 0) {
                resultBox.innerHTML = '<div class="search-modal-empty">검색 결과가 없습니다.</div>';
                return;
            }

            var html = '';

            list.forEach(function(p) {
                var priceText = p.p_price != null ? Number(p.p_price).toLocaleString() + '원' : '';
                var name = String(p.p_name || '').replace(/\\/g, '\\\\').replace(/'/g, "\\'");

                html += '<div class="result-item" onclick="pickResult(\'' + name + '\', ' + p.p_no + ')">';
                html += '상품번호 : ' + p.p_no + ' / ';
                html += p.p_name;
                if (priceText) html += ' - ' + priceText;
                html += '</div>';
            });

            resultBox.innerHTML = html;
        })
        .catch(function(error) {
            console.error(error);
            resultBox.innerHTML = '<div class="search-modal-empty">상품 검색 중 오류가 발생했습니다.</div>';
        });
}

document.getElementById('inquiryForm').addEventListener('submit', function(e) {
    var agreed = document.querySelector('input[name="i_define"]:checked');

    if (!agreed || agreed.value !== 'Y') {
        e.preventDefault();
        alert('개인정보 수집 및 이용에 동의해야 등록할 수 있습니다.');
    }
});

document.getElementById('searchModalOverlay').addEventListener('click', function(e) {
    if (e.target === this) closeSearchModal();
});
</script>
<%@ include file="/WEB-INF/views/footer.jsp" %>
</body>
</html>