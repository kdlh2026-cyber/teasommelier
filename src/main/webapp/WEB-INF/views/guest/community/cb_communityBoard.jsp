<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>커뮤니티 게시판</title>
<link rel="stylesheet" href="/css/communityBoard.css">
<link rel="stylesheet" href="/css/cb.css">
<link rel="stylesheet" href="/css/review.css">
<link rel="stylesheet" href="/css/qna.css">
</head>
<body>
<%@ include file="../../header.jsp" %>
	<div class="community-board">
    <h3 class="board-title">커뮤니티 게시판</h3>

    <div class="board-menu">
        <button class="board-menu-item" data-url="/guest/community/cb_brandnoticeList" onclick="loadTab(this)">브랜드 소식</button>
        <button class="board-menu-item" data-url="/guest/community/cb_editorialList" onclick="loadTab(this)">에디토리얼</button>
        <button class="board-menu-item" data-url="/guest/community/cb_reviewList" onclick="loadTab(this)">리뷰</button>
        <button class="board-menu-item" data-url="/guest/community/cb_qnaList" onclick="loadTab(this)">Q&A</button>
    </div>

    <!-- 비동기로 로드된 리스트가 삽입될 위치 -->
    <div id="board-content-area"></div>
</div>

<script>
function loadTab(btn) {
    const url = btn.dataset.url;

    // 클릭한 버튼만 active, 나머지는 해제
    document.querySelectorAll('.board-menu-item').forEach(el => el.classList.remove('active'));
    btn.classList.add('active');

    // 1. 현재 로드하는 URL을 sessionStorage에 저장
    sessionStorage.setItem('lastCommunityTab', url);

    // 2. AJAX 요청으로 콘텐츠 로드
    fetch(url)
        .then(response => response.text())
        .then(html => {
            document.getElementById('board-content-area').innerHTML = html;
        })
        .catch(err => console.error('Error loading tab:', err));
}

document.addEventListener('DOMContentLoaded', () => {
    // 1. 세션에 저장된 마지막 탭 URL을 가져옴
    const savedUrl = sessionStorage.getItem('lastCommunityTab');
    const defaultUrl = '/guest/community/cb_brandnoticeList';
    const targetUrl = savedUrl ? savedUrl : defaultUrl;

    // 2. URL에 해당하는 버튼을 찾아서 active 처리 + 로드
    const targetBtn = Array.from(document.querySelectorAll('.board-menu-item'))
        .find(el => el.dataset.url === targetUrl);

    if (targetBtn) {
        loadTab(targetBtn);
    }
});
</script>
<%@ include file="../../footer.jsp" %>
</body>
</html>
