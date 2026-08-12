<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<style>
    .footer-container {
        width: 100%;
        padding: 40px 20px; /* 위아래 여백을 주어 푸터 영역 확보 */
        background-color: #f9f9f9; /* 배경색이 있다면 확인하기 좋음 */
        border-top: 1px solid #ddd;
    }

    .footer-sns {
        display: flex;
        gap: 12px;
        justify-content: flex-end; /* 오른쪽 정렬 */
        align-items: center;
    }

    .footer-sns a {
        display: flex;
        align-items: center;
        justify-content: center;
        width: 50px;
        height: 50px;
        background-color: #ededed;
        border-radius: 50%;
        color: #999999;
        font-size: 20px;
        text-decoration: none;
        transition: all 0.2s ease;
    }
</style>
<div>
	<div class="footer-container">
	<div>
		<table>
			
		</table>
	</div>
	<div class="footer-sns">
            <a href="https://www.kakaocorp.com/" target="_blank" title="카카오톡 채널"><i class="fa-solid fa-comment"></i></a>
            <a href="https://www.naver.com/" target="_blank" title="네이버" style="font-weight: 900; font-family: sans-serif; font-size: 20px;">N</a>
            <a href="https://www.youtube.com/" target="_blank" title="유튜브"><i class="fa-brands fa-youtube"></i></a>
    </div>
    </div>
</div>