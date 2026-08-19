function saveTabState() {
    // hidden input으로 넘어가는 cb_category 값("리뷰", "Q&A" 등)을 확인하여 적절한 URL 저장
    const category = document.querySelector('input[name="cb_category"]').value;
    
    let tabUrl = '/guest/community/cb_brandnoticeList'; // 기본값
    
    if (category === '리뷰') {
        tabUrl = '/guest/community/cb_reviewList';
    } else if (category === '에디토리얼') {
        tabUrl = '/guest/community/cb_editorialList';
    } else if (category === 'Q&A') {
        tabUrl = '/guest/community/cb_qnaList';
    } else if (category === '브랜드소식') {
        tabUrl = '/guest/community/cb_brandnoticeList';
    }

    sessionStorage.setItem('lastCommunityTab', tabUrl);
}