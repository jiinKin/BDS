/* 변수 선언 */
var joinButton = document.getElementById('joinButton'); // 가입하기 버튼을 ID로 가져옴
var yy = document.getElementById('yy'); // 연도 입력란
var mm = document.getElementById('mm'); // 월 선택란
var dd = document.getElementById('dd'); // 일 입력란

/* 가입하기 버튼 클릭 이벤트 핸들러 연결 */
joinButton.addEventListener("click", function (e) {
    e.preventDefault(); // 기본 제출 동작을 막음

    // 입력된 연도, 월, 일을 가져와서 yyyymmdd 형식의 문자열로 조합
    var year = yy.value;
    var month = mm.value;
    var day = dd.value;

    // 월과 일이 한 자리 숫자인 경우 앞에 0을 추가
    if (month.length === 1) {
        month = '0' + month;
    }
    if (day.length === 1) {
        day = '0' + day;
    }

    // yyyymmdd 형식으로 조합
    var birthdate = year + month + day;

    // 조합된 생년월일을 hidden input에 설정
    document.getElementById('user_birth').value = birthdate;

    // 폼 제출
    document.frm.submit();
});