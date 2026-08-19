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
	let m_name= document.member.m_name;
	let m_phone2=document.member.m_phone2;
	let m_phone3=document.member.m_phone3;
	let m_email = document.member.m_email;
	let term_chk = document.member.term_chk;
	let personal_chk = document.member.personal_chk;
	let expm_Id = /^[a-zA-Z0-9]{4,16}$/; // 영문소문자/숫자 4~16
	let expm_Passwd = /^[a-zA-Z0-9~`!@#$%^&*_\-={}\[\]|;:<>,.?\/]{10,16}$/; //대소문자/숫자/특수문자 10 16
	let expm_Phone2 = /^[0-9]{4}$/;
	let expm_Phone3 = /^[0-9]{4}$/;
	let expm_Email = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/
	let validCount = 0;
	if (/[a-zA-Z]/.test(m_passwd.value)) validCount++; // 영문 대소문자
	if (/[0-9]/.test(m_passwd.value)) validCount++; // 숫자
	if (/[~`!@#$%^&*_\-={}\[\]|;:<>,.?\/]/.test(m_passwd.value)) validCount++;
	
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
	
	if (m_passwd.value.search(/\s/) !== -1) {
					alert("비밀번호에 공백(띄어쓰기)은 포함할 수 없습니다.");
					m_passwd.value = "";
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
	
	// 2개이상 조합
	
	if (validCount < 2) {
			alert("비밀번호는 영문, 숫자, 특수문자 중 2가지 이상을 조합해야 합니다.");
			m_passwd.value = "";
			m_passwd.focus();
			return false;
	}

	// 아이디 포함 여부 검사
	if (m_passwd.value.indexOf(m_id.value) > -1) {
			alert("비밀번호에 아이디를 포함할 수 없습니다.");
			m_passwd.value = "";
			m_passwd.focus();
			return false;
	}
	
	// 동일 숫자
	let count1 = 0; // 연속카운트 ++ 
	let count2 = 0; // 연속카운트 --
	let count3 = 0;
			
	for (let i=0; i<m_passwd.value.length; i++){
		let char0;
		let char1;
		let char2;
				
		if(i>=2){
			char0 = m_passwd.value.charCodeAt(i-2); //a--> 97
			char1 = m_passwd.value.charCodeAt(i-1); //b-->98
			char2 = m_passwd.value.charCodeAt(i); //c-->99
							
			//연속 카운트 증가
			if(char0-char1 == -1 && char1-char2 == -1){
				count1++;
			}
			else{
				count1 = 0;
			}
					
			//연속 카운트 감소
			if(char0-char1 == 1 && char1-char2 == 1){
				count2++;
			}
			else{
				count2 = 0;
			}
					
			//동일 문자 카운트
			if(char0-char1 == 0 && char1-char2 ==0){
				count3++;
			}
			else{
				count3=0;
			}
			if(count1>0 || count2>0){
				alert("영문, 숫자는 3자 이상 연속 입력할 수 없습니다.");
				return false;
			}
			if(count3>0){
				alert("동일한 문자를 3번이상 사용할 수 없습니다.");
				return false;
			}
		}
	}
		
	if(!m_name.value){
		alert("이름을 입력해주세요");
		m_name.focus();
		return false;
	}
		
	if(!m_phone2.value){
		alert("휴대폰번호를 입력해주세요");
		m_phone2.focus();
		return false;
	}
			
	if(!expm_Phone2.test(m_phone2.value)){
		alert("연락처는 4자리 숫자만 가능합니다.");
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
		alert("연락처는 4자리 숫자만 가능합니다.");
		m_phone3.value="";
		m_phone3.focus();
		return false;
	}
	
	if(!m_email.value){
		alert("이메일을 입력해주세요");
		m_email.focus();
		return false;
	}
	
	if (m_email.value.search(/\s/) !== -1) {
			alert("이메일에 공백(띄어쓰기)은 포함할 수 없습니다.");
			m_email.value = "";
			m_email.focus();
			return false;
	}
	
	if(!expm_Email.test(m_email.value)){
			alert("올바른 이메일 형식이 아닙니다. (예: user@example.com)");
			m_email.value = "";
			m_email.focus();
			return false;
	}

	if(!term_chk.checked){
		alert("이용약관에 동의해주세요.");
		return false;
	}
	
	if(!personal_chk.checked){
		alert("개인정보 수집 및 이용에 동의해주세요.");
		return false;
	}
	
}