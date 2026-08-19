<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
document.addEventListener("DOMContentLoaded", function() {
    // 현재 접속 중인 페이지의 전체 URL 가져오기
    const currentUrl = window.location.href;
    
    // 메뉴 안의 모든 a 태그 가져오기
    const menuLinks = document.querySelectorAll('.mypage-menu li a');
    
    menuLinks.forEach(link => {
        // a 태그의 href 속성값 가져오기
        let href = link.getAttribute('href');
        
        // 상대경로("../")를 제거하여 순수 경로만 추출 
        href = href.replace("../", "");
        
        // 현재 URL 주소에 해당 경로가 포함되어 있다면 (현재 페이지라면)
        if (currentUrl.includes(href)) {
            // 부모 태그인 <li>에 'active' 클래스 추가
            link.parentElement.classList.add('active');
        }
    });
});
</script>
<style>
/* 메뉴 전체 컨테이너 설정 */
.mypage-menu {
    display: flex;
    width: 100%;
    max-width: 1400px;               /* 전체 본문 최대 너비(1200px)와 동일하게 제한 */
    margin: 40px auto;               /* 화면 중앙 정렬 */
    padding: 0;
    list-style: none;
    box-sizing: border-box;
}

/* 각 리스트 항목 설정 */
.mypage-menu li {
    flex: 1;                         /* 고정 px 대신 6개 메뉴가 균등하게 1/6씩 차지 */
    box-sizing: border-box;
    border-top: 2px solid #888;      
    border-bottom: 1px solid #ddd;   
    border-right: 1px solid #ddd;    
}

/* 첫 번째 항목의 왼쪽 테두리 */
.mypage-menu li:first-child {
    border-left: 1px solid #ddd;
}

/* 링크 텍스트 설정 */
.mypage-menu li a {
    display: block;                  
    padding: 16px 0;
    text-align: center;              
    text-decoration: none;           
    color: #555;                     
    font-size: 16px;                 
    background-color: #fff;          
}

/* 활성화된 메뉴 디자인 */
.mypage-menu li.active a {
    background-color: #1a1a1a;       
    color: #ffffff;                  
    font-weight: bold;               
}
</style>
<ul class="mypage-menu">
	<li>
		<a href="/member/orderList">주문조회</a>
	</li>
	<li>
		<a href="/myFavorite?m_no=${sessionScope.loginMember.m_no}">관심상품</a>
	</li>
	<li>
		<a href="/member/mypage/MemberCash">적립금</a>
	</li>
	<li>
		<a href="/member/mypage/CommunityManagement">게시물관리</a>
	</li>
	<li>
		<a href="/member/mypage/ShipaddrManagement">배송주소관리</a>
	</li>
	<li>
		<a href="/member/mypage/InqiryManagement">대량구매문의 관리</a>
	</li>
</ul>