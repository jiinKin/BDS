<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Alert</title>
    <script>
        // 페이지 로드 시 실행되는 함수
        window.onload = function() {
            // successModify가 값이 있으면 알림 창 띄우고 리다이렉트
            if("${successModify}" !== "") {
                alert("${successModify}");
                // 원하는 페이지로 리다이렉트
                location.href = "./logout.do";
            }
            // failModify가 값이 있으면 알림 창 띄우고 리다이렉트
            else if("${failModify}" !== "") {
                alert("${failModify}");
                // 원하는 페이지로 리다이렉트
                location.href = "./moveModifyPW.do";
            }else if("${successLink}" !== ""){
            	alert("${successLink}");
          		location.href = "./index.jsp";
            }else if("${failLink}" !== ""){
            	alert("${failLink}");
            	location.href = "./myPage.do";
            }
        };
    </script>
</head>
<body>
</body>
</html>