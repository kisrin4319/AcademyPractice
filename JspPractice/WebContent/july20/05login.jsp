<%@ page contentType="text/html; charset=euc-kr" %>
<%
	String id = request.getParameter("memberId");
	if (id.equals("KH21")) {
		response.sendRedirect("./01requestInfo.jsp");
	} else {
%>

<html>
<head><title>로그인에 실패</title></head>
<body>
아이디가 KH05이 아닙니다.
</body>
</html>
<%
	}
%>
