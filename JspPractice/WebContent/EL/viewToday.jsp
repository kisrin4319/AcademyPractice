<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page session="false" %>
<%@ taglib prefix="elfunc" uri="/WEB-INF/el-functions.tld" %>
<%
	java.util.Date today = new java.util.Date();
	request.setAttribute("today", today);

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>EL 함수 호출</title>
</head>
<body>
	오늘은 <b>${elfunc:dateFormat(today) }</b>입니다.
</body>
</html>