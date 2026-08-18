<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>매장수정</title>
<!-- 카카오 주소검색(우편번호) + 지오코딩/역지오코딩 SDK -->
<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=26a58eff51243ea572aa7258f6dd02fd&libraries=services"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<link rel="stylesheet" href="/css/admin-shop.css">
</head>
<body>
	<div>
		<%@ include file="/WEB-INF/views/header.jsp" %>
	</div>

	<div class="admin-shop-wrap">
		<h1>매장수정</h1>

		<form name="product" method="post" action="/admin/ShopUpdate" enctype="multipart/form-data" class="admin-shop-form">
			<%-- Spring Security CSRF 사용 중이면 아래 hidden 필드 필요 --%>
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
			<%-- 수정 대상 식별용 PK --%>
			<input type="hidden" name="sh_no" value="${shop.sh_no}">
			<%-- 새 이미지 안 올렸을 때 컨트롤러가 기존 파일명 유지하는 데 씀 --%>
			<input type="hidden" name="existing_sh_img" value="${shop.sh_img}">
			<table>
				<tr>
					<th>매장명</th>
					<td><input type="text" name="sh_name" value="${shop.sh_name}" required></td>
				</tr>
				<tr>
					<th>이미지</th>
					<td>
						<%-- 기존 이미지 파일명 표시 (file input은 기존 파일 재설정 불가, 새로 선택 시에만 교체) --%>
						<c:if test="${not empty shop.sh_img}">
							현재 이미지: ${shop.sh_img}<br>
						</c:if>
						<%-- name을 sh_img_file로 분리 - DTO의 String sh_img 필드와 바인딩 충돌 방지 --%>
						<input type="file" name="sh_img_file">
					</td>
				</tr>
				<tr>
					<th>주소 검색</th>
					<td>
						<div class="addr-search-row">
							<input type="text" id="addr" placeholder="주소를 검색하세요">
							<button type="button" onclick="searchAddress()">주소 검색</button>
						</div>
					</td>
				</tr>
				<tr>
					<th>위도</th>
					<%-- sh_lat, sh_lon은 지오코딩 결과로 자동 채워짐 (readonly) --%>
					<td><input type="text" name="sh_lat" id="sh_lat" value="${shop.sh_lat}" readonly required></td>
				</tr>
				<tr>
					<th>경도</th>
					<td><input type="text" name="sh_lon" id="sh_lon" value="${shop.sh_lon}" readonly required></td>
				</tr>
			</table>
			<input type="submit" value="수정하기">
			<input type="reset" value="수정취소" onclick="history.back();">
		</form>
	</div>

	<div>
        <%@ include file="/WEB-INF/views/footer.jsp" %>
    </div>

	<script>
		// 페이지 로드 시 기존 위도/경도로 역지오코딩해서 주소창에 미리 표시
		window.onload = function() {
			var lat = document.getElementById('sh_lat').value;
			var lon = document.getElementById('sh_lon').value;

			if (lat && lon) {
				var geocoder = new kakao.maps.services.Geocoder();
				var coord = new kakao.maps.LatLng(lat, lon);

				geocoder.coord2Address(coord.getLng(), coord.getLat(), function(result, status) {
					if (status === kakao.maps.services.Status.OK) {
						var address = result[0].road_address
							? result[0].road_address.address_name
							: result[0].address.address_name;
						document.getElementById('addr').value = address;
					}
				});
			}
		};

		// 다음 우편번호(주소검색) 팝업 열기
		function searchAddress() {
			new daum.Postcode({
				oncomplete: function(data) {
					// 도로명 주소 우선, 없으면 지번 주소 사용
					var address = data.roadAddress || data.jibunAddress;
					document.getElementById('addr').value = address;

					// 카카오맵 지오코딩으로 주소 -> 위도/경도 변환 (재검색 시 좌표 갱신)
					var geocoder = new kakao.maps.services.Geocoder();
					geocoder.addressSearch(address, function(result, status) {
						if (status === kakao.maps.services.Status.OK) {
							document.getElementById('sh_lat').value = result[0].y; // 위도
							document.getElementById('sh_lon').value = result[0].x; // 경도
						} else {
							alert('주소로 좌표를 찾지 못했습니다. 다른 주소로 다시 검색해주세요.');
						}
					});
				}
			}).open();
		}
	</script>
</body>
</html>