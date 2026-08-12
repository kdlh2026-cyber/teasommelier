<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<style>
    .footer-sns {
        display: flex;
        gap: 12px; /* 아이콘끼리 떨어지는 간격 */
        text-align: right;
        position: absolute;
        right: 0;
    }
    .footer-sns a {
        display: flex;
        align-items: center;
        justify-content: center;
        width: 50px;       /* 동그라미 크기 */
        height: 50px;      /* 동그라미 크기 */
        background-color: #ededed; /* 캡처와 유사한 연한 회색 배경 */
        border-radius: 50%; /* 완벽한 동그라미로 만듦 */
        color: #999999;    /* 아이콘 내부 기호 색상 */
        font-size: 20px;   /* 아이콘 기호 크기 */
        text-decoration: none;
        transition: all 0.2s ease;
    }
</style>
<div>
	<div>
	<div class="footer-sns">
            <a href="https://www.kakaocorp.com/" target="_blank" title="카카오톡 채널"><i class="fa-solid fa-comment"></i></a>
            <a href="https://www.naver.com/" target="_blank" title="네이버" style="font-weight: 900; font-family: sans-serif; font-size: 20px;">N</a>
            <a href="https://www.youtube.com/" target="_blank" title="유튜브"><i class="fa-brands fa-youtube"></i></a>
    </div>
    </div>
</div>