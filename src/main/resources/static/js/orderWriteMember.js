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
    let userCash = parseInt(document.querySelector(".maxCash").innerText) || 0;
    let useAmount = userCash > maxLimit ? maxLimit : userCash;
    
    document.querySelector(".useCash").value = useAmount;
    totalDiscount();
}

function totalDiscount(){
    const cashInput = document.querySelector(".useCash");
    let val = parseInt(cashInput.value) || 0;

    if(val < 0) val = 0;
    if(val > maxLimit){
        alert("적립금은 1회 최대 3,000원까지만 사용 가능합니다.");
        val = maxLimit;
    }
    
    const userCash = parseInt(document.querySelector(".maxCash").innerText) || 0;
    if(val > userCash) val = userCash;
    
    cashInput.value = val;
    document.querySelector(".totalDiscount").innerText = val.toLocaleString();
    
    updateTotal(val);
}

function updateTotal(discount){
    const finalTotal = orderPtotal + shipping - discount;
    const earnPoint = Math.floor(finalTotal * 0.01);
    
    document.querySelector(".discountTotal").innerText = discount.toLocaleString();
    document.querySelector(".finalTotal").innerText = finalTotal.toLocaleString();
    document.querySelector(".earnPoint").innerText = earnPoint.toLocaleString();
}

// 페이지가 로드될 때 초기화 실행 (DOMContentLoaded 이벤트 활용)
document.addEventListener("DOMContentLoaded", function() {
    updateTotal(0);
});

async function requestPayment(){
    const form = document.writeForm;

    // 1. 받는 사람 유효성 검사
    if (!form.o_name.value.trim()) {
        alert("받는 사람 이름을 입력해주세요.");
        form.o_name.focus();
        return;
    }

    // 2. 주소 유효성 검사
    if (!form.o_zip.value.trim() || !form.o_addr1.value.trim()) {
        alert("배송지 주소를 검색해주세요.");
        return;
    }

    // 3. 휴대전화 형식 검사 (각 4자리 숫자)
    const expPhone = /^[0-9]{4}$/;
    if (!expPhone.test(form.o_phone2.value.trim()) || !expPhone.test(form.o_phone3.value.trim())) {
        alert("휴대전화 번호는 각 4자리 숫자만 입력 가능합니다.");
        if (!expPhone.test(form.o_phone2.value.trim())) form.o_phone2.focus();
        else form.o_phone3.focus();
        return;
    }

    // 4. 이메일 형식 검사
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

    // 결제 프로세스 진행
    const finalTotalStr = document.querySelector(".finalTotal").innerText.replace(/,/g, '');
    const finalTotalAmount = parseInt(finalTotalStr, 10);
    const paymentId = "order-" + new Date().getTime();
    
    console.log("생성된 paymentId:", paymentId);
    
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