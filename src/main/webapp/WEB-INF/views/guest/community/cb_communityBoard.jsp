<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>커뮤니티 게시판</title>
<link rel="stylesheet" href="/css/communityBoard.css">
</head>
<body>
<%@ include file="../../header.jsp" %>
	<div class="community-board">
    <h3 class="board-title">커뮤니티 게시판</h3>

    <div class="board-menu">
        <button class="board-menu-item" onclick="loadTab('/guest/community/cb_brandnoticeList')">브랜드 소식</button>
        <button class="board-menu-item" onclick="loadTab('/guest/community/cb_editorialList')">에디토리얼</button>
        <button class="board-menu-item" onclick="loadTab('/guest/community/cb_reviewList')">리뷰</button>
        <button class="board-menu-item" onclick="loadTab('/guest/community/cb_qnaList')">Q&A</button>
    </div>

    <!-- 비동기로 로드된 리스트가 삽입될 위치 -->
    <div id="board-content-area"></div>
</div>

<script>
function loadTab(url) {
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
    
    // 2. 저장된 URL이 있으면 그 탭을, 없으면 기본값(브랜드소식)을 로드
    const defaultUrl = '/guest/community/cb_brandnoticeList';
    loadTab(savedUrl ? savedUrl : defaultUrl);
});
</script>
<%@ include file="../../footer.jsp" %>
</body>
</html>