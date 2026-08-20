function goPopup(){
    var pop = window.open("/guest/jusoPopup","pop","width=570,height=420, scrollbars=yes, resizable=yes"); 
}

function jusoCallBack(o_addr1, o_addr2, o_zip){
    document.writeForm.o_zip.value = o_zip;
    document.writeForm.o_addr1.value = o_addr1;
    document.writeForm.o_addr2.value = o_addr2;
}

const shipping = 0;

function allCash(){
    // 보유 잔액 가져오기 (콤마 제거)
    let maxCashText = document.querySelector(".maxCash").innerText.replace(/,/g, '').trim();
    let userCash = parseInt(maxCashText, 10) || 0;
    // 최대 한도(3000원)와 보유 잔액 중 작은 값 선택
    let useAmount = userCash > maxLimit ? maxLimit : userCash;
    
    const cashInput = document.querySelector(".useCash");
    cashInput.value = useAmount;
    
    // 통합 계산 함수 호출
    totalDiscount();
}

function totalDiscount(){
    const cashInput = document.querySelector(".useCash");
    let val = parseInt(cashInput.value.replace(/,/g, ''), 10) || 0;

    if(isNaN(val) || val < 0) val = 0;
    
    if(val > maxLimit){
        alert("적립금은 1회 최대 3,000원까지만 사용 가능합니다.");
        val = maxLimit;
    }
    
    let maxCashText = document.querySelector(".maxCash").innerText.replace(/,/g, '').trim();
    const userCash = parseInt(maxCashText, 10) || 0;
    
    if(val > userCash){
        alert("보유하신 적립금보다 많을 수 없습니다.");
        val = userCash;
    }
    
    cashInput.value = val;
    
    // 적용금액 텍스트 업데이트
    document.querySelector(".applyDiscount").innerText = val.toLocaleString();
    
    updateTotal(val);
}

function updateTotal(discount){
    const finalTotal = orderPtotal + shipping - discount;
    const earnPoint = Math.floor(finalTotal * 0.01);
    
    document.querySelector(".discountTotal").innerText = discount.toLocaleString();
    document.querySelector(".finalTotal").innerText = finalTotal.toLocaleString();
    document.querySelector(".earnPoint").innerText = earnPoint.toLocaleString();
}

// 페이지가 로드될 때 초기화 실행
document.addEventListener("DOMContentLoaded", function() {
    updateTotal(0);
});

async function requestPayment(){
    const form = document.writeForm;

    if (!form.o_name.value.trim()) {
        alert("받는 사람 이름을 입력해주세요.");
        form.o_name.focus();
        return;
    }

    if (!form.o_zip.value.trim() || !form.o_addr1.value.trim()) {
        alert("배송지 주소를 검색해주세요.");
        return;
    }

    const expPhone = /^[0-9]{4}$/;
    if (!expPhone.test(form.o_phone2.value.trim()) || !expPhone.test(form.o_phone3.value.trim())) {
        alert("휴대전화 번호는 각 4자리 숫자만 입력 가능합니다.");
        if (!expPhone.test(form.o_phone2.value.trim())) form.o_phone2.focus();
        else form.o_phone3.focus();
        return;
    }

    const expEmail = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
    if (!form.o_email.value.trim()) {
        alert("이메일을 입력해주세요.");
        form.o_email.focus();
        return;
    }
    if (!expEmail.test(form.o_email.value.trim())) {
        alert("올바른 이메일 형식이 아닙니다. (예: user@example.com)");
        form.o_email.value = "";
        form.o_email.focus();
        return;
    }

    const finalTotalStr = document.querySelector(".finalTotal").innerText.replace(/,/g, '');
    const finalTotalAmount = parseInt(finalTotalStr, 10);
    const paymentId = "order-" + new Date().getTime();
    
    try{
        const response = await PortOne.requestPayment({
            storeId : "store-06537574-48da-43b1-9835-1ed0b17839e4",
            channelKey : "channel-key-af20f4e3-df0f-4219-8594-260e8269a7fb",
            paymentId : paymentId,
            orderName : "차 주문",
            totalAmount : finalTotalAmount,
            currency: "CURRENCY_KRW",
            payMethod: "EASY_PAY",
        });
        
        if(response.code != null){
            alert("결제 실패: " + response.message);
            return;
        }
        
        document.getElementById("paymentId").value = paymentId;  
        
        alert("결제가 완료되었습니다.");
        document.writeForm.submit();
    }catch(error){
        console.error("결제 중 오류 발생:", error);
        alert("결제 진행 중 오류 발생");
    }
}