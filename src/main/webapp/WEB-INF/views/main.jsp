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
.banner-section {
    width: 100%;
    margin: 40px 0;
}

.banner-list {
    display: flex;
    list-style: none;
    padding: 0;
    margin: 0;
    width: 100%;
}

.banner-item {
    flex: 1;
    overflow: hidden; /* 확대 시 영역 밖으로 이미지가 넘치지 않도록 방지 */
}

/* 링크 전체를 블록 요소 및 기준점으로 설정 */
.banner-link {
    display: block;
    position: relative;
    width: 100%;
    height: 100%;
    text-decoration: none;
    overflow: hidden;
}

/* 이미지 감싸는 영역 */
.banner-img {
    width: 100%;
    height: 100%;
    overflow: hidden;
}

/* 기본 이미지 스타일 및 부드러운 애니메이션 */
.banner-img img {
    width: 100%;
    height: 100%;
    min-height: 520px;
    max-height: 650px;
    object-fit: cover;
    display: block;
    transition: transform 0.5s ease; /* 부드러운 확대 애니메이션 */
}

/* 호버 시 이미지 확대 */
.banner-link:hover .banner-img img {
    transform: scale(1.15);
}

/* 텍스트 & 버튼 오버레이 */
.banner-content {
    position: absolute;
    bottom: 60px;
    left: 50%;
    transform: translateX(-50%);
    display: flex;
    flex-direction: column;
    align-items: center;
    text-align: center;
    width: 100%;
    padding: 0 20px;
    box-sizing: border-box;
    pointer-events: none; /* 클릭 이벤트가 부모 <a>로 전달되도록 설정 */
}

.banner-content {
    color: #ffffff;
    font-size: 24px;
    font-weight: 700;
    line-height: 1.4;
    margin: 0 0 24px 0;
    text-shadow: 0 2px 8px rgba(0, 0, 0, 0.4);
}

/* 더 알아보기 버튼 */
.banner-content .btn-more {
    display: inline-block;
    padding: 12px 30px;
    background-color: rgba(45, 45, 45, 0.85);
    color: #ffffff;
    font-size: 14px;
    font-weight: 500;
    transition: background-color 0.3s;
}

</style>
</head>
<body>
<%@ include file="header.jsp" %>
<div>
	<div class="main-slide">
	</div>
	<div>
		<h1>베스트 상품만 모아서</h1>
	</div>
	<div class="banner-section">
    <ul class="banner-list">
        <li class="banner-item">
            <a href="/guest/productList?productType=%ED%8B%B0%EB%B0%B1" class="banner-link">
                <span class="banner-img">
                    <img src="/images/main_img/bannerL1.jpg" alt="티백">
                </span>
                <span class="banner-content">
                        잎차의 향미 그대로<br>
                        전해지는 100% 순면 티백
                    <span class="btn-more">더 알아보기</span>
                </span>
            </a>
        </li>
        <li class="banner-item">
            <a href="/guest/productList?productType=%EC%9E%8E%EC%B0%A8" class="banner-link">
                <span class="banner-img">
                    <img src="/images/main_img/bannerR1.jpg" alt="잎차">
                </span>
                <span class="banner-content">
                        고품격 잎차의 풍미가 담긴<br>
                        감각적인 디자인 틴
                    <span class="btn-more">더 알아보기</span>
                </span>
            </a>
        </li>
    </ul>
</div>
	<div>
		<h1>다양하게 즐기는 티 세트</h1>
	</div>
</div>
<%@ include file="footer.jsp" %>
</body>
</html>