function goPopup(){
	var pop = window.open("/guest/jusoPopup","pop","width=570,height=420, scrollbars=yes, resizable=yes"); 

}

function jusoCallBack(s_addr1,s_addr2,s_zipno){
		// 팝업페이지에서 주소입력한 정보를 받아서, 현 페이지에 정보를 등록합니다.
		document.shipaddr.s_addr1.value = s_addr1;
		document.shipaddr.s_addr2.value = s_addr2;
		document.shipaddr.s_zipno.value = s_zipno;
}

function addrcheck(){
	
	let s_deliveryname = document.shipaddr.s_deliveryname;
	let s_name = document.shipaddr.s_name;
	let s_zipno = document.shipaddr.s_zipno;
	let s_addr1= document.shipaddr.s_addr1;
	let s_phone2=document.shipaddr.s_phone2;
	let s_phone3=document.shipaddr.s_phone3;
	let expm_Phone2 = /^[0-9]{4}$/;
	let expm_Phone3 = /^[0-9]{4}$/;

	if(!s_deliveryname.value){
		alert("배송지명을 입력해주세요");
		s_deliveryname.focus();
		return false;
	}
	
	if(!s_name.value){
		alert("이름을 입력해주세요");
		s_name.focus();
		return false;
	}
		
	if(!s_zipno.value){
		alert("우편번호를 입력해주세요");
		return false;
	}
	
	if(!s_addr1.value){
		alert("주소를 입력해주세요");
		return false;
	}
	
	if(!s_phone2.value){
			alert("휴대폰번호를 입력해주세요");
			s_phone2.focus();
			return false;
	}
	
	if(!expm_Phone2.test(s_phone2.value)){
		alert("연락처는 숫자만 가능합니다.");
		s_phone2.value="";
		s_phone2.focus();
		return false;
	}
	
	if(!s_phone3.value){
			alert("휴대폰번호를 입력해주세요");
			s_phone3.focus();
			return false;
	}	
	
	if(!expm_Phone3.test(s_phone3.value)){
		alert("연락처는 숫자만 가능합니다.");
		s_phone3.value="";
		s_phone3.focus();
		return false;
	}
	
}