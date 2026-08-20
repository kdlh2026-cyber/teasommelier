<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TeaSommelier</title>
<style>
	.container {
        max-width: 1400px; /* 전체 너비 제한 */
        margin: 0 auto;    /* 양쪽 여백을 동일하게 주어 가운데 정렬 */
        padding: 40px 20px; /* 상하 40px, 좌우 20px 여백 (화면이 좁아졌을 때 딱 붙지 않게 방지) */
    }
    .container h1 {
        margin-bottom: 30px; /* 원하는 만큼 픽셀(px) 값을 조절하세요 */
    }
    .box {
        background-color: #f7f7f7; /* 밝은 회색 배경 */
        height: 600px;             /* 박스의 고정 높이 (원하는 대로 조절하세요) */
        overflow-y: auto;          /* 내용이 높이를 초과하면 세로 스크롤 생성 */
        padding: 30px 40px;        /* 상하 30px, 좌우 40px 안쪽 여백 */
        color: #555555;            /* 글자 색상 (너무 진하지 않은 회색) */
        font-size: 14px;           /* 글자 크기 */
        line-height: 1.8;          /* 줄 간격 (가독성을 높임) */
        white-space: pre-wrap;     /* 코드 상의 줄바꿈(엔터)을 화면에 그대로 적용 */
    }

    /* 스크롤바 디자인 커스텀 (Webkit 기반 브라우저용: 크롬, 엣지, 사파리 등) */
    .box::-webkit-scrollbar {
        width: 10px;               /* 스크롤바 두께 */
    }
    .box::-webkit-scrollbar-thumb {
        background-color: #999;    /* 스크롤바(잡고 움직이는 부분) 색상 */
        border-radius: 10px;       /* 스크롤바 둥글게 */
        background-clip: padding-box;
        border: 2px solid transparent; /* 여백을 줘서 스크롤바가 너무 두껍지 않게 보이게 함 */
    }
    .box::-webkit-scrollbar-track {
        background-color: transparent; /* 스크롤바 트랙(바탕) 색상 */
    }
</style>
</head>
<body>
<%@ include file="header.jsp" %>
<div class="container">
	<div>
		<h1>이용약관</h1>
	</div>
	<div>
		<%@ include file="guest/TermsofUse.jsp" %>
	</div>
</div>
<%@ include file="footer.jsp" %>
</body>
</html>