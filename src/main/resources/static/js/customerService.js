window.onload = function() {

	// 1. 아코디언 토글 (질문 클릭 시 답변 펼침/접힘)
	var toggleBtns = document.getElementsByClassName("csToggleBtn");
	for (var i = 0; i < toggleBtns.length; i++) {
		toggleBtns[i].onclick = function() {
			var content = this.parentNode.nextElementSibling;
			if (content.style.display === "none") {
				content.style.display = "block";
			} else {
				content.style.display = "none";
			}
		};
	}

	// 2. 카테고리 필터링
	var categoryBtns = document.querySelectorAll("#csCategoryList button");
	var items = document.querySelectorAll("#csAccordionList > div");

	for (var i = 0; i < categoryBtns.length; i++) {
		categoryBtns[i].onclick = function() {
			var selected = this.getAttribute("data-category");

			for (var j = 0; j < items.length; j++) {
				var itemCategory = items[j].getAttribute("data-category");

				if (selected === "전체" || selected === itemCategory) {
					items[j].style.display = "block";
				} else {
					items[j].style.display = "none";
				}
				// 카테고리 전환 시 열려있던 답변은 다시 닫아줌
				items[j].querySelector(".csContent").style.display = "none";
			}
		};
	}

};