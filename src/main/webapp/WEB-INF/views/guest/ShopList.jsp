<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>매장안내</title>

<!-- 카카오맵 JavaScript SDK -->
<script type="text/javascript"
        src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=26a58eff51243ea572aa7258f6dd02fd"></script>

<style>
    /* 카카오맵 크기 */
    #map {
        width: 100%;
        height: 500px;
        margin-bottom: 30px;
    }

    .shop-page {
        width: 1200px;
        margin: 30px auto;
    }

    .shop-table {
        width: 100%;
    }

    .table-row {
        display: grid;
        grid-template-columns: 150px 1fr 250px 100px;
        align-items: center;
        border-bottom: 1px solid #ddd;
        min-height: 100px;
    }

    .table-row.header {
        min-height: 50px;
        background-color: #f5f5f5;
        font-weight: bold;
    }

    .col {
        padding: 10px;
        text-align: center;
    }

    .img-box {
        width: 100px;
        height: 70px;
        object-fit: cover;
    }
</style>

</head>

<body>

<div class="shop-page">

    <h2>매장안내</h2>

    <!-- 카카오맵 -->
    <div id="map"></div>


    <!-- 매장 목록 -->
    <div class="shop-table">

        <div class="table-row header">
            <div class="col">이미지</div>
            <div class="col">매장명</div>
            <div class="col">위치(위도/경도)</div>
            <div class="col">상세보기</div>
        </div>

        <c:forEach var="shop" items="${shopList}">

            <div class="table-row">

                <div class="col">
                    <img class="img-box"
                         src="${shop.sh_img}"
                         alt="${shop.sh_name}">
                </div>

                <div class="col">
                    ${shop.sh_name}
                </div>

                <div class="col">
                    ${shop.sh_lat}, ${shop.sh_lon}
                </div>

                <div class="col">
                    <a href="/guest/shopDetail?sh_no=${shop.sh_no}">
                        보기
                    </a>
                </div>

            </div>

        </c:forEach>

    </div>

</div>


<script>

    // 지도 표시 영역
    var container = document.getElementById('map');

    // 기본 지도 위치
    var options = {
        center: new kakao.maps.LatLng(37.5665, 126.9780),
        level: 7
    };

    // 지도 생성
    var map = new kakao.maps.Map(container, options);


    // 지도 범위
    var bounds = new kakao.maps.LatLngBounds();


    <c:forEach var="shop" items="${shopList}">

        var lat = parseFloat("${shop.sh_lat}");
        var lon = parseFloat("${shop.sh_lon}");

        if (!isNaN(lat) && !isNaN(lon)) {

            var position = new kakao.maps.LatLng(lat, lon);

            // 마커 생성
            var marker = new kakao.maps.Marker({
                position: position,
                map: map
            });

            // 지도 범위에 추가
            bounds.extend(position);

        }

    </c:forEach>


    // 매장이 있으면 모든 매장이 보이도록 지도 이동
    <c:if test="${not empty shopList}">
        map.setBounds(bounds);
    </c:if>

</script>

</body>
</html>