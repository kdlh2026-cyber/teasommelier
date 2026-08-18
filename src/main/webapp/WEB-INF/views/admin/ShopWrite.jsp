<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>매장등록</title>
<!-- 카카오 주소검색(우편번호) + 지오코딩 SDK -->
<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=26a58eff51243ea572aa7258f6dd02fd&libraries=services"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<link rel="stylesheet" href="/css/admin-shop.css">
</head>
<body>
	<div>
		<%@ include file="/WEB-INF/views/header.jsp" %>
	</div>

	<div class="admin-shop-wrap">
		<h1>매장등록</h1>

		<form name="product" method="post" action="/admin/ShopWritePro" enctype="multipart/form-data" class="admin-shop-form">
			<%-- Spring Security CSRF 사용 중이면 아래 hidden 필드 필요 --%>
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
			<table>
				<tr>
					<th>매장명</th>
					<td><input type="text" name="sh_name" required></td>
				</tr>
				<tr>
					<th>이미지</th>
					<%-- name을 sh_img_file로 분리 - DTO의 String sh_img 필드와 바인딩 충돌 방지 --%>
					<td><input type="file" name="sh_img_file"></td>
				</tr>
				<tr>
					<th>주소 검색</th>
					<td>
						<div class="addr-search-row">
							<input type="text" id="addr" placeholder="주소를 검색하세요" readonly>
							<button type="button" onclick="searchAddress()">주소 검색</button>
						</div>
					</td>
				</tr>
				<tr>
					<th>위도</th>
					<%-- sh_lat, sh_lon은 지오코딩 결과로 자동 채워짐 (readonly) --%>
					<td><input type="text" name="sh_lat" id="sh_lat" readonly required></td>
				</tr>
				<tr>
					<th>경도</th>
					<td><input type="text" name="sh_lon" id="sh_lon" readonly required></td>
				</tr>
			</table>
			<input type="submit" value="등록하기">
			<input type="reset" value="등록취소" onclick="history.back();">
		</form>
	</div>

	<div>
        <%@ include file="/WEB-INF/views/footer.jsp" %>
    </div>

	<script>
		// 다음 우편번호(주소검색) 팝업 열기
		function searchAddress() {
			new daum.Postcode({
				oncomplete: function(data) {
					// 도로명 주소 우선, 없으면 지번 주소 사용
					var address = data.roadAddress || data.jibunAddress;
					document.getElementById('addr').value = address;

					// 카카오맵 지오코딩으로 주소 -> 위도/경도 변환
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