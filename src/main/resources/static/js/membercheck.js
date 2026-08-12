function goPopup(){
	var pop = window.open("/guest/jusoPopup","pop","width=570,height=420, scrollbars=yes, resizable=yes"); 

}

function jusoCallBack(m_addr1,m_addr2,m_zipno){
		// 팝업페이지에서 주소입력한 정보를 받아서, 현 페이지에 정보를 등록합니다.
		document.member.m_addr1.value = m_addr1;
		document.member.m_addr2.value = m_addr2;
		document.member.m_zipno.value = m_zipno;
}

document.addEventListener('DOMContentLoaded', function() {
	
    const allchk = document.querySelector('input[name="all_chk"]');
    const termchks = document.querySelectorAll('input[name="term_chk"], input[name="personal_chk"], input[name="m_rsms"], input[name="m_remail"]');

	// 전체 체크 누를시 하위 체크 모두 클릭
    allchk.addEventListener('change', function() {
        termchks.forEach(chk => {
            chk.checked = allchk.checked;
        });
    });

    termchks.forEach(chk => {
        chk.addEventListener('change', function() {
            // 모든 하위 항목이 체크되었는지 확인
            const isAllChecked = Array.from(termchks).every(item => item.checked);
            allchk.checked = isAllChecked;
        });
    });
});

function membercheck(){
	let m_id = document.member.m_id;
	let m_passwd = document.member.m_passwd;
	let chk_passwd = document.member.chk_passwd;
	let m_name= document.member.mname;
	let m_phone1=document.member.m_phone1;
	let m_phone2=document.member.m_phone2;
	let m_phone3=document.member.m_phone3;
	let m_tel1=document.member.mtel1;
	let m_tel2=document.member.mtel2;
	let m_tel3=document.member.mtel3;
	let m_addr1=document.member.m_addr1;
	let term_chk = document.member.term_chk;
	let personal_chk = document.member.personal_chk;
	let expm_Id = /^[a-zA-Z0-9]{4,16}$/; // 영문소문자/숫자 4~16
	let expm_Passwd = /^[a-zA-Z0-9~`!@#$%^&*_\-={}\[\]|;:<>,.?\/]{10,16}$/; //대소문자/숫자/특수문자 10 16
	let expm_Phone1 = /^[0-9]{3}$/;
	let expm_Phone2 = /^[0-9]{4}$/;
	let expm_Phone3 = /^[0-9]{4}$/;
	let expm_Tel1 = /^[0-9]{3}$/;
	let expm_Tel2 = /^[0-9]{4}$/;
	let expm_Tel3 = /^[0-9]{4}$/;
	
	if(!m_id.value){
		alert("아이디를 입력해주세요");
		m_id.focus();
		return false;
	}
		
	if(!expm_Id.test(m_id.value)){
		alert("아이디는 영문숫자 4~12자리까지 가능합니다.");
		m_id.value="";
		m_id.focus();
		return false;
	}
	
	if(!m_passwd.value){
		alert("비밀번호를 입력해주세요");
		m_passwd.focus();
		return false;
	}
		
	if(!expm_Passwd.test(m_passwd.value)){
		alert("비밀번호는 영문숫자,특수기호 10~16자리까지 가능합니다.");
		m_passwd.value="";
		m_passwd.focus();
		return false;
	}
	
	if(m_passwd.value != chk_passwd.value){
		alert("비밀번호가 다릅니다.")
		m_passwd.value = "";
		chk_passwd.value = "";
		m_passwd.focus();
		return false;
	}
		
	if(!m_name.value){
		alert("이름을 입력해주세요");
		m_name.focus();
		return false;
	}
	
	if(!expm_Tel1.test(m_tel1.value)){
		alert("연락처는 숫자만 가능합니다.");
		m_tel1.value="";
		m_tel1.focus();
		return false;
	}
	if(!expm_Tel2.test(m_tel2.value)){
		alert("연락처는 숫자만 가능합니다.");
		m_tel2.value="";
		m_tel2.focus();
		return false;
	}
	if(!expm_Tel3.test(m_tel3.value)){
		alert("연락처는 숫자만 가능합니다.");
		m_tel3.value="";
		m_tel3.focus();
		return false;
	}
	
	if(!m_phone1.value){
		alert("휴대폰번호를 입력해주세요");
		m_phone1.focus();
		return false;
	}
		
	if(!expm_Phone1.test(m_phone1.value)){
		alert("연락처는 숫자만 가능합니다.");
		m_phone1.value="";
		m_phone1.focus();
		return false;
	}
		
	if(!m_phone2.value){
		alert("휴대폰번호를 입력해주세요");
		m_phone2.focus();
		return false;
	}
			
	if(!expm_Phone2.test(m_phone2.value)){
		alert("연락처는 숫자만 가능합니다.");
		m_phone2.value="";
		m_phone2.focus();
		return false;
	}

	if(!m_phone3.value){
		alert("휴대폰번호를 입력해주세요");
		m_phone3.focus();
		return false;
	}
			
	if(!expm_Phone3.test(m_phone3.value)){
		alert("연락처는 숫자만 가능합니다.");
		m_phone3.value="";
		m_phone3.focus();
		return false;
	}
	
	if(!m_addr1.value){
		alert("주소를 입력해주세요");
		return false;
	}
	
	if(!term_chk.cheked){
		alert("이용약관에 동의해주세요.");
		return false;
	}
	
	if(!personal_chk.cheked){
		alert("개인정보 수집 및 이용에 동의해주세요.");
		return false;
	}
}