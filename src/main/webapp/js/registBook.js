document.addEventListener("DOMContentLoaded", function () {
    var result = document.getElementById("alert").getAttribute("data-result");
    if (result) {
        alert(result);
    }
});