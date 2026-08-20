function saveTabState() {
    const category = document.querySelector('input[name="cb_category"]').value;
    let tabUrl = '/guest/community/cb_brandnoticeList';

    if (category === '리뷰') tabUrl = '/guest/community/cb_reviewList';
    else if (category === '에디토리얼') tabUrl = '/guest/community/cb_editorialList';
    else if (category === 'Q&A') tabUrl = '/guest/community/cb_qnaList';
    else if (category === '브랜드소식') tabUrl = '/guest/community/cb_brandnoticeList';

    sessionStorage.setItem('lastCommunityTab', tabUrl);
    // 여기서 제목/내용 검증 로직은 제거
}

function insertCheck(){
    let cb_subject = document.getElementsByName('cb_subject')[0];
    let cb_content = document.getElementsByName('cb_content')[0];

    if(!cb_subject.value.trim()){
        alert("제목을 입력하시오.");
        cb_subject.focus();
        return false;
    }

    if(!cb_content.value.trim()){
        alert("내용을 입력하시오.");
        cb_content.focus();
        return false;
    }

    return true; // 통과해야 실제 제출됨
}