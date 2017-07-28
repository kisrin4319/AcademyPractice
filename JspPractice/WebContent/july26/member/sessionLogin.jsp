<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import = "java.net.URLEncoder" %>
<%
	String id =request.getParameter("id");
	String password = request.getParameter("password");
	String value = request.getParameter("saveId");
	
	if(id.equals(password)){
		session.setAttribute("MEMBERID", id);
		if(value!=null && value.equals("checked")){
			Cookie cookie = new Cookie("id",URLEncoder.encode(id));
			cookie.setMaxAge(60);
			response.addCookie(cookie);
		}
	%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>로그인 성공</title>
</head>
<body>로그인에 성공했습니다.
</body>
</html>

<%
	} else { //로그인 실패시
%>
<script>
alert("로그인에 실패하였습니다.");
history.go(-1);
</script>
<%
	}
%>
