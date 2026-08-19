<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TeaSommelier</title>
<script>
document.addEventListener('DOMContentLoaded', () => {
    const slider = document.getElementById('slideTrack');
    let isDown = false;
    let startX;
    let autoSlideInterval;
    let isAnimating = false;

    // 한 방향(오른쪽)으로만 무한 슬라이드 되도록 처리하는 함수
    function moveToNextSlide() {
        if (isAnimating) return;
        isAnimating = true;

        slider.scrollTo({ left: slider.clientWidth, behavior: 'smooth' });

        setTimeout(() => {
            slider.classList.add('dragging');
            slider.appendChild(slider.firstElementChild);
            slider.scrollLeft = 0;
            
           	requestAnimationFrame(() => {
                slider.classList.remove('dragging');
                isAnimating = false;
            });
        }, 600); 
    }

    // 자동 슬라이드 시작
    function startAutoSlide() {
        clearInterval(autoSlideInterval);
        autoSlideInterval = setInterval(moveToNextSlide, 3000);
    }

    // 자동 슬라이드 정지
    function stopAutoSlide() {
        clearInterval(autoSlideInterval);
    }

    // --- 개선된 마우스 드래그 컨트롤 ---

    // 1. 슬라이드 안에서 마우스를 꾹 눌렀을 때
    slider.addEventListener('mousedown', (e) => {
        if (isAnimating) return; 
        
        // 브라우저가 링크(a)를 강제로 드래그하려는 기본 동작을 원천 차단
        e.preventDefault(); 
        
        isDown = true;
        slider.classList.add('dragging');
        startX = e.pageX;
        stopAutoSlide(); // 꾹 누르고 있는 동안에는 자동 슬라이드가 완전히 멈춤
    });

    // 마우스가 슬라이드 밖으로 삐져나가도 드래그가 끊기지 않도록 'window'에서 감지
    window.addEventListener('mousemove', (e) => {
        if (!isDown || isAnimating) return;
        e.preventDefault();
        
        const walk = startX - e.pageX; 
        
        // 왼쪽으로 드래그(이전 장으로 돌아가기) 방지
        if (walk < 0) {
            slider.scrollLeft = 0;
        } else {
            slider.scrollLeft = walk; 
        }
    });

    // 클릭을 떼는 동작도 'window' 전체에서 감지
    window.addEventListener('mouseup', (e) => {
        if (!isDown) return;
        isDown = false;
        slider.classList.remove('dragging');
        
        const dragDistance = startX - e.pageX;
        
        if (dragDistance > 100) {
            moveToNextSlide();
        } else {
            slider.scrollTo({ left: 0, behavior: 'smooth' });
        }
        
        startAutoSlide(); // 드래그가 끝난 후 다시 3초 자동 슬라이드 재시작
    });

    // --- a 태그(링크) 오작동 방지 ---
    let dragStartX = 0;
    slider.addEventListener('mousedown', (e) => { dragStartX = e.pageX; });
    slider.querySelectorAll('a').forEach(link => {
        link.addEventListener('click', (e) => {
            // 마우스를 10px 이상 끌었다면 드래그로 간주하고 링크 이동을 취소
            if (Math.abs(dragStartX - e.pageX) > 10) {
                e.preventDefault(); 
            }
        });
    });

    // 페이지 로드 시 최초 자동 실행
    startAutoSlide();
});
</script>
<link rel="stylesheet" href="css/main.css">
</head>
<body>
<%@ include file="header.jsp" %>
<div>
	<div class="main-slide" id="main-slide">
	    <div id="slideTrack">
	        <div class="slide-item"><a href="">
	            <img src="/images/main_img/main_5-1.jpg" alt="메인이미지1">
	            </a>
	        </div>
	        <div class="slide-item">
	        	<a href="">
	            <img src="/images/main_img/main_5_0.jpg" alt="메인이미지2">
	            </a>
	        </div>
	    </div>
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
	
	<div class="product">
		<h2>다양하게 즐기는 티 세트</h2>
    	<%@ include file="guest/productMain.jsp" %>
	</div>
</div>
<%@ include file="footer.jsp" %>
</body>
</html>