function productModifyCheck() {
    const form = document.product;
    
    if (!form.p_name.value.trim()) {
        alert("상품명을 입력해주세요.");
        form.p_name.focus();
        return false;
    }
    if (!form.p_category.value.trim()) {
        alert("카테고리를 입력해주세요.");
        form.p_category.focus();
        return false;
    }
    if (!form.p_price.value.trim()) {
        alert("가격을 입력해주세요.");
        form.p_price.focus();
        return false;
    }
    if (isNaN(form.p_price.value.trim())) {
        alert("가격은 숫자만 입력 가능합니다.");
        form.p_price.value = "";
        form.p_price.focus();
        return false;
    }
    if (!form.p_type.value.trim()) {
        alert("종류를 입력해주세요.");
        form.p_type.focus();
        return false;
    }
    if (!form.p_capacity.value.trim()) {
        alert("용량을 입력해주세요.");
        form.p_capacity.focus();
        return false;
    }
    if (!form.p_stock.value.trim()) {
        alert("재고수량을 입력해주세요.");
        form.p_stock.focus();
        return false;
    }
    if (isNaN(form.p_stock.value.trim())) {
        alert("재고수량은 숫자만 입력 가능합니다.");
        form.p_stock.value = "";
        form.p_stock.focus();
        return false;
    }

    // 유효성 검사 통과 시 폼 제출
    form.submit();
}