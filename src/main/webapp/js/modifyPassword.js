function changePassword() {
    var currentPassword = document.getElementById("currentPassword").value;
    var newPassword = document.getElementById("newPassword").value;
    var confirmPassword = document.getElementById("confirmPassword").value;

    // 새로운 비밀번호에 영어 대문자, 소문자, 숫자, 특수문자 각각 하나 이상을 포함하는지 검사
    var passwordRegex = /^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#$%^&*()_+{}\[\]:;<>,.?~\\/-]).{8,}$/;
    if (!passwordRegex.test(newPassword)) {
        alert("새로운 비밀번호는 영어 대문자, 소문자, 숫자, 특수문자를 각각 하나 이상 포함하여 최소 8자 이상이어야 합니다.");
        return;
    }

    // 현재 비밀번호와 새로운 비밀번호가 같은지 확인
    if (newPassword === currentPassword) {
        alert("현재 비밀번호와 새로운 비밀번호는 같을 수 없습니다.");
        return;
    }

    // 새로운 비밀번호와 확인 비밀번호가 같은지 확인
    if (newPassword !== confirmPassword) {
       alert("새로운 비밀번호와 확인 비밀번호가 일치하지 않습니다.");
        return;
    }

    // 유효성 검사를 통과한 경우 폼을 제출합니다.
    $("#modifyButton").submit();
}





