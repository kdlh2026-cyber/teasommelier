function csCheck(){
	let cs_category=document.getElementsByName('cs_category')[0];
	let cs_subject=document.getElementsByName('cs_subject')[0];
	let cs_content=document.getElementsByName('cs_content')[0];
	
	
	if (!cs_subject.value){
		alert("제목을 작성하여 주십시오.");
		cs_subject.focus();
		return false;
	}
		
	if (!cs_content.value){
		alert("내용을 작성하여 주십시오.");
		return false;
	}
	
	return true;
}