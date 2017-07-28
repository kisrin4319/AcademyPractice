<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import = "KH.member.MemberInfo" %>
<jsp:useBean id="member" scope = "request" class ="KH.member.MemberInfo"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>인사말</title>
</head>
<body>
<%
	//MemberInfo member = 
	//(MemberInfo)request.getAttribute("member");
%>
<%= member.getName() %> (<%= member.getId() %>) 회원님 안녕하세요.
</body>
</html>