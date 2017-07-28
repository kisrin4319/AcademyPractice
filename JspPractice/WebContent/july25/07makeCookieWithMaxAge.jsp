<%@ page contentType = "text/html; charset=euc-kr" %>
<%
	Cookie cookie = new Cookie("onem", "1minute");
	cookie.setMaxAge(60 * 1); // 60초(1분)
	response.addCookie(cookie);
%>
<html>
<head><title>쿠키유효시간설정</title></head>
<body>

유효시간이 1분인 onem 쿠키 생성.

</body>
</html>
