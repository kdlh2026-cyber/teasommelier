<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>매장안내</title>

<!-- 카카오맵 JavaScript SDK (autoload=false: 로드 후 수동으로 kakao.maps.load 호출) -->
<script type="text/javascript"
        src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=26a58eff51243ea572aa7258f6dd02fd&autoload=false"></script>

<link rel="stylesheet" href="/css/shop.css">
</head>

<body>
<%@ include file="/WEB-INF/views/header.jsp" %>
<div class="shop-page">
    <!-- 매장 선택 탭 -->
    <div class="shop-tabs">
        <c:forEach var="shop" items="${shopList}" varStatus="status">
            <button type="button"
                    class="tab-btn ${status.first ? 'active' : ''}"
                    data-name="${shop.sh_name}"
                    data-img="${shop.sh_img}"
                    data-lat="${shop.sh_lat}"
                    data-lon="${shop.sh_lon}"
                    onclick="selectShop(this)">
                ${shop.sh_name}
            </button>
        </c:forEach>
    </div>

    <!-- 카테고리 라인 (매장별로 JS에서 갱신) -->
    <div class="shop-category" id="shopCategory"></div>

    <!-- 매장 타이틀 (매장별로 JS에서 갱신) -->
    <div class="shop-title" id="shopTitle"></div>

    <!-- 선택된 매장 이미지 (사진+주소정보 전체 포함) -->
    <div class="shop-img-box">
        <img id="shopImg" src="" alt="매장 정보">
    </div>

    <!-- 카카오맵 (이미지 끝난 바로 다음에 표시) -->
    <div id="map"></div>

</div>


<script>

    // 매장별 카테고리 / 타이틀 (DB 컬럼 없어서 하드코딩)
    function getParameterByName(name) {
        var url = window.location.href;
        name = name.replace(/[\[\]]/g, "\\$&");
        var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"),
            results = regex.exec(url);
        if (!results) return null;
        if (!results[2]) return '';
        return decodeURIComponent(results[2].replace(/\+/g, " "));
    }

    var shopDetailMap = {
    	'센텀시티점': {
             category: 'TEA SALON | TEA BOUTIQUE | TAKEAWAY TEA',
             title: 'TEA SOMMELIER 센텀시티점'
        },
        '광복점': {
             category: 'TEA BOUTIQUE | TAKEAWAY TEA',
             title: 'TEA SOMMELIER 광복점'
        },
        '동래점': {
          	 category: 'TEA SALON | TEA BOUTIQUE',
             title: 'TEA SOMMELIER 동래점'
        },
        '부산본점': {
            category: 'TEA SALON | TEA BOUTIQUE',
            title: 'TEA SOMMELIER 부산본점'
        }
        
    };

    // SDK 로드 후 지도 초기화 (autoload=false 이므로 수동 호출)
    if (typeof kakao !== 'undefined') {
        kakao.maps.load(function () {
            initMap();
        });
    }


    // 지도 관련 전역 변수
    var map;
    var currentMarker = null;

    // 지도 초기화 함수
    function initMap() {

        var container = document.getElementById('map');

        var options = {
            center: new kakao.maps.LatLng(37.5665, 126.9780),
            level: 4
        };

        map = new kakao.maps.Map(container, options);

        // 레이아웃이 늦게 잡히는 문제 방지 - 지도 재정렬
        setTimeout(function () {
            map.relayout();
        }, 300);

        // 페이지 최초 로드 시 첫 번째 매장 자동 선택
      var shopName = getParameterByName('name');
        
        if (shopName) {
            var targetBtn = document.querySelector('.tab-btn[data-name="' + shopName + '"]');
            if (targetBtn) {
                selectShop(targetBtn);
            }
        } else {
            // 파라미터가 없으면 기존처럼 첫 번째 매장 선택
            var firstTab = document.querySelector('.tab-btn');
            if (firstTab != null) {
                selectShop(firstTab);
            }
        }
              
    }


    // 매장 선택 처리 함수
    function selectShop(btn) {

        // 지도가 아직 생성 안 됐으면 무시 (SDK 로드 실패 시 방어)
        if (typeof map === 'undefined' || map == null) {
            return;
        }

        // 탭 active 클래스 갱신
        var tabs = document.querySelectorAll('.tab-btn');
        tabs.forEach(function (t) {
            t.classList.remove('active');
        });
        btn.classList.add('active');

        // 버튼에 담아둔 매장 정보 꺼내기
        var name = btn.getAttribute('data-name');
        var img = btn.getAttribute('data-img');
        var lat = parseFloat(btn.getAttribute('data-lat'));
        var lon = parseFloat(btn.getAttribute('data-lon'));

        // 이미지 경로: static/images/shop/ 폴더 기준
        document.getElementById('shopImg').src = '/images/shop/' + img;

        // 카테고리 / 타이틀 갱신
        var detail = shopDetailMap[name];
        if (detail) {
            document.getElementById('shopCategory').innerText = detail.category;
            document.getElementById('shopTitle').innerText = detail.title;
        } else {
            document.getElementById('shopCategory').innerText = '';
            document.getElementById('shopTitle').innerText = name;
        }

        if (!isNaN(lat) && !isNaN(lon)) {

            var position = new kakao.maps.LatLng(lat, lon);

            // 지도 중심 이동
            map.setCenter(position);

            // 기존 마커 제거 후 새 마커 생성
            if (currentMarker != null) {
                currentMarker.setMap(null);
            }

            currentMarker = new kakao.maps.Marker({
                position: position,
                map: map
            });
        }
    }
</script>
<%@ include file="/WEB-INF/views/footer.jsp" %>
</body>
</html>